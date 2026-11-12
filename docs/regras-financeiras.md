# Regras financeiras

## Tipos de movimentação
- income: receita.
- expense: despesa.
- transfer: transferência entre contas próprias.
- card_payment: pagamento de fatura (liquidação, não despesa nova).
- refund: reembolso, vinculado à despesa original quando possível.

## Valores
Armazenar valores em centavos (BIGINT), moeda BRL.

## Rateio
Guardar valor total, parcela do usuário, participantes e regra de divisão. Relatórios pessoais somam apenas a parcela do usuário.

## Cartões
Compra gera despesa e obrigação na fatura. Pagamento da fatura reduz saldo bancário e liquida a obrigação, sem duplicar a despesa.

## IA
Guardar conteúdo original, interpretação estruturada, confiança, estado (proposed/needs_confirmation/posted/rejected) e correções do usuário.
