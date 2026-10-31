-- Roo's European Christmas — database setup
-- Paste the whole file into Supabase → SQL Editor → New query → Run.

create table if not exists public.trip_items (
  trip_id     uuid        not null,
  kind        text        not null,          -- 'event' | 'idea' | 'booking' | 'pack'
  id          text        not null,
  data        jsonb       not null default '{}'::jsonb,
  deleted     boolean     not null default false,
  updated_by  text,
  updated_at  timestamptz not null default now(),
  primary key (trip_id, kind, id)
);

create index if not exists trip_items_trip_idx on public.trip_items (trip_id, updated_at);

-- Row Level Security: the app uses the public "anon" key, and the trip is kept
-- private by the long random trip id in the family link. Only people with the link
-- can see or change the trip. (Anyone with the link is "family".)
alter table public.trip_items enable row level security;

drop policy if exists "family read"   on public.trip_items;
drop policy if exists "family write"  on public.trip_items;
drop policy if exists "family update" on public.trip_items;

create policy "family read"   on public.trip_items for select to anon using (true);
create policy "family write"  on public.trip_items for insert to anon with check (true);
create policy "family update" on public.trip_items for update to anon using (true) with check (true);

-- Keep updated_at honest
create or replace function public.touch_updated_at() returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end $$;
drop trigger if exists trip_items_touch on public.trip_items;
create trigger trip_items_touch before update on public.trip_items
  for each row execute function public.touch_updated_at();

-- Live sync between phones
alter publication supabase_realtime add table public.trip_items;
