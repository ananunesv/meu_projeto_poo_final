<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Zen Mind</title>
    <link rel="stylesheet" type="text/css" href="/static/css/base.css">
    <link rel="stylesheet" type="text/css" href="/static/css/meditation.css">
</head>
<body>
    <!-- Navegação -->
    <nav class="main-nav">
        <div class="nav-container">
            <div class="logo">
                <span class="logo-icon">🧘</span>
                <span class="logo-text">Zen Mind</span>
            </div>
            
            <ul class="nav-links">
                <li><a href="/">Início</a></li>
                <li><a href="/dashboard" class="active">Dashboard</a></li>
                <li><a href="/meditacoes">Minhas Meditações</a></li>
                <li><a href="/forum">Fórum</a></li>
                <li class="user-menu">
                    <span>Olá, {{current_user.username}}!</span>
                    <form method="post" action="/logout" style="display:inline;">
                        <button type="submit" class="logout-btn">Sair</button>
                    </form>
                </li>
            </ul>
        </div>
    </nav>
    
    <!-- Conteúdo Principal -->
    <main class="dashboard-content">
        <div class="container">
            <!-- Header do Dashboard -->
            <div class="dashboard-header">
                <h1>Bem-vindo, {{current_user.username}}! 🧘</h1>
                <p>Acompanhe seu progresso e gerencie suas meditações</p>
            </div>
            
            <!-- Estatísticas -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">📊</div>
                    <div class="stat-info">
                        <h3>{{stats.total_meditations}}</h3>
                        <p>Meditações Criadas</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">⏱️</div>
                    <div class="stat-info">
                        <h3>{{stats.total_duration}} min</h3>
                        <p>Tempo Total</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">📈</div>
                    <div class="stat-info">
                        <h3>{{stats.average_duration}} min</h3>
                        <p>Duração Média</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">🎯</div>
                    <div class="stat-info">
                        <h3>{{stats.categories|length}}</h3>
                        <p>Categorias Utilizadas</p>
                    </div>
                </div>
            </div>
            
            <!-- Ações Rápidas -->
            <div class="quick-actions">
                <h2>Ações Rápidas</h2>
                <div class="action-cards">
                    <a href="/meditacoes/nova" class="action-card">
                        <div class="action-icon">➕</div>
                        <h3>Nova Meditação</h3>
                        <p>Crie uma nova sessão personalizada</p>
                    </a>
                    
                    <a href="/meditacoes" class="action-card">
                        <div class="action-icon">📝</div>
                        <h3>Minhas Meditações</h3>
                        <p>Visualize e edite suas sessões</p>
                    </a>
                    
                    <a href="/forum" class="action-card">
                        <div class="action-icon">💬</div>
                        <h3>Fórum</h3>
                        <p>Compartilhe experiências</p>
                    </a>
                </div>
            </div>
            
            <!-- Meditações Recentes -->
            {% if recent_meditations %}
            <div class="recent-meditations">
                <h2>Meditações Recentes</h2>
                <div class="meditation-list">
                    {% for meditation in recent_meditations %}
                    <div class="meditation-item">
                        <div class="meditation-info">
                            <h3><a href="/meditacoes/{{meditation.id}}">{{meditation.title}}</a></h3>
                            <p class="meditation-meta">
                                <span class="category">{{meditation.category}}</span>
                                <span class="duration">{{meditation.get_duration_formatted()}}</span>
                            </p>
                            <p class="meditation-description">{{meditation.description[:100]}}...</p>
                        </div>
                        <div class="meditation-actions">
                            <a href="/meditacoes/{{meditation.id}}" class="btn-view">Ver</a>
                            <a href="/meditacoes/{{meditation.id}}/editar" class="btn-edit">Editar</a>
                        </div>
                    </div>
                    {% endfor %}
                </div>
                
                <div class="view-all">
                    <a href="/meditacoes" class="btn-secondary">Ver todas as meditações</a>
                </div>
            </div>
            {% else %}
            <div class="empty-state">
                <div class="empty-icon">🧘‍♀️</div>
                <h2>Comece sua jornada!</h2>
                <p>Você ainda não criou nenhuma meditação. Que tal começar agora?</p>
                <a href="/meditacoes/nova" class="btn-primary">Criar primeira meditação</a>
            </div>
            {% endif %}
            
            <!-- Categorias Preferidas -->
            {% if stats.categories %}
            <div class="categories-chart">
                <h2>Suas Categorias Preferidas</h2>
                <div class="categories-list">
                    {% for category, count in stats.categories.items() %}
                    <div class="category-item">
                        <span class="category-name">{{category}}</span>
                        <span class="category-count">{{count}} sessões</span>
                        <div class="category-bar">
                            <div class="category-progress" style="width: {{(count / stats.total_meditations * 100)|round}}%"></div>
                        </div>
                    </div>
                    {% endfor %}
                </div>
            </div>
            {% endif %}
        </div>
    </main>
    
    <!-- JavaScript -->
    <script src="/static/js/main.js"></script>
    <script src="/static/js/meditation.js"></script>
</body>
</html>