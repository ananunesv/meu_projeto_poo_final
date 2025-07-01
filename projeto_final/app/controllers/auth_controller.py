from bottle import template, request, response, redirect
from app.services.user_service import UserService
from app.services.session_service import SessionService
from app.config.constants import MESSAGES

class AuthController:
    """Controller de autenticação - Login, registro, logout"""
    
    def __init__(self):
        self.user_service = UserService()
        self.session_service = SessionService()
    
    def login_page(self):
        """Exibe página de login"""
        # Se já estiver logado, redirecionar para dashboard
        if self._is_authenticated():
            redirect('/dashboard')
        
        return template('app/views/templates/auth/login.tpl')
    
    def process_login(self):
        """Processa formulário de login"""
        username = request.forms.get('username', '').strip()
        password = request.forms.get('password', '').strip()
        
    def process_login(self):
        """Processa formulário de login"""
        username = request.forms.get('username', '').strip()
        password = request.forms.get('password', '').strip()
        
        # Validações básicas
        if not username or not password:
            return template('app/views/templates/auth/login.tpl', 
                          error="Username e senha são obrigatórios")
        
        # Tentar autenticar
        user = self.user_service.authenticate_user(username, password)
        if user:
            # Criar sessão
            session_id = self.session_service.create_session(username)
            
            # Configurar cookie seguro
            response.set_cookie('session_id', session_id, 
                              httponly=True, 
                              secure=False,  # True em produção com HTTPS
                              max_age=3600)  # 1 hora
            
            # Redirecionar para dashboard
            redirect('/dashboard')
        else:
            return template('app/views/templates/auth/login.tpl', 
                          error=MESSAGES['INVALID_CREDENTIALS'])
    
    def register_page(self):
        """Exibe página de registro"""
        # Se já estiver logado, redirecionar para dashboard
        if self._is_authenticated():
            redirect('/dashboard')
        
        return template('app/views/templates/auth/register.tpl')
    
    def process_register(self):
        """Processa formulário de registro"""
        username = request.forms.get('username', '').strip()
        email = request.forms.get('email', '').strip()
        password = request.forms.get('password', '').strip()
        confirm_password = request.forms.get('confirm_password', '').strip()
        
        # Validações
        errors = []
        
        if not username or not email or not password:
            errors.append("Todos os campos são obrigatórios")
        
        if password != confirm_password:
            errors.append("Senhas não coincidem")
        
        if len(password) < 6:
            errors.append("Senha deve ter pelo menos 6 caracteres")
        
        if '@' not in email or '.' not in email:
            errors.append("Email inválido")
        
        # Se há erros, retornar para formulário
        if errors:
            return template('app/views/templates/auth/register.tpl', 
                          errors=errors,
                          username=username,
                          email=email)
        
        # Tentar criar usuário
        user, message = self.user_service.create_user(username, email, password)
        
        if user:
            # Usuário criado com sucesso - fazer login automático
            session_id = self.session_service.create_session(username)
            
            response.set_cookie('session_id', session_id, 
                              httponly=True, 
                              secure=False,
                              max_age=3600)
            
            redirect('/dashboard')
        else:
            # Erro na criação
            return template('app/views/templates/auth/register.tpl', 
                          error=message,
                          username=username,
                          email=email)
    
    def logout(self):
        """Processa logout"""
        session_id = request.get_cookie('session_id')
        if session_id:
            self.session_service.destroy_session(session_id)
        
        response.delete_cookie('session_id')
        redirect('/')
    
    def _is_authenticated(self):
        """Verifica se usuário está autenticado"""
        session_id = request.get_cookie('session_id')
        if session_id:
            return self.session_service.validate_session(session_id)
        return False
    
    def _get_current_user(self):
        """Retorna usuário atual"""
        session_id = request.get_cookie('session_id')
        if session_id:
            username = self.session_service.get_user_by_session(session_id)
            if username:
                return self.user_service.get_user_by_username(username)
        return None
