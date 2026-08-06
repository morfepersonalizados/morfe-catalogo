-- Executado em 2026-08-06. Cria suporte a admin (allowlist) e variações de cor por produto.

create table public.catalog_admins (
  id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz default now()
);

create table public.catalog_product_colors (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.catalog_products(id) on delete cascade,
  name text not null,
  sort_order int default 0
);

alter table public.catalog_admins enable row level security;
alter table public.catalog_product_colors enable row level security;

create policy "cores sao publicas para leitura"
  on public.catalog_product_colors for select
  to anon, authenticated
  using (true);

create policy "admin gerencia categorias"
  on public.catalog_categories for all
  to authenticated
  using (exists (select 1 from public.catalog_admins where id = auth.uid()))
  with check (exists (select 1 from public.catalog_admins where id = auth.uid()));

create policy "admin gerencia produtos"
  on public.catalog_products for all
  to authenticated
  using (exists (select 1 from public.catalog_admins where id = auth.uid()))
  with check (exists (select 1 from public.catalog_admins where id = auth.uid()));

create policy "admin gerencia cores"
  on public.catalog_product_colors for all
  to authenticated
  using (exists (select 1 from public.catalog_admins where id = auth.uid()))
  with check (exists (select 1 from public.catalog_admins where id = auth.uid()));

create policy "admin le proprio registro"
  on public.catalog_admins for select
  to authenticated
  using (id = auth.uid());

-- Coluna de selo opcional (ex: "Mais vendido")
alter table public.catalog_products add column badge text;

-- Categoria pode ser removida sem apagar os produtos ligados a ela
alter table public.catalog_products drop constraint catalog_products_category_id_fkey;
alter table public.catalog_products add constraint catalog_products_category_id_fkey
  foreign key (category_id) references public.catalog_categories(id) on delete set null;

-- Conta de admin criada separadamente via auth.users/auth.identities (ver memoria.md
-- para o procedimento e a ressalva sobre a coluna confirmation_token não poder ser NULL).
