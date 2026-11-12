'use client';

import { FormEvent, useState } from 'react';
import Link from 'next/link';
import { useSearchParams } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';

export default function LoginForm() {
  const searchParams = useSearchParams();
  const [mode, setMode] = useState<'signin' | 'signup'>('signin');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState('');
  const [error, setError] = useState(searchParams.get('error') ? 'Nao foi possivel concluir a autenticacao. Tente novamente.' : '');

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setLoading(true);
    setMessage('');
    setError('');

    try {
      const supabase = createClient();
      if (mode === 'signin') {
        const { error: authError } = await supabase.auth.signInWithPassword({ email, password });
        if (authError) throw authError;
        window.location.assign('/');
      } else {
        const { data, error: authError } = await supabase.auth.signUp({
          email,
          password,
          options: { emailRedirectTo: `${window.location.origin}/auth/callback` },
        });
        if (authError) throw authError;
        if (data.session) window.location.assign('/');
        else setMessage('Cadastro iniciado! Confira seu e-mail para confirmar a conta.');
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Ocorreu um erro. Tente novamente.');
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="authShell">
      <section className="authCard">
        <Link href="/" className="authBrand"><span className="brandIcon">M</span><span>Meu Assistente <b>Financeiro</b></span></Link>
        <p className="eyebrow">SUA VIDA FINANCEIRA, SOB CONTROLE</p>
        <h1>{mode === 'signin' ? 'Que bom ter você de volta.' : 'Vamos começar?'}</h1>
        <p className="authIntro">{mode === 'signin' ? 'Entre para acompanhar sua vida financeira.' : 'Crie sua conta para organizar suas finanças.'}</p>
        <form onSubmit={handleSubmit} className="authForm">
          <label htmlFor="email">E-mail</label>
          <input id="email" type="email" autoComplete="email" value={email} onChange={(e) => setEmail(e.target.value)} required placeholder="voce@email.com" />
          <label htmlFor="password">Senha</label>
          <input id="password" type="password" autoComplete={mode === 'signin' ? 'current-password' : 'new-password'} minLength={8} value={password} onChange={(e) => setPassword(e.target.value)} required placeholder="Mínimo de 8 caracteres" />
          {error && <p className="authError" role="alert">{error}</p>}
          {message && <p className="authMessage" role="status">{message}</p>}
          <button type="submit" disabled={loading}>{loading ? 'Aguarde...' : mode === 'signin' ? 'Entrar' : 'Criar minha conta'}</button>
        </form>
        <p className="authSwitch">{mode === 'signin' ? 'Ainda não tem conta?' : 'Já tem uma conta?'} <button type="button" onClick={() => { setMode(mode === 'signin' ? 'signup' : 'signin'); setError(''); setMessage(''); }}>{mode === 'signin' ? 'Criar conta' : 'Fazer login'}</button></p>
        <p className="authFoot">Seus dados financeiros são privados e vinculados à sua conta.</p>
      </section>
    </main>
  );
}
