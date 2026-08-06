-- Executado em 2026-08-06. Cores confirmadas com o usuário para os produtos que variam por cor.

insert into public.catalog_product_colors (product_id, name, sort_order)
select id, cor, ord
from public.catalog_products
cross join lateral (values
  ('Azul', 1), ('Vermelho', 2), ('Preto', 3), ('Amarelo', 4), ('Verde', 5), ('Rosa', 6)
) as cores(cor, ord)
where name in ('Caneca Interior Colorido 300ml', 'Caneca Interior e Alça Colorida');

insert into public.catalog_product_colors (product_id, name, sort_order)
select id, cor, ord
from public.catalog_products
cross join lateral (values
  ('Degradê Azul Fosco', 1), ('Degradê Vermelho Fosco', 2)
) as cores(cor, ord)
where name = 'Caneca Chopp';

-- Pendente: Tarja Branca, Glitter, Mágica e Vidro Fosco ficam para o usuário cadastrar
-- via /admin quando tiver definido as variações, em vez de assumir aqui.
