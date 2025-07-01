from bottle import template, request, response, redirect
from app.services.meditation_service import MeditationService
from app.services.session_service import SessionService
from app.services.user_service import UserService
from app.config.constants import MEDITATION_CATEGORIES, MESSAGES

class MeditationController:
    """Controller de meditações - CRUD completo"""
    
    def __init__(self):
        self.meditation_service = MeditationService()
        self.session_service = SessionService()
        self.user_service = UserService()
    
    def _require_authentication(self):
        """Verifica autenticação obrigatória"""
        current_user = self._get_current_user()
        if not current_user:
            redirect('/login')
        return current_user
    
    def _get_current_user(self):
        """Retorna usuário atual"""
        session_id = request.get_cookie('session_id')
        if session_id:
            username = self.session_service.get_user_by_session(session_id)
            if username:
                return self.user_service.get_user_by_username(username)
        return None
    
    def dashboard(self):
        """Dashboard principal do usuário"""
        current_user = self._require_authentication()
        
        # Buscar meditações do usuário
        user_meditations = self.meditation_service.get_meditations_by_user(current_user.username)
        
        # Buscar estatísticas
        stats = self.meditation_service.get_user_stats(current_user.username)
        
        # Meditações recentes (últimas 5)
        recent_meditations = sorted(user_meditations, 
                                  key=lambda x: x.created_at, 
                                  reverse=True)[:5]
        
        return template('app/views/templates/meditation/dashboard.tpl',
                       current_user=current_user,
                       user_meditations=user_meditations,
                       recent_meditations=recent_meditations,
                       stats=stats,
                       categories=MEDITATION_CATEGORIES)
    
    def list_meditations(self):
        """Lista todas as meditações do usuário"""
        current_user = self._require_authentication()
        
        # Filtros opcionais
        category_filter = request.query.get('category', '').strip()
        search_term = request.query.get('search', '').strip()
        
        # Buscar meditações do usuário
        meditations = self.meditation_service.get_meditations_by_user(current_user.username)
        
        # Aplicar filtros
        if category_filter:
            meditations = [m for m in meditations if m.category == category_filter]
        
        if search_term:
            search_lower = search_term.lower()
            meditations = [m for m in meditations 
                         if search_lower in m.title.lower() 
                         or search_lower in m.description.lower()]
        
        # Ordenar por data (mais recentes primeiro)
        meditations = sorted(meditations, key=lambda x: x.created_at, reverse=True)
        
        return template('app/views/templates/meditation/list.tpl',
                       current_user=current_user,
                       meditations=meditations,
                       categories=MEDITATION_CATEGORIES,
                       current_category=category_filter,
                       search_term=search_term)
    
    def new_meditation(self):
        """Exibe formulário para nova meditação"""
        current_user = self._require_authentication()
        
        return template('app/views/templates/meditation/form.tpl',
                       current_user=current_user,
                       categories=MEDITATION_CATEGORIES,
                       meditation=None,
                       action='create')
    
    def create_meditation(self):
        """Processa criação de nova meditação"""
        current_user = self._require_authentication()
        
        # Capturar dados do formulário
        title = request.forms.get('title', '').strip()
        duration = request.forms.get('duration', '').strip()
        category = request.forms.get('category', '').strip()
        description = request.forms.get('description', '').strip()
        
        # Tentar criar meditação
        meditation, message = self.meditation_service.create_meditation(
            title, duration, category, description, current_user.username
        )
        
        if meditation:
            # Sucesso - redirecionar para detalhes
            redirect(f'/meditacoes/{meditation.id}')
        else:
            # Erro - retornar formulário com erros
            return template('app/views/templates/meditation/form.tpl',
                           current_user=current_user,
                           categories=MEDITATION_CATEGORIES,
                           meditation=None,
                           action='create',
                           error=message,
                           form_data={
                               'title': title,
                               'duration': duration,
                               'category': category,
                               'description': description
                           })
    
    def view_meditation(self, meditation_id):
        """Exibe detalhes de uma meditação"""
        current_user = self._require_authentication()
        
        meditation = self.meditation_service.get_meditation_by_id(meditation_id)
        
        if not meditation:
            redirect('/meditacoes')
        
        # Verificar se o usuário é o proprietário
        if meditation.username != current_user.username:
            redirect('/meditacoes')
        
        return template('app/views/templates/meditation/detail.tpl',
                       current_user=current_user,
                       meditation=meditation)
    
    def edit_meditation(self, meditation_id):
        """Exibe formulário de edição"""
        current_user = self._require_authentication()
        
        meditation = self.meditation_service.get_meditation_by_id(meditation_id)
        
        if not meditation or meditation.username != current_user.username:
            redirect('/meditacoes')
        
        return template('app/views/templates/meditation/form.tpl',
                       current_user=current_user,
                       categories=MEDITATION_CATEGORIES,
                       meditation=meditation,
                       action='edit')
    
    def update_meditation(self, meditation_id):
        """Processa atualização de meditação"""
        current_user = self._require_authentication()
        
        meditation = self.meditation_service.get_meditation_by_id(meditation_id)
        
        if not meditation or meditation.username != current_user.username:
            redirect('/meditacoes')
        
        # Capturar dados do formulário
        title = request.forms.get('title', '').strip()
        duration = request.forms.get('duration', '').strip()
        category = request.forms.get('category', '').strip()
        description = request.forms.get('description', '').strip()
        
        # Tentar atualizar
        success, message = self.meditation_service.update_meditation(
            meditation_id, title, duration, category, description
        )
        
        if success:
            # Sucesso - redirecionar para detalhes
            redirect(f'/meditacoes/{meditation_id}')
        else:
            # Erro - retornar formulário com erros
            # Atualizar objeto meditation com novos dados para exibir no form
            meditation.title = title
            meditation.duration = duration
            meditation.category = category
            meditation.description = description
            
            return template('app/views/templates/meditation/form.tpl',
                           current_user=current_user,
                           categories=MEDITATION_CATEGORIES,
                           meditation=meditation,
                           action='edit',
                           error=message)
    
    def delete_meditation(self, meditation_id):
        """Remove uma meditação"""
        current_user = self._require_authentication()
        
        # Verificar se a meditação existe e pertence ao usuário
        meditation = self.meditation_service.get_meditation_by_id(meditation_id)
        
        if not meditation or meditation.username != current_user.username:
            redirect('/meditacoes')
        
        # Tentar deletar
        success, message = self.meditation_service.delete_meditation(
            meditation_id, current_user.username
        )
        
        # Redirecionar para lista (independente do resultado)
        redirect('/meditacoes')
