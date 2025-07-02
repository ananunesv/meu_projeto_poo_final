%rebase('base.tpl', title='Dashboard - Zen Mind', extra_css='')

<main class="main-content">
    <div class="container">
        <!-- Header do Dashboard com gradiente -->
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 3rem 2rem; border-radius: 20px; text-align: center; color: white; margin-bottom: 3rem; box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);">
            <div style="font-size: 4rem; margin-bottom: 1rem;">🧘</div>
            <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem; font-weight: 700;">Dashboard</h1>
            <p style="font-size: 1.2rem; opacity: 0.9; margin: 0;">Bem-vindo, {{current_user.username}}!</p>
            <p style="font-size: 1rem; opacity: 0.8; margin-top: 0.5rem;">Continue sua jornada de autoconhecimento</p>
        </div>

        <!-- Ações Rápidas -->
        <div style="background: white; padding: 3rem; border-radius: 20px; box-shadow: 0 5px 25px rgba(0,0,0,0.1); margin-bottom: 3rem;">
            <div style="text-align: center; margin-bottom: 2rem;">
                <h2 style="color: #333; font-size: 2rem; margin-bottom: 0.5rem;">⚡ Ações Rápidas</h2>
                <p style="color: #666; font-size: 1.1rem;">O que você gostaria de fazer hoje?</p>
            </div>
            
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 2rem;">
                <a href="/meditacoes/nova" style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 2rem; border-radius: 15px; text-decoration: none; text-align: center; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3); display: block;">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">➕</div>
                    <h3 style="margin-bottom: 0.5rem; font-size: 1.3rem; font-weight: 600;">Nova Meditação</h3>
                    <p style="opacity: 0.9; margin: 0; font-size: 0.95rem;">Crie uma nova sessão personalizada</p>
                </a>
                
                <a href="/meditacoes" style="background: linear-gradient(135deg, #48bb78, #38a169); color: white; padding: 2rem; border-radius: 15px; text-decoration: none; text-align: center; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(72, 187, 120, 0.3); display: block;">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">📋</div>
                    <h3 style="margin-bottom: 0.5rem; font-size: 1.3rem; font-weight: 600;">Minhas Meditações</h3>
                    <p style="opacity: 0.9; margin: 0; font-size: 0.95rem;">Veja e gerencie suas meditações</p>
                </a>
                
                <a href="/forum" style="background: linear-gradient(135deg, #ed8936, #dd6b20); color: white; padding: 2rem; border-radius: 15px; text-decoration: none; text-align: center; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(237, 137, 54, 0.3); display: block;">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">💬</div>
                    <h3 style="margin-bottom: 0.5rem; font-size: 1.3rem; font-weight: 600;">Fórum</h3>
                    <p style="opacity: 0.9; margin: 0; font-size: 0.95rem;">Conecte-se com a comunidade</p>
                </a>
            </div>
        </div>

        <!-- Motivação -->
        <div style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); padding: 3rem; border-radius: 20px; text-align: center; color: white; box-shadow: 0 5px 25px rgba(240, 147, 251, 0.3);">
            <div style="font-size: 4rem; margin-bottom: 1rem;">🌱</div>
            <h3 style="font-size: 1.8rem; margin-bottom: 1rem; font-weight: 600;">Continue crescendo!</h3>
            <p style="font-size: 1.1rem; opacity: 0.9; margin-bottom: 2rem;">Cada momento de meditação é um passo em direção ao seu bem-estar</p>
            <div style="display: flex; justify-content: center; gap: 1rem; flex-wrap: wrap;">
                <a href="/meditacoes/nova" style="background: white; color: #f5576c; padding: 1rem 2rem; border-radius: 25px; text-decoration: none; font-weight: 600; font-size: 1rem;">Começar agora</a>
                <a href="/download" style="background: rgba(255,255,255,0.2); color: white; padding: 1rem 2rem; border-radius: 25px; text-decoration: none; font-weight: 600; font-size: 1rem; border: 2px solid white;">Ver App Mobile</a>
            </div>
        </div>
    </div>
</main>

<style>
a[style*="background: linear-gradient"]:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.2) !important;
}

@media (max-width: 768px) {
    .container > div[style*="grid-template-columns"] {
        grid-template-columns: 1fr !important;
    }
    
    .container h1[style*="font-size: 2.5rem"] {
        font-size: 2rem !important;
    }
    
    .container h2[style*="font-size: 2rem"] {
        font-size: 1.5rem !important;
    }
}
</style> 