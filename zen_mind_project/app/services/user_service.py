import json
import os
from datetime import datetime
from app.models.user import User
from app.config.settings import USERS_FILE

class UserService:
    """Gerenciador de usuários - CRUD completo"""
    
    def __init__(self):
        self.users = []
        self.file_path = USERS_FILE
        self.load_users()
    
    def load_users(self):
        """Carrega usuários do arquivo JSON"""
        try:
            if os.path.exists(self.file_path):
                with open(self.file_path, 'r', encoding='utf-8') as file:
                    data = json.load(file)
                    self.users = [User(**user_data) for user_data in data]
            else:
                # Criar usuários iniciais se arquivo não existir
                self._create_initial_users()
        except Exception as e:
            print(f"Erro ao carregar usuários: {e}")
            self._create_initial_users()
    
    def save_users(self):
        """Salva usuários no arquivo JSON"""
        try:
            os.makedirs(os.path.dirname(self.file_path), exist_ok=True)
            with open(self.file_path, 'w', encoding='utf-8') as file:
                data = [user.to_dict() for user in self.users]
                json.dump(data, file, indent=2, ensure_ascii=False)
            print(f"[DEBUG] Usuários salvos com sucesso: {len(self.users)} usuários")
        except Exception as e:
            print(f"Erro ao salvar usuários: {e}")
    
    def _create_initial_users(self):
        """Cria usuários iniciais para desenvolvimento"""
        initial_users = [
            User("admin", "admin@zenMind.com", "admin123"),
            User("ana_medita", "ana@email.com", "123456"),
            User("guest", "guest@zenMind.com", "guest123")
        ]
        self.users = initial_users
        self.save_users()
    
    # CREATE
    def create_user(self, username, email, password):
        """Cria um novo usuário"""
        # Validações
        if self.username_exists(username):
            return None, "Nome de usuário já existe"
        
        if self.email_exists(email):
            return None, "Email já cadastrado"
        
        if len(username) < 3 or len(username) > 20:
            return None, "Nome de usuário deve ter entre 3 e 20 caracteres"
        
        if len(password) < 6:
            return None, "Senha deve ter pelo menos 6 caracteres"
        
        if '@' not in email or '.' not in email:
            return None, "Email inválido"
        
        # Criar usuário
        new_user = User(username, email, password)
        self.users.append(new_user)
        self.save_users()
        
        return new_user, "Usuário criado com sucesso"
    
    # READ
    def get_user_by_username(self, username):
        """Busca usuário por nome de usuário"""
        for user in self.users:
            if user.username == username:
                return user
        return None
    
    def get_user_by_email(self, email):
        """Busca usuário por email"""
        for user in self.users:
            if user.email == email:
                return user
        return None
    
    def get_all_users(self):
        """Retorna todos os usuários"""
        return self.users
    
    def username_exists(self, username):
        """Verifica se nome de usuário já existe"""
        return self.get_user_by_username(username) is not None
    
    def email_exists(self, email):
        """Verifica se email já está cadastrado"""
        return self.get_user_by_email(email) is not None
    
    # UPDATE
    def update_user(self, username, email=None, password=None):
        """Atualiza dados de um usuário"""
        user = self.get_user_by_username(username)
        if not user:
            return False, "Usuário não encontrado"
        
        if email and email != user.email:
            if self.email_exists(email):
                return False, "Email já cadastrado por outro usuário"
            user.email = email
        
        if password:
            if len(password) < 6:
                return False, "Senha deve ter pelo menos 6 caracteres"
            user.password = password
        
        self.save_users()
        return True, "Usuário atualizado com sucesso"
    
    def update_user_profile(self, current_user, new_username=None, new_email=None, new_password=None):
        """Atualiza perfil do usuário - método específico para perfil"""
        try:
            # Validações
            if new_username and new_username != current_user.username:
                if self.username_exists(new_username):
                    return False, "Nome de usuário já existe"
                if len(new_username) < 3 or len(new_username) > 20:
                    return False, "Nome de usuário deve ter entre 3 e 20 caracteres"
            
            if new_email and new_email != current_user.email:
                if self.email_exists(new_email):
                    return False, "Email já está sendo usado por outro usuário"
                if '@' not in new_email or '.' not in new_email:
                    return False, "Email inválido"
            
            if new_password:
                if len(new_password) < 6:
                    return False, "Nova senha deve ter pelo menos 6 caracteres"
            
            # Aplicar alterações
            if new_username:
                current_user.username = new_username
            
            if new_email:
                current_user.email = new_email
            
            if new_password:
                current_user.password = new_password
            
            # Salvar alterações
            self.save_users()
            
            return True, "Perfil atualizado com sucesso"
            
        except Exception as e:
            print(f"Erro ao atualizar perfil: {e}")
            return False, "Erro interno ao atualizar perfil"
    
    # DELETE
    def delete_user(self, username):
        """Remove um usuário"""
        user = self.get_user_by_username(username)
        if not user:
            return False, "Usuário não encontrado"
        
        # Não permitir deletar admin
        if username == 'admin':
            return False, "Não é possível deletar o usuário admin"
        
        self.users.remove(user)
        self.save_users()
        return True, "Usuário removido com sucesso"
    
    def delete_user_and_data(self, username):
        """Remove usuário e todos os seus dados relacionados"""
        try:
            # Deletar todas as meditações do usuário
            from app.services import meditation_service
            user_meditations = meditation_service.get_meditations_by_user(username)
            for meditation in user_meditations:
                meditation_service.delete_meditation(meditation.id, username)
            
            # Deletar todos os posts do usuário no fórum
            from app.services import forum_service
            user_posts = forum_service.get_posts_by_user(username)
            for post in user_posts:
                forum_service.delete_post(post.id, username)
            
            # Deletar o usuário
            success, message = self.delete_user(username)
            
            if success:
                return True, "Conta e todos os dados relacionados foram deletados com sucesso"
            else:
                return False, message
                
        except Exception as e:
            print(f"Erro ao deletar usuário e dados: {e}")
            return False, "Erro interno ao deletar conta"
    
    # AUTHENTICATION
    def authenticate_user(self, username, password):
        """Autentica um usuário"""
        user = self.get_user_by_username(username)
        if user and user.validate_password(password):
            return user
        return None
    
    def get_user_count(self):
        """Retorna número total de usuários"""
        return len(self.users)
    
    # STATISTICS
    def get_user_statistics(self, username):
        """Retorna estatísticas completas do usuário"""
        try:
            from app.services import meditation_service, forum_service
            
            # Estatísticas de meditação
            meditation_stats = meditation_service.get_user_stats(username)
            
            # Estatísticas do fórum
            user_posts = forum_service.get_posts_by_user(username)
            
            # Calcular dados adicionais
            user = self.get_user_by_username(username)
            account_age_days = 0
            if user and hasattr(user, 'created_at'):
                try:
                    created_date = datetime.fromisoformat(user.created_at)
                    account_age_days = (datetime.now() - created_date).days
                except:
                    account_age_days = 0
            
            return {
                'meditation_stats': meditation_stats,
                'forum_posts': len(user_posts),
                'account_age_days': account_age_days,
                'total_meditations': meditation_stats.get('total_meditations', 0),
                'total_meditation_time': meditation_stats.get('total_duration', 0),
                'average_meditation_duration': meditation_stats.get('average_duration', 0),
                'meditation_categories': meditation_stats.get('categories', {}),
                'is_active_user': meditation_stats.get('total_meditations', 0) > 0 or len(user_posts) > 0
            }
            
        except Exception as e:
            print(f"Erro ao obter estatísticas do usuário: {e}")
            return {
                'meditation_stats': {},
                'forum_posts': 0,
                'account_age_days': 0,
                'total_meditations': 0,
                'total_meditation_time': 0,
                'average_meditation_duration': 0,
                'meditation_categories': {},
                'is_active_user': False
            }