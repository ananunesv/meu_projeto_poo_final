# Configurações globais do Zen Mind
import os

# Configurações do servidor
HOST = '0.0.0.0'
PORT = 8080
DEBUG = True

# Configurações de segurança
SECRET_KEY = 'zen_mind_secret_key_2025'
SESSION_TIMEOUT = 3600  # 1 hora em segundos

# Caminhos dos arquivos
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA_DIR = os.path.join(BASE_DIR, 'data')
TEMPLATES_DIR = os.path.join(BASE_DIR, 'views', 'templates')
STATIC_DIR = os.path.join(BASE_DIR, 'views', 'static')

# Configurações de arquivos JSON
USERS_FILE = os.path.join(DATA_DIR, 'users.json')
MEDITATIONS_FILE = os.path.join(DATA_DIR, 'meditations.json')
FORUM_POSTS_FILE = os.path.join(DATA_DIR, 'forum_posts.json')
SESSIONS_FILE = os.path.join(DATA_DIR, 'sessions.json')

# WebSocket
WEBSOCKET_PORT = 8081