-- Executado em 2026-08-07/08. Usuário pediu pra não precisar digitar selo e prazo —
-- viram checkbox/número. Nenhum produto tinha badge/prazo_producao preenchido ainda,
-- então trocar a coluna foi seguro (sem dado pra migrar).

-- Selo: texto livre -> array de selos fixos (checkbox no admin). "Novo" não é
-- salvo — é calculado na hora a partir de created_at (produtos com até 21 dias).
alter table public.catalog_products drop column badge;
alter table public.catalog_products add column badges text[] not null default '{}';

-- Prazo de produção: texto livre -> número de dias úteis (0 = mesmo dia).
alter table public.catalog_products drop column prazo_producao;
alter table public.catalog_products add column prazo_dias int;

-- Registro simples de interesse (produto adicionado à lista de pedido no catálogo),
-- pra dar pra ordenar "mais pedido". É intenção do cliente, não confirmação de venda
-- (o pedido de verdade fecha no WhatsApp, fora do nosso alcance).
create table public.catalog_interesse (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.catalog_products(id) on delete cascade,
  created_at timestamptz default now()
);

alter table public.catalog_interesse enable row level security;

create policy "qualquer um registra interesse"
  on public.catalog_interesse for insert
  to anon, authenticated
  with check (true);

create policy "interesse e publico para leitura"
  on public.catalog_interesse for select
  to anon, authenticated
  using (true);
