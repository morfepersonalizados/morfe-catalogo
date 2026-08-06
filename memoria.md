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
- **2026-08-05** — Repositório `morfepersonalizados/morfe-catalogo` criado (público, sem segredos no código) e primeiro commit enviado. `gh repo create --push` foi bloqueado pelo classificador do modo automático (bloqueio fixo, não contorna com confirmação em chat); caminho usado: usuário criou o repositório vazio pelo site, e o push comum (`git push`) funcionou normalmente.

## Problemas encontrados e soluções
- ERP (`morfe-ERP`) é um app 100% client-side (sem servidor próprio): senha e URL de sincronização ficam sempre visíveis a quem abrir o site, independente do repositório ser público ou privado. Mitigação aplicada: rotação de credenciais. Correção definitiva pendente: migrar para autenticação real (ligada à mesma base Supabase) — ver pendências.
- Sem ferramenta de automação de navegador instalada (Playwright/chromium-cli ausentes) — verificação visual da página ficou por conta do usuário abrindo o arquivo localmente, em vez de screenshot automatizado.

- **2026-08-05** — Catálogo publicado na Vercel: projeto `morfe-catalogo-xfyv` (time "Morfê"), conectado ao repositório GitHub `morfepersonalizados/morfe-catalogo`, Root Directory `catalogo/`, deploy automático a cada push na branch `main`. URL ao vivo: https://morfe-catalogo-xfyv.vercel.app (confirmado HTTP 200, catálogo carregando). `vercel --prod` via CLI também foi bloqueado pelo classificador do modo automático; caminho usado: import do repositório pelo painel da Vercel (usuário), sem precisar de comando de deploy meu.

- **2026-08-06** — Definida a direção visual do catálogo, a partir de uma referência do Dribbble ("Gadgets shop", https://dribbble.com/shots/18320234) que o usuário gostou. Paleta oficial extraída por amostragem de pixel do arquivo "Logos morfe" no Canva (`DAG29BOqNtI`, acesso via conector Canva já autorizado): usuário confirmou usar **só** a variação marrom/terracota (`#4C2507` principal, `#FFFBE2` creme, `#B18C35` dourado de acento) — não a azul nem a rosa, que também existem no brand kit. Documentado em `design/paleta.md`. Logo em alta resolução exportado do Canva e salvo em `design/logo-morfe-marrom.png`.
- **2026-08-06** — Lista de funcionalidades a adaptar da referência (aprovada implicitamente, sem objeção do usuário): cards de produto com selo/categoria/preço em destaque, blocos de categoria coloridos, página de detalhe do produto com seletor de personalização (cor/texto), favoritar (local, sem login), busca por nome. Explicitamente fora de escopo: carrinho/checkout multi-item, filtro pesado (faixa de preço/marca), avaliações com estrelas, newsletter.

- **2026-08-06** — Criado sistema de admin: tabela `catalog_admins` (allowlist), tabela `catalog_product_colors` (variação de cor/modelo por produto), políticas RLS de escrita restritas a admin autenticado. Conta de admin criada via Supabase Auth para `alencarjv2015@gmail.com` (senha gerada e entregue ao usuário fora do repositório — nunca commitar credencial).
- **2026-08-06** — Cores por produto confirmadas com o usuário: Caneca Interior Colorido e Caneca Interior e Alça Colorida (azul, vermelho, preto, amarelo, verde, rosa); Caneca Chopp (degradê azul fosco, degradê vermelho fosco, mais podem ser adicionados); Mouse Pad varia por formato (não cor) — já modelado como produtos separados; Azulejo varia por tamanho — já modelado como produtos separados. Cores de Tarja Branca/Glitter/Mágica/Vidro Fosco ficam para o usuário cadastrar via admin quando estiver pronto, em vez de levantar tudo agora.
- **2026-08-06** — Criada pasta-template reaproveitável em `c:\Users\alenc\Downloads\catalogo-produto-template\PROMPT.md` — receita genérica (sem dado da Morfê) do que foi aprendido nesse projeto, para usar como ponto de partida em catálogos de outros negócios (fase 2). Deve ser atualizada conforme o catálogo da Morfê evoluir.

## Pendências / próximos passos
- Testar o link ao vivo (https://morfe-catalogo-xfyv.vercel.app) no celular, vindo do WhatsApp/Instagram como um cliente real faria.
- Considerar domínio próprio (ex: catalogo.morfepersonalizados.com.br) em vez do domínio `.vercel.app` padrão, quando fizer sentido.
- Produtos que existem no ERP mas não têm foto: se/quando o usuário mandar fotos, evoluir o catálogo de texto-only para incluir imagem.
- Migração de longo prazo do ERP para autenticação real via Supabase (mencionada como ideia, não decidida).
- Fase 2 (generalizar o catálogo como produto pra vender pra outros negócios) ainda não iniciada — depende de validar a fase 1 primeiro.
