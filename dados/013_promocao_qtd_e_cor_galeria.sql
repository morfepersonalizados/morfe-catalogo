-- Executado em 2026-08-08.
-- Promoção por quantidade, 100% controlada pelo admin: a partir de X unidades do
-- MESMO produto, cada unidade passa a custar Y. Ex: Caneca Branca normal R$35,
-- promo_qtd_minima=2, promo_preco_unitario_cents=3250 -> comprando 2+, cada uma
-- sai a R$32,50 (R$65 no total de 2, em vez de R$70).
alter table public.catalog_products add column promo_qtd_minima int;
alter table public.catalog_products add column promo_preco_unitario_cents int;
