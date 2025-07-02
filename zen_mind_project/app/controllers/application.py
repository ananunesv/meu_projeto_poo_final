from bottle import template, request, response, redirect
from app.services import user_service, session_service
from app.utils.decorators import get_current_user, is_authenticated

class Application:
    """Controller principal - Coordena operações gerais"""
    
    def __init__(self):
        self.pages = {
            'home': self.home,
            'helper': self.helper,
            'download': self.download
        }
        
        # Services
        self.user_service = user_service
        self.session_service = session_service
    
    def render(self, page, **kwargs):
        """Renderiza uma página com dados opcionais"""
        content = self.pages.get(page, self.helper)
        return content(**kwargs)
    
    def home(self, **kwargs):
        """Página inicial - Landing page"""
        current_user = get_current_user()
        return template('homepage.tpl', 
                       current_user=current_user, 
                       **kwargs)
    
    def helper(self, **kwargs):
        """Página de documentação"""
        current_user = get_current_user()
        return template('documentation.tpl', 
                       current_user=current_user,
                       **kwargs)
    
    def download(self, **kwargs):
        """Página de download do app"""
        current_user = get_current_user()
        return template('app_download.tpl', 
                       current_user=current_user,
                       **kwargs)
    
    # ===== MÉTODOS DE SESSÃO =====
    
    def get_session_id(self):
        """Recupera session_id dos cookies"""
        return request.get_cookie('session_id')
    
    def get_current_user(self):
        """Retorna usuário logado atual"""
        return get_current_user()
    
    def is_authenticated(self):
        """Verifica se há usuário autenticado"""
        return is_authenticated()
    
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
