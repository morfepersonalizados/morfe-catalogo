-- Executado em 2026-08-08. Usuário identificou um problema real: uma arte pode
-- valer pra vários produtos (ex: Homem-Aranha em várias canecas), mas uma foto/vídeo
-- de exemplo às vezes mostra especificamente UM produto (ex: vídeo mostrando a arte
-- só na caneca branca). Sem isso, esse vídeo aparecia enganosamente pra quem tava
-- vendo a mesma arte a partir de qualquer outro produto também.
-- NULL = mídia genérica (aparece pra todo mundo); preenchido = só aparece pra quem
-- estiver olhando a arte a partir daquele produto específico. Na galeria de temas
-- (sem produto no contexto), continua mostrando tudo.
alter table public.catalog_design_media
  add column product_id uuid references public.catalog_products(id) on delete set null;
