-- Run this once in your Supabase project's SQL Editor (see SETUP.md)

create extension if not exists "uuid-ossp";

create table events (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  event_date date not null,
  event_time text,
  location text,
  description text,
  created_at timestamp with time zone default now()
);

create table sermons (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  sermon_date date not null,
  preacher text,
  scripture_reference text,
  description text,
  link text,
  created_at timestamp with time zone default now()
);

-- Enable Row Level Security
alter table events enable row level security;
alter table sermons enable row level security;

-- Anyone (including the public site, not logged in) can VIEW rows
create policy "Public can view events" on events
  for select using (true);

create policy "Public can view sermons" on sermons
  for select using (true);

-- Only logged-in leaders (authenticated users) can add, edit, or delete
create policy "Leaders can insert events" on events
  for insert with check (auth.role() = 'authenticated');
create policy "Leaders can update events" on events
  for update using (auth.role() = 'authenticated');
create policy "Leaders can delete events" on events
  for delete using (auth.role() = 'authenticated');

create policy "Leaders can insert sermons" on sermons
  for insert with check (auth.role() = 'authenticated');
create policy "Leaders can update sermons" on sermons
  for update using (auth.role() = 'authenticated');
create policy "Leaders can delete sermons" on sermons
  for delete using (auth.role() = 'authenticated');
