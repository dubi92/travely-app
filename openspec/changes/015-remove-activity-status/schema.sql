-- Remove status column from activities table
alter table public.activities drop column if exists status;

-- Drop the enum type if no longer used (optional, keeping it safe for now or dropping)
-- drop type if exists activity_status;
