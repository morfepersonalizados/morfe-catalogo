# Memória do projeto

## Decisões aprovadas
- **2026-08-05** — Catálogo da Morfê: página web navegável (não loja completa com carrinho/pagamento), pedido finalizado via WhatsApp.
- **2026-08-05** — Hospedagem: ferramentas gerenciadas (Supabase + Netlify/GitHub Pages). Sem hospedagem manual/FTP.
- **2026-08-05** — Reaproveitar o projeto Supabase `loja morfe` já existente (não criar projeto novo), mas com **tabelas novas e simples** (`catalog_categories`, `catalog_products`) em vez do schema completo de e-commerce que já estava lá.
- **2026-08-05** — Catálogo fase 1 é só texto (nome, categoria, preço) — sem fotos, já que nenhum produto tinha foto cadastrada no ERP.
- **2026-08-05** — Metodologia de um documento externo (curso "Criando um Site com Claude Code"): aproveitar só a disciplina de documentação (CLAUDE.md/memoria.md) e o checklist de pré-publicação. Rejeitado hospedagem Hostinger/FTP e o padrão de site estático feito à mão por produto (não serve pro objetivo de produto revendável e reutilizável).

## Decisões rejeitadas
- Recriar o site do zero sem aproveitar nada do que já existia (rejeitado — havia backend Supabase real e utilizável).
- Seguir o fluxo Hostinger/FTP do documento externo (conflita com a decisão de hospedagem gerenciada).

## Alterações realizadas
- **2026-08-05** — Corrigida brecha de segurança no ERP (`morfepersonalizados/morfe-ERP`): senha antiga (`morfe2105`) do Google Apps Script exposta em repositório público; senha rotacionada para `Morfe2105@` e validada (senha antiga agora rejeitada pelo servidor, `index.html` atualizado e sincronização confirmada funcionando).
- **2026-08-05** — Limpeza no Supabase `loja morfe`: removidos 7 pedidos de teste (`status = pending_payment`) da tabela `orders` antiga (confirmados pelo usuário como teste).
- **2026-08-05** — Criadas tabelas `catalog_categories` e `catalog_products` no projeto Supabase `loja morfe`, com RLS: leitura pública só de categorias e produtos com `is_available = true`, sem política de escrita pública.
- **2026-08-05** — Inseridos 6 categorias e 17 produtos (dados reais recuperados do ERP via `Sheets API` do Google Apps Script, com autorização do usuário para leitura).
- **2026-08-05** — Criado `index.html` (catálogo estático, HTML/CSS/JS puro) em `c:\Users\alenc\Downloads\morfe\`, consumindo a API REST do Supabase com a chave publicável, com botão "Pedir" por produto que abre o WhatsApp (92994875346) com mensagem pré-preenchida.
- **2026-08-05** — Reorganizada a pasta do projeto: `catalogo/` (site), `design/` (referências visuais, incluindo screenshots da Printi já salvos pelo usuário), `dados/` (scripts SQL das migrations, numerados). Scripts SQL já executados no Supabase salvos em `dados/001_criar_tabelas_catalogo.sql` e `dados/002_popular_catalogo.sql`.
- **2026-08-05** — Instalado GitHub CLI (`gh`) via winget e autenticado como `morfepersonalizados` (login por device code, autorizado pelo usuário). Git configurado localmente (`user.name`/`user.email`) para permitir commits.

## Problemas encontrados e soluções
- ERP (`morfe-ERP`) é um app 100% client-side (sem servidor próprio): senha e URL de sincronização ficam sempre visíveis a quem abrir o site, independente do repositório ser público ou privado. Mitigação aplicada: rotação de credenciais. Correção definitiva pendente: migrar para autenticação real (ligada à mesma base Supabase) — ver pendências.
- Sem ferramenta de automação de navegador instalada (Playwright/chromium-cli ausentes) — verificação visual da página ficou por conta do usuário abrindo o arquivo localmente, em vez de screenshot automatizado.

## Pendências / próximos passos
- Usuário confirmar visualmente que `index.html` renderiza corretamente (categorias, preços, botão do WhatsApp).
- Decidir hospedagem final: GitHub Pages (disponível agora) vs Netlify (precisa o usuário autorizar o conector no claude.ai).
- Publicar o catálogo e testar o link real no celular.
- Produtos que existem no ERP mas não têm foto: se/quando o usuário mandar fotos, evoluir o catálogo de texto-only para incluir imagem.
- Migração de longo prazo do ERP para autenticação real via Supabase (mencionada como ideia, não decidida).
- Fase 2 (generalizar o catálogo como produto pra vender pra outros negócios) ainda não iniciada — depende de validar a fase 1 primeiro.
