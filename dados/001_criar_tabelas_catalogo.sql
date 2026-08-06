-- Executado em 2026-08-05 no projeto Supabase "loja morfe" (rzicwtwowfyogtcqekun)
-- Cria as tabelas do catálogo, separadas do schema antigo de e-commerce já existente no projeto.

create table public.catalog_categories (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  sort_order int default 0,
  created_at timestamptz default now()
);

create table public.catalog_products (
  id uuid primary key default gen_random_uuid(),
  category_id uuid references public.catalog_categories(id),
  name text not null,
  price_cents int not null,
  description text,
  is_available boolean not null default true,
  sort_order int default 0,
  created_at timestamptz default now()
);

alter table public.catalog_categories enable row level security;
alter table public.catalog_products enable row level security;

create policy "categorias sao publicas para leitura"
  on public.catalog_categories for select
  to anon, authenticated
  using (true);

create policy "produtos disponiveis sao publicos para leitura"
  on public.catalog_products for select
  to anon, authenticated
  using (is_available = true);
