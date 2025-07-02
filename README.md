# 🧘 Zen Mind - Plataforma de Meditação

## 📖 Sobre o Projeto

**Zen Mind** é uma plataforma web moderna para meditação desenvolvida em Python com o framework Bottle. O projeto oferece uma experiência completa de bem-estar digital onde usuários podem:

- 🆕 **Criar e gerenciar sessões de meditação personalizadas** (CRUD completo)
- 💬 **Participar de uma comunidade ativa** com fórum em tempo real
- 📊 **Acompanhar progresso pessoal** através de dashboard interativo
- 🤝 **Interagir com outros praticantes** compartilhando experiências
- 📱 **Interface responsiva** com design moderno e gradientes atrativos
- 🎨 **UX/UI otimizada** para uma experiência zen e relaxante

## 🏗️ Arquitetura Técnica

- **Framework**: Bottle (Python) - Minimalista e eficiente
- **Padrão**: MVC (Model-View-Controller) rigorosamente implementado
- **Templates**: Sistema de herança com Bottle Template Engine
- **Persistência**: JSON (ideal para desenvolvimento e prototipagem)
- **Autenticação**: Sistema de sessões com cookies seguros
- **Frontend**: HTML5, CSS3 com gradients modernos, JavaScript vanilla
- **Responsividade**: Mobile-first design com breakpoints otimizados

## 📁 Estrutura Detalhada do Projeto

```
oo-ana/
├── main.py                              # 🚀 PONTO DE ENTRADA PRINCIPAL
├── requirements.txt                     # 📦 Dependências globais
├── README.md                           # 📚 Esta documentação
│
└── zen_mind_project/                   # 📂 Aplicação principal
    ├── route.py                        # 🛤️ Definição centralizada de rotas
    ├── run.py                         # 🔄 Script de execução alternativo
    │
    └── app/                           # 📂 Estrutura MVC organizada
        ├── models/                    # 🏗️ Entidades de domínio
        │   ├── user.py               # 👤 Modelo de usuário
        │   ├── meditation.py         # 🧘 Modelo de meditação
        │   └── forum_post.py         # 💬 Modelo de posts do fórum
        │
        ├── services/                  # ⚙️ Camada de lógica de negócio
        │   ├── __init__.py           # 📋 Exportação de serviços
        │   ├── user_service.py       # 👥 Gerenciamento de usuários
        │   ├── meditation_service.py # 🧘 CRUD de meditações
        │   ├── forum_service.py      # 💬 Gerenciamento do fórum
        │   ├── session_service.py    # 🔐 Controle de sessões
        │   └── websocket_service.py  # 🔄 Comunicação tempo real
        │
        ├── controllers/               # 🎮 Controladores de rotas
        │   ├── application.py        # 🏠 Controller principal
        │   ├── auth_controller.py    # 🔐 Autenticação
        │   ├── meditation_controller.py # 🧘 CRUD meditações
        │   └── forum_controller.py   # 💬 Fórum
        │
        ├── views/                     # 🎨 Interface e apresentação
        │   └── templates/            # 📄 Templates organizados
        │       ├── base.tpl          # 🏗️ Template base (herança)
        │       ├── homepage.tpl      # 🏠 Página inicial
        │       ├── app_download.tpl  # 📱 Download do app
        │       ├── documentation.tpl # 📚 Documentação
        │       ├── auth/             # 🔐 Templates de autenticação
        │       ├── meditation/       # 🧘 Templates de meditação
        │       │   ├── meditation_dashboard.tpl  # 📊 Dashboard
        │       │   ├── meditation_form.tpl       # ➕ Formulário
        │       │   ├── meditation_list.tpl       # 📋 Lista
        │       │   └── meditation_detail.tpl     # 👁️ Detalhes
        │       └── forum/            # 💬 Templates do fórum
        │           └── forum_index.tpl # 🗣️ Página principal
        │
        ├── config/                    # ⚙️ Configurações
        │   ├── settings.py           # 🔧 Configurações gerais
        │   └── constants.py          # 📊 Constantes do sistema
        │
        ├── utils/                     # 🛠️ Utilitários
        │   └── decorators.py         # 🔒 Decorators de autenticação
        │
        └── data/                      # 💾 Armazenamento JSON
            ├── users.json            # 👤 Dados de usuários
            ├── meditations.json      # 🧘 Dados de meditações
            ├── forum_posts.json      # 💬 Posts do fórum
            └── sessions.json         # 🔐 Sessões ativas
```

