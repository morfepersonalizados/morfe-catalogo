-- Executado em 2026-08-08. Cada cor/variação de produto (ex: "Interior Amarelo",
-- "Interior Azul") pode ter sua própria foto/vídeo. Ao escolher a cor no catálogo,
-- a imagem principal do produto troca pra mostrar aquela variação específica.
alter table public.catalog_product_colors add column image_url text;
