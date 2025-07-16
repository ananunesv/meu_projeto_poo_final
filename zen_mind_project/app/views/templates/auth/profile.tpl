%rebase('base.tpl', title='Meu Perfil - Zen Mind', extra_css='')

<main class="main-content">
    <div class="container">
        <!-- Header do Perfil -->
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 3rem 2rem; border-radius: 20px; text-align: center; color: white; margin-bottom: 3rem; box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);">
            <div style="font-size: 4rem; margin-bottom: 1rem;">👤</div>
            <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem; font-weight: 700;">Meu Perfil</h1>
            <p style="font-size: 1.2rem; opacity: 0.9; margin: 0;">Gerencie suas informações pessoais</p>
        </div>

        <!-- Mensagens -->
        % if defined('success') and success:
            <div style="background: linear-gradient(135deg, #48bb78, #38a169); color: white; padding: 1.5rem; border-radius: 15px; margin-bottom: 2rem; text-align: center; box-shadow: 0 5px 15px rgba(72, 187, 120, 0.3);">
                <div style="font-size: 1.5rem; margin-bottom: 0.5rem;">✅</div>
                <strong>{{success}}</strong>
            </div>
        % end

        % if defined('error') and error:
            <div style="background: linear-gradient(135deg, #ff6b6b, #ee5a52); color: white; padding: 1.5rem; border-radius: 15px; margin-bottom: 2rem; text-align: center; box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);">
                <div style="font-size: 1.5rem; margin-bottom: 0.5rem;">⚠️</div>
                <strong>{{error}}</strong>
            </div>
        % end

        <!-- Informações do Perfil -->
        <div style="background: white; padding: 3rem; border-radius: 20px; box-shadow: 0 5px 25px rgba(0,0,0,0.1); margin-bottom: 3rem;">
            <div style="text-align: center; margin-bottom: 3rem;">
                <div style="width: 120px; height: 120px; background: linear-gradient(135deg, #667eea, #764ba2); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 3rem; color: white; font-weight: 600;">
                    {{current_user.username[0].upper()}}
                </div>
                <h2 style="color: #333; font-size: 2rem; margin-bottom: 0.5rem;">{{current_user.username}}</h2>
                <p style="color: #666; font-size: 1.1rem;">Membro desde {{current_user.created_at[:10] if hasattr(current_user, 'created_at') else 'Data não disponível'}}</p>
            </div>

            <!-- Detalhes do Perfil -->
            <div style="max-width: 600px; margin: 0 auto;">
                <div style="display: grid; gap: 2rem;">
                    <!-- Nome de Usuário -->
                    <div style="background: #f8f9fa; padding: 2rem; border-radius: 15px; border-left: 5px solid #667eea;">
                        <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 1rem;">
                            <span style="font-size: 1.5rem;">👤</span>
                            <h3 style="color: #333; margin: 0; font-size: 1.2rem;">Nome de Usuário</h3>
                        </div>
                        <p style="color: #666; font-size: 1.1rem; margin: 0; font-weight: 500;">{{current_user.username}}</p>
                    </div>

                    <!-- Email -->
                    <div style="background: #f8f9fa; padding: 2rem; border-radius: 15px; border-left: 5px solid #48bb78;">
                        <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 1rem;">
                            <span style="font-size: 1.5rem;">📧</span>
                            <h3 style="color: #333; margin: 0; font-size: 1.2rem;">Email</h3>
                        </div>
                        <p style="color: #666; font-size: 1.1rem; margin: 0; font-weight: 500;">{{current_user.email}}</p>
                    </div>

                    <!-- Senha -->
                    <div style="background: #f8f9fa; padding: 2rem; border-radius: 15px; border-left: 5px solid #ffc107;">
                        <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 1rem;">
                            <span style="font-size: 1.5rem;">🔒</span>
                            <h3 style="color: #333; margin: 0; font-size: 1.2rem;">Senha</h3>
                        </div>
                        <p style="color: #666; font-size: 1.1rem; margin: 0; font-weight: 500;">••••••••</p>
                    </div>
                </div>

                <!-- Ações -->
                <div style="text-align: center; margin-top: 3rem;">
                    <a href="/perfil/editar" style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 1.25rem 3rem; border-radius: 25px; text-decoration: none; font-weight: 600; font-size: 1.1rem; margin-right: 1rem; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3); display: inline-block;">
                        ✏️ Editar Perfil
                    </a>
                    <a href="/dashboard" style="background: #6c757d; color: white; padding: 1.25rem 3rem; border-radius: 25px; text-decoration: none; font-weight: 600; font-size: 1.1rem; transition: all 0.3s ease; display: inline-block;">
                        ↩️ Voltar ao Dashboard
                    </a>
                </div>
            </div>
        </div>

        <!-- Estatísticas do Usuário -->
        <%
        try:
            from app.services import meditation_service, forum_service
            user_stats = meditation_service.get_user_stats(current_user.username)
            user_posts = forum_service.get_posts_by_user(current_user.username)
        except:
            user_stats = {'total_meditations': 0, 'total_duration': 0, 'average_duration': 0}
            user_posts = []
        %>

        <div style="background: white; padding: 3rem; border-radius: 20px; box-shadow: 0 5px 25px rgba(0,0,0,0.1); margin-bottom: 3rem;">
            <div style="text-align: center; margin-bottom: 2rem;">
                <h3 style="color: #333; font-size: 1.8rem; margin-bottom: 0.5rem;">📊 Suas Estatísticas</h3>
                <p style="color: #666; font-size: 1.1rem;">Veja sua jornada no Zen Mind</p>
            </div>

            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 2rem;">
                <!-- Meditações -->
                <div style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);">
                    <div style="font-size: 2.5rem; margin-bottom: 1rem;">🧘</div>
                    <h4 style="font-size: 2rem; margin-bottom: 0.5rem; font-weight: 700;">{{user_stats.get('total_meditations', 0)}}</h4>
                    <p style="opacity: 0.9; margin: 0;">Meditações criadas</p>
                </div>

                <!-- Tempo Total -->
                <div style="background: linear-gradient(135deg, #48bb78, #38a169); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 5px 15px rgba(72, 187, 120, 0.3);">
                    <div style="font-size: 2.5rem; margin-bottom: 1rem;">⏱️</div>
                    <h4 style="font-size: 2rem; margin-bottom: 0.5rem; font-weight: 700;">{{user_stats.get('total_duration', 0)}}</h4>
                    <p style="opacity: 0.9; margin: 0;">Minutos planejados</p>
                </div>

                <!-- Posts no Fórum -->
                <div style="background: linear-gradient(135deg, #ed8936, #dd6b20); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 5px 15px rgba(237, 137, 54, 0.3);">
                    <div style="font-size: 2.5rem; margin-bottom: 1rem;">💬</div>
                    <h4 style="font-size: 2rem; margin-bottom: 0.5rem; font-weight: 700;">{{len(user_posts) if user_posts else 0}}</h4>
                    <p style="opacity: 0.9; margin: 0;">Posts no fórum</p>
                </div>

                <!-- Média de Duração -->
                <div style="background: linear-gradient(135deg, #f093fb, #f5576c); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 5px 15px rgba(240, 147, 251, 0.3);">
                    <div style="font-size: 2.5rem; margin-bottom: 1rem;">📈</div>
                    <h4 style="font-size: 2rem; margin-bottom: 0.5rem; font-weight: 700;">{{user_stats.get('average_duration', 0)}}</h4>
                    <p style="opacity: 0.9; margin: 0;">Média de minutos</p>
                </div>
            </div>
        </div>

        <!-- Zona de Perigo -->
        <div style="background: white; padding: 3rem; border-radius: 20px; box-shadow: 0 5px 25px rgba(0,0,0,0.1); border: 2px solid #ff6b6b;">
            <div style="text-align: center; margin-bottom: 2rem;">
                <div style="font-size: 3rem; margin-bottom: 1rem;">⚠️</div>
                <h3 style="color: #dc3545; font-size: 1.8rem; margin-bottom: 0.5rem;">Zona de Perigo</h3>
                <p style="color: #666; font-size: 1.1rem;">Esta ação não pode ser desfeita</p>
            </div>

            <div style="max-width: 400px; margin: 0 auto;">
                <button onclick="showDeleteModal()" style="background: linear-gradient(135deg, #ff6b6b, #ee5a52); color: white; padding: 1rem 2rem; border: none; border-radius: 25px; font-weight: 600; font-size: 1rem; cursor: pointer; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3); width: 100%;">
                    🗑️ Deletar Conta Permanentemente
                </button>
            </div>
        </div>
    </div>