## 🚀 Como Executar o Projeto

### ✅ Pré-requisitos
- Python 3.8+ instalado
- pip (gerenciador de pacotes Python)
- Navegador web moderno

### 📋 Passo a Passo

#### 1️⃣ Clone ou baixe o projeto
```bash
# Se usar Git
git clone <repository-url>
cd oo-ana

# Ou extraia o ZIP e navegue até a pasta
cd oo-ana
```

#### 2️⃣ Instale as dependências
```bash
# Instalar dependências globais
pip install -r requirements.txt

# Dependências principais: bottle, requests
```

#### 3️⃣ Execute o servidor
```bash
# MÉTODO PRINCIPAL (Recomendado)
python main.py

# Método alternativo
python zen_mind_project/run.py
```

#### 4️⃣ Acesse a aplicação
```
🌐 URL: http://localhost:8080
📱 Interface responsiva e moderna
```

#### 5️⃣ Credenciais de teste
```
👤 Usuário: admin
🔑 Senha: admin123

👤 Usuário: ana_medita  
🔑 Senha: 123456
```

## 🌐 Mapa Completo de Rotas

### 🏠 **Rotas Públicas**
| Rota | Método | Descrição | Status |
|------|--------|-----------|--------|
| `/` | GET | 🏠 Página inicial moderna | ✅ |
| `/home` | GET | 🏠 Página inicial (alternativa) | ✅ |
| `/login` | GET/POST | 🔐 Autenticação de usuários | ✅ |
| `/register` | GET/POST | 📝 Cadastro de novos usuários | ✅ |
| `/download` | GET | 📱 Página de download do app | ✅ |
| `/helper` | GET | 📚 Documentação do framework | ✅ |

### 🔒 **Rotas Protegidas** (Requer Login)
| Rota | Método | Descrição | Status |
|------|--------|-----------|--------|
| `/dashboard` | GET | 📊 Dashboard principal com design moderno | ✅ |
| `/meditacoes` | GET | 📋 Lista de meditações (design aprimorado) | ✅ |
| `/meditacoes/nova` | GET/POST | ➕ Criar nova meditação (form estilizado) | ✅ |
| `/meditacoes/<id>` | GET | 👁️ Visualizar detalhes da meditação | ✅ |
| `/meditacoes/<id>/editar` | GET/POST | ✏️ Editar meditação existente | ✅ |
| `/meditacoes/<id>/deletar` | POST | 🗑️ Remover meditação | ✅ |
| `/forum` | GET | 💬 Fórum da comunidade (design moderno) | ✅ |
| `/forum/post` | POST | ✍️ Criar novo post no fórum | ✅ |
| `/forum/post/<id>/deletar` | POST | 🗑️ Deletar post (owner/admin) | ✅ |
| `/logout` | POST | 🚪 Encerrar sessão | ✅ |

## 🎨 Funcionalidades Implementadas

### ✅ **Sistema de Autenticação**
- Login/logout seguro com sessões
- Sistema de cookies com timeout
- Proteção de rotas com decorators
- Validação de credenciais
- Redirecionamento automático

### ✅ **CRUD Completo de Meditações**
- **Create**: Formulário moderno com validação
- **Read**: Lista estilizada + visualização detalhada  
- **Update**: Edição inline com preservação de dados
- **Delete**: Confirmação de exclusão
- Categorização (Respiração, Mindfulness, etc.)
- Filtros por categoria
- Validação de dados robusta

### ✅ **Fórum da Comunidade**
- Posts em tempo real
- Sistema de moderação
- Estatísticas da comunidade
- Interface de conversação moderna
- Proteção contra spam

### ✅ **Interface Moderna**
- **Design System**: Gradientes harmoniosos
- **Responsividade**: Mobile-first approach
- **UX/UI**: Cards com hover effects
- **Tipografia**: Hierarquia visual clara
- **Cores**: Paleta zen e relaxante
- **Animações**: Transições suaves

