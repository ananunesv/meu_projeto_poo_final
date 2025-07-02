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
    
    # DELETE
    def delete_user(self, username):
        """Remove um usuário"""
        user = self.get_user_by_username(username)
        if not user:
            return False, "Usuário não encontrado"
        
        self.users.remove(user)
        self.save_users()
        return True, "Usuário removido com sucesso"
    
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
