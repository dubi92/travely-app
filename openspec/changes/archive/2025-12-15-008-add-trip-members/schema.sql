-- Create trip_members table
create table if not exists trip_members (
  id uuid primary key default gen_random_uuid(),
  trip_id uuid references trips(id) on delete cascade not null,
  user_id uuid references auth.users(id) not null,
  role text default 'member' check (role in ('admin', 'member')),
  joined_at timestamptz default now(),
  unique(trip_id, user_id)
);

-- Create trip_invitations table
create table if not exists trip_invitations (
  id uuid primary key default gen_random_uuid(),
  trip_id uuid references trips(id) on delete cascade not null,
  invite_code text unique not null,
  created_by uuid references auth.users(id) not null,
  expires_at timestamptz,
  created_at timestamptz default now()
);

-- Enable RLS
alter table trip_members enable row level security;
alter table trip_invitations enable row level security;

-- Policies for trip_members

-- 1. Users can view members of trips they belong to
-- Helper function to avoid recursion in RLS
create or replace function get_user_trip_ids()
returns setof uuid
language sql
security definer
set search_path = public
stable
as $$
  select trip_id from trip_members where user_id = auth.uid();
$$;

-- 1. Users can view members of trips they belong to
create policy "View members of own trips"
  on trip_members for select
  using (
    trip_id in ( select get_user_trip_ids() )
  );

-- Helper to check admin status or creator status securely
create or replace function is_trip_admin_or_creator(check_trip_id uuid)
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1 from trip_members
    where trip_id = check_trip_id
    and user_id = auth.uid()
    and role = 'admin'
  ) or exists (
    select 1 from trips
    where id = check_trip_id
    and created_by = auth.uid()
  );
$$;

-- 2. Admins/Creators can insert members
create policy "Admins can add members"
  on trip_members for insert
  with check (
    is_trip_admin_or_creator(trip_id)
  );
  
-- 3. Admins/Creators can update roles
create policy "Admins can update members"
  on trip_members for update
  using (
    is_trip_admin_or_creator(trip_id)
  );

-- 4. Admins/Creators can remove members
create policy "Admins can delete members"
  on trip_members for delete
  using (
    is_trip_admin_or_creator(trip_id)
  );

-- 5. Users can leave trips (delete themselves)
create policy "Users can leave trips"
  on trip_members for delete
  using (
    user_id = auth.uid()
  );


-- Policies for trip_invitations

-- 1. Admins can view/manage invitations for their trips
create policy "Admins manage invitations"
  on trip_invitations for all
  using (
    exists (
      select 1 from trip_members
      where trip_members.trip_id = trip_invitations.trip_id
      and trip_members.user_id = auth.uid()
      and trip_members.role = 'admin'
    )
  );

-- 2. Authenticated users can read invitations (to validate code)
create policy "Authenticated users can read invitations"
    on trip_invitations for select
    to authenticated
    using (true);

-- Functions
create or replace function join_trip(invite_code text)
returns void
language plpgsql
security definer
as $$
declare
  target_trip_id uuid;
begin
  -- Validate code
  select trip_id into target_trip_id
  from trip_invitations
  where trip_invitations.invite_code = join_trip.invite_code;

  if target_trip_id is null then
    raise exception 'Invalid invite code';
  end if;

  -- Insert member (idempotent)
  insert into trip_members (trip_id, user_id, role)
  values (target_trip_id, auth.uid(), 'member')
  on conflict (trip_id, user_id) do nothing;
end;
$$;

-- Fix for missing relationship: Explicitly link trip_members to profiles
alter table trip_members
  add constraint trip_members_user_id_fkey_profiles
  foreign key (user_id)
  references profiles(id);
