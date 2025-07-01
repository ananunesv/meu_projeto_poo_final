<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fórum - Zen Mind</title>
    <link rel="stylesheet" type="text/css" href="/static/css/base.css">
    <link rel="stylesheet" type="text/css" href="/static/css/forum.css">
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
                <li><a href="/dashboard">Dashboard</a></li>
                <li><a href="/meditacoes">Minhas Meditações</a></li>
                <li><a href="/forum" class="active">Fórum</a></li>
                <li class="user-menu">
                    <span>Olá, {{current_user.username}}!</span>
                    <form method="post" action="/logout" style="display:inline;">
                        <button type="submit" class="logout-btn">Sair</button>
                    </form>
                </li>
            </ul>
        </div>
    </nav>
    
    <!-- Conteúdo Principal -->
    <main class="forum-content">
        <div class="container">
            <!-- Header do Fórum -->
            <div class="forum-header">
                <h1>💬 Fórum da Comunidade</h1>
                <p>Compartilhe experiências, dicas e reflexões sobre meditação</p>
            </div>
            
            <!-- Estatísticas e Usuários Online -->
            <div class="forum-stats">
                <div class="stats-card">
                    <h3>📊 Estatísticas</h3>
                    <p><strong>{{stats.total_posts}}</strong> posts total</p>
                    <p><strong>{{stats.unique_users}}</strong> usuários participando</p>
                    <p>Usuário mais ativo: <strong>{{stats.most_active_user}}</strong></p>
                </div>
                
                <div class="online-users">
                    <h3>🟢 Online Agora ({{online_users|length}})</h3>
                    {% if online_users %}
                        <div class="user-list">
                            {% for user in online_users %}
                                <span class="online-user">{{user}}</span>
                            {% endfor %}
                        </div>
                    {% else %}
                        <p>Nenhum usuário online via WebSocket</p>
                    {% endif %}
                </div>
            </div>
            
            <!-- Formulário para Novo Post -->
            <div class="new-post">
                <h2>✍️ Compartilhar Experiência</h2>
                <form method="post" action="/forum/post" class="post-form">
                    <div class="form-group">
                        <textarea name="content" 
                                  placeholder="Compartilhe sua experiência, uma reflexão ou dica sobre meditação..." 
                                  maxlength="500" 
                                  required 
                                  rows="4"></textarea>
                        <small>Máximo 500 caracteres. Seja respeitoso e construtivo.</small>
                    </div>
                    <button type="submit" class="btn-primary">Publicar</button>
                </form>
            </div>
            
            <!-- Lista de Posts -->
            <div class="posts-section">
                <h2>💭 Conversas Recentes</h2>
                
                {% if posts %}
                    <div class="posts-list" id="posts-container">
                        {% for post in posts %}
                        <div class="post-item" data-post-id="{{post.id}}">
                            <div class="post-header">
                                <div class="post-author">
                                    <span class="author-avatar">🧘</span>
                                    <span class="author-name">{{post.username}}</span>
                                </div>
                                <div class="post-meta">
                                    <span class="post-time">{{post.get_time_ago()}}</span>
                                    {% if current_user.username == post.username or current_user.username == 'admin' %}
                                        <form method="post" action="/forum/post/{{post.id}}/deletar" 
                                              style="display:inline;" 
                                              onsubmit="return confirm('Tem certeza que deseja deletar este post?')">
                                            <button type="submit" class="delete-btn" title="Deletar">🗑️</button>
                                        </form>
                                    {% endif %}
                                </div>
                            </div>
                            
                            <div class="post-content">
                                {{post.content}}
                            </div>
                        </div>
                        {% endfor %}
                    </div>
                {% else %}
                    <div class="empty-state">
                        <div class="empty-icon">💬</div>
                        <h3>Nenhuma conversa ainda</h3>
                        <p>Seja o primeiro a compartilhar uma experiência!</p>
                    </div>
                {% endif %}
            </div>
            
            <!-- WebSocket Status -->
            <div class="websocket-status" id="ws-status">
                <span class="status-indicator" id="ws-indicator">🔴</span>
                <span id="ws-text">Conectando ao chat em tempo real...</span>
            </div>
        </div>
    </main>
    
    <!-- JavaScript -->
    <script src="/static/js/main.js"></script>
    <script src="/static/js/websocket.js"></script>
    <script>
        // Inicializar WebSocket para atualizações em tempo real
        document.addEventListener('DOMContentLoaded', function() {
            // Placeholder para WebSocket - será implementado depois
            console.log('Fórum carregado. WebSocket será implementado na próxima fase.');
            
            // Simular status conectado por enquanto
            setTimeout(() => {
                const indicator = document.getElementById('ws-indicator');
                const text = document.getElementById('ws-text');
                indicator.textContent = '🟢';
                text.textContent = 'Chat em tempo real ativo';
            }, 2000);
        });
    </script>
</body>
</html