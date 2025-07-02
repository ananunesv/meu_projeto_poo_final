%rebase('base.tpl', title='Zen Mind - Meditação Guiada para o Dia a Dia', extra_css='')

<!-- Main Container -->
<div class="container">
    <!-- Hero Section -->
    <section class="hero" id="home">
        <div class="hero-content">
            <h1 class="hero-title">
                Encontre sua <span class="gradient-text">paz interior</span> 
                em apenas 5 minutos por dia
            </h1>
            <p class="hero-subtitle">
                Meditações guiadas, sons relaxantes e exercícios de respiração 
                para reduzir o estresse e melhorar seu bem-estar.
            </p>
            <div class="hero-buttons">
                % if defined('current_user') and current_user:
                    <a href="/dashboard" class="primary-btn">
                        <span class="btn-icon">🧘</span>
                        Meu Dashboard
                    </a>
                    <a href="/meditacoes/nova" class="secondary-btn">
                        Nova Meditação
                    </a>
                % else:
                    <a href="/register" class="primary-btn">
                        <span class="btn-icon">📱</span>
                        Começar Grátis
                    </a>
                    <a href="/login" class="secondary-btn">
                        Já tenho conta
                    </a>
                % end
            </div>
            <div class="hero-stats">
                <div class="stat">
                    <span class="stat-number">2M+</span>
                    <span class="stat-label">Usuários ativos</span>
                </div>
                <div class="stat">
                    <span class="stat-number">4.8⭐</span>
                    <span class="stat-label">Avaliação</span>
                </div>
                <div class="stat">
                    <span class="stat-number">500+</span>
                    <span class="stat-label">Meditações</span>
                </div>
            </div>
        </div>
        <div class="hero-visual">
            <div class="phone-mockup">
                <div class="phone-screen">
                    <div class="app-interface">
                        <div class="breathing-circle"></div>
                        <p class="breathing-text">Respire...</p>
                    </div>
                </div>
            </div>
            <div class="floating-elements">
                <div class="float-element element-1">😌</div>
                <div class="float-element element-2">🌸</div>
                <div class="float-element element-3">☮️</div>
                <div class="float-element element-4">✝️</div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features" id="features">
        <div class="section-header">
            <h2 class="section-title">Recursos que transformam sua rotina</h2>
            <p class="section-subtitle">Tudo que você precisa para uma mente mais calma e focada</p>
        </div>
        
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <span>🎧</span>
                </div>
                <h3>Meditações Guiadas</h3>
                <p>Sessões de 5 a 60 minutos com instrutores certificados para todos os níveis.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <span>🌙</span>
                </div>
                <h3>Histórias para Dormir</h3>
                <p>Narrativas relaxantes que ajudam você a ter uma noite de sono tranquila.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <span>🌊</span>
                </div>
                <h3>Sons da Natureza</h3>
                <p>Biblioteca com sons de chuva, oceano, floresta e muito mais.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <span>📊</span>
                </div>
                <h3>Acompanhe seu Progresso</h3>
                <p>Estatísticas detalhadas sobre sua jornada de meditação e bem-estar.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <span>💨</span>
                </div>
                <h3>Exercícios de Respiração</h3>
                <p>Técnicas guiadas para reduzir ansiedade e aumentar o foco.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <span>🔔</span>
                </div>
                <h3>Lembretes Personalizados</h3>
                <p>Notificações gentis para manter sua prática diária.</p>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section class="pricing" id="pricing">
        <div class="section-header">
            <h2 class="section-title">Escolha seu plano</h2>
            <p class="section-subtitle">Comece grátis e evolua no seu ritmo</p>
        </div>
        
        <div class="pricing-cards">
            <div class="pricing-card">
                <h3 class="plan-name">Gratuito</h3>
                <div class="plan-price">
                    <span class="price">R$ 0</span>
                    <span class="period">/mês</span>
                </div>
                <ul class="plan-features">
                    <li>10 meditações básicas</li>
                    <li>3 sons relaxantes</li>
                    <li>Exercícios de respiração</li>
                    <li>Acompanhamento básico</li>
                </ul>
                % if defined('current_user') and current_user:
                    <a href="/dashboard" class="plan-btn secondary">Ir ao Dashboard</a>
                % else:
                    <a href="/register" class="plan-btn secondary">Começar Agora</a>
                % end
            </div>
            
            <div class="pricing-card featured">
                <div class="popular-badge">Mais Popular</div>
                <h3 class="plan-name">Premium</h3>
                <div class="plan-price">
                    <span class="price">R$ 19,90</span>
                    <span class="period">/mês</span>
                </div>
                <ul class="plan-features">
                    <li>500+ meditações</li>
                    <li>Todos os sons e músicas</li>
                    <li>Histórias para dormir</li>
                    <li>Modo offline</li>
                    <li>Estatísticas avançadas</li>
                    <li>Sem anúncios</li>
                </ul>
                % if defined('current_user') and current_user:
                    <a href="/meditacoes" class="plan-btn primary">Ver Meditações</a>
                % else:
                    <a href="/register" class="plan-btn primary">Teste 7 dias grátis</a>
                % end
            </div>
            
            <div class="pricing-card">
                <h3 class="plan-name">Família</h3>
                <div class="plan-price">
                    <span class="price">R$ 29,90</span>
                    <span class="period">/mês</span>
                </div>
                <ul class="plan-features">
                    <li>Tudo do Premium</li>
                    <li>Até 6 contas</li>
                    <li>Conteúdo para crianças</li>
                    <li>Controle parental</li>
                    <li>Suporte prioritário</li>
                </ul>
                % if defined('current_user') and current_user:
                    <a href="/forum" class="plan-btn secondary">Visitar Fórum</a>
                % else:
                    <a href="/register" class="plan-btn secondary">Escolher Plano</a>
                % end
            </div>
        </div>
    </section>

    <!-- Download Section -->
    <section class="download" id="download">
        <div class="download-content">
            <h2 class="download-title">Pronto para transformar sua vida?</h2>
            <p class="download-subtitle">
                % if defined('current_user') and current_user:
                    Continue sua jornada de meditação e explore todos os recursos disponíveis.
                % else:
                    Junte-se a milhões de pessoas que já descobriram os benefícios da meditação diária.
                % end
            </p>
            <div class="download-buttons">
                % if defined('current_user') and current_user:
                    <a href="/meditacoes/nova" class="store-btn" style="background: linear-gradient(45deg, #667eea, #764ba2); color: white; text-decoration: none; padding: 12px 24px; border-radius: 8px; display: inline-block; margin: 0 10px;">
                        Nova Meditação
                    </a>
                    <a href="/helper" class="store-btn" style="background: linear-gradient(45deg, #667eea, #764ba2); color: white; text-decoration: none; padding: 12px 24px; border-radius: 8px; display: inline-block; margin: 0 10px;">
                        Documentação
                    </a>
                % else:
                    <a href="/register" class="store-btn">
                        <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjQwIiB2aWV3Qm94PSIwIDAgMTIwIDQwIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8cmVjdCB3aWR0aD0iMTIwIiBoZWlnaHQ9IjQwIiByeD0iOCIgZmlsbD0iYmxhY2siLz4KPHRleHQgeD0iNjAiIHk9IjI1IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSJ3aGl0ZSIgZm9udC1mYW1pbHk9IkFyaWFsIiBmb250LXNpemU9IjE0Ij5DcmllIENvbnRhPC90ZXh0Pgo8L3N2Zz4=" alt="Criar Conta">
                    </a>
                    <a href="/login" class="store-btn">
                        <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjQwIiB2aWV3Qm94PSIwIDAgMTIwIDQwIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8cmVjdCB3aWR0aD0iMTIwIiBoZWlnaHQ9IjQwIiByeD0iOCIgZmlsbD0iYmxhY2siLz4KPHRleHQgeD0iNjAiIHk9IjI1IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSJ3aGl0ZSIgZm9udC1mYW1pbHk9IkFyaWFsIiBmb250LXNpemU9IjE0Ij5GYXplciBMb2dpbjwvdGV4dD4KPC9zdmc+" alt="Fazer Login">
                    </a>
                % end
            </div>
            % if not (defined('current_user') and current_user):
            <div class="qr-code">
                <div class="qr-placeholder">QR</div>
                <p>Escaneie para baixar</p>
            </div>
            % end
        </div>
    </section>
</div>

<!-- Scroll to top button -->
<button class="scroll-top" aria-label="Voltar ao topo">↑</button>