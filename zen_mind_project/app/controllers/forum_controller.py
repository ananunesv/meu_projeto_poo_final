from bottle import template, request, response, redirect
from app.services import forum_service, session_service, user_service
from app.services.websocket_service import WebSocketService
from app.utils.decorators import login_required, get_current_user, require_admin
import asyncio

class ForumController:
    """Controller do fórum - Posts e interações"""
    
    def __init__(self):
        self.forum_service = forum_service
        self.session_service = session_service
        self.user_service = user_service
        self.websocket_service = WebSocketService()
    
    def _require_authentication(self):
        """Verifica autenticação obrigatória"""
        current_user = get_current_user()
        if not current_user:
            redirect('/login')
        return current_user
    
    def _get_current_user(self):
        """Retorna usuário atual"""
        return get_current_user()
    
    @login_required
    def forum_page(self):
        """Página principal do fórum"""
        current_user = get_current_user()
        
        # Buscar posts recentes
        posts = self.forum_service.get_recent_posts(limit=20)
        
        # Estatísticas do fórum
        stats = self.forum_service.get_forum_stats()
        
        # Usuários online (se WebSocket estiver ativo)
        online_users = self.websocket_service.get_online_users()
        
        return template('forum/forum_index.tpl',
                       current_user=current_user,
                       posts=posts,
                       stats=stats,
                       online_users=online_users)
    
    @login_required
    def create_post(self):
        """Cria um novo post no fórum"""
        current_user = get_current_user()
        
        content = request.forms.get('content', '').strip()
        
        if not content:
            redirect('/forum')
        
        # Criar post
        post, message = self.forum_service.create_post(current_user.username, content)
        
        if post:
            # Notificar via WebSocket (assíncrono)
            try:
                loop = asyncio.get_event_loop()
                loop.create_task(
                    self.websocket_service.broadcast_forum_post(post.to_dict())
                )
            except:
                # Se não conseguir notificar via WebSocket, continuar normalmente
                pass
        
        # Redirecionar para o fórum
        redirect('/forum')
    
    @login_required
    def delete_post(self, post_id):
        """Remove um post do fórum"""
        current_user = get_current_user()
        
        # Verificar se o post existe
        post = self.forum_service.get_post_by_id(post_id)
        
        if not post:
            redirect('/forum')
        
        # Verificar permissões (proprietário ou admin)
        if post.username != current_user.username and current_user.username != 'admin':
            redirect('/forum')
        
        # Deletar post
        success, message = self.forum_service.delete_post(post_id, current_user.username)
        
        # Redirecionar para o fórum
        redirect('/forum')
    
    @login_required
    def get_posts_api(self):
        """API para buscar posts (para AJAX)"""
        current_user = get_current_user()
        
        if not current_user:
            response.status = 401
            return {'error': 'Não autenticado'}
        
        # Parâmetros de consulta
        limit = int(request.query.get('limit', 10))
        offset = int(request.query.get('offset', 0))
        
        # Buscar posts
        all_posts = self.forum_service.get_all_posts()
        posts = all_posts[offset:offset+limit]
        
        # Converter para dicionário
        posts_data = [post.to_dict() for post in posts]
        
        return {
            'posts': posts_data,
            'total': len(all_posts),
            'has_more': offset + limit < len(all_posts)
        }
    
    @require_admin
    def moderate_post(self, post_id):
        """Modera um post (admin only)"""
        current_user = get_current_user()
        
        # Moderar post
        success, message = self.forum_service.moderate_content(post_id)
        
        # Redirecionar para o fórum
        redirect('/forum')
    
    def notify_realtime(self, event_type, data):
        """Notifica eventos em tempo real via WebSocket"""
        try:
            loop = asyncio.get_event_loop()
            
            if event_type == 'new_post':
                loop.create_task(
                    self.websocket_service.broadcast_forum_post(data)
                )
            elif event_type == 'user_joined':
                loop.create_task(
                    self.websocket_service.broadcast_user_joined(data.get('username'))
                )
            elif event_type == 'user_left':
                loop.create_task(
                    self.websocket_service.broadcast_user_left(data.get('username'))
                )
        except Exception as e:
            print(f"Erro ao notificar via WebSocket: {e}")
    
    @login_required
    def get_forum_stats_api(self):
        """API para estatísticas do fórum"""
        current_user = get_current_user()
        
        if not current_user:
            response.status = 401
            return {'error': 'Não autenticado'}
        
        stats = self.forum_service.get_forum_stats()
        websocket_stats = self.websocket_service.get_connection_stats()
        
        return {
            'forum_stats': stats,
            'realtime_stats': websocket_stats
        }