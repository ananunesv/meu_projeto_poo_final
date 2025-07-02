%rebase('base.tpl', title='Download App - Zen Mind', extra_css='')

<main class="main-content">
    <div class="container">
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 4rem 2rem; border-radius: 15px; text-align: center; color: white; margin-bottom: 3rem;">
            <h1>📱 Zen Mind App</h1>
            <p>Leve a meditação para onde você for</p>
        </div>

        <div style="text-align: center; margin-bottom: 3rem;">
            <h2>Disponível em breve</h2>
            <p>O aplicativo móvel do Zen Mind está em desenvolvimento. Em breve você poderá meditar onde estiver!</p>
            
            <div style="margin: 2rem 0;">
                <a href="#" onclick="alert('Em breve na App Store!')" style="display: inline-block; background: #667eea; color: white; padding: 1rem 2rem; border-radius: 8px; text-decoration: none; margin: 0.5rem;">
                    🍎 App Store
                </a>
                
                <a href="#" onclick="alert('Em breve no Google Play!')" style="display: inline-block; background: #667eea; color: white; padding: 1rem 2rem; border-radius: 8px; text-decoration: none; margin: 0.5rem;">
                    🤖 Google Play
                </a>
        </div>
    </div>

        <div style="background: white; padding: 3rem 2rem; border-radius: 15px; text-align: center;">
            <h2>Enquanto isso...</h2>
            <p>Continue praticando na versão web do Zen Mind</p>
            
                    % if defined('current_user') and current_user:
                <a href="/dashboard" style="display: inline-block; background: #667eea; color: white; padding: 1rem 2rem; border-radius: 8px; text-decoration: none; margin: 0.5rem;">Meu Dashboard</a>
                <a href="/meditacoes" style="display: inline-block; background: #764ba2; color: white; padding: 1rem 2rem; border-radius: 8px; text-decoration: none; margin: 0.5rem;">Minhas Meditações</a>
                    % else:
                <a href="/register" style="display: inline-block; background: #667eea; color: white; padding: 1rem 2rem; border-radius: 8px; text-decoration: none; margin: 0.5rem;">Começar Agora</a>
                <a href="/login" style="display: inline-block; background: #764ba2; color: white; padding: 1rem 2rem; border-radius: 8px; text-decoration: none; margin: 0.5rem;">Fazer Login</a>
                    % end
        </div>
    </div>
</main> 