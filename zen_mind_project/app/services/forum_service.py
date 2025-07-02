import json
import os
from datetime import datetime
from app.models.forum_post import ForumPost
from app.config.settings import FORUM_POSTS_FILE

class ForumService:
    """Gerenciador de posts do fórum - CRUD completo"""
    
    def __init__(self):
        self.posts = []
        self.file_path = FORUM_POSTS_FILE
        self.load_posts()
    
    def load_posts(self):
        """Carrega posts do arquivo JSON"""
        try:
            if os.path.exists(self.file_path):
                with open(self.file_path, 'r', encoding='utf-8') as file:
                    data = json.load(file)
                    self.posts = [ForumPost(**post_data) for post_data in data]
            else:
                self._create_initial_posts()
        except Exception as e:
            print(f"Erro ao carregar posts: {e}")
            self._create_initial_posts()
    
    def save_posts(self):
        """Salva posts no arquivo JSON"""
        try:
            os.makedirs(os.path.dirname(self.file_path), exist_ok=True)
            with open(self.file_path, 'w', encoding='utf-8') as file:
                data = [post.to_dict() for post in self.posts]
                json.dump(data, file, indent=2, ensure_ascii=False)
        except Exception as e:
            print(f"Erro ao salvar posts: {e}")
    
    def _create_initial_posts(self):
        """Cria posts iniciais para desenvolvimento"""
        initial_posts = [
            ForumPost(
                username="admin",
                content="Bem-vindos ao fórum do Zen Mind! 🧘 Compartilhem suas experiências de meditação, dicas e reflexões. Vamos crescer juntos nesta jornada de autoconhecimento!"
            ),
            ForumPost(
                username="ana_medita",
                content="Acabei de completar minha primeira semana de meditação diária. Que transformação incrível! A ansiedade diminuiu muito e me sinto mais centrada. Recomendo começarem aos poucos, 5 minutos por dia já fazem diferença! 💙"
            )
        ]
        self.posts = initial_posts
        self.save_posts()
    
    # CREATE
    def create_post(self, username, content):
        """Cria um novo post"""
        try:
            new_post = ForumPost(username, content)
            
            # Validar conteúdo
            if not new_post.is_valid():
                errors = new_post.validate_content()
                return None, "; ".join(errors)
            
            # Adicionar à lista e salvar
            self.posts.append(new_post)
            self.save_posts()
            
            return new_post, "Post criado com sucesso"
        
        except Exception as e:
            return None, f"Erro ao criar post: {str(e)}"
    
    # READ
    def get_post_by_id(self, post_id):
        """Busca post por ID"""
        for post in self.posts:
            if post.id == post_id:
                return post
        return None
    
    def get_all_posts(self):
        """Retorna todos os posts ordenados por data (mais recentes primeiro)"""
        return sorted(self.posts, key=lambda x: x.timestamp, reverse=True)
    
    def get_posts_by_user(self, username):
        """Busca todos os posts de um usuário"""
        return [post for post in self.posts if post.username == username]
    
    def get_recent_posts(self, limit=10):
        """Retorna posts mais recentes"""
        sorted_posts = self.get_all_posts()
        return sorted_posts[:limit]
    
    # DELETE
    def delete_post(self, post_id, username=None):
        """Remove um post"""
        post = self.get_post_by_id(post_id)
        if not post:
            return False, "Post não encontrado"
        
        # Verificar se o usuário tem permissão para deletar
        if username and post.username != username:
            return False, "Você não tem permissão para deletar este post"
        
        self.posts.remove(post)
        self.save_posts()
        return True, "Post removido com sucesso"
    
    # MODERATION
    def moderate_content(self, post_id):
        """Modera conteúdo de um post (admin only)"""
        post = self.get_post_by_id(post_id)
        if not post:
            return False, "Post não encontrado"
        
        # Verificação básica de moderação
        if not post.is_valid():
            self.delete_post(post_id)
            return True, "Post removido por violação das regras"
        
        return True, "Post aprovado"
    
    # STATISTICS
    def get_forum_stats(self):
        """Retorna estatísticas do fórum"""
        total_posts = len(self.posts)
        unique_users = len(set(post.username for post in self.posts))
        
        # Posts por usuário
        user_posts = {}
        for post in self.posts:
            if post.username not in user_posts:
                user_posts[post.username] = 0
            user_posts[post.username] += 1
        
        # Usuário mais ativo
        most_active_user = max(user_posts.items(), key=lambda x: x[1]) if user_posts else ("Nenhum", 0)
        
        return {
            'total_posts': total_posts,
            'unique_users': unique_users,
            'posts_per_user': user_posts,
            'most_active_user': most_active_user[0],
            'most_active_posts': most_active_user[1]
        }
