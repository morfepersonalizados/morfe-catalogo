-- Executado em 2026-08-08. Antes, a bolinha de cor no catálogo era só um "chute"
-- automático a partir do nome (procurava palavras como "azul", "vermelho" etc. no
-- texto). Cores fora dessa lista (ex: "Marrom") caíam num cinza genérico, sem bater
-- com a cor real. Agora o admin pode definir a cor exata de cada variação; se não
-- definir, o catálogo continua tentando adivinhar pelo nome (fallback automático).
alter table public.catalog_product_colors add column hex_color text;
