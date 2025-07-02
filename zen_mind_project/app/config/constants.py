# Constantes do sistema Zen Mind

# Categorias de meditação
MEDITATION_CATEGORIES = [
    'respiracao',
    'sono', 
    'foco',
    'ansiedade',
    'relaxamento',
    'mindfulness'
]

# Durações padrão (em minutos)
MEDITATION_DURATIONS = [5, 10, 15, 20, 30, 45, 60]

# Mensagens do sistema
MESSAGES = {
    'USER_NOT_FOUND': 'Usuário não encontrado',
    'INVALID_CREDENTIALS': 'Credenciais inválidas',
    'USERNAME_EXISTS': 'Nome de usuário já existe',
    'EMAIL_EXISTS': 'Email já cadastrado',
    'MEDITATION_CREATED': 'Meditação criada com sucesso',
    'MEDITATION_UPDATED': 'Meditação atualizada com sucesso',
    'MEDITATION_DELETED': 'Meditação excluída com sucesso',
    'POST_CREATED': 'Post criado com sucesso',
    'SESSION_EXPIRED': 'Sessão expirada',
    'LOGIN_SUCCESS': 'Login realizado com sucesso',
    'LOGOUT_SUCCESS': 'Logout realizado com sucesso'
}

# Validações
MIN_USERNAME_LENGTH = 3
MAX_USERNAME_LENGTH = 20
MIN_PASSWORD_LENGTH = 6
MAX_POST_LENGTH = 500
MIN_MEDITATION_DURATION = 1
MAX_MEDITATION_DURATION = 120