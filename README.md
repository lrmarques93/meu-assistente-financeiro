# Meu Assistente Financeiro

Sua vida financeira, sob controle. Você conversa. A inteligência organiza.

Aplicação web responsiva para organização financeira pessoal, com evolução planejada para uma plataforma multiusuário.

## Stack
- Next.js 15 + React 19 + TypeScript
- Supabase Auth + PostgreSQL
- Vercel (deploy planejado)

## Começar localmente
1. Instale Node.js 20 ou superior.
2. Execute `npm install`.
3. Copie `.env.example` para `.env.local`.
4. Preencha `NEXT_PUBLIC_SUPABASE_URL` e `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` com os dados do projeto Supabase.
5. Execute `npm run dev`.

## Estado atual
- Dashboard inicial responsivo.
- Login e cadastro por e-mail/senha preparados com Supabase Auth.
- Sessão SSR por cookies e proteção de rotas preparadas.
- Migração SQL inicial com contas, cartões, categorias, lançamentos, rateios e orçamentos, todas com RLS.
- Projeto Supabase dedicado criado e ativo em São Paulo.
- Migração inicial aplicada; seis tabelas confirmadas com RLS habilitado.
- Tipos TypeScript gerados a partir do schema real.
- Build e testes automatizados ainda precisam ser executados.

## Documentação
- [Requisitos](docs/requisitos.md)
- [Arquitetura](docs/arquitetura.md)
- [Regras financeiras](docs/regras-financeiras.md)
- [Autenticação](docs/autenticacao.md)
- [Implantação Supabase](docs/implantacao-supabase.md)
- [Changelog](docs/changelog.md)

## Segurança
Nunca envie chaves secret/service_role ao navegador. Use somente a chave publishable em variáveis `NEXT_PUBLIC_`. Todas as tabelas expostas no schema public devem manter RLS habilitado.
