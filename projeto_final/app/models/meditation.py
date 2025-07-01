from datetime import datetime
import uuid

class Meditation:
    """Modelo para sessões de meditação"""
    
    def __init__(self, title, duration, category, description, username, id=None, created_at=None):
        self.id = id or str(uuid.uuid4())
        self.title = title
        self.duration = int(duration)  # em minutos
        self.category = category
        self.description = description
        self.username = username  # proprietário da meditação
        self.created_at = created_at or datetime.now().isoformat()
    
    def get_duration_formatted(self):
        """Retorna duração formatada"""
        if self.duration < 60:
            return f"{self.duration} min"
        else:
            hours = self.duration // 60
            minutes = self.duration % 60
            if minutes == 0:
                return f"{hours}h"
            return f"{hours}h {minutes}min"
    
    def to_dict(self):
        """Converte o objeto para dicionário"""
        return {
            'id': self.id,
            'title': self.title,
            'duration': self.duration,
            'category': self.category,
            'description': self.description,
            'username': self.username,
            'created_at': self.created_at
        }
    
    def validate_data(self):
        """Valida os dados da meditação"""
        errors = []
        
        if not self.title or len(self.title.strip()) < 2:
            errors.append("Título deve ter pelo menos 2 caracteres")
        
        if not isinstance(self.duration, int) or self.duration < 1 or self.duration > 120:
            errors.append("Duração deve estar entre 1 e 120 minutos")
        
        if not self.category:
            errors.append("Categoria é obrigatória")
        
        if not self.description or len(self.description.strip()) < 10:
            errors.append("Descrição deve ter pelo menos 10 caracteres")
        
        return errors
    
    def is_valid(self):
        """Verifica se a meditação é válida"""
        return len(self.validate_data()) == 0
    
    def __str__(self):
        return f"Meditation(title='{self.title}', duration={self.duration}min, category='{self.category}')"
    
    def __repr__(self):
        return self.__str__()