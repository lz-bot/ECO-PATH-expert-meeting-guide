create table public.expert_meeting_submissions (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),

  expert text,
  language text,

  recommended_pathway text,
  start_point text,
  endpoint text,
  main_clinical_steps text,
  branches_variants text,
  transfer_criteria text,
  protocols_documents text,
  document_timing text,
  unresolved_questions text,
  next_action text,
  scope_sentence text,
  parking_lot text,
  action_points text
);

alter table public.expert_meeting_submissions enable row level security;

create policy "Anyone can submit expert meeting responses"
on public.expert_meeting_submissions
for insert
to anon
with check (true);

create policy "Anyone can view expert meeting responses"
on public.expert_meeting_submissions
for select
to anon
using (true);
