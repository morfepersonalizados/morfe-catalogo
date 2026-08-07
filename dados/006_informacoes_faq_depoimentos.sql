-- Executado em 2026-08-06. Bloco "Como comprar / Dúvidas" do catálogo: informações
-- gerais da loja (pagamento, entrega, embalagem, troca/garantia, quem somos), FAQ e
-- depoimentos de clientes — tudo editável pelo admin, sem precisar mexer no código.
-- Prazo de produção NÃO entra em catalog_settings porque varia por produto/quantidade
-- (fica em catalog_products.prazo_producao, preenchido produto a produto).

create table public.catalog_settings (
  id int primary key default 1,
  quem_somos text,
  pagamento text,
  entrega text,
  embalagem text,
  troca_garantia text,
  updated_at timestamptz default now(),
  constraint catalog_settings_singleton check (id = 1)
);
insert into public.catalog_settings (id) values (1);

create table public.catalog_faq (
  id uuid primary key default gen_random_uuid(),
  pergunta text not null,
  resposta text not null,
  sort_order int default 0,
  created_at timestamptz default now()
);

create table public.catalog_depoimentos (
  id uuid primary key default gen_random_uuid(),
  texto text,
  imagem_url text,
  autor text,
  sort_order int default 0,
  created_at timestamptz default now()
);

alter table public.catalog_products add column prazo_producao text;

alter table public.catalog_settings enable row level security;
alter table public.catalog_faq enable row level security;
alter table public.catalog_depoimentos enable row level security;

create policy "settings sao publicas para leitura"
  on public.catalog_settings for select
  to anon, authenticated
  using (true);

create policy "faq e publico para leitura"
  on public.catalog_faq for select
  to anon, authenticated
  using (true);

create policy "depoimentos sao publicos para leitura"
  on public.catalog_depoimentos for select
  to anon, authenticated
  using (true);

create policy "admin gerencia settings"
  on public.catalog_settings for all
  to authenticated
  using (exists (select 1 from public.catalog_admins where id = auth.uid()))
  with check (exists (select 1 from public.catalog_admins where id = auth.uid()));

create policy "admin gerencia faq"
  on public.catalog_faq for all
  to authenticated
  using (exists (select 1 from public.catalog_admins where id = auth.uid()))
  with check (exists (select 1 from public.catalog_admins where id = auth.uid()));

create policy "admin gerencia depoimentos"
  on public.catalog_depoimentos for all
  to authenticated
  using (exists (select 1 from public.catalog_admins where id = auth.uid()))
  with check (exists (select 1 from public.catalog_admins where id = auth.uid()));

-- Conteúdo real (não placeholder) fornecido pelo dono da loja em 2026-08-06:
update public.catalog_settings set
  pagamento = 'Pix, cartão de crédito ou débito (via Mercado Pago).',
  entrega = 'A entrega fica por conta do cliente — pode pedir um Uber Entrega (ou similar) até nosso endereço, ou combinar retirada no local.',
  embalagem = 'Todo pedido sai da loja em uma sacola própria da Morfê. Alguns produtos, como as canecas, também vêm em uma caixinha; outros, como os azulejos, vão só na sacola — depende do formato da peça.',
  troca_garantia = 'Como cada peça é feita sob encomenda, especialmente pra você, não fazemos troca por arrependimento. Se o produto chegar com defeito de fabricação, chama a gente em até 7 dias após receber — resolvemos com troca ou reparo, sem custo. Fotos ou vídeo do problema ajudam a agilizar.'
where id = 1;
-- quem_somos ficou em branco (aguardando resposta do usuário sobre a loja), preenchível via admin.

insert into public.catalog_faq (pergunta, resposta, sort_order) values
  ('Vocês fazem entrega?', 'A entrega fica por conta do cliente (Uber Entrega ou similar). Também dá pra combinar retirada no local.', 1),
  ('Quais formas de pagamento vocês aceitam?', 'Pix, cartão de crédito ou débito, via Mercado Pago.', 2),
  ('O produto vem embalado?', 'Sim — todo pedido sai numa sacola própria da Morfê. Alguns produtos (como canecas) também vêm numa caixinha; outros (como azulejos) vão só na sacola, dependendo do formato.', 3),
  ('Como funciona a personalização?', 'Você escolhe o produto, a cor (quando tiver variação) e um tema/arte pronta — ou manda sua própria ideia na hora de fechar o pedido pelo WhatsApp.', 4),
  ('Posso trocar se eu não gostar do resultado?', 'Como é feito sob encomenda pra você, não fazemos troca por arrependimento. Em caso de defeito de fabricação, é só chamar a gente em até 7 dias após receber.', 5);
