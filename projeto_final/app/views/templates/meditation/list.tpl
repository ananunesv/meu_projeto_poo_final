<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minhas Meditações - Zen Mind</title>
    <link rel="stylesheet" type="text/css" href="/static/css/base.css">
</head>
<body>
    <nav class="main-nav">
        <div class="nav-container">
            <div class="logo">
                <span class="logo-icon">🧘</span>
                <span class="logo-text">Zen Mind</span>
            </div>
            <ul class="nav-links">
                <li><a href="/">Início</a></li>
                <li><a href="/dashboard">Dashboard</a></li>
                <li><a href="/meditacoes" class="active">Minhas Meditações</a></li>
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
    
    <main class="meditation-list-content">
        <div class="container">
            <div class="page-header">
                <h1>Minhas Meditações</h1>
                <a href="/meditacoes/nova" class="btn-primary">Nova Meditação</a>
            </div>
            
            {% if meditations %}
                <div class="meditations-grid">
                    {% for meditation in meditations %}
                    <div class="meditation-card">
                        <h3><a href="/meditacoes/{{meditation.id}}">{{meditation.title}}</a></h3>
                        <p class="meditation-meta">
                            {{meditation.category}} • {{meditation.get_duration_formatted()}}
                        </p>
                        <p class="meditation-description">{{meditation.description[:100]}}...</p>
                        <div class="meditation-actions">
                            <a href="/meditacoes/{{meditation.id}}" class="btn-view">Ver</a>
                            <a href="/meditacoes/{{meditation.id}}/editar" class="btn-edit">Editar</a>
                            <form method="post" action="/meditacoes/{{meditation.id}}/deletar" style="display:inline;">
                                <button type="submit" class="btn-delete" onclick="return confirm('Tem certeza?')">Excluir</button>
                            </form>
                        </div>
                    </div>
                    {% endfor %}
                </div>
            {% else %}
                <div class="empty-state">
                    <h2>Nenhuma meditação ainda</h2>
                    <p>Crie sua primeira sessão de meditação!</p>
                    <a href="/meditacoes/nova" class="btn-primary">Criar Meditação</a>
                </div>
            {% endif %}
        </div>
    </main>
</body>
</html>