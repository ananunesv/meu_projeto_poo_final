from bottle import template, request, response, redirect
from app.services import user_service, session_service
from app.config.constants import MESSAGES
from app.utils.decorators import get_current_user

class AuthController:
    """Controller de autenticação - Login, registro, logout"""
    
    def __init__(self):
        self.user_service = user_service
        self.session_service = session_service
    
    def login_page(self):
        """Exibe página de login"""
        # Se já estiver logado, redirecionar para dashboard
        current_user = get_current_user()
        if current_user:
            redirect('/dashboard')
            
        return template('auth/login.tpl')
    
    def process_login(self):
        """Processa formulário de login"""
        username = request.forms.get('username', '').strip()
        password = request.forms.get('password', '').strip()
        
        print(f"[DEBUG] Login attempt - Username: {username}")
        
        # Validações básicas
        if not username or not password:
            return template('auth/login.tpl', 
                          error="Username e senha são obrigatórios",
                          form_data={'username': username})
        
        # Tentar autenticar
        user = self.user_service.authenticate_user(username, password)
        print(f"[DEBUG] User authenticated: {user is not None}")
        
        if user:
            # Criar sessão
            session_id = self.session_service.create_session(username)
            print(f"[DEBUG] Session created: {session_id}")
            
            # Configurar cookie com configurações mais amplas
            response.set_cookie('session_id', session_id, 
                              httponly=False,  # Permitir acesso via JavaScript para debug
                              secure=False,    # HTTP permitido
                              max_age=3600,    # 1 hora
                              path='/')        # Disponível em todo o site
            
            print(f"[DEBUG] Cookie set for session: {session_id}")
            
            # Redirecionar para dashboard
            redirect('/dashboard')
        else:
            print(f"[DEBUG] Authentication failed for user: {username}")
            return template('auth/login.tpl', 
                          error="Credenciais inválidas",
                          form_data={'username': username})
    
    def register_page(self):
        """Exibe página de registro"""
        # Se já estiver logado, redirecionar para dashboard
        current_user = get_current_user()
        if current_user:
            redirect('/dashboard')
            
        return template('auth/register.tpl')
    
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
            return template('auth/register.tpl', 
                          errors=errors,
                          form_data={
                              'username': username,
                              'email': email
                          })
        
        # Tentar criar usuário
        user, message = self.user_service.create_user(username, email, password)
        
        if user:
            # Usuário criado com sucesso - fazer login automático
            session_id = self.session_service.create_session(username)
            
            response.set_cookie('session_id', session_id, 
                              httponly=False, 
                              secure=False,
                              max_age=3600,
                              path='/')
            
            redirect('/dashboard')
        else:
            # Erro na criação
            return template('auth/register.tpl', 
                          error=message,
                          form_data={
                              'username': username,
                              'email': email
                          })
    
    def logout(self):
        """Processa logout"""
        session_id = request.get_cookie('session_id')
        if session_id:
            self.session_service.destroy_session(session_id)
        
        response.delete_cookie('session_id', path='/')
        redirect('/')
    
    def _is_authenticated(self):
        """Verifica se usuário está autenticado"""
        session_id = request.get_cookie('session_id')
        if session_id:
            return self.session_service.validate_session(session_id)
        return False
    
    def _get_current_user(self):
        """Retorna usuário atual"""
        return get_current_user()
