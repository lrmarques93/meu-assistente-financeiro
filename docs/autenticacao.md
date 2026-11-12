# Autenticacao

A aplicacao usa Supabase Auth com cookies e PKCE por meio de `@supabase/ssr`.

## Variaveis
Configure no ambiente local e na Vercel:
- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`

Use somente a chave publishable no frontend. Nunca coloque secret/service_role em variavel NEXT_PUBLIC_.

## Fluxo
- `/login`: login por e-mail e senha e cadastro.
- `/auth/callback`: troca o codigo PKCE por sessao.
- `middleware.ts`: atualiza a sessao e protege rotas privadas.
- Clientes Supabase separados para navegador e servidor.

A confirmacao de e-mail deve ser configurada no painel do Supabase. Adicione a URL de callback do ambiente em Authentication > URL Configuration.
