-- Initial personal-finance schema. Every user-owned table is protected by RLS.
create table if not exists public.accounts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null check (length(trim(name)) > 0),
  account_type text not null check (account_type in ('bank','cash','benefit')),
  institution text,
  opening_balance_cents bigint not null default 0,
  is_archived boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (id, user_id)
);

create table if not exists public.credit_cards (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null check (length(trim(name)) > 0),
  brand text,
  last_four text check (last_four is null or last_four ~ '^[0-9]{4}$'),
  credit_limit_cents bigint check (credit_limit_cents is null or credit_limit_cents >= 0),
  closing_day smallint check (closing_day between 1 and 31),
  due_day smallint check (due_day between 1 and 31),
  is_archived boolean not null default false,
  created_at timestamptz not null default now(),
  unique (id, user_id)
);

create table if not exists public.categories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null check (length(trim(name)) > 0),
  category_type text not null check (category_type in ('income','expense')),
  color text,
  icon text,
  created_at timestamptz not null default now(),
  unique (id, user_id),
  unique (user_id, name, category_type)
);

create table if not exists public.transactions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  transaction_type text not null check (transaction_type in ('income','expense','transfer','card_payment','refund')),
  amount_cents bigint not null check (amount_cents > 0),
  description text not null check (length(trim(description)) > 0),
  occurred_on date not null default current_date,
  account_id uuid,
  destination_account_id uuid,
  credit_card_id uuid,
  category_id uuid,
  notes text,
  source text not null default 'manual' check (source in ('manual','whatsapp','import')),
  status text not null default 'confirmed' check (status in ('pending','confirmed','cancelled')),
  idempotency_key text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (id, user_id),
  foreign key (account_id, user_id) references public.accounts(id, user_id),
  foreign key (destination_account_id, user_id) references public.accounts(id, user_id),
  foreign key (credit_card_id, user_id) references public.credit_cards(id, user_id),
  foreign key (category_id, user_id) references public.categories(id, user_id),
  check (
    (transaction_type = 'transfer' and account_id is not null and destination_account_id is not null and account_id <> destination_account_id)
    or (transaction_type <> 'transfer')
  ),
  check (
    (transaction_type = 'expense' and credit_card_id is not null and account_id is null)
    or (transaction_type <> 'expense')
    or (credit_card_id is null)
  )
);

create unique index if not exists transactions_user_idempotency_key
  on public.transactions(user_id, idempotency_key)
  where idempotency_key is not null;
create index if not exists transactions_user_date_idx
  on public.transactions(user_id, occurred_on desc);
create index if not exists transactions_user_type_date_idx
  on public.transactions(user_id, transaction_type, occurred_on desc);

create table if not exists public.transaction_splits (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  transaction_id uuid not null,
  participant_name text not null check (length(trim(participant_name)) > 0),
  amount_cents bigint not null check (amount_cents > 0),
  is_owner_share boolean not null default false,
  created_at timestamptz not null default now(),
  foreign key (transaction_id, user_id) references public.transactions(id, user_id) on delete cascade
);
create index if not exists transaction_splits_user_transaction_idx
  on public.transaction_splits(user_id, transaction_id);

create table if not exists public.budgets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  category_id uuid,
  name text not null check (length(trim(name)) > 0),
  amount_cents bigint not null check (amount_cents > 0),
  month_start date not null,
  created_at timestamptz not null default now(),
  unique (id, user_id),
  unique (user_id, category_id, month_start),
  foreign key (category_id, user_id) references public.categories(id, user_id)
);

alter table public.accounts enable row level security;
alter table public.credit_cards enable row level security;
alter table public.categories enable row level security;
alter table public.transactions enable row level security;
alter table public.transaction_splits enable row level security;
alter table public.budgets enable row level security;

create policy "Users manage their own accounts" on public.accounts
  for all to authenticated using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
create policy "Users manage their own credit cards" on public.credit_cards
  for all to authenticated using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
create policy "Users manage their own categories" on public.categories
  for all to authenticated using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
create policy "Users manage their own transactions" on public.transactions
  for all to authenticated using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
create policy "Users manage their own transaction splits" on public.transaction_splits
  for all to authenticated using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
create policy "Users manage their own budgets" on public.budgets
  for all to authenticated using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

grant select, insert, update, delete on public.accounts to authenticated;
grant select, insert, update, delete on public.credit_cards to authenticated;
grant select, insert, update, delete on public.categories to authenticated;
grant select, insert, update, delete on public.transactions to authenticated;
grant select, insert, update, delete on public.transaction_splits to authenticated;
grant select, insert, update, delete on public.budgets to authenticated;
