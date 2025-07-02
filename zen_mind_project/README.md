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

## 📁 Estrutura Organizada do Projeto

```
oo-ana/
├── zen_mind_project/        # Projeto principal
│   ├── app/                 # Aplicação (MVC)
│   │   ├── models/          # Entidades (User, Meditation, ForumPost)
│   │   ├── services/        # Lógica de negócio (CRUD managers)
│   │   ├── controllers/     # Controladores de rota
│   │   ├── views/           # Templates e arquivos estáticos
│   │   ├── data/            # Arquivos JSON (banco de dados)
│   │   ├── config/          # Configurações
│   │   └── utils/           # Utilitários
│   ├── route.py             # Definição de rotas
│   └── requirements.txt     # Dependências específicas
├── main.py                  # Ponto de entrada principal
├── requirements.txt         # Dependências globais
├── setup.py                 # Script de configuração
├── run.py                   # Script de execução alternativo
└── README.md               # Esta documentação
```

## 🚀 Como Executar

### Opção 1: Execução Direta (Recomendado)
```bash
# Instalar dependências
pip install -r requirements.txt

# Executar o projeto
python main.py
```

### Opção 2: Script de configuração
```bash
# Instalar e executar em um comando
python setup.py
```

### Opção 3: Script alternativo
```bash
python run.py
```

## 🌐 Rotas Disponíveis

- **/** - Home page
- **/login** - Autenticação
- **/dashboard** - Dashboard do usuário
- **/meditacoes** - Lista de meditações
- **/forum** - Fórum da comunidade
- **/helper** - Documentação

## 🛠️ Tecnologias Utilizadas

- **Backend**: Python, Bottle
- **Frontend**: HTML5, CSS3, JavaScript
- **Tempo Real**: WebSockets
- **Persistência**: JSON

## 📚 Status das Funcionalidades

### ✅ Implementado
- Sistema de login/logout
- CRUD de meditações
- Interface responsiva
- Fórum básico
- Estrutura MVC organizada

### 🔄 Em Desenvolvimento
- WebSocket em tempo real
- Notificações push
- Dashboard avançado

## 🔧 Resolução de Problemas

Se encontrar erros de importação:
```bash
# Verificar se está no diretório correto
cd /c/Users/pande/Desktop/oo-ana

# Reinstalar dependências
pip install -r requirements.txt --force-reinstall

# Executar com debug
python main.py
```

## 👥 Contribuição
Projeto desenvolvido para a disciplina de Orientação a Objetos - UnB 2025.1

## 📄 Licença
Projeto acadêmico - UnB 