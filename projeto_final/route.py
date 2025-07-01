# route.py - Arquivo principal do Zen Mind
from app.controllers.application import Application
from app.controllers.auth_controller import AuthController
from app.controllers.meditation_controller import MeditationController
from app.controllers.forum_controller import ForumController
from bottle import Bottle, run, static_file
from app.config.settings import HOST, PORT, DEBUG, STATIC_DIR

# Inicializar aplicação Bottle
app = Bottle()

# Inicializar controllers
main_app = Application()
auth_ctrl = AuthController()
meditation_ctrl = MeditationController()
forum_ctrl = ForumController()

# ===== ROTAS ESTÁTICAS =====
@app.route('/static/<filepath:path>')
def serve_static(filepath):
    return static_file(filepath, root=STATIC_DIR)

# ===== ROTA PRINCIPAL =====
@app.route('/')
@app.route('/home')
def home():
    return main_app.render('home')

@app.route('/helper')
def helper():
    return main_app.render('helper')

# ===== ROTAS DE AUTENTICAÇÃO =====
@app.route('/login', method='GET')
def login_page():
    return auth_ctrl.login_page()

@app.route('/login', method='POST')
def process_login():
    return auth_ctrl.process_login()

@app.route('/register', method='GET') 
def register_page():
    return auth_ctrl.register_page()

@app.route('/register', method='POST')
def process_register():
    return auth_ctrl.process_register()

@app.route('/logout', method='POST')
def logout():
    return auth_ctrl.logout()

# ===== ROTAS DE MEDITAÇÃO =====
@app.route('/dashboard')
def dashboard():
    return meditation_ctrl.dashboard()

@app.route('/meditacoes')
def list_meditations():
    return meditation_ctrl.list_meditations()

@app.route('/meditacoes/nova', method='GET')
def new_meditation_form():
    return meditation_ctrl.new_meditation()

@app.route('/meditacoes/nova', method='POST')
def create_meditation():
    return meditation_ctrl.create_meditation()

@app.route('/meditacoes/<meditation_id>')
def view_meditation(meditation_id):
    return meditation_ctrl.view_meditation(meditation_id)

@app.route('/meditacoes/<meditation_id>/editar', method='GET')
def edit_meditation_form(meditation_id):
    return meditation_ctrl.edit_meditation(meditation_id)

@app.route('/meditacoes/<meditation_id>/editar', method='POST')
def update_meditation(meditation_id):
    return meditation_ctrl.update_meditation(meditation_id)

@app.route('/meditacoes/<meditation_id>/deletar', method='POST')
def delete_meditation(meditation_id):
    return meditation_ctrl.delete_meditation(meditation_id)

# ===== ROTAS DO FÓRUM =====
@app.route('/forum')
def forum_page():
    return forum_ctrl.forum_page()

@app.route('/forum/post', method='POST')
def create_post():
    return forum_ctrl.create_post()

@app.route('/forum/post/<post_id>/deletar', method='POST')
def delete_post(post_id):
    return forum_ctrl.delete_post(post_id)

# ===== OUTRAS ROTAS =====
@app.route('/download')
def download_page():
    return main_app.render('download')

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
    run(app, host=HOST, port=PORT, debug=DEBUG, reloader=DEBUG)