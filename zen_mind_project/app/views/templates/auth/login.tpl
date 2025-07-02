<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Zen Mind</title>
    <link rel="stylesheet" type="text/css" href="/static/css/base.css">
    <style>
        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 2rem;
        }
        
        .login-card {
            background: white;
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        
        .login-header {
            margin-bottom: 2rem;
        }
        
        .login-header h1 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .login-header p {
            color: #666;
            font-size: 1rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
            text-align: left;
        }
        
        .form-group label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .form-group input {
            width: 100%;
            padding: 1rem;
            border: 2px solid rgba(102, 126, 234, 0.2);
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .password-group {
            position: relative;
        }
        
        .password-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            color: #666;
            padding: 4px;
            border-radius: 4px;
            transition: all 0.3s ease;
        }
        
        .password-toggle:hover {
            color: #667eea;
            background: rgba(102, 126, 234, 0.1);
        }
        
        .login-btn {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
        }
        
        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .register-link {
            color: #666;
        }
        
        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .register-link a:hover {
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
            color: white;
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
            background: rgba(255, 107, 107, 0.1);
            color: #d63031;
            padding: 1rem;
            border-radius: 10px;
            border: 1px solid rgba(255, 107, 107, 0.3);
            margin-bottom: 1.5rem;
            text-align: center;
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

    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <h1>🧘 Zen Mind</h1>
                <p>Entre na sua conta para continuar</p>
            </div>

            % if defined('error') and error:
                <div class="error-message">
                    {{error}}
                </div>
            % end

            <form method="post" action="/login">
                <div class="form-group">
                    <label for="username">Usuário</label>
                    <input type="text" id="username" name="username" 
                           value="{{get('form_data', {}).get('username', '') if defined('form_data') else ''}}"
                           placeholder="Digite seu usuário" required>
                </div>

                <div class="form-group">
                    <label for="password">Senha</label>
                    <div class="password-group">
                        <input type="password" id="password" name="password" 
                               placeholder="Digite sua senha" required>
                        <button type="button" class="password-toggle" onclick="togglePassword()">
                            👁️
                        </button>
                    </div>
                </div>

                <button type="submit" class="login-btn">Entrar</button>
            </form>

            <div class="register-link">
                Não tem conta? <a href="/register">Cadastre-se aqui</a>
            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const toggleBtn = document.querySelector('.password-toggle');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleBtn.textContent = '🙈';
            } else {
                passwordField.type = 'password';
                toggleBtn.textContent = '👁️';
            }
        }
    </script>
</body>
</html>