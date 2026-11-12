# Implantação do Supabase

## Projeto criado
- Nome: `meu-assistente-financeiro`
- Project ref: `kqymwzkwpcpfaezeyeiq`
- Região: `sa-east-1` (São Paulo)
- URL: `https://kqymwzkwpcpfaezeyeiq.supabase.co`
- Status: `ACTIVE_HEALTHY`
- Plano da organização no momento da criação: Free

O banco é separado do projeto `plataforma-contabil`.

## Criar o projeto
- Nome sugerido: `meu-assistente-financeiro`
- Região sugerida: `sa-east-1` (São Paulo)
- Após a criação, copiar a Project URL e a Publishable key.

## Aplicar o banco
No Supabase SQL Editor, executar o conteúdo de:
`supabase/migrations/202611120001_initial_schema.sql`

A migração cria as tabelas iniciais e habilita RLS com políticas de acesso limitadas ao usuário autenticado.

## Configurar autenticação
Em Authentication > URL Configuration:
- Definir a URL principal do app.
- Adicionar `https://SEU-DOMINIO/auth/callback` em Redirect URLs.
- Para desenvolvimento, adicionar `http://localhost:3000/auth/callback`.

Em Authentication > Providers, habilitar Email. A confirmação de e-mail pode permanecer ativada.

## Variáveis de ambiente
Configurar localmente em `.env.local` e no projeto Vercel:
- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`

Não adicionar service_role ou secret key ao frontend.

## Verificação após conexão
1. Aplicar migração e confirmar as seis tabelas.
2. Executar advisors de segurança e corrigir alertas.
3. Testar cadastro, confirmação de e-mail, login e logout.
4. Testar que um usuário não consegue ler ou alterar dados de outro.
