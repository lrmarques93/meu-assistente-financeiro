const cards = [
  { label: 'Receitas do mês', value: 'R$ 0,00', detail: 'Nenhuma receita cadastrada' },
  { label: 'Despesas do mês', value: 'R$ 0,00', detail: 'Nenhuma despesa cadastrada' },
  { label: 'Saldo disponível', value: 'R$ 0,00', detail: 'Cadastre suas contas para começar' },
];

export default function Home() {
  return (
    <main className="shell">
      <header className="topbar">
        <a className="brand" href="#"><span className="brandIcon">M</span><span>Meu Assistente <b>Financeiro</b></span></a>
        <span className="status"><i /> Protótipo inicial</span>
      </header>
      <section className="welcome">
        <div>
          <p className="eyebrow">CONTROLE FINANCEIRO INTELIGENTE</p>
          <h1>Sua vida financeira,<br /><em>sob controle.</em></h1>
          <p className="intro">Você conversa. A inteligência organiza.</p>
        </div>
        <div className="assistantCard">
          <div className="assistantIcon">✦</div>
          <div><strong>Seu assistente está chegando</strong><p>Em breve, registre despesas e receitas pelo WhatsApp, com texto, áudio ou foto.</p></div>
        </div>
      </section>
      <section className="sectionHead"><div><p className="eyebrow">VISÃO GERAL</p><h2>Resumo financeiro</h2></div><span className="period">Este mês</span></section>
      <section className="cards">
        {cards.map((card) => <article className="metric" key={card.label}><span className="metricLabel">{card.label}</span><strong>{card.value}</strong><small>{card.detail}</small></article>)}
      </section>
      <section className="lowerGrid">
        <article className="panel"><div className="panelHead"><h3>Últimos lançamentos</h3><span>0 registros</span></div><div className="empty"><div className="emptyIcon">＋</div><strong>Seu histórico começa aqui</strong><p>Adicione seu primeiro lançamento para acompanhar suas movimentações.</p></div></article>
        <article className="panel"><div className="panelHead"><h3>Comece por aqui</h3><span>Configuração</span></div><ul className="steps"><li><b>01</b><span><strong>Cadastre suas contas</strong><small>Bancos, dinheiro e benefícios</small></span></li><li><b>02</b><span><strong>Adicione seus cartões</strong><small>Limites e vencimentos</small></span></li><li><b>03</b><span><strong>Faça seu primeiro lançamento</strong><small>Manual ou pelo assistente</small></span></li></ul></article>
      </section>
      <footer>MEU ASSISTENTE FINANCEIRO <span>•</span> Versão 0.1.0</footer>
    </main>
  );
}
