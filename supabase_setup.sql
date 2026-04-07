create table if not exists public.dashboard_snapshots (
  user_id uuid primary key references auth.users(id) on delete cascade,
  snapshot jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default timezone('utc', now())
);

create or replace function public.set_dashboard_snapshot_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;

drop trigger if exists set_dashboard_snapshot_updated_at on public.dashboard_snapshots;

create trigger set_dashboard_snapshot_updated_at
before update on public.dashboard_snapshots
for each row
execute function public.set_dashboard_snapshot_updated_at();

alter table public.dashboard_snapshots enable row level security;

drop policy if exists "Users can read own dashboard snapshot" on public.dashboard_snapshots;
create policy "Users can read own dashboard snapshot"
on public.dashboard_snapshots
for select
to authenticated
using ((select auth.uid()) is not null and (select auth.uid()) = user_id);

drop policy if exists "Users can insert own dashboard snapshot" on public.dashboard_snapshots;
create policy "Users can insert own dashboard snapshot"
on public.dashboard_snapshots
for insert
to authenticated
with check ((select auth.uid()) is not null and (select auth.uid()) = user_id);

drop policy if exists "Users can update own dashboard snapshot" on public.dashboard_snapshots;
create policy "Users can update own dashboard snapshot"
on public.dashboard_snapshots
for update
to authenticated
using ((select auth.uid()) is not null and (select auth.uid()) = user_id)
with check ((select auth.uid()) is not null and (select auth.uid()) = user_id);

drop policy if exists "Users can delete own dashboard snapshot" on public.dashboard_snapshots;
create policy "Users can delete own dashboard snapshot"
on public.dashboard_snapshots
for delete
to authenticated
using ((select auth.uid()) is not null and (select auth.uid()) = user_id);

create index if not exists dashboard_snapshots_updated_at_idx
on public.dashboard_snapshots (updated_at desc);
