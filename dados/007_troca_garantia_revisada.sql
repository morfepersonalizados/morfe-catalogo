-- Executado em 2026-08-07. Reescrita da política de troca/garantia com embasamento
-- legal real (usuário pediu pra pesquisar como outros negócios fazem), depois de
-- pesquisa sobre CDC: direito de arrependimento (Art. 49, 7 dias, compra fora do
-- estabelecimento) tecnicamente vale mesmo pra personalizado — a lei não abre exceção
-- explícita — mas jurisprudência (TJSP) reconhece que, se o fornecedor informa
-- claramente ANTES da compra que produto personalizado não tem troca por
-- arrependimento (já que não pode ser reaproveitado pra outro cliente), o consumidor
-- fica vinculado a essa política. Por isso o texto abaixo é explícito e visível antes
-- do pedido ser fechado. Garantia contra defeito de fabricação usa o prazo real do
-- CDC Art. 26 (90 dias pra bem durável, contados do recebimento p/ vício aparente).
update public.catalog_settings set
  troca_garantia = 'Cada peça é feita sob encomenda, especialmente para você — por isso, depois que a produção começa, não fazemos troca ou cancelamento por arrependimento (mudança de ideia sobre cor, tema, texto etc.), já que uma peça personalizada não pode ser reaproveitada para outro cliente. Por isso, revise com atenção os detalhes da personalização (nome, cor, arte) antes de confirmar o pedido.

Se o produto chegar com defeito de fabricação, você tem até 90 dias após o recebimento pra reclamar — é a garantia legal prevista no Código de Defesa do Consumidor (Art. 26). É só chamar a gente no WhatsApp com fotos ou vídeo do problema; resolvemos com troca ou reparo, sem custo.'
where id = 1;

update public.catalog_faq set
  resposta = 'Como é feito sob encomenda especialmente pra você, não fazemos troca por arrependimento — revise os detalhes da personalização antes de confirmar. Já em caso de defeito de fabricação, você tem até 90 dias pra reclamar (garantia legal do CDC): é só chamar a gente no WhatsApp com fotos do problema.'
where pergunta = 'Posso trocar se eu não gostar do resultado?';
