from bottle import template, request, response, redirect
from app.services.user_service import UserService
from app.services.session_service import SessionService

class Application:
    """Controller principal - Coordena operações gerais"""
    
    def __init__(self):
        self.pages = {
            'home': self.home,
            'helper': self.helper,
            'download': self.download
        }
        
        # Services
        self.user_service = UserService()
        self.session_service = SessionService()
    
    def render(self, page, **kwargs):
        """Renderiza uma página com dados opcionais"""
        content = self.pages.get(page, self.helper)
        return content(**kwargs)
    
    def home(self, **kwargs):
        """Página inicial - Landing page"""
        current_user = self.get_current_user()
        return template('app/views/templates/home.tpl', 
                       current_user=current_user, 
                       **kwargs)
    
    def helper(self, **kwargs):
        """Página de documentação"""
        return template('app/views/templates/helper.tpl', **kwargs)
    
    def download(self, **kwargs):
        """Página de download do app"""
        return template('app/views/templates/download.tpl', **kwargs)
    
    # ===== MÉTODOS DE SESSÃO =====
    
    def get_session_id(self):
        """Recupera session_id dos cookies"""
        return request.get_cookie('session_id')
    
    def get_current_user(self):
        """Retorna usuário logado atual"""
        session_id = self.get_session_id()
        if session_id:
            username = self.session_service.get_user_by_session(session_id)
            if username:
                return self.user_service.get_user_by_username(username)
        return None
    
    def is_authenticated(self):
        """Verifica se há usuário autenticado"""
        return self.get_current_user() is not None
    
    def require_authentication(self):
        """Redireciona para login se não estiver autenticado"""
        if not self.is_authenticated():
            redirect('/login')
    
    def authenticate_user(self, username, password):
        """Autentica usuário e cria sessão"""
        user = self.user_service.authenticate_user(username, password)
        if user:
            session_id = self.session_service.create_session(username)
            return session_id, user
        return None, None
    
    def logout_user(self):
        """Faz logout do usuário atual"""
        session_id = self.get_session_id()
        if session_id:
            self.session_service.destroy_session(session_id)
            response.delete_cookie('session_id')
