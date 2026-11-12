# Changelog

## 0.3.0 — Supabase provisionado
- Criado projeto Supabase dedicado em São Paulo (sa-east-1).
- Aplicada migração inicial com seis tabelas e RLS.
- Criados índices para colunas de chaves estrangeiras.
- Consultadas políticas RLS e executados advisors: nenhum alerta de segurança.
- Tipos TypeScript gerados diretamente do banco.


## 0.2.0 — Autenticação e base de dados
- Adicionados clientes Supabase para navegador e servidor usando cookies SSR.
- Preparados login, cadastro, callback PKCE e middleware de proteção de rotas.
- Adicionada migração inicial com contas, cartões, categorias, transações, rateios e orçamentos.
- RLS e políticas de isolamento por usuário habilitadas na migração.
- Padronizada variável de chave pública para NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY.
- Ainda pendente: criar/conectar projeto Supabase dedicado, aplicar migração e executar build/testes.

## 0.1.0 — Scaffold inicial
- Identidade visual inicial.
- Dashboard estático responsivo.
- Estrutura de diretórios Next.js.
- Documentação de requisitos e regras financeiras.
- Preparação de variáveis de ambiente.
