-- Cover foreign-key columns to keep joins and cascading operations efficient.
create index if not exists accounts_user_id_idx on public.accounts(user_id);
create index if not exists credit_cards_user_id_idx on public.credit_cards(user_id);
create index if not exists budgets_category_user_idx on public.budgets(category_id, user_id);
create index if not exists transaction_splits_transaction_user_idx on public.transaction_splits(transaction_id, user_id);
create index if not exists transactions_account_user_idx on public.transactions(account_id, user_id);
create index if not exists transactions_destination_account_user_idx on public.transactions(destination_account_id, user_id);
create index if not exists transactions_credit_card_user_idx on public.transactions(credit_card_id, user_id);
create index if not exists transactions_category_user_idx on public.transactions(category_id, user_id);
