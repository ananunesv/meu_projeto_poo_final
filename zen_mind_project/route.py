# route.py - Arquivo principal do Zen Mind
from app.controllers.application import Application
from app.controllers.auth_controller import AuthController
from app.controllers.meditation_controller import MeditationController
from app.controllers.forum_controller import ForumController
from bottle import Bottle, run, static_file, TEMPLATE_PATH, request, response, HTTPError
from app.config.settings import HOST, PORT, DEBUG, STATIC_DIR, TEMPLATES_DIR
from app.utils.decorators import get_current_user
import json

# Configurar o caminho dos templates para o Bottle
TEMPLATE_PATH.clear()
TEMPLATE_PATH.append(TEMPLATES_DIR)
TEMPLATE_PATH.append('.')  # Diretório atual como fallback

# Inicializar aplicação Bottle
app = Bottle()

# Inicializar controllers
main_app = Application()
auth_ctrl = AuthController()
meditation_ctrl = MeditationController()
forum_ctrl = ForumController()

# ===== MIDDLEWARE PARA TRATAMENTO DE ERROS =====
@app.error(404)
def error404(error):
    """Página 404 personalizada"""
    current_user = get_current_user()
    return f"""
    <html>
    <head>
        <title>Página não encontrada - Zen Mind</title>
        <style>
            body {{ font-family: Arial, sans-serif; text-align: center; margin-top: 100px; }}
            .error-container {{ max-width: 500px; margin: 0 auto; }}
            .emoji {{ font-size: 4em; margin-bottom: 20px; }}
            h1 {{ color: #667eea; }}
            .back-link {{ margin-top: 30px; }}
            .back-link a {{ color: #667eea; text-decoration: none; padding: 10px 20px; border: 2px solid #667eea; border-radius: 5px; }}
        </style>
    </head>
    <body>
        <div class="error-container">
            <div class="emoji">🧘‍♀️</div>
            <h1>Página não encontrada</h1>
            <p>A página que você está procurando não existe.</p>
            <div class="back-link">
                <a href="/">Voltar ao início</a>
                {'<a href="/dashboard" style="margin-left: 10px;">Dashboard</a>' if current_user else ''}
            </div>
        </div>
    </body>
    </html>
    """

@app.error(500)
def error500(error):
    """Página de erro 500 personalizada"""
    return f"""
    <html>
    <head>
        <title>Erro interno - Zen Mind</title>
        <style>
            body {{ font-family: Arial, sans-serif; text-align: center; margin-top: 100px; }}
            .error-container {{ max-width: 500px; margin: 0 auto; }}
            .emoji {{ font-size: 4em; margin-bottom: 20px; }}
            h1 {{ color: #e74c3c; }}
            .back-link {{ margin-top: 30px; }}
            .back-link a {{ color: #667eea; text-decoration: none; padding: 10px 20px; border: 2px solid #667eea; border-radius: 5px; }}
        </style>
    </head>
    <body>
        <div class="error-container">
            <div class="emoji">⚠️</div>
            <h1>Erro interno do servidor</h1>
            <p>Algo deu errado. Tente novamente mais tarde.</p>
            <div class="back-link">
                <a href="/">Voltar ao início</a>
            </div>
        </div>
    </body>
    </html>
    """

# ===== ROTAS ESTÁTICAS =====
@app.route('/static/<filepath:path>')
def serve_static(filepath):
    """Servir arquivos estáticos"""
    return static_file(filepath, root=STATIC_DIR)

# ===== ROTA PRINCIPAL =====
@app.route('/')
@app.route('/home')
def home():
    """Página inicial"""
    return main_app.render('home')

@app.route('/helper')
def helper():
    """Página de documentação"""
    return main_app.render('helper')

# ===== ROTAS DE AUTENTICAÇÃO =====
@app.route('/login', method='GET')
def login_page():
    """Página de login"""
    return auth_ctrl.login_page()

@app.route('/login', method='POST')
def process_login():
    """Processar login"""
    return auth_ctrl.process_login()

@app.route('/register', method='GET') 
def register_page():
    """Página de registro"""
    return auth_ctrl.register_page()

@app.route('/register', method='POST')
def process_register():
    """Processar registro"""
    return auth_ctrl.process_register()

@app.route('/logout', method='POST')
def logout():
    """Processar logout"""
    return auth_ctrl.logout()

# ===== ROTAS DE PERFIL =====
@app.route('/perfil')
def profile_page():
    """Página do perfil do usuário"""
    return auth_ctrl.profile_page()

