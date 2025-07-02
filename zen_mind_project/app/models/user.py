from datetime import datetime
import hashlib

class User:
    """Modelo para usuários do sistema Zen Mind"""
    
    def __init__(self, username, email, password, created_at=None):
        self.username = username
        self.email = email
        self.password = password  # Será hash em produção
        self.created_at = created_at or datetime.now().isoformat()
    
    def validate_password(self, password):
        """Valida se a senha fornecida está correta"""
        # Em produção, usaria hash + salt
        return self.password == password
    
    def hash_password(self, password):
        """Gera hash da senha (simplificado para desenvolvimento)"""
        # Em produção, usaria bcrypt ou similar
        return hashlib.md5(password.encode()).hexdigest()
    
    def to_dict(self):
        """Converte o objeto para dicionário"""
        return {
            'username': self.username,
            'email': self.email,
            'password': self.password,
            'created_at': self.created_at
        }
    
    def get_info(self):
        """Retorna informações públicas do usuário"""
        return {
            'username': self.username,
            'email': self.email,
            'created_at': self.created_at
        }
    
    def __str__(self):
        return f"User(username='{self.username}', email='{self.email}')"
    
    def __repr__(self):
        return self.__str__()