</main>

<!-- Modal de Confirmação de Exclusão -->
<div id="deleteModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); z-index: 1000; justify-content: center; align-items: center;">
    <div style="background: white; padding: 3rem; border-radius: 20px; max-width: 500px; margin: 0 2rem; text-align: center;">
        <div style="font-size: 4rem; margin-bottom: 1rem;">⚠️</div>
        <h3 style="color: #dc3545; margin-bottom: 1rem; font-size: 1.5rem;">Confirmar Exclusão</h3>
        <p style="color: #666; margin-bottom: 2rem; line-height: 1.6;">
            Tem certeza que deseja deletar sua conta? Esta ação irá:
            <br><br>
            • Deletar todas suas meditações<br>
            • Remover todos seus posts do fórum<br>
            • Excluir permanentemente seu perfil<br>
            <br>
            <strong>Esta ação não pode ser desfeita!</strong>
        </p>
        
        <form method="post" action="/perfil/deletar" style="margin-bottom: 1rem;">
            <input type="password" name="password" placeholder="Digite sua senha para confirmar" 
                   style="width: 100%; padding: 1rem; border: 2px solid #dc3545; border-radius: 10px; margin-bottom: 1rem; font-size: 1rem;" required>
            
            <div style="display: flex; gap: 1rem; justify-content: center;">
                <button type="submit" style="background: #dc3545; color: white; padding: 1rem 2rem; border: none; border-radius: 10px; font-weight: 600; cursor: pointer;">
                    Sim, deletar conta
                </button>
                <button type="button" onclick="hideDeleteModal()" style="background: #6c757d; color: white; padding: 1rem 2rem; border: none; border-radius: 10px; font-weight: 600; cursor: pointer;">
                    Cancelar
                </button>
            </div>
        </form>
    </div>
