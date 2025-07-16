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
        
        /* Menu dropdown do usuário */
        .user-dropdown {
            position: relative;
            display: inline-block;
        }
        
        .user-dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            min-width: 200px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            border-radius: 10px;
            z-index: 1000;
            overflow: hidden;
            border: 1px solid #e9ecef;
        }
        
        .user-dropdown:hover .user-dropdown-content {
            display: block;
        }
        
        .user-dropdown-content a {
            color: #333;
            padding: 1rem 1.5rem;
            text-decoration: none;
            display: block;
            transition: all 0.3s ease;
            border-bottom: 1px solid #f8f9fa;
        }
        
        .user-dropdown-content a:hover {
            background-color: #f8f9fa;
            color: #667eea;
        }
        
        .user-dropdown-content a:last-child {
            border-bottom: none;
        }
        
        .user-avatar {
            width: 35px;
            height: 35px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1rem;
            margin-right: 0.75rem;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            cursor: pointer;
            padding: 0.5rem 1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
            background: rgba(102, 126, 234, 0.1);
        }
        
        .user-info:hover {
            background: rgba(102, 126, 234, 0.15);
        }
        
        .user-details {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        
        .user-name {
            font-weight: 600;
            color: #333;
            font-size: 0.9rem;
        }
        
        .user-status {
            font-size: 0.8rem;
            color: #666;
        }
        
        /* Mobile responsivo */
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .nav-container {
                flex-wrap: wrap;
            }
            
            .user-dropdown-content {
                right: -100px;
                min-width: 180px;
            }
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
                    
                    <!-- Menu dropdown do usuário -->
                    <li class="user-dropdown">
                        <div class="user-info">
                            <div class="user-avatar">{{current_user.username[0].upper()}}</div>
                            <div class="user-details">
                                <div class="user-name">{{current_user.username}}</div>
                                <div class="user-status">Online</div>
                            </div>
                            <span style="margin-left: 0.5rem; color: #666;">▼</span>
                        </div>
                        
                        <div class="user-dropdown-content">
                            <a href="/perfil">
                                <span style="margin-right: 0.5rem;">👤</span>
                                Meu Perfil
                            </a>
                            <a href="/perfil/editar">
                                <span style="margin-right: 0.5rem;">⚙️</span>
                                Configurações
                            </a>
                            <a href="/meditacoes">
                                <span style="margin-right: 0.5rem;">🧘</span>
                                Minhas Meditações
                            </a>
                            <a href="/forum">
                                <span style="margin-right: 0.5rem;">💬</span>
                                Fórum
                            </a>
                            <a href="#" onclick="document.getElementById('logoutForm').submit(); return false;" style="color: #dc3545;">
                                <span style="margin-right: 0.5rem;">🚪</span>
                                Sair
                            </a>
                        </div>
                        
                        <!-- Formulário de logout oculto -->
                        <form id="logoutForm" method="post" action="/logout" style="display: none;">
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
    
    <!-- JavaScript para dropdown do usuário -->
    <script>
        // Fechar dropdown quando clicar fora
        document.addEventListener('click', function(event) {
            const dropdown = document.querySelector('.user-dropdown');
            if (dropdown && !dropdown.contains(event.target)) {
                const dropdownContent = dropdown.querySelector('.user-dropdown-content');
                if (dropdownContent) {
                    dropdownContent.style.display = 'none';
                }
            }
        });
        
        // Toggle dropdown no mobile
        document.addEventListener('DOMContentLoaded', function() {
            const userInfo = document.querySelector('.user-info');
            if (userInfo && window.innerWidth <= 768) {
                userInfo.addEventListener('click', function(e) {
                    e.preventDefault();
                    const dropdownContent = this.parentElement.querySelector('.user-dropdown-content');
                    if (dropdownContent) {
                        dropdownContent.style.display = dropdownContent.style.display === 'block' ? 'none' : 'block';
                    }
                });
            }
        });
    </script>
    
    % if defined('extra_js'):
    {{!extra_js}}
    % end
</body>
</html>