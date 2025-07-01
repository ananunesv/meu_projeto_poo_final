<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{meditation.title}} - Zen Mind</title>
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
    
    <main class="meditation-detail-content">
        <div class="container">
            <div class="meditation-header">
                <h1>{{meditation.title}}</h1>
                <div class="meditation-meta">
                    <span class="category">{{meditation.category}}</span>
                    <span class="duration">{{meditation.get_duration_formatted()}}</span>
                </div>
            </div>
            
            <div class="meditation-content">
                <div class="meditation-description">
                    <h2>Descrição</h2>
                    <p>{{meditation.description}}</p>
                </div>
                
                <div class="meditation-actions">
                    <a href="/meditacoes/{{meditation.id}}/editar" class="btn-primary">Editar</a>
                    <form method="post" action="/meditacoes/{{meditation.id}}/deletar" style="display:inline;">
                        <button type="submit" class="btn-danger" onclick="return confirm('Tem certeza que deseja excluir esta meditação?')">Excluir</button>
                    </form>
                    <a href="/meditacoes" class="btn-secondary">Voltar à Lista</a>
                </div>
            </div>
        </div>
    </main>
</body>
</html>