### ✅ **Dashboard Interativo**
- Estatísticas visuais
- Ações rápidas com gradientes
- Cards informativos
- Design motivacional

## 🛠️ Tecnologias e Padrões

### **Backend**
- **Bottle**: Framework minimalista Python
- **MVC**: Arquitetura bem estruturada
- **Services Layer**: Separação de responsabilidades
- **Decorators**: Controle de acesso elegante

### **Frontend**
- **HTML5**: Semântica moderna
- **CSS3**: Gradients, flexbox, grid
- **JavaScript**: Vanilla para interatividade
- **Template Engine**: Bottle templates com herança

### **Persistência**
- **JSON**: Formato simples e legível
- **File System**: Organização em /data/
- **Models**: Classes Python com validação

## 🎯 Guia de Uso

### 1️⃣ **Primeiro Acesso**
1. Execute `python main.py`
2. Acesse `http://localhost:8080`
3. Clique em "Entrar" no menu
4. Use: admin / admin123

### 2️⃣ **Criando Meditações**
1. No dashboard, clique "Nova Meditação"
2. Preencha o formulário estilizado
3. Escolha categoria e duração
4. Descreva a técnica detalhadamente
5. Clique "Criar Meditação"

### 3️⃣ **Gerenciando Meditações**
1. Acesse "Minhas Meditações"
2. Use os filtros por categoria
3. Ver/Editar/Excluir com botões coloridos
4. Interface de cards moderna

### 4️⃣ **Participando do Fórum**
1. Acesse "Fórum" no menu
2. Veja estatísticas da comunidade
3. Escreva posts respeitosos
4. Interaja com outros usuários

## 🔧 Solução de Problemas

### ❌ **Erro: Módulo não encontrado**
```bash
# Verifique se está no diretório correto
pwd
# Deve estar em: /c/Users/pande/Desktop/oo-ana

# Reinstale dependências
pip install -r requirements.txt --force-reinstall
```

### ❌ **Erro: Porta 8080 ocupada**
```bash
# Windows
netstat -ano | findstr :8080
taskkill /PID <PID_NUMBER> /F

# Ou altere a porta em zen_mind_project/app/config/settings.py
```

### ❌ **Erro: Arquivos JSON corrompidos**
```bash
# Limpe os dados (irá recriar usuários padrão)
rm zen_mind_project/app/data/*.json
python main.py
```

### ❌ **Erro: Template não encontrado**
```bash
# Verifique se executou do diretório raiz
python main.py  # NÃO: cd zen_mind_project && python main.py
```

## 📱 Recursos Avançados

### 🎨 **Design System**
- Paleta de cores zen (azuis, roxos, verdes)
- Gradients harmoniosos em todos os componentes
- Micro-interações com hover effects
- Layout responsivo com breakpoints otimizados

### 🔒 **Segurança**
- Sanitização de inputs
- Proteção CSRF em formulários
- Validação server-side robusta
- Controle de acesso granular

### 📊 **Analytics** (Futuro)
- Tempo total de meditação
- Frequência de prática
- Categorias preferidas
- Progresso ao longo do tempo

## 🚀 Próximas Funcionalidades

### 🔄 **Em Planejamento**
- [ ] WebSocket tempo real no fórum
- [ ] Sistema de notificações push
- [ ] Upload de áudios guiados
- [ ] Calendário de práticas
- [ ] Badges e conquistas
- [ ] API REST completa
- [ ] App mobile nativo

### 🎯 **Melhorias Técnicas**
- [ ] Migração para banco relacional
- [ ] Sistema de cache
- [ ] Testes automatizados
- [ ] Deploy em cloud
- [ ] Monitoramento de performance

## 👥 Informações do Projeto

**Desenvolvido para**: Disciplina de Orientação a Objetos  
**Instituição**: Universidade de Brasília (UnB)  
**Período**: 2025.1  
**Linguagem**: Python 3.8+  
**Framework**: Bottle  
**Licença**: Acadêmica  

## 📞 Suporte

Para dúvidas ou problemas:
1. Verifique este README completo
2. Confira os logs no terminal
3. Teste com usuário admin/admin123
4. Reinicie o servidor se necessário

---

**🧘 Zen Mind - Encontre sua paz interior através da tecnologia** ✨ 