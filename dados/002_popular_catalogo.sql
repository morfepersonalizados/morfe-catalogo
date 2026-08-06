-- Executado em 2026-08-05. Dados recuperados do ERP (morfe-ERP) via leitura autorizada da Sheets API.
-- 6 categorias e 17 produtos.

insert into public.catalog_categories (name, sort_order) values
  ('Caneca', 1),
  ('Azulejo', 2),
  ('Mouse Pad', 3),
  ('Chaveiro', 4),
  ('Adesivo', 5),
  ('Outros', 6);

insert into public.catalog_products (category_id, name, price_cents, sort_order) values
  ((select id from public.catalog_categories where name='Azulejo'), 'Azulejo 10x10 cm', 2500, 1),
  ((select id from public.catalog_categories where name='Azulejo'), 'Azulejo 15x15 cm', 3500, 2),
  ((select id from public.catalog_categories where name='Azulejo'), 'Azulejo 20x20 cm', 4500, 3),
  ((select id from public.catalog_categories where name='Caneca'), 'Caneca Branca', 3500, 1),
  ((select id from public.catalog_categories where name='Caneca'), 'Caneca Chopp', 5000, 2),
  ((select id from public.catalog_categories where name='Caneca'), 'Caneca Glitter', 5000, 3),
  ((select id from public.catalog_categories where name='Caneca'), 'Caneca Interior Colorido 300ml', 4500, 4),
  ((select id from public.catalog_categories where name='Caneca'), 'Caneca Interior e Alça Colorida', 5500, 5),
  ((select id from public.catalog_categories where name='Caneca'), 'Caneca Mágica', 4000, 6),
  ((select id from public.catalog_categories where name='Caneca'), 'Caneca Tarja', 5000, 7),
  ((select id from public.catalog_categories where name='Caneca'), 'Caneca Vidro Fosco', 4000, 8),
  ((select id from public.catalog_categories where name='Mouse Pad'), 'Mouse Pad Redondo/Coração', 4000, 1),
  ((select id from public.catalog_categories where name='Mouse Pad'), 'Mouse Pad Retangular', 3500, 2),
  ((select id from public.catalog_categories where name='Mouse Pad'), 'Mouse Pad Ergonômico', 4500, 3),
  ((select id from public.catalog_categories where name='Chaveiro'), 'Chaveiro Personalizado', 1500, 1),
  ((select id from public.catalog_categories where name='Adesivo'), 'Adesivo Escolar (1 cartela)', 1500, 1),
  ((select id from public.catalog_categories where name='Outros'), 'Quebra-cabeça Personalizado', 3000, 1);
