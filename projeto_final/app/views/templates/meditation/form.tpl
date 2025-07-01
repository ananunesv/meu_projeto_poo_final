<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% if action == 'edit' %}Editar{% else %}Nova{% endif %} Meditação - Zen Mind</title>
    <link rel="stylesheet" type="text/css" href="/static/css/base.css">
    <link rel="stylesheet" type="text/css" href="/static/css/meditation.css">
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
    
    <!-- Conteúdo Principal -->
    <main class="form-content">
        <div class="container">
            <div class="form-header">
                <h1>{% if action == 'edit' %}Editar Meditação{% else %}Nova Meditação{% endif %}</h1>
                <p>{% if action == 'edit' %}Modifique os dados da sua sessão{% else %}Crie uma nova sessão personalizada{% endif %}</p>
            </div>
            
            {% if error %}
                <div class="error-message">
                    {{error}}
                </div>
            {% endif %}
            
            <div class="form-container">
                <form method="post" class="meditation-form">
                    <div class="form-group">
                        <label for="title">Título da Meditação *</label>
                        <input type="text" id="title" name="title" 
                               value="{% if meditation %}{{meditation.title}}{% elif form_data %}{{form_data.title}}{% endif %}" 
                               placeholder="Ex: Respiração Matinal" 
                               required maxlength="100">
                        <small>Dê um nome descritivo para sua sessão</small>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="duration">Duração (minutos) *</label>
                            <input type="number" id="duration" name="duration" 
                                   value="{% if meditation %}{{meditation.duration}}{% elif form_data %}{{form_data.duration}}{% endif %}" 
                                   min="1" max="120" required>
                            <small>Entre 1 e 120 minutos</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="category">Categoria *</label>
                            <select id="category" name="category" required>
                                <option value="">Selecione uma categoria</option>
                                {% for cat in categories %}
                                    <option value="{{cat}}" 
                                            {% if (meditation and meditation.category == cat) or (form_data and form_data.category == cat) %}selected{% endif %}>
                                        {{cat|title}}
                                    </option>
                                {% endfor %}
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="description">Descrição *</label>
                        <textarea id="description" name="description" 
                                  placeholder="Descreva a técnica, objetivos e instruções da meditação..." 
                                  required maxlength="500" rows="6">{% if meditation %}{{meditation.description}}{% elif form_data %}{{form_data.description}}{% endif %}</textarea>
                        <small>Mínimo 10 caracteres, máximo 500</small>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn-primary">
                            {% if action == 'edit' %}Atualizar Meditação{% else %}Criar Meditação{% endif %}
                        </button>
                        <a href="{% if action == 'edit' %}/meditacoes/{{meditation.id}}{% else %}/dashboard{% endif %}" 
                           class="btn-secondary">Cancelar</a>
                    </div>
                </form>
            </div>
            
            <!-- Dicas -->
            <div class="tips-section">
                <h3>💡 Dicas para uma boa meditação:</h3>
                <ul>
                    <li><strong>Título claro:</strong> Use nomes que descrevam o objetivo (ex: "Foco para Estudos")</li>
                    <li><strong>Duração realista:</strong> Comece com 5-10 minutos se for iniciante</li>
                    <li><strong>Descrição detalhada:</strong> Inclua instruções de respiração e postura</li>
                    <li><strong>Categoria correta:</strong> Facilita encontrar a meditação depois</li>
                </ul>
            </div>
        </div>
    </main>
    
    <!-- JavaScript -->
    <script src="/static/js/main.js"></script>
    <script>
        // Contador de caracteres para descrição
        const textarea = document.getElementById('description');
        const maxLength = 500;
        
        if (textarea) {
            const counter = document.createElement('div');
            counter.className = 'char-counter';
            counter.style.textAlign = 'right';
            counter.style.fontSize = '0.8rem';
            counter.style.color = '#666';
            textarea.parentNode.appendChild(counter);
            
            function updateCounter() {
                const remaining = maxLength - textarea.value.length;
                counter.textContent = `${remaining} caracteres restantes`;
                counter.style.color = remaining < 50 ? '#c33' : '#666';
            }
            
            textarea.addEventListener('input', updateCounter);
            updateCounter();
        }
    </script>
</body>
</html>
