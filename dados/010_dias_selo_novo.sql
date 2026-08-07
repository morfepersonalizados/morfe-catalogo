-- Executado em 2026-08-08. Usuário pediu controle sobre por quanto tempo o selo
-- "Novo" fica ativo (e poder desligar ele). 0 = desativado. Editável na aba Loja do admin.
alter table public.catalog_settings add column dias_selo_novo int not null default 21;
