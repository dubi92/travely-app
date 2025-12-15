-- Activities Table
create type activity_status as enum ('planned', 'booked', 'done');
create type activity_category as enum ('food', 'sightseeing', 'accommodation', 'transport', 'shopping', 'other');

create table public.activities (
    id uuid not null default gen_random_uuid(),
    trip_id uuid not null references public.trips(id) on delete cascade,
    title text not null,
    description text,
    location text,
    start_time timestamptz not null,
    end_time timestamptz,
    category activity_category not null default 'other',
    status activity_status not null default 'planned',
    price decimal(10, 2),
    currency text default 'USD',
    image_url text,
    is_paid boolean default false,
    created_by uuid not null references auth.users(id),
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    
    constraint activities_pkey primary key (id)
);

-- Indexes
create index activities_trip_id_idx on public.activities(trip_id);
create index activities_start_time_idx on public.activities(start_time);

-- RLS for Activities
alter table public.activities enable row level security;

-- Policies for Activities

-- View: Trip members can view activities
create policy "Trip members can view activities"
    on public.activities
    for select
    using (
        exists (
            select 1 from public.trip_members
            where trip_members.trip_id = activities.trip_id
            and trip_members.user_id = auth.uid()
        )
    );

-- Create: Trip members can create activities (editors and owners ideally, but simplifying to members for now as per trip CRUD usually allows members to add)
create policy "Trip members can insert activities"
    on public.activities
    for insert
    with check (
        exists (
            select 1 from public.trip_members
            where trip_members.trip_id = trip_id
            and trip_members.user_id = auth.uid()
        )
    );

-- Update: Creator or Trip Owner/Admin can update (simplifying to creator or any member for MVP flexibility, or sticking to tasks: "creator or trip admin")
-- Task says: 2.4 Create UPDATE policy: creator or trip admin can update
create policy "Creators and admins can update activities"
    on public.activities
    for update
    using (
        activities.created_by = auth.uid()
        or exists (
            select 1 from public.trip_members
            where trip_members.trip_id = activities.trip_id
            and trip_members.user_id = auth.uid()
            and trip_members.role in ('owner', 'admin')
        )
    );

-- Delete: Creator or Trip Owner/Admin can delete
create policy "Creators and admins can delete activities"
    on public.activities
    for delete
    using (
        activities.created_by = auth.uid()
        or exists (
            select 1 from public.trip_members
            where trip_members.trip_id = activities.trip_id
            and trip_members.user_id = auth.uid()
            and trip_members.role in ('owner', 'admin')
        )
    );


-- Activity Participants Table (Junction table)
create table public.activity_participants (
    activity_id uuid not null references public.activities(id) on delete cascade,
    user_id uuid not null references auth.users(id) on delete cascade,
    status text default 'joined', -- could be 'joined', 'maybe', 'declined'
    created_at timestamptz not null default now(),
    
    constraint activity_participants_pkey primary key (activity_id, user_id)
);

-- RLS for Activity Participants
alter table public.activity_participants enable row level security;

-- View: Trip members (via activity->trip) can view participants
create policy "Trip members can view activity participants"
    on public.activity_participants
    for select
    using (
        exists (
            select 1 from public.activities
            join public.trip_members on trip_members.trip_id = activities.trip_id
            where activities.id = activity_participants.activity_id
            and trip_members.user_id = auth.uid()
        )
    );

-- Insert/Update/Delete: User can manage their own participation
create policy "Users can manage their own participation"
    on public.activity_participants
    for all
    using ( user_id = auth.uid() )
    with check ( user_id = auth.uid() );
