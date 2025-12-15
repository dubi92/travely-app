-- Create trips table
create table if not exists trips (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  destination text,
  cover_image_url text,
  start_date date not null,
  end_date date not null,
  default_currency text default 'USD',
  overall_budget decimal(12,2),
  daily_limit decimal(12,2),
  travel_pace text check (travel_pace in ('relaxed', 'balanced', 'packed')),
  status text default 'planning' check (status in ('planning', 'confirmed', 'completed', 'archived')),
  created_by uuid references auth.users not null,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Enable RLS
alter table trips enable row level security;

-- Policies for trips
create policy "Users can view their own trips"
  on trips for select
  using (created_by = auth.uid());

create policy "Users can insert their own trips"
  on trips for insert
  with check (created_by = auth.uid());

create policy "Users can update their own trips"
  on trips for update
  using (created_by = auth.uid());

create policy "Users can delete their own trips"
  on trips for delete
  using (created_by = auth.uid());


