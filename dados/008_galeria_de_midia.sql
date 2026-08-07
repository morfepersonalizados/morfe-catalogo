-- Executado em 2026-08-07. Antes só dava pra colocar 1 foto/vídeo por produto e por
-- arte (coluna image_url). Usuário pediu pra poder colocar mais de uma. image_url
-- continua sendo a capa (usada em cards/listagens); estas tabelas guardam os itens
-- extras da galeria, mostrados no quick-view do produto e no lightbox da arte.
create table public.catalog_product_media (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.catalog_products(id) on delete cascade,
  url text not null,
  sort_order int default 0,
  created_at timestamptz default now()
);

create table public.catalog_design_media (
  id uuid primary key default gen_random_uuid(),
  design_id uuid not null references public.catalog_designs(id) on delete cascade,
  url text not null,
  sort_order int default 0,
  created_at timestamptz default now()
);

alter table public.catalog_product_media enable row level security;
alter table public.catalog_design_media enable row level security;

create policy "midia de produto e publica para leitura"
  on public.catalog_product_media for select
  to anon, authenticated
  using (true);

create policy "midia de arte e publica para leitura"
  on public.catalog_design_media for select
  to anon, authenticated
  using (true);

create policy "admin gerencia midia de produto"
  on public.catalog_product_media for all
  to authenticated
  using (exists (select 1 from public.catalog_admins where id = auth.uid()))
  with check (exists (select 1 from public.catalog_admins where id = auth.uid()));

create policy "admin gerencia midia de arte"
  on public.catalog_design_media for all
  to authenticated
  using (exists (select 1 from public.catalog_admins where id = auth.uid()))
  with check (exists (select 1 from public.catalog_admins where id = auth.uid()));
