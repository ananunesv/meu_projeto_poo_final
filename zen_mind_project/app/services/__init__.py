# app/services/__init__.py
from .user_service import UserService
from .session_service import SessionService
from .meditation_service import MeditationService
from .forum_service import ForumService
from .websocket_service import WebSocketService

# Instâncias únicas dos serviços para serem usadas em toda a aplicação
user_service = UserService()
session_service = SessionService()
meditation_service = MeditationService()
forum_service = ForumService()
websocket_service = WebSocketService()

__all__ = [
    'UserService', 'MeditationService', 'ForumService', 'SessionService', 'WebSocketService',
    'user_service', 'session_service', 'meditation_service', 'forum_service', 'websocket_service'
]