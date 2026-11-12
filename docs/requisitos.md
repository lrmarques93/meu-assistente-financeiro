# Requisitos do produto — MVP

## Objetivo
Aplicativo web responsivo de finanças pessoais, multiusuário e futuramente comercializável.

## Escopo inicial
- Dashboard com receitas, despesas e saldo.
- Cadastro de contas bancárias, dinheiro, cartões e benefícios.
- Cadastro de categorias.
- Lançamentos manuais.
- Preparação para entrada por WhatsApp (texto, áudio e imagem).
- Classificação assistida por IA com confirmação quando houver ambiguidade.

## Regras essenciais
1. Persistir dinheiro em centavos inteiros.
2. Despesa compartilhada: preservar valor total e participantes; somar nos relatórios pessoais apenas a parcela do titular.
3. Compra no cartão gera despesa; pagamento da fatura liquida obrigação e não gera nova despesa.
4. Transferência entre contas próprias não altera receita/despesa consolidada.
5. Mensagens recebidas precisam de idempotência para evitar duplicidade.
6. IA não deve confirmar dados ausentes por suposição.
7. Dados isolados por usuário com Row Level Security.

## Fora do primeiro corte
- Open Finance.
- Aplicativo nativo.
- Assinaturas e cobrança comercial.
- Sincronização automática de extratos.
