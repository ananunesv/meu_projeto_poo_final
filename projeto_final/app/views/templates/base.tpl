<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}Zen Mind - Plataforma de Meditação{% endblock %}</title>
    
    <!-- CSS Base -->
    <link rel="stylesheet" type="text/css" href="/static/css/base.css">
    {% block extra_css %}{% endblock %}
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="/static/img/zen-icon.png">
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
                {% if current_user %}
                    <li><a href="/dashboard">Dashboard</a></li>
                    <li><a href="/meditacoes">Minhas Meditações</a></li>
                    <li><a href="/forum">Fórum</a></li>
                    <li class="user-menu">
                        <span>Olá, {{current_user.username}}!</span>
                        <form method="post" action="/logout" style="display:inline;">
                            <button type="submit" class="logout-btn">Sair</button>
                        </form>
                    </li>
                {% else %}
                    <li><a href="/login" class="nav-cta">Entrar</a></li>
                {% endif %}
            </ul>
        </div>
    </nav>
    
    <!-- Conteúdo Principal -->
    <main class="main-content">
        {% block content %}{% endblock %}
    </main>
    
    <!-- Footer -->
    <footer class="main-footer">
        <div class="footer-content">
            <p>&copy; 2025 Zen Mind - Projeto Acadêmico UnB</p>
            <div class="footer-links">
                <a href="/helper">Documentação</a>
                <a href="/download">Download App</a>
            </div>
        </div>
    </footer>
    
    <!-- JavaScript Base -->
    <script src="/static/js/main.js"></script>
    {% block extra_js %}{% endblock %}
</body>
</html>
