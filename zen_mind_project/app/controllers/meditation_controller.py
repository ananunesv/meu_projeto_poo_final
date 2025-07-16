from bottle import template, request, response, redirect
from app.services import meditation_service, session_service, user_service
from app.config.constants import MEDITATION_CATEGORIES, MESSAGES
from app.utils.decorators import login_required, get_current_user

class MeditationController:
    """Controller de meditações - CRUD completo"""
    
    def __init__(self):
        self.meditation_service = meditation_service
        self.session_service = session_service
        self.user_service = user_service
    
    def _require_authentication(self):
        """Verifica autenticação obrigatória"""
        current_user = get_current_user()
        if not current_user:
            redirect('/login')
        return current_user
    
    def _get_current_user(self):
        """Retorna usuário atual"""
        return get_current_user()
    
    def _clean_text(self, text):
        """Limpa e valida texto de entrada"""
        if not text:
            return ""
        
        # Remove quebras de linha excessivas e espaços
        text = ' '.join(text.strip().split())
        
        # Limita o tamanho
        if len(text) > 500:
            text = text[:500]
        
        return text
    
    @login_required
    def dashboard(self):
        """Dashboard principal do usuário"""
        current_user = get_current_user()
        
        # Buscar meditações do usuário
        user_meditations = self.meditation_service.get_meditations_by_user(current_user.username)
        
        # Buscar estatísticas
        stats = self.meditation_service.get_user_stats(current_user.username)
        
        # Meditações recentes (últimas 5)
        recent_meditations = sorted(user_meditations, 
                                  key=lambda x: x.created_at, 
                                  reverse=True)[:5]
        
        return template('meditation/meditation_dashboard.tpl',
                       current_user=current_user,
                       user_meditations=user_meditations,
                       recent_meditations=recent_meditations,
                       stats=stats,
                       categories=MEDITATION_CATEGORIES)
    
    @login_required
    def list_meditations(self):
        """Lista todas as meditações do usuário"""
        current_user = get_current_user()
        
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
        
        return template('meditation/meditation_list.tpl',
                       current_user=current_user,
                       meditations=meditations,
                       categories=MEDITATION_CATEGORIES,
                       current_category=category_filter,
                       search_term=search_term)
    
    @login_required
    def new_meditation(self):
        """Exibe formulário para nova meditação"""
        current_user = get_current_user()
        
        return template('meditation/meditation_form.tpl',
                       current_user=current_user,
                       categories=MEDITATION_CATEGORIES,
                       meditation=None,
                       action='create')
    
    @login_required
    def create_meditation(self):
        """Processa criação de nova meditação"""
        current_user = get_current_user()
        
        # Capturar dados do formulário
        title = request.forms.get('title', '').strip()
        duration_str = request.forms.get('duration', '').strip()
        category = request.forms.get('category', '').strip()
        description = request.forms.get('description', '').strip()
        
        # Validar e limpar dados
        title = self._clean_text(title)
        description = self._clean_text(description)
        
        # Validação adicional
        try:
            duration = int(duration_str) if duration_str else 0
        except ValueError:
            duration = 0
        
        # Verificar se a categoria é válida
        valid_categories = ['respiracao', 'mindfulness', 'relaxamento', 'concentracao', 'sono', 'estresse']
        if category not in valid_categories:
            category = ''
        
        # Tentar criar meditação
        meditation, message = self.meditation_service.create_meditation(
            title, duration, category, description, current_user.username
        )
        
        if meditation:
            # Sucesso - redirecionar para detalhes
            redirect(f'/meditacoes/{meditation.id}')
        else:
            # Erro - retornar formulário com erros
            return template('meditation/meditation_form.tpl',
                           current_user=current_user,
                           categories=MEDITATION_CATEGORIES,
                           meditation=None,
                           action='create',
                           error=message,
                           form_data={
                               'title': title,
                               'duration': duration_str,
                               'category': category,
                               'description': description
                           })
    
    @login_required
    def view_meditation(self, meditation_id):
        """Exibe detalhes de uma meditação"""
        current_user = get_current_user()
        
        meditation = self.meditation_service.get_meditation_by_id(meditation_id)
        
        if not meditation:
            redirect('/meditacoes')
        
        # Verificar se o usuário é o proprietário
        if meditation.username != current_user.username:
            redirect('/meditacoes')
        
        return template('meditation/meditation_detail.tpl',
                       current_user=current_user,
                       meditation=meditation)
    
    @login_required
    def edit_meditation(self, meditation_id):
        """Exibe formulário de edição"""
        current_user = get_current_user()
        
        meditation = self.meditation_service.get_meditation_by_id(meditation_id)
        
        if not meditation or meditation.username != current_user.username:
            redirect('/meditacoes')
        
        return template('meditation/meditation_form.tpl',
                       current_user=current_user,
                       categories=MEDITATION_CATEGORIES,
                       meditation=meditation,
                       action='edit')
    
    @login_required
    def update_meditation(self, meditation_id):
        """Processa atualização de meditação"""
        current_user = get_current_user()
        
        meditation = self.meditation_service.get_meditation_by_id(meditation_id)
        
        if not meditation or meditation.username != current_user.username:
            redirect('/meditacoes')
        
        # Capturar dados do formulário
        title = request.forms.get('title', '').strip()
        duration_str = request.forms.get('duration', '').strip()
        category = request.forms.get('category', '').strip()
        description = request.forms.get('description', '').strip()
        
        # Validar e limpar dados
        title = self._clean_text(title)
        description = self._clean_text(description)
        
        # Validação adicional
        try:
            duration = int(duration_str) if duration_str else meditation.duration
        except ValueError:
            duration = meditation.duration
        
        # Verificar se a categoria é válida
        valid_categories = ['respiracao', 'mindfulness', 'relaxamento', 'concentracao', 'sono', 'estresse']
        if category not in valid_categories:
            category = meditation.category
        
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
            
            return template('meditation/meditation_form.tpl',
                           current_user=current_user,
                           categories=MEDITATION_CATEGORIES,
                           meditation=meditation,
                           action='edit',
                           error=message)
    
    @login_required
    def delete_meditation(self, meditation_id):
        """Remove uma meditação"""
        current_user = get_current_user()
        
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