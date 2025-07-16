%rebase('base.tpl', title=meditation.title if meditation else 'Meditação', extra_css='')

<main class="main-content">
    <div class="container">
        % if meditation:
            <!-- Header da meditação -->
            <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 3rem 2rem; border-radius: 20px; text-align: center; color: white; margin-bottom: 3rem; box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);">
                <div style="font-size: 4rem; margin-bottom: 1rem;">🧘</div>
                <h1 style="font-size: 2.5rem; margin-bottom: 1rem; font-weight: 700; word-wrap: break-word;">{{meditation.title}}</h1>
                <div style="display: flex; justify-content: center; align-items: center; gap: 2rem; flex-wrap: wrap;">
                    <div style="background: rgba(255, 255, 255, 0.2); padding: 0.75rem 1.5rem; border-radius: 25px; font-weight: 600;">
                        ⏱️ {{meditation.duration}} minutos
                    </div>
                    <div style="background: rgba(255, 255, 255, 0.2); padding: 0.75rem 1.5rem; border-radius: 25px; font-weight: 600;">
                        🏷️ {{meditation.category.title()}}
                    </div>
                    % try:
                        % if hasattr(meditation, 'created_at') and meditation.created_at:
                            <div style="background: rgba(255, 255, 255, 0.2); padding: 0.75rem 1.5rem; border-radius: 25px; font-weight: 600;">
                                📅 {{meditation.created_at[:10]}}
                            </div>
                        % end
                    % except:
                        <!-- Data não disponível -->
                    % end
                </div>
            </div>
            
            <!-- Conteúdo da meditação -->
            <div style="background: white; padding: 3rem; border-radius: 20px; box-shadow: 0 5px 25px rgba(0,0,0,0.1); margin-bottom: 3rem;">
                <div style="text-align: center; margin-bottom: 3rem;">
                    <h2 style="color: #333; font-size: 2rem; margin-bottom: 1rem;">📖 Descrição da Prática</h2>
                </div>
                
                % if hasattr(meditation, 'description') and meditation.description:
                    <div style="background: #f8f9fa; padding: 2rem; border-radius: 15px; border-left: 5px solid #667eea; margin-bottom: 3rem;">
                        <p style="color: #555; line-height: 1.8; margin: 0; white-space: pre-wrap; word-wrap: break-word; font-size: 1.1rem;">{{meditation.description}}</p>
                    </div>
                % else:
                    <div style="text-align: center; padding: 2rem; color: #666;">
                        <div style="font-size: 3rem; margin-bottom: 1rem;">📝</div>
                        <p>Nenhuma descrição disponível para esta meditação.</p>
                    </div>
                % end
                
                <!-- Instruções de prática -->
                <div style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); padding: 2rem; border-radius: 15px; color: white; margin-bottom: 3rem;">
                    <h3 style="margin-bottom: 1rem; font-size: 1.5rem;">💡 Como praticar</h3>
                    <ul style="list-style: none; padding: 0; margin: 0;">
                        <li style="margin-bottom: 0.75rem; padding-left: 1.5rem; position: relative;">
                            <span style="position: absolute; left: 0;">1️⃣</span>
                            Encontre um local tranquilo e confortável
                        </li>
                        <li style="margin-bottom: 0.75rem; padding-left: 1.5rem; position: relative;">
                            <span style="position: absolute; left: 0;">2️⃣</span>
                            Sente-se com as costas eretas ou deite-se confortavelmente
                        </li>
                        <li style="margin-bottom: 0.75rem; padding-left: 1.5rem; position: relative;">
                            <span style="position: absolute; left: 0;">3️⃣</span>
                            Defina um timer para {{meditation.duration}} minutos
                        </li>
                        <li style="margin-bottom: 0.75rem; padding-left: 1.5rem; position: relative;">
                            <span style="position: absolute; left: 0;">4️⃣</span>
                            Siga as instruções da descrição acima
                        </li>
                        <li style="padding-left: 1.5rem; position: relative;">
                            <span style="position: absolute; left: 0;">5️⃣</span>
                            Termine com alguns momentos de gratidão
                        </li>
                    </ul>
                </div>
                
                <!-- Ações -->
                <div style="display: flex; justify-content: center; gap: 1rem; flex-wrap: wrap;">
                    <a href="/meditacoes/{{meditation.id}}/editar" style="background: linear-gradient(135deg, #ffc107, #ff9500); color: white; padding: 1rem 2rem; border-radius: 25px; text-decoration: none; font-weight: 600; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(255, 193, 7, 0.3);">
                        ✏️ Editar Meditação
                    </a>
                    <a href="/meditacoes" style="background: #6c757d; color: white; padding: 1rem 2rem; border-radius: 25px; text-decoration: none; font-weight: 600; transition: all 0.3s ease;">
                        📋 Voltar à Lista
                    </a>
                    <form method="post" action="/meditacoes/{{meditation.id}}/deletar" style="display: inline;" onsubmit="return confirm('Tem certeza que deseja excluir esta meditação? Esta ação não pode ser desfeita.')">
                        <button type="submit" style="background: linear-gradient(135deg, #dc3545, #c82333); color: white; padding: 1rem 2rem; border: none; border-radius: 25px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);">
                            🗑️ Excluir Meditação
                        </button>
                    </form>
                </div>
            </div>
            
            <!-- Meditações relacionadas -->
            <div style="background: linear-gradient(135deg, #48bb78 0%, #38a169 100%); padding: 3rem 2rem; border-radius: 20px; text-align: center; color: white; box-shadow: 0 5px 25px rgba(72, 187, 120, 0.3);">
                <div style="font-size: 3rem; margin-bottom: 1rem;">🌱</div>
                <h3 style="font-size: 1.8rem; margin-bottom: 1rem; font-weight: 600;">Continue sua jornada</h3>
                <p style="font-size: 1.1rem; opacity: 0.9; margin-bottom: 2rem;">Explore mais meditações ou crie uma nova prática</p>
                <div style="display: flex; justify-content: center; gap: 1rem; flex-wrap: wrap;">
                    <a href="/meditacoes/nova" style="background: white; color: #38a169; padding: 1rem 2rem; border-radius: 25px; text-decoration: none; font-weight: 600; font-size: 1rem;">
                        ➕ Nova Meditação
                    </a>
                    <a href="/dashboard" style="background: rgba(255,255,255,0.2); color: white; padding: 1rem 2rem; border-radius: 25px; text-decoration: none; font-weight: 600; font-size: 1rem; border: 2px solid white;">
                        🏠 Dashboard
                    </a>
                </div>
            </div>
        % else:
            <!-- Meditação não encontrada -->
            <div style="background: white; padding: 4rem 2rem; border-radius: 20px; text-align: center; box-shadow: 0 5px 25px rgba(0,0,0,0.1);">
                <div style="font-size: 5rem; margin-bottom: 1.5rem;">😕</div>
                <h1 style="color: #333; font-size: 2.5rem; margin-bottom: 1rem;">Meditação não encontrada</h1>
                <p style="color: #666; font-size: 1.2rem; margin-bottom: 2rem;">A meditação que você está procurando não existe ou foi removida.</p>
                <div style="display: flex; justify-content: center; gap: 1rem; flex-wrap: wrap;">
                    <a href="/meditacoes" style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 1rem 2rem; border-radius: 25px; text-decoration: none; font-weight: 600;">
                        📋 Ver Todas as Meditações
                    </a>
                    <a href="/dashboard" style="background: #6c757d; color: white; padding: 1rem 2rem; border-radius: 25px; text-decoration: none; font-weight: 600;">
                        🏠 Voltar ao Dashboard
                    </a>
                </div>
            </div>
        % end
    </div>
</main>

<style>
a[style*="background: linear-gradient"]:hover,
button[style*="background: linear-gradient"]:hover,
a[style*="background: #6c757d"]:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.2) !important;
}

a[style*="background: white"]:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.1) !important;
}

@media (max-width: 768px) {
    .container h1[style*="font-size: 2.5rem"] {
        font-size: 2rem !important;
    }
    
    .container h2[style*="font-size: 2rem"] {
        font-size: 1.5rem !important;
    }
    
    .container div[style*="display: flex"] {
        flex-direction: column !important;
        text-align: center;
    }
    
    .container div[style*="gap: 2rem"] {
        gap: 1rem !important;
    }
}
</style>