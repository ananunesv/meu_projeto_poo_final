Esta pasta pode ser utilizada para armazenar os arquivos do seu banco de dados
# 🧘 Zen Mind - Plataforma de Meditação

## 📖 Sobre o Projeto
Zen Mind é uma plataforma web para meditação onde usuários podem:
- Criar e gerenciar sessões de meditação personalizadas (CRUD)
- Participar de uma comunidade ativa com fórum em tempo real
- Acompanhar seu progresso pessoal
- Interagir com outros praticantes

## 🏗️ Arquitetura
- **Framework**: Bottle (Python)
- **Padrão**: MVC (Model-View-Controller)
- **Banco de Dados**: JSON (desenvolvimento)
- **WebSocket**: Para comunicação em tempo real
- **Frontend**: HTML, CSS, JavaScript

## 📁 Estrutura do Projeto

zen_mind/
├── app/
│   ├── models/          # Entidades (User, Meditation, ForumPost)
│   ├── services/        # Lógica de negócio (CRUD managers)
│   ├── controllers/     # Controladores de rota
│   ├── views/           # Templates e arquivos estáticos
│   ├── data/            # Arquivos JSON (banco de dados)
│   ├── config/          # Configurações
│   └── utils/           # Utilitários
├── route.py             # Definição de rotas
├── wsgi.py              # Servidor WebSocket
└── requirements.txt     # Dependências

## 🚀 Como Executar

### Método 1: Python Local
```bash
pip install -r requirements.txt
python route.py

## Método 2: Docker
bashdocker build -t zen-mind .
docker run -p 8080:8080 -v $(pwd):/app zen-mind

## 🌐 Rotas Disponíveis

/ - Home page
/login - Autenticação
/dashboard - Dashboard do usuário
/meditacoes - Lista de meditações
/forum - Fórum da comunidade
/helper - Documentação

🛠️ Tecnologias Utilizadas

Backend: Python, Bottle
Frontend: HTML5, CSS3, JavaScript
Tempo Real: WebSockets
Persistência: JSON
Container: Docker

📚 Funcionalidades
✅ Implementado

Sistema de login/logout
CRUD de meditações
Interface responsiva
Fórum básico

🔄 Em Desenvolvimento

WebSocket em tempo real
Notificações push
Dashboard avançado

📋 Próximas Funcionalidades

Estatísticas de progresso
Meditações guiadas
Modo offline

👥 Contribuição
Projeto desenvolvido para a disciplina de Orientação a Objetos - UnB 2025.1
📄 Licença
Projeto acadêmico - UnB