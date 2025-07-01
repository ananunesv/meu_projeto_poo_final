<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro - Zen Mind</title>
    <link rel="stylesheet" type="text/css" href="/static/css/base.css">
    <style>
        .auth-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .auth-card {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        
        .auth-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .logo {
            font-size: 2rem;
            margin-bottom: 1rem;
        }
        
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        
        .form-group input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .btn-primary {
            width: 100%;
            padding: 0.75rem;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .btn-primary:hover {
            background: #5a6fd8;
        }
        
        .error {
            background: #fee;
            color: #c33;
            padding: 0.75rem;
            border-radius: 6px;
            margin-bottom: 1rem;
            border: 1px solid #fcc;
        }
        
        .errors {
            background: #fee;
            color: #c33;
            padding: 0.75rem;
            border-radius: 6px;
            margin-bottom: 1rem;
            border: 1px solid #fcc;
        }
        
        .errors ul {
            margin: 0;
            padding-left: 1rem;
        }
        
        .auth-links {
            text-align: center;
            margin-top: 1rem;
        }
        
        .auth-links a {
            color: #667eea;
            text-decoration: none;
        }
        
        .auth-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <div class="logo">🧘 Zen Mind</div>
                <h2>Criar sua conta</h2>
            </div>
            
            {% if error %}
                <div class="error">{{ error }}</div>
            {% endif %}
            
            {% if errors %}
                <div class="errors">
                    <ul>
                        {% for error in errors %}
                            <li>{{ error }}</li>
                        {% endfor %}
                    </ul>
                </div>
            {% endif %}
            
            <form method="post" action="/register">
                <div class="form-group">
                    <label for="username">Nome de usuário</label>
                    <input type="text" id="username" name="username" 
                           value="{{ username or '' }}" required autofocus>
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" 
                           value="{{ email or '' }}" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Senha</label>
                    <input type="password" id="password" name="password" 
                           placeholder="Mínimo 6 caracteres" required>
                </div>
                
                <div class="form-group">
                    <label for="confirm_password">Confirmar senha</label>
                    <input type="password" id="confirm_password" name="confirm_password" 
                           placeholder="Digite a senha novamente" required>
                </div>
                
                <button type="submit" class="btn-primary">Criar conta</button>
            </form>
            
            <div class="auth-links">
                <p>Já tem conta? <a href="/login">Faça login aqui</a></p>
                <p><a href="/">← Voltar ao início</a></p>
            </div>
        </div>
    </div>
</body>
</html>