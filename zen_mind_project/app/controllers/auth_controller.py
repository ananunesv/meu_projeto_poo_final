from bottle import template, request, response, redirect
from app.services import user_service, session_service
from app.config.constants import MESSAGES
from app.utils.decorators import get_current_user, login_required

class AuthController:
    """Controller de autenticação - Login, registro, logout e perfil"""
    
    def __init__(self):
        self.user_service = user_service
        self.session_service = session_service
    
    def login_page(self):
        """Exibe página de login"""
        # Se já estiver logado, redirecionar para dashboard
        current_user = get_current_user()
        if current_user:
            redirect('/dashboard')
            
        return template('auth/login.tpl')
    
    def process_login(self):
        """Processa formulário de login"""
        username = request.forms.get('username', '').strip()
        password = request.forms.get('password', '').strip()
        
        print(f"[DEBUG] Login attempt - Username: {username}")
        
        # Validações básicas
        if not username or not password:
            return template('auth/login.tpl', 
                          error="Username e senha são obrigatórios",
                          form_data={'username': username})
        
        # Tentar autenticar
        user = self.user_service.authenticate_user(username, password)
        print(f"[DEBUG] User authenticated: {user is not None}")
        
        if user:
            # Criar sessão
            session_id = self.session_service.create_session(username)
            print(f"[DEBUG] Session created: {session_id}")
            
            # Configurar cookie com configurações mais amplas
            response.set_cookie('session_id', session_id, 
                              httponly=False,  # Permitir acesso via JavaScript para debug
                              secure=False,    # HTTP permitido
                              max_age=3600,    # 1 hora
                              path='/')        # Disponível em todo o site
            
            print(f"[DEBUG] Cookie set for session: {session_id}")
            
            # Redirecionar para dashboard
            redirect('/dashboard')
        else:
            print(f"[DEBUG] Authentication failed for user: {username}")
            return template('auth/login.tpl', 
                          error="Credenciais inválidas",
                          form_data={'username': username})
    
    def register_page(self):
        """Exibe página de registro"""
        # Se já estiver logado, redirecionar para dashboard
        current_user = get_current_user()
        if current_user:
            redirect('/dashboard')
            
        return template('auth/register.tpl')
    
    def process_register(self):
        """Processa formulário de registro"""
        username = request.forms.get('username', '').strip()
        email = request.forms.get('email', '').strip()
        password = request.forms.get('password', '').strip()
        confirm_password = request.forms.get('confirm_password', '').strip()
        
        # Validações
        errors = []
        
        if not username or not email or not password:
            errors.append("Todos os campos são obrigatórios")
        
        if password != confirm_password:
            errors.append("Senhas não coincidem")
        
        if len(password) < 6:
            errors.append("Senha deve ter pelo menos 6 caracteres")
        
        if '@' not in email or '.' not in email:
            errors.append("Email inválido")
        
        # Se há erros, retornar para formulário
        if errors:
            return template('auth/register.tpl', 
                          errors=errors,
                          form_data={
                              'username': username,
                              'email': email
                          })
        
        # Tentar criar usuário
        user, message = self.user_service.create_user(username, email, password)
        
        if user:
            # Usuário criado com sucesso - fazer login automático
            session_id = self.session_service.create_session(username)
            
            response.set_cookie('session_id', session_id, 
                              httponly=False, 
                              secure=False,
                              max_age=3600,
                              path='/')
            
            redirect('/dashboard')
        else:
            # Erro na criação
            return template('auth/register.tpl', 
                          error=message,
                          form_data={
                              'username': username,
                              'email': email
                          })
    
    def logout(self):
        """Processa logout"""
        session_id = request.get_cookie('session_id')
        if session_id:
            self.session_service.destroy_session(session_id)
        
        response.delete_cookie('session_id', path='/')
        redirect('/')
    
    # ===== MÉTODOS DE PERFIL =====
    
    @login_required
    def profile_page(self):
        """Exibe página de perfil do usuário"""
        current_user = get_current_user()
        return template('auth/profile.tpl', current_user=current_user)
    
    @login_required
    def edit_profile_page(self):
        """Exibe formulário de edição do perfil"""
        current_user = get_current_user()
        return template('auth/edit_profile.tpl', current_user=current_user)
    
    @login_required
    def update_profile(self):
        """Processa atualização do perfil"""
        current_user = get_current_user()
        
        # Capturar dados do formulário
        new_username = request.forms.get('username', '').strip()
        new_email = request.forms.get('email', '').strip()
        current_password = request.forms.get('current_password', '').strip()
        new_password = request.forms.get('new_password', '').strip()
        confirm_password = request.forms.get('confirm_password', '').strip()
        
        # Validações
        errors = []
        
        # Validar campos obrigatórios
        if not new_username or not new_email:
            errors.append("Nome de usuário e email são obrigatórios")
        
        # Validar formato do email
        if '@' not in new_email or '.' not in new_email:
            errors.append("Email inválido")
        
        # Validar tamanho do username
        if len(new_username) < 3 or len(new_username) > 20:
            errors.append("Nome de usuário deve ter entre 3 e 20 caracteres")
        
        # Se está mudando username, verificar se não existe
        if new_username != current_user.username:
            if self.user_service.username_exists(new_username):
                errors.append("Nome de usuário já existe")
        
        # Se está mudando email, verificar se não existe
        if new_email != current_user.email:
            if self.user_service.email_exists(new_email):
                errors.append("Email já está sendo usado por outro usuário")
        
        # Se quer alterar senha
        if new_password:
            # Verificar senha atual
            if not current_password:
                errors.append("Digite sua senha atual para alterá-la")
            elif not current_user.validate_password(current_password):
                errors.append("Senha atual incorreta")
            
            # Validar nova senha
            if len(new_password) < 6:
                errors.append("Nova senha deve ter pelo menos 6 caracteres")
            
            # Confirmar nova senha
            if new_password != confirm_password:
                errors.append("Confirmação da nova senha não confere")
        
        # Se há erros, retornar ao formulário
        if errors:
            return template('auth/edit_profile.tpl',
                          current_user=current_user,
                          errors=errors,
                          form_data={
                              'username': new_username,
                              'email': new_email
                          })
        
        # Atualizar dados do usuário
        try:
            # Se mudou username, precisamos lidar com as sessões
            if new_username != current_user.username:
                # Primeiro, atualizar os dados do usuário
                current_user.username = new_username
                current_user.email = new_email
                if new_password:
                    current_user.password = new_password
                
                # Salvar as alterações
                self.user_service.save_users()
                
                # Destruir sessão atual e criar nova com novo username
                session_id = request.get_cookie('session_id')
                if session_id:
                    self.session_service.destroy_session(session_id)
                
                # Criar nova sessão com novo username
                new_session_id = self.session_service.create_session(new_username)
                response.set_cookie('session_id', new_session_id,
                                  httponly=False,
                                  secure=False,
                                  max_age=3600,
                                  path='/')
            else:
                # Só atualizar email e/ou senha
                current_user.email = new_email
                if new_password:
                    current_user.password = new_password
                
                # Salvar as alterações
                self.user_service.save_users()
            
            # Redirecionar para perfil com mensagem de sucesso
            return template('auth/profile.tpl',
                          current_user=current_user,
                          success="Perfil atualizado com sucesso!")
            
        except Exception as e:
            print(f"Erro ao atualizar perfil: {e}")
            return template('auth/edit_profile.tpl',
                          current_user=current_user,
                          error="Erro interno. Tente novamente.",
                          form_data={
                              'username': new_username,
                              'email': new_email
                          })
    
    @login_required
    def delete_account(self):
        """Deleta a conta do usuário"""
        current_user = get_current_user()
        password = request.forms.get('password', '').strip()
        
        # Verificar senha antes de deletar
        if not password:
            return template('auth/profile.tpl',
                          current_user=current_user,
                          error="Digite sua senha para confirmar a exclusão")
        
        if not current_user.validate_password(password):
            return template('auth/profile.tpl',
                          current_user=current_user,
                          error="Senha incorreta")
        
        try:
            # Deletar todas as meditações do usuário
            from app.services import meditation_service
            user_meditations = meditation_service.get_meditations_by_user(current_user.username)
            for meditation in user_meditations:
                meditation_service.delete_meditation(meditation.id, current_user.username)
            
            # Deletar todos os posts do usuário no fórum
            from app.services import forum_service
            user_posts = forum_service.get_posts_by_user(current_user.username)
            for post in user_posts:
                forum_service.delete_post(post.id, current_user.username)
            
            # Destruir sessão
            session_id = request.get_cookie('session_id')
            if session_id:
                self.session_service.destroy_session(session_id)
            
            # Deletar usuário
            success, message = self.user_service.delete_user(current_user.username)
            
            # Remover cookie
            response.delete_cookie('session_id', path='/')
            
            # Redirecionar para home
            redirect('/?deleted=true')
            
        except Exception as e:
            print(f"Erro ao deletar conta: {e}")
            return template('auth/profile.tpl',
                          current_user=current_user,
                          error="Erro interno. Tente novamente.")
    
    def _is_authenticated(self):
        """Verifica se usuário está autenticado"""
        session_id = request.get_cookie('session_id')
        if session_id:
            return self.session_service.validate_session(session_id)
        return False
    
    def _get_current_user(self):
        """Retorna usuário atual"""
        return get_current_user()