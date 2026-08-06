-- Executado em 2026-08-06. Biblioteca de artes/temas personalizáveis, ligada a
-- produtos por many-to-many (o mesmo tema pode valer pra vários produtos, ou só um
-- — não força uma regra única). Preço nunca vem da arte, só do produto (catalog_products).

create table public.catalog_designs (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  theme text,
  image_url text,
  sort_order int default 0,
  created_at timestamptz default now()
);

create table public.catalog_product_designs (
  product_id uuid not null references public.catalog_products(id) on delete cascade,
  design_id uuid not null references public.catalog_designs(id) on delete cascade,
  primary key (product_id, design_id)
);

alter table public.catalog_designs enable row level security;
alter table public.catalog_product_designs enable row level security;

create policy "artes sao publicas para leitura"
  on public.catalog_designs for select
  to anon, authenticated
  using (true);

create policy "vinculos de arte sao publicos para leitura"
  on public.catalog_product_designs for select
  to anon, authenticated
  using (true);

create policy "admin gerencia artes"
  on public.catalog_designs for all
  to authenticated
  using (exists (select 1 from public.catalog_admins where id = auth.uid()))
  with check (exists (select 1 from public.catalog_admins where id = auth.uid()));

create policy "admin gerencia vinculos de arte"
  on public.catalog_product_designs for all
  to authenticated
  using (exists (select 1 from public.catalog_admins where id = auth.uid()))
  with check (exists (select 1 from public.catalog_admins where id = auth.uid()));

-- Conjunto inicial de artes (nomes reais tirados dos arquivos do Canva da Morfê),
-- sem vínculo a produtos ainda — o usuário liga pelo admin, já que só ele sabe
-- com certeza em quais produtos cada arte se aplica.
insert into public.catalog_designs (name, theme, sort_order) values
  ('Homem-Aranha', 'Séries e Filmes', 1),
  ('Venom', 'Séries e Filmes', 2),
  ('Harry Potter', 'Séries e Filmes', 3),
  ('Séries (diversas)', 'Séries e Filmes', 4),
  ('Times de Futebol', 'Futebol e Boi-Bumbá', 1),
  ('Caprichoso e Garantido', 'Futebol e Boi-Bumbá', 2),
  ('Dia dos Namorados', 'Datas Comemorativas', 1),
  ('Dia das Mães', 'Datas Comemorativas', 2),
  ('Dia dos Pais', 'Datas Comemorativas', 3),
  ('Carnaval', 'Datas Comemorativas', 4),
  ('Cristã', 'Religioso', 1);
