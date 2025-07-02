from datetime import datetime
import uuid

class ForumPost:
    """Modelo para posts do fórum"""
    
    def __init__(self, username, content, id=None, timestamp=None):
        self.id = id or str(uuid.uuid4())
        self.username = username
        self.content = content
        self.timestamp = timestamp or datetime.now().isoformat()
    
    def get_time_ago(self):
        """Retorna tempo relativo desde a criação"""
        try:
            post_time = datetime.fromisoformat(self.timestamp)
            now = datetime.now()
            diff = now - post_time
            
            if diff.days > 0:
                return f"{diff.days} dia(s) atrás"
            elif diff.seconds > 3600:
                hours = diff.seconds // 3600
                return f"{hours} hora(s) atrás"
            elif diff.seconds > 60:
                minutes = diff.seconds // 60
                return f"{minutes} minuto(s) atrás"
            else:
                return "Agora mesmo"
        except:
            return "Data inválida"
    
    def validate_content(self):
        """Valida o conteúdo do post"""
        errors = []
        
        if not self.content or len(self.content.strip()) < 3:
            errors.append("Post deve ter pelo menos 3 caracteres")
        
        if len(self.content) > 500:
            errors.append("Post não pode ter mais de 500 caracteres")
        
        # Verificação básica de conteúdo inapropriado
        inappropriate_words = ['spam', 'lixo', 'idiota']  # Lista básica
        content_lower = self.content.lower()
        for word in inappropriate_words:
            if word in content_lower:
                errors.append("Conteúdo contém palavras inapropriadas")
                break
        
        return errors
    
    def is_valid(self):
        """Verifica se o post é válido"""
        return len(self.validate_content()) == 0
    
    def to_dict(self):
        """Converte o objeto para dicionário"""
        return {
            'id': self.id,
            'username': self.username,
            'content': self.content,
            'timestamp': self.timestamp
        }
    
    def get_preview(self, max_length=100):
        """Retorna prévia do conteúdo"""
        if len(self.content) <= max_length:
            return self.content
        return self.content[:max_length] + "..."
    
    def __str__(self):
        return f"ForumPost(username='{self.username}', content='{self.get_preview(50)}')"
    
    def __repr__(self):
        return self.__str__()