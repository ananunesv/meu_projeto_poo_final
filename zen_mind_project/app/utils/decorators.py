from functools import wraps
from bottle import request, redirect, response
from app.services import session_service, user_service

def login_required(f):
    """Decorator que exige autenticação para acessar a rota"""
    @wraps(f)
    def wrapper(*args, **kwargs):
        # Verificar se há sessão válida
        session_id = request.get_cookie('session_id')
        
        print(f"[DEBUG] login_required - session_id: {session_id}")
        
        if not session_id:
            print(f"[DEBUG] No session_id found, redirecting to login")
            redirect('/login')
        
        # Validar sessão
        if not session_service.validate_session(session_id):
            print(f"[DEBUG] Invalid session: {session_id}, redirecting to login")
            redirect('/login')
        
        # Obter usuário atual
        username = session_service.get_user_by_session(session_id)
        if not username:
            print(f"[DEBUG] No username found for session: {session_id}, redirecting to login")
            redirect('/login')
            
        current_user = user_service.get_user_by_username(username)
        if not current_user:
            print(f"[DEBUG] User not found: {username}, redirecting to login")
            redirect('/login')
        
        # Adicionar usuário atual ao request para facilitar acesso
        request.current_user = current_user
        print(f"[DEBUG] User authenticated: {username}")
            
        return f(*args, **kwargs)
    return wrapper

def get_current_user():
    """Função helper para obter usuário atual em qualquer lugar"""
    try:
        session_id = request.get_cookie('session_id')
        if session_id and session_service.validate_session(session_id):
            username = session_service.get_user_by_session(session_id)
            if username:
                return user_service.get_user_by_username(username)
    except Exception as e:
        print(f"[DEBUG] Error getting current user: {e}")
    return None

def is_authenticated():
    """Verifica se há usuário autenticado"""
    return get_current_user() is not None

def require_admin(f):
    """Decorator que exige privilégios de admin"""
    @wraps(f)
    def wrapper(*args, **kwargs):
        current_user = get_current_user()
        if not current_user or current_user.username != 'admin':
            response.status = 403
            return "Acesso negado - Privilégios de admin necessários"
        return f(*args, **kwargs)
    return wrapper
