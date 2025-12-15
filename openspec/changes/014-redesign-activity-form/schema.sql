-- Add metadata column to activities table
alter table public.activities 
add column if not exists metadata jsonb default '{}'::jsonb;

-- Create storage bucket for activity images if it doesn't exist
insert into storage.buckets (id, name, public)
values ('activity_images', 'activity_images', true)
on conflict (id) do nothing;

-- Create policy to allow authenticated users to upload files
create policy "Allow authenticated uploads"
on storage.objects for insert
to authenticated
with check ( bucket_id = 'activity_images' );

-- Create policy to allow public to view files
create policy "Allow public view"
on storage.objects for select
to public
using ( bucket_id = 'activity_images' );
