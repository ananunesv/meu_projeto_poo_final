import json
import os
import uuid
from datetime import datetime, timedelta
from app.config.settings import SESSIONS_FILE, SESSION_TIMEOUT

class SessionService:
    """Gerenciador de sessões de usuário"""
    
    def __init__(self):
        self.active_sessions = {}  # {session_id: {'username': str, 'created_at': datetime, 'last_activity': datetime}}
        self.session_timeout = SESSION_TIMEOUT
        self.file_path = SESSIONS_FILE
        self.load_sessions()
    
    def load_sessions(self):
        """Carrega sessões do arquivo JSON"""
        try:
            if os.path.exists(self.file_path):
                with open(self.file_path, 'r', encoding='utf-8') as file:
                    data = json.load(file)
                    # Converter strings de data para datetime
                    for session_id, session_data in data.items():
                        session_data['created_at'] = datetime.fromisoformat(session_data['created_at'])
                        session_data['last_activity'] = datetime.fromisoformat(session_data['last_activity'])
                    self.active_sessions = data
        except (json.JSONDecodeError, FileNotFoundError) as e:
            print(f"Arquivo de sessões não encontrado ou inválido, começando com um novo: {e}")
            self.active_sessions = {}
        except Exception as e:
            print(f"Erro ao carregar sessões: {e}")
            self.active_sessions = {}
    
    def save_sessions(self):
        """Salva sessões no arquivo JSON"""
        try:
            os.makedirs(os.path.dirname(self.file_path), exist_ok=True)
            
            # Converter datetime para string para JSON
            data_to_save = {}
            for session_id, session_data in self.active_sessions.items():
                data_to_save[session_id] = {
                    'username': session_data['username'],
                    'created_at': session_data['created_at'].isoformat(),
                    'last_activity': session_data['last_activity'].isoformat()
                }
            
            with open(self.file_path, 'w', encoding='utf-8') as file:
                json.dump(data_to_save, file, indent=2, ensure_ascii=False)
        except Exception as e:
            print(f"Erro ao salvar sessões: {e}")
    
    def generate_session_id(self):
        """Gera um ID único para sessão"""
        return str(uuid.uuid4())
    
    def create_session(self, username):
        """Cria uma nova sessão para o usuário"""
        # Limpar sessões expiradas primeiro
        self.cleanup_expired_sessions()
        
        # Destruir qualquer sessão antiga que este usuário possa ter
        old_session_id = self.get_session_by_username(username)
        if old_session_id:
            self.destroy_session(old_session_id)

        # Criar nova sessão
        session_id = self.generate_session_id()
        now = datetime.now()
        
        self.active_sessions[session_id] = {
            'username': username,
            'created_at': now,
            'last_activity': now
        }
        
        self.save_sessions()
        return session_id
    
    def validate_session(self, session_id):
        """Valida se a sessão existe e não expirou"""
        if not session_id or session_id not in self.active_sessions:
            return False
        
        session = self.active_sessions[session_id]
        now = datetime.now()
        
        # Verificar se a sessão expirou
        if (now - session['last_activity']).total_seconds() > self.session_timeout:
            self.destroy_session(session_id)
            return False
        
        # Atualizar última atividade
        session['last_activity'] = now
        self.save_sessions()
        return True
    
    def get_user_by_session(self, session_id):
        """Retorna o usuário associado à sessão"""
        if self.validate_session(session_id):
            return self.active_sessions[session_id]['username']
        return None
    
    def get_session_by_username(self, username):
        """Busca sessão ativa por nome de usuário"""
        for session_id, session_data in self.active_sessions.items():
            if session_data['username'] == username:
                # Não validar a sessão aqui para garantir que a encontremos mesmo que esteja expirada
                return session_id
        return None
    
    def destroy_session(self, session_id):
        """Remove uma sessão"""
        if session_id in self.active_sessions:
            del self.active_sessions[session_id]
            self.save_sessions()
            return True
        return False
    
    def update_activity(self, session_id):
        """Atualiza o timestamp de última atividade"""
        if session_id in self.active_sessions:
            self.active_sessions[session_id]['last_activity'] = datetime.now()
            self.save_sessions()
    
    def cleanup_expired_sessions(self):
        """Remove sessões expiradas"""
        now = datetime.now()
        expired_sessions = []
        
        for session_id, session_data in self.active_sessions.items():
            if (now - session_data['last_activity']).total_seconds() > self.session_timeout:
                expired_sessions.append(session_id)
        
        for session_id in expired_sessions:
            del self.active_sessions[session_id]
        
        if expired_sessions:
            self.save_sessions()
    
    def get_active_sessions_count(self):
        """Retorna número de sessões ativas"""
        self.cleanup_expired_sessions()
        return len(self.active_sessions)
    
    def get_session_info(self, session_id):
        """Retorna informações da sessão"""
        if session_id in self.active_sessions:
            session = self.active_sessions[session_id]
            return {
                'session_id': session_id,
                'username': session['username'],
                'created_at': session['created_at'].isoformat(),
                'last_activity': session['last_activity'].isoformat(),
                'duration': str(datetime.now() - session['created_at'])
            }
        return None