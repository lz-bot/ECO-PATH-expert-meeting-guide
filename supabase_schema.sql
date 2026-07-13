create table if not exists public.expert_meeting_submissions (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),

  expert text,
  language text,

  q1_asked boolean,
  q1_answer text,
  q2_asked boolean,
  q2_answer text,
  q3_asked boolean,
  q3_answer text,
  q4_asked boolean,
  q4_answer text,
  q5_asked boolean,
  q5_answer text,
  q6_asked boolean,
  q6_answer text,

  recommended_pathway text,
  start_point text,
  endpoint text,
  main_clinical_steps text,
  branches_variants text,
  transfer_criteria text,
  protocols_documents text,
  document_timing text,
  existing_data_sources text,
  unresolved_questions text,
  next_action text,
  pathway_locked text,
  boundaries_locked text,
  map_ready text,
  scope_sentence text,
  parking_lot text,
  action_points text
);

create table if not exists public.expert_meeting_admins (
  email text primary key,
  created_at timestamptz not null default now()
);

alter table public.expert_meeting_submissions
  add column if not exists q1_asked boolean,
  add column if not exists q1_answer text,
  add column if not exists q2_asked boolean,
  add column if not exists q2_answer text,
  add column if not exists q3_asked boolean,
  add column if not exists q3_answer text,
  add column if not exists q4_asked boolean,
  add column if not exists q4_answer text,
  add column if not exists q5_asked boolean,
  add column if not exists q5_answer text,
  add column if not exists q6_asked boolean,
  add column if not exists q6_answer text,
  add column if not exists existing_data_sources text,
  add column if not exists pathway_locked text,
  add column if not exists boundaries_locked text,
  add column if not exists map_ready text;

alter table public.expert_meeting_submissions enable row level security;
alter table public.expert_meeting_admins enable row level security;

grant usage on schema public to anon, authenticated;
revoke select, update, delete on public.expert_meeting_submissions from anon;
revoke select, update, delete on public.expert_meeting_submissions from public;
revoke update, delete on public.expert_meeting_submissions from authenticated;
revoke all on public.expert_meeting_admins from anon, authenticated, public;
grant insert on public.expert_meeting_submissions to anon;
grant select on public.expert_meeting_submissions to authenticated;

create or replace function public.is_expert_meeting_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.expert_meeting_admins
    where lower(email) = lower(coalesce(auth.jwt() ->> 'email', ''))
  );
$$;

revoke all on function public.is_expert_meeting_admin() from public;
grant execute on function public.is_expert_meeting_admin() to authenticated;

drop policy if exists "Anyone can submit expert meeting responses"
on public.expert_meeting_submissions;

create policy "Anyone can submit expert meeting responses"
on public.expert_meeting_submissions
for insert
to anon
with check (true);

drop policy if exists "Anyone can view expert meeting responses"
on public.expert_meeting_submissions;

drop policy if exists "Admin can view expert meeting responses"
on public.expert_meeting_submissions;

create policy "Admin can view expert meeting responses"
on public.expert_meeting_submissions
for select
to authenticated
using (public.is_expert_meeting_admin());

notify pgrst, 'reload schema';

-- Add your administrator email in the Supabase SQL Editor, not in this public repository:
-- insert into public.expert_meeting_admins (email)
-- values ('your.email@example.com')
-- on conflict (email) do nothing;
