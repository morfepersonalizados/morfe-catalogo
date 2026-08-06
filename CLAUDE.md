# Projeto: Catálogo Morfê → produto revendável

## O que é isto
Fase 1: catálogo web para a Morfê Personalizados (Manaus-AM), navegável, com pedido via WhatsApp.
Fase 2 (futura): generalizar essa base para vender catálogos/sistemas parecidos para outros negócios, local e online.

Decisões e histórico completo: ver [memoria.md](memoria.md).

## Estrutura de pastas
- `catalogo/` — o site em si (o que vai pro ar). Hoje é só `index.html`.
- `design/` — referências visuais, mockups, capturas de tela de inspiração/concorrentes. Nada de código.
- `dados/` — scripts SQL (migrations do Supabase), numerados na ordem em que foram executados. Serve pra reconstruir o banco do zero se precisar.
- `CLAUDE.md` / `memoria.md` — na raiz, documentação do projeto.

## Stack e por quê
- **Dados:** Supabase (Postgres + RLS), projeto `loja morfe` (id `rzicwtwowfyogtcqekun`), tabelas `catalog_categories` / `catalog_products`.
- **Front-end:** HTML/CSS/JS puro, sem framework, consumindo a REST API do Supabase com a chave publicável (`sb_publishable_...`).
- **Hospedagem:** gerenciada (GitHub Pages agora; Netlify quando o usuário autorizar o conector). **Nunca** hospedagem manual tipo Hostinger/FTP — decisão explícita do usuário para evitar se tornar responsável por manutenção/segurança de servidor.

## Como trabalhar comigo
- Ferramentas que o usuário já usa/tem conta: **GitHub, Vercel, Google Apps Script**. Supabase ele tem mas não usa há tempo.
- Antes de acessar qualquer ferramenta/conta conectada (GitHub, Vercel, Supabase, etc.) ou fazer algo em sistema externo, **sempre perguntar antes e explicar o que vai ser feito e por quê** — mesmo com permissão já dada antes, confirmar de novo a cada ação relevante.
- Manter as coisas separadas e organizadas (design, código, dados, documentação) — nunca misturado — para que dê pra reverter ou recomeçar de uma base limpa se algo der errado.
- `memoria.md`: atualizar proativamente sempre que fizer sentido, sem precisar perguntar.
- Regras novas que o usuário disser na conversa: se for claramente uma regra, adicionar aqui direto; se não tiver certeza se cabe aqui, perguntar antes.

## Regras
- Não colocar segredos sensíveis (senhas, chaves privadas, service_role key) em código client-side. Só chave publicável + RLS restritiva.
- Toda tabela nova precisa de RLS habilitado com política explícita antes de ser considerada pronta — nunca depender de "ninguém vai adivinhar a URL".
- Não trocar a stack (ex: introduzir framework, trocar Supabase por outro backend) sem avisar e explicar antes.
- Antes de mudanças grandes de arquitetura ou de mexer em dados reais (produção, pedidos, clientes), explicar o plano e esperar confirmação.
- Ações reversíveis e locais: pode seguir direto. Ações em sistemas externos/produção (deploy, escrita em banco com dados reais, rotação de credenciais): confirmar antes.
- Ao final de decisões importantes, registrar em `memoria.md`.

## Checklist antes de publicar qualquer versão
- [ ] Sem caminhos quebrados / sem placeholders esquecidos
- [ ] Só caminhos relativos (funciona em qualquer domínio)
- [ ] Sem arquivos temporários ou console.log de debug
- [ ] Testado em mobile (é onde a maioria dos clientes vai abrir, vindo do WhatsApp/Instagram)
- [ ] Console do navegador sem erros
- [ ] `memoria.md` atualizado
