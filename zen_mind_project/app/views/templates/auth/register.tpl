<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - Zen Mind</title>
    
    <!-- Meta tags para modo escuro -->
    <meta name="color-scheme" content="light dark">
    <meta name="theme-color" content="#667eea" media="(prefers-color-scheme: light)">
    <meta name="theme-color" content="#1a1a2e" media="(prefers-color-scheme: dark)">
    
    <style>
        /* ===== VARIÁVEIS CSS ===== */
        :root {
            --bg-primary: #ffffff;
            --bg-secondary: #f8f9fa;
            --bg-card: #ffffff;
            --bg-input: #f8f9fa;
            --text-primary: #1a1a2e;
            --text-secondary: #6c757d;
            --text-muted: #adb5bd;
            --text-inverse: #ffffff;
            --border-primary: #e9ecef;
            --border-focus: #667eea;
            --primary: #667eea;
            --secondary: #764ba2;
            --danger: #dc3545;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --bg-primary: #1a1a2e;
                --bg-secondary: #16213e;
                --bg-card: #16213e;
                --bg-input: #242b3d;
                --text-primary: #e9ecef;
                --text-secondary: #adb5bd;
                --text-muted: #6c757d;
                --text-inverse: #1a1a2e;
                --border-primary: rgba(255, 255, 255, 0.1);
            }
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        
        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            padding: 2rem;
        }
        
        .register-card {
            background: var(--bg-card);
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            text-align: center;
            border: 1px solid var(--border-primary);
        }

        @media (prefers-color-scheme: dark) {
            .register-card {
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            }
        }
        
        .register-header {
            margin-bottom: 2rem;
        }
        
        .register-header h1 {
            font-size: 2rem;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }
        
        .register-header p {
            color: var(--text-secondary);
            font-size: 1rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
            text-align: left;
        }
        
        .form-group label {
            display: block;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }
        
        .form-group input {
            width: 100%;
            padding: 1rem;
            border: 2px solid var(--border-primary);
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-sizing: border-box;
            background: var(--bg-input);
            color: var(--text-primary);
        }
        
        .form-group input:focus {
            outline: none;
            border-color: var(--border-focus);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            background: var(--bg-card);
        }

        .form-group input::placeholder {
            color: var(--text-muted);
        }
        
        .register-btn {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: var(--text-inverse);
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
        }
        
        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .login-link {
            color: var(--text-secondary);
        }
        
        .login-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        .back-home {
            position: absolute;
            top: 2rem;
            left: 2rem;
        }
        
        .back-home a {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-inverse);
            text-decoration: none;
            font-weight: 500;
            opacity: 0.9;
            transition: all 0.3s ease;
        }
        
        .back-home a:hover {
            opacity: 1;
            transform: translateX(-5px);
        }
        
        .error-message {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger);
            padding: 1rem;
            border-radius: 10px;
            border: 1px solid rgba(220, 53, 69, 0.3);
            margin-bottom: 1.5rem;
            text-align: center;
        }
        
        .error-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .error-list li {
            margin-bottom: 0.5rem;
        }

        /* Responsividade */
        @media (max-width: 480px) {
            .register-container {
                padding: 1rem;
            }
            
            .register-card {
                padding: 2rem;
            }
            
            .back-home {
                top: 1rem;
                left: 1rem;
            }
        }

        /* Acessibilidade */
        :focus {
            outline: 2px solid var(--primary) !important;
            outline-offset: 2px !important;
        }
    </style>
</head>
<body>
    <div class="back-home">
        <a href="/">
            <span>←</span>
            <span>Voltar ao Início</span>
        </a>
    </div>

    <div class="register-container">
        <div class="register-card">
            <div class="register-header">
                <h1>🧘 Zen Mind</h1>
                <p>Crie sua conta e comece sua jornada</p>
            </div>

            % if defined('error') and error:
                <div class="error-message">
                    {{error}}
                </div>
            % end

            % if defined('errors') and errors:
                <div class="error-message">
                    <ul class="error-list">
                    % for error in errors:
                        <li>{{error}}</li>
                    % end
                    </ul>
                </div>
            % end

            <form method="post" action="/register">
                <div class="form-group">
                    <label for="username">Nome de Usuário</label>
                    <input type="text" id="username" name="username" 
                           value="{{get('form_data', {}).get('username', '') if defined('form_data') else ''}}"
                           placeholder="Digite seu nome de usuário" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" 
                           value="{{get('form_data', {}).get('email', '') if defined('form_data') else ''}}"
                           placeholder="Digite seu email" required>
                </div>

                <div class="form-group">
                    <label for="password">Senha</label>
                    <input type="password" id="password" name="password" 
                           placeholder="Digite sua senha (mín. 6 caracteres)" required>
                </div>

                <div class="form-group">
                    <label for="confirm_password">Confirmar Senha</label>
                    <input type="password" id="confirm_password" name="confirm_password" 
                           placeholder="Digite sua senha novamente" required>
                </div>

                <button type="submit" class="register-btn">Criar Conta</button>
            </form>

            <div class="login-link">
                Já tem conta? <a href="/login">Faça login aqui</a>
            </div>
        </div>
    </div>

    <script>
        // Detectar modo escuro
        document.addEventListener('DOMContentLoaded', function() {
            const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
            
            if (prefersDark) {
                console.log('🌙 Modo escuro ativo na página de registro');
            } else {
                console.log('☀️ Modo claro ativo na página de registro');
            }
        });
    </script>
</body>
</html>