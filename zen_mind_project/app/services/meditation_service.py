import json
import os
import uuid
from datetime import datetime
from app.models.meditation import Meditation
from app.config.settings import MEDITATIONS_FILE
from app.config.constants import MEDITATION_CATEGORIES

class MeditationService:
    """Gerenciador de meditações - CRUD completo"""
    
    def __init__(self):
        self.meditations = []
        self.file_path = MEDITATIONS_FILE
        self.load_meditations()
    
    def load_meditations(self):
        """Carrega meditações do arquivo JSON"""
        try:
            if os.path.exists(self.file_path):
                with open(self.file_path, 'r', encoding='utf-8') as file:
                    data = json.load(file)
                    self.meditations = [Meditation(**med_data) for med_data in data]
            else:
                self._create_initial_meditations()
        except Exception as e:
            print(f"Erro ao carregar meditações: {e}")
            self._create_initial_meditations()
    
    def save_meditations(self):
        """Salva meditações no arquivo JSON"""
        try:
            os.makedirs(os.path.dirname(self.file_path), exist_ok=True)
            with open(self.file_path, 'w', encoding='utf-8') as file:
                data = [meditation.to_dict() for meditation in self.meditations]
                json.dump(data, file, indent=2, ensure_ascii=False)
        except Exception as e:
            print(f"Erro ao salvar meditações: {e}")
    
    def _create_initial_meditations(self):
        """Cria meditações iniciais para desenvolvimento"""
        initial_meditations = [
            Meditation(
                title="Respiração Matinal",
                duration=10,
                category="respiracao",
                description="Técnica de respiração 4-7-8 para começar o dia com energia positiva",
                username="admin"
            ),
            Meditation(
                title="Meditação para Dormir",
                duration=20,
                category="sono",
                description="Relaxamento progressivo para uma noite tranquila e reparadora",
                username="admin"
            ),
            Meditation(
                title="Foco e Concentração",
                duration=15,
                category="foco",
                description="Meditação mindfulness para aumentar a concentração no trabalho",
                username="ana_medita"
            )
        ]
        self.meditations = initial_meditations
        self.save_meditations()
    
    # CREATE
    def create_meditation(self, title, duration, category, description, username):
        """Cria uma nova meditação"""
        try:
            # Criar objeto meditação
            new_meditation = Meditation(title, duration, category, description, username)
            
            # Validar dados
            if not new_meditation.is_valid():
                errors = new_meditation.validate_data()
                return None, "; ".join(errors)
            
            # Adicionar à lista e salvar
            self.meditations.append(new_meditation)
            self.save_meditations()
            
            return new_meditation, "Meditação criada com sucesso"
        
        except Exception as e:
            return None, f"Erro ao criar meditação: {str(e)}"
    
    # READ
    def get_meditation_by_id(self, meditation_id):
        """Busca meditação por ID"""
        for meditation in self.meditations:
            if meditation.id == meditation_id:
                return meditation
        return None
    
    def get_meditations_by_user(self, username):
        """Busca todas as meditações de um usuário"""
        return [med for med in self.meditations if med.username == username]
    
    def get_all_meditations(self):
        """Retorna todas as meditações"""
        return self.meditations
    
    def get_meditations_by_category(self, category):
        """Busca meditações por categoria"""
        return [med for med in self.meditations if med.category == category]
    
    def get_categories(self):
        """Retorna todas as categorias disponíveis"""
        return MEDITATION_CATEGORIES
    
    def get_recent_meditations(self, limit=5):
        """Retorna meditações mais recentes"""
        sorted_meditations = sorted(
            self.meditations, 
            key=lambda x: x.created_at, 
            reverse=True
        )
        return sorted_meditations[:limit]
    
    # UPDATE
    def update_meditation(self, meditation_id, title=None, duration=None, 
                         category=None, description=None):
        """Atualiza uma meditação existente"""
        meditation = self.get_meditation_by_id(meditation_id)
        if not meditation:
            return False, "Meditação não encontrada"
        
        # Atualizar campos fornecidos
        if title is not None:
            meditation.title = title
        if duration is not None:
            meditation.duration = int(duration)
        if category is not None:
            meditation.category = category
        if description is not None:
            meditation.description = description
        
        # Validar dados atualizados
        if not meditation.is_valid():
            errors = meditation.validate_data()
            return False, "; ".join(errors)
        
        self.save_meditations()
        return True, "Meditação atualizada com sucesso"
    
    # DELETE
    def delete_meditation(self, meditation_id, username=None):
        """Remove uma meditação"""
        meditation = self.get_meditation_by_id(meditation_id)
        if not meditation:
            return False, "Meditação não encontrada"
        
        # Verificar se o usuário tem permissão para deletar
        if username and meditation.username != username:
            return False, "Você não tem permissão para deletar esta meditação"
        
        self.meditations.remove(meditation)
        self.save_meditations()
        return True, "Meditação removida com sucesso"
    
    # STATISTICS
    def get_user_stats(self, username):
        """Retorna estatísticas de um usuário"""
        user_meditations = self.get_meditations_by_user(username)
        
        if not user_meditations:
            return {
                'total_meditations': 0,
                'total_duration': 0,
                'categories': {},
                'average_duration': 0
            }
        
        total_duration = sum(med.duration for med in user_meditations)
        categories = {}
        
        for med in user_meditations:
            if med.category not in categories:
                categories[med.category] = 0
            categories[med.category] += 1
        
        return {
            'total_meditations': len(user_meditations),
            'total_duration': total_duration,
            'categories': categories,
            'average_duration': round(total_duration / len(user_meditations), 1)
        }
