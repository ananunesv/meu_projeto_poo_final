<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - Zen Mind</title>
    <link rel="stylesheet" type="text/css" href="/static/css/base.css">
    <style>
        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 2rem;
        }
        
        .register-card {
            background: white;
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            text-align: center;
        }
        
        .register-header {
            margin-bottom: 2rem;
        }
        
        .register-header h1 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .register-header p {
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
        
        .register-btn {
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
        
        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .login-link {
            color: #666;
        }
        
        .login-link a {
            color: #667eea;
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
        
        .error-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .error-list li {
            margin-bottom: 0.5rem;
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
</body>
</html>