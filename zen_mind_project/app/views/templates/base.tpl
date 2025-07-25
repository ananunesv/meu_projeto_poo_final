<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{get('title', 'Zen Mind - Plataforma de Meditação')}}</title>
    
    <!-- CSS Base com Modo Escuro -->
    <link rel="stylesheet" type="text/css" href="/static/css/base.css">
    <link rel="stylesheet" type="text/css" href="/static/css/dark-mode.css">
    
    % if defined('extra_css'):
    {{!extra_css}}
    % end
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="/static/img/zen-icon.png">
    
    <!-- Meta tags para modo escuro -->
    <meta name="color-scheme" content="light dark">
    <meta name="theme-color" content="#667eea" media="(prefers-color-scheme: light)">
    <meta name="theme-color" content="#1a1a2e" media="(prefers-color-scheme: dark)">
    
    <!-- Estilos principais com suporte ao modo escuro -->
    <style>
        /* ===== VARIÁVEIS CSS PRINCIPAIS ===== */
        :root {
            --bg-primary: #ffffff;
            --bg-secondary: #f8f9fa;
            --bg-tertiary: #e9ecef;
            --bg-card: #ffffff;
            --bg-input: #f8f9fa;
            --text-primary: #1a1a2e;
            --text-secondary: #6c757d;
            --text-muted: #adb5bd;
            --text-inverse: #ffffff;
            --border-primary: #e9ecef;
            --border-secondary: #dee2e6;
            --border-focus: #667eea;
            --shadow-light: 0 5px 25px rgba(0,0,0,0.1);
            --shadow-medium: 0 10px 35px rgba(0,0,0,0.15);
            --primary: #667eea;
            --secondary: #764ba2;
            --success: #48bb78;
            --warning: #ffc107;
            --danger: #dc3545;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --bg-primary: #1a1a2e;
                --bg-secondary: #16213e;
                --bg-tertiary: #0f1419;
                --bg-card: #16213e;
                --bg-input: #242b3d;
                --text-primary: #e9ecef;
                --text-secondary: #adb5bd;
                --text-muted: #6c757d;
                --text-inverse: #1a1a2e;
                --border-primary: rgba(255, 255, 255, 0.1);
                --border-secondary: rgba(255, 255, 255, 0.15);
                --shadow-light: 0 5px 25px rgba(0,0,0,0.3);
                --shadow-medium: 0 10px 35px rgba(0,0,0,0.4);
            }
        }

        body {
            background-color: var(--bg-primary) !important;
            color: var(--text-primary) !important;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }
        
        .main-content {
            min-height: calc(100vh - 140px);
            padding: 2rem 0;
            background: linear-gradient(135deg, var(--bg-secondary) 0%, var(--bg-tertiary) 100%);
        }
        
        /* Navegação */
        .main-nav {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border-primary);
            z-index: 1000;
            padding: 1rem 0;
            transition: all 0.3s ease;
        }

        @media (prefers-color-scheme: dark) {
            .main-nav {
                background: rgba(26, 26, 46, 0.95) !important;
            }
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            color: var(--primary);
            font-weight: 700;
            font-size: 1.5rem;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 2rem;
            align-items: center;
            margin: 0;
            padding: 0;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--text-primary);
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: var(--primary);
        }

        .nav-cta {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: var(--text-inverse) !important;
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
        }

        .nav-cta:hover {
            color: var(--text-inverse) !important;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
        
        /* Dropdown do usuário */
        .user-dropdown {
            position: relative;
            display: inline-block;
        }
        
        .user-dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background: var(--bg-card);
            min-width: 200px;
            box-shadow: var(--shadow-medium);
            border-radius: 10px;
            z-index: 1000;
            overflow: hidden;
            border: 1px solid var(--border-primary);
        }
        
        .user-dropdown:hover .user-dropdown-content {
            display: block;
        }
        
        .user-dropdown-content a {
            color: var(--text-primary);
            padding: 1rem 1.5rem;
            text-decoration: none;
            display: block;
            transition: all 0.3s ease;
            border-bottom: 1px solid var(--border-primary);
        }
        
        .user-dropdown-content a:hover {
            background: var(--bg-input);
            color: var(--primary);
        }
        
        .user-dropdown-content a:last-child {
            border-bottom: none;
        }
        
        .user-avatar {
            width: 35px;
            height: 35px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-inverse);
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
            color: var(--text-primary);
            font-size: 0.9rem;
        }
        
        .user-status {
            font-size: 0.8rem;
            color: var(--text-secondary);
        }
        
        /* Footer */
        .main-footer {
            background: var(--text-primary);
            color: var(--text-inverse);
            padding: 2rem 0;
            text-align: center;
        }

        @media (prefers-color-scheme: dark) {
            .main-footer {
                background: var(--bg-tertiary) !important;
                color: var(--text-primary) !important;
                border-top: 1px solid var(--border-primary);
            }
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        .footer-links {
            display: flex;
            gap: 2rem;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--text-inverse);
        }

        @media (prefers-color-scheme: dark) {
            .footer-links a {
                color: var(--text-secondary);
            }
            
            .footer-links a:hover {
                color: var(--text-primary);
            }
        }
        
        /* Responsividade */
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
            
            .footer-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            .container {
                padding: 0 1rem;
            }
            
            .main-content {
                padding: 1rem 0;
            }
        }
        
        /* Acessibilidade */
        :focus {
            outline: 2px solid var(--primary) !important;
            outline-offset: 2px !important;
        }
        
        /* Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: var(--bg-secondary);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--border-secondary);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--text-muted);
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
                            <span style="margin-left: 0.5rem; color: var(--text-secondary);">▼</span>
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
                            <a href="#" onclick="document.getElementById('logoutForm').submit(); return false;" style="color: var(--danger);">
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
    
    <!-- JavaScript para modo escuro -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('🧘 Zen Mind carregado com suporte ao modo escuro!');
            
            // Detectar e aplicar modo escuro
            const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
            
            if (prefersDark) {
                console.log('🌙 Modo escuro ativo');
                document.body.classList.add('dark-mode');
                updateNavbarForDarkMode(true);
            } else {
                console.log('☀️ Modo claro ativo');
                document.body.classList.remove('dark-mode');
                updateNavbarForDarkMode(false);
            }
            
            // Escutar mudanças na preferência
            if (window.matchMedia) {
                const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
                mediaQuery.addListener(function(e) {
                    if (e.matches) {
                        console.log('🌙 Alterado para modo escuro');
                        document.body.classList.add('dark-mode');
                        updateNavbarForDarkMode(true);
                    } else {
                        console.log('☀️ Alterado para modo claro');
                        document.body.classList.remove('dark-mode');
                        updateNavbarForDarkMode(false);
                    }
                });
            }
            
            // Função para atualizar navbar
            function updateNavbarForDarkMode(isDark) {
                const navbar = document.querySelector('.main-nav');
                if (navbar) {
                    if (isDark) {
                        navbar.style.background = 'rgba(26, 26, 46, 0.95)';
                        navbar.style.borderBottomColor = 'rgba(255, 255, 255, 0.1)';
                    } else {
                        navbar.style.background = 'rgba(255, 255, 255, 0.95)';
                        navbar.style.borderBottomColor = 'rgba(0, 0, 0, 0.1)';
                    }
                }
            }
        });
        
        // Dropdown do usuário
        document.addEventListener('click', function(event) {
            const dropdown = document.querySelector('.user-dropdown');
            if (dropdown && !dropdown.contains(event.target)) {
                const dropdownContent = dropdown.querySelector('.user-dropdown-content');
                if (dropdownContent) {
                    dropdownContent.style.display = 'none';
                }
            }
        });
        
        // Menu mobile
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
        
        // Acessibilidade
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Tab') {
                document.body.classList.add('keyboard-navigation');
            }
        });
        
        document.addEventListener('mousedown', function() {
            document.body.classList.remove('keyboard-navigation');
        });
        
        console.log('✅ Sistema de modo escuro inicializado!');
    </script>
    
    % if defined('extra_js'):
    {{!extra_js}}
    % end
</body>
</html>