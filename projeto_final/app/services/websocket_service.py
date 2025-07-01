import asyncio
import websockets  # ← CORRIGIR: era "websocket_service"
import json
from datetime import datetime 

class WebSocketService:
    """Gerenciador de conexões WebSocket para tempo real"""
    
    def __init__(self):
        self.connected_clients = set()
        self.client_sessions = {}   # {websocket: {'username': str, 'connected_at': datetime}}
    
    async def register_client(self, websocket, username=None):
        """Registra um novo cliente WebSocket"""
        self.connected_clients.add(websocket)
        self.client_sessions[websocket] = {
            'username': username or 'Anonymous',
            'connected_at': datetime.now()
        }
        
        print(f"✅ Cliente conectado: {username or 'Anonymous'} ({len(self.connected_clients)} online)")
        
        # Notificar outros clientes sobre nova conexão
        await self.broadcast_user_joined(username or 'Anonymous')
    
    async def unregister_client(self, websocket):
        """Remove um cliente WebSocket"""
        if websocket in self.connected_clients:
            self.connected_clients.remove(websocket)
            
            # Recuperar informações antes de remover
            client_info = self.client_sessions.get(websocket, {})
            username = client_info.get('username', 'Anonymous')
            
            if websocket in self.client_sessions:
                del self.client_sessions[websocket]
            
            print(f"❌ Cliente desconectado: {username} ({len(self.connected_clients)} online)")
            
            # Notificar outros clientes sobre desconexão
            await self.broadcast_user_left(username)
    
    async def broadcast_message(self, message_data):
        """Envia mensagem para todos os clientes conectados"""
        if not self.connected_clients:
            return
        
        message = json.dumps(message_data, ensure_ascii=False)
        disconnected_clients = []
        
        for client in self.connected_clients.copy():
            try:
                await client.send(message)
            except websockets.exceptions.ConnectionClosed:
                disconnected_clients.append(client)
            except Exception as e:
                print(f"Erro ao enviar mensagem para cliente: {e}")
                disconnected_clients.append(client)
        
        # Remover clientes desconectados
        for client in disconnected_clients:
            await self.unregister_client(client)
    
    async def send_to_user(self, username, message_data):
        """Envia mensagem para um usuário específico"""
        message = json.dumps(message_data, ensure_ascii=False)
        
        for client, session_info in self.client_sessions.items():
            if session_info['username'] == username:
                try:
                    await client.send(message)
                    return True
                except Exception as e:
                    print(f"Erro ao enviar mensagem para {username}: {e}")
                    await self.unregister_client(client)
        
        return False
    
    async def broadcast_forum_post(self, post_data):
        """Notifica sobre novo post no fórum"""
        message = {
            'type': 'new_forum_post',
            'data': post_data,
            'timestamp': datetime.now().isoformat()
        }
        await self.broadcast_message(message)
    
    async def broadcast_user_joined(self, username):
        """Notifica sobre usuário que se conectou"""
        message = {
            'type': 'user_joined',
            'username': username,
            'online_count': len(self.connected_clients),
            'timestamp': datetime.now().isoformat()
        }
        await self.broadcast_message(message)
    
    async def broadcast_user_left(self, username):
        """Notifica sobre usuário que se desconectou"""
        message = {
            'type': 'user_left',
            'username': username,
            'online_count': len(self.connected_clients),
            'timestamp': datetime.now().isoformat()
        }
        await self.broadcast_message(message)
    
    async def notify_meditation_created(self, meditation_data):
        """Notifica sobre nova meditação criada"""
        message = {
            'type': 'meditation_created',
            'data': meditation_data,
            'timestamp': datetime.now().isoformat()
        }
        await self.broadcast_message(message)
    
    async def handle_client_message(self, websocket, message):
        """Processa mensagens recebidas dos clientes"""
        try:
            data = json.loads(message)
            message_type = data.get('type')
            
            if message_type == 'ping':
                # Responder pong para manter conexão viva
                await websocket.send(json.dumps({'type': 'pong'}))
            
            elif message_type == 'chat_message':
                # Rebroadcast mensagem de chat (se implementarmos chat)
                username = self.client_sessions.get(websocket, {}).get('username', 'Anonymous')
                chat_data = {
                    'type': 'chat_message',
                    'username': username,
                    'content': data.get('content', ''),
                    'timestamp': datetime.now().isoformat()
                }
                await self.broadcast_message(chat_data)
            
        except json.JSONDecodeError:
            print("Mensagem WebSocket inválida recebida")
        except Exception as e:
            print(f"Erro ao processar mensagem WebSocket: {e}")
    
    def get_online_users(self):
        """Retorna lista de usuários online"""
        users = []
        for session_info in self.client_sessions.values():
            username = session_info['username']
            if username != 'Anonymous' and username not in users:
                users.append(username)
        return users
    
    def get_connection_stats(self):
        """Retorna estatísticas de conexão"""
        return {
            'total_connections': len(self.connected_clients),
            'online_users': self.get_online_users(),
            'anonymous_connections': len([s for s in self.client_sessions.values() if s['username'] == 'Anonymous'])
        }