@app.route('/perfil/editar', method='GET')
def edit_profile_page():
    """Página de edição do perfil"""
    return auth_ctrl.edit_profile_page()

@app.route('/perfil/editar', method='POST')
def update_profile():
    """Processar atualização do perfil"""
    return auth_ctrl.update_profile()

@app.route('/perfil/deletar', method='POST')
def delete_account():
    """Deletar conta do usuário"""
    return auth_ctrl.delete_account()

# ===== ROTAS DE MEDITAÇÃO =====
@app.route('/dashboard')
def dashboard():
    """Dashboard principal"""
    return meditation_ctrl.dashboard()

@app.route('/meditacoes')
def list_meditations():
    """Lista de meditações"""
    return meditation_ctrl.list_meditations()

@app.route('/meditacoes/nova', method='GET')
def new_meditation_form():
    """Formulário nova meditação"""
    return meditation_ctrl.new_meditation()

@app.route('/meditacoes/nova', method='POST')
def create_meditation():
    """Criar meditação"""
    return meditation_ctrl.create_meditation()

@app.route('/meditacoes/<meditation_id>')
def view_meditation(meditation_id):
    """Ver detalhes da meditação"""
    return meditation_ctrl.view_meditation(meditation_id)

@app.route('/meditacoes/<meditation_id>/editar', method='GET')
def edit_meditation_form(meditation_id):
    """Formulário editar meditação"""
    return meditation_ctrl.edit_meditation(meditation_id)

@app.route('/meditacoes/<meditation_id>/editar', method='POST')
def update_meditation(meditation_id):
    """Atualizar meditação"""
    return meditation_ctrl.update_meditation(meditation_id)

@app.route('/meditacoes/<meditation_id>/deletar', method='POST')
def delete_meditation(meditation_id):
    """Deletar meditação"""
    return meditation_ctrl.delete_meditation(meditation_id)

# ===== ROTAS DO FÓRUM =====
@app.route('/forum')
def forum_page():
    """Página principal do fórum"""
    return forum_ctrl.forum_page()

@app.route('/forum/post', method='POST')
def create_post():
    """Criar post no fórum"""
    return forum_ctrl.create_post()

@app.route('/forum/post/<post_id>/deletar', method='POST')
def delete_post(post_id):
    """Deletar post do fórum"""
    return forum_ctrl.delete_post(post_id)

# ===== OUTRAS ROTAS =====
@app.route('/download')
def download_page():
    """Página de download"""
    return main_app.render('download')

@app.route('/debug/session')
def debug_session():
    """Debug da sessão atual"""
    session_id = request.get_cookie('session_id')
    from app.services.session_service import SessionService
    from app.services.user_service import UserService
    
    session_service = SessionService()
    user_service = UserService()
    
    debug_info = {
        'session_id': session_id,
        'session_exists': session_id in session_service.active_sessions if session_id else False,
        'session_valid': session_service.validate_session(session_id) if session_id else False,
        'current_user': None
    }
    
    if session_id:
        username = session_service.get_user_by_session(session_id)
        debug_info['username'] = username
        if username:
            user = user_service.get_user_by_username(username)
            debug_info['user_found'] = user is not None
            if user:
                debug_info['current_user'] = user.username
    
    response.content_type = 'application/json'
    return json.dumps(debug_info, indent=2)

# ===== SERVIDOR =====
if __name__ == '__main__':
    print("🧘 Zen Mind iniciando...")
    print(f"📍 Servidor: http://{HOST}:{PORT}")
    print(f"📚 Helper: http://{HOST}:{PORT}/helper")
    print(f"🔑 Login: http://{HOST}:{PORT}/login")
    print("✨ Funcionalidades disponíveis:")
    print("   - Sistema de login/registro")
    print("   - CRUD de meditações")
    print("   - Fórum da comunidade")
    print("   - Dashboard personalizado")
    print("   - Perfil do usuário (CRUD completo)")
    print(f"👤 Perfil: http://{HOST}:{PORT}/perfil")
    print(f"🔍 Debug sessão: http://{HOST}:{PORT}/debug/session")
    
    try:
        run(app, host=HOST, port=PORT, debug=DEBUG, reloader=DEBUG)
    except KeyboardInterrupt:
        print("\n🛑 Servidor interrompido pelo usuário")
    except Exception as e:
        print(f"❌ Erro ao iniciar servidor: {e}")