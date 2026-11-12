# Arquitetura inicial

- Frontend: Next.js App Router + TypeScript.
- Banco e autenticação: Supabase PostgreSQL/Auth.
- IA: OpenAI API via rotas server-side.
- Mensageria: WhatsApp Cloud API via webhook server-side.
- Deploy: Vercel.

## Fluxo WhatsApp futuro
Webhook recebe evento -> valida assinatura/token -> identifica usuário -> registra mensagem com chave idempotente -> extrai/transcreve conteúdo -> IA retorna proposta estruturada -> validador aplica regras financeiras -> grava ou solicita confirmação -> responde no WhatsApp.

Segredos de API somente no servidor. Aplicar RLS em todas as tabelas com dados de usuário.
