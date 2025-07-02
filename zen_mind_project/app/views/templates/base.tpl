<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{get('title', 'Zen Mind - Plataforma de Meditação')}}</title>
    
    <!-- CSS Base -->
    <link rel="stylesheet" type="text/css" href="/static/css/base.css">
    % if defined('extra_css'):
    {{!extra_css}}
    % end
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="/static/img/zen-icon.png">
    
    <!-- Estilos adicionais para layout -->
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }
        
        .main-content {
            min-height: calc(100vh - 140px);
            padding: 2rem 0;
        }
        
        /* Estilos para formulários */
        .form-content {
            background: #f5f5f5;
            min-height: calc(100vh - 140px);
            padding: 2rem 0;
        }
        
        .form-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .form-header h1 {
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .form-header p {
            color: #666;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            border: 1px solid #f5c6cb;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            border: 1px solid #c3e6cb;
        }
        
        /* Estilos para fórum */
        .forum-content {
            background: #f5f5f5;
            min-height: calc(100vh - 140px);
            padding: 2rem 0;
        }
        
        .forum-header {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .forum-stats {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .stats-card, .online-users {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .new-post {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .posts-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .post-item {
            border-bottom: 1px solid #eee;
            padding: 1.5rem 0;
        }
        
        .post-item:last-child {
            border-bottom: none;
        }
        
        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .post-author {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .post-content {
            line-height: 1.6;
        }
        
        .websocket-status {
            background: white;
            padding: 1rem;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <!-- Navegação -->
    <nav class="main-nav">
        <div class="nav-container">
            <a href="/" class="logo">
                <span class="logo-icon">🧘</span>
                <span class="logo-text">Zen Mind</span>
            </a>
            
            <ul class="nav-links">
                <li><a href="/">Início</a></li>
                % if defined('current_user') and current_user:
                    <li><a href="/dashboard">Dashboard</a></li>
                    <li><a href="/meditacoes">Minhas Meditações</a></li>
                    <li><a href="/forum">Fórum</a></li>
                    <li class="user-menu">
                        <span>Olá, {{current_user.username}}!</span>
                        <form method="post" action="/logout" style="display:inline;">
                            <button type="submit" class="logout-btn">Sair</button>
                        </form>
                    </li>
                % else:
                    <li><a href="/login" class="nav-cta">Entrar</a></li>
                % end
            </ul>
        </div>
    </nav>
    
    <!-- Conteúdo Principal -->
    {{!base}}
    
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
    % if defined('extra_js'):
    {{!extra_js}}
    % end
</body>
</html>