</div>

<script>
function showDeleteModal() {
    document.getElementById('deleteModal').style.display = 'flex';
}

function hideDeleteModal() {
    document.getElementById('deleteModal').style.display = 'none';
}

// Fechar modal se clicar fora
document.getElementById('deleteModal').addEventListener('click', function(e) {
    if (e.target === this) {
        hideDeleteModal();
    }
});

// Efeitos hover
document.addEventListener('DOMContentLoaded', function() {
    const buttons = document.querySelectorAll('a[style*="background: linear-gradient"], button[style*="background: linear-gradient"]');
    
    buttons.forEach(button => {
        button.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-3px)';
            this.style.boxShadow = '0 10px 25px rgba(0,0,0,0.2)';
        });
        
        button.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
            this.style.boxShadow = this.style.boxShadow.replace('0 10px 25px', '0 5px 15px');
        });
    });
});
</script>

<style>
@media (max-width: 768px) {
    .container > div[style*="grid-template-columns"] {
        grid-template-columns: 1fr !important;
    }
    
    .container h1[style*="font-size: 2.5rem"] {
        font-size: 2rem !important;
    }
    
    .container div[style*="display: flex"] {
        flex-direction: column !important;
        gap: 1rem !important;
    }
    
    .container a[style*="margin-right: 1rem"] {
        margin-right: 0 !important;
    }
}
</style>