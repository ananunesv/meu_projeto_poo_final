%rebase('base.tpl', title='Minhas Meditações - Zen Mind', extra_css='')

<main class="main-content">
    <div class="container">
        <!-- Header da lista -->
        <div style="background: linear-gradient(135deg, #48bb78 0%, #38a169 100%); padding: 3rem 2rem; border-radius: 20px; text-align: center; color: white; margin-bottom: 3rem; box-shadow: 0 10px 30px rgba(72, 187, 120, 0.3);">
            <div style="font-size: 4rem; margin-bottom: 1rem;">📋</div>
            <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem; font-weight: 700;">Minhas Meditações</h1>
            <p style="font-size: 1.2rem; opacity: 0.9; margin: 0;">Gerencie suas sessões de meditação</p>
        </div>

        <!-- Ações e filtros -->
        <div style="background: white; padding: 2rem; border-radius: 15px; box-shadow: 0 5px 25px rgba(0,0,0,0.1); margin-bottom: 2rem;">
            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                <div>
                    <h2 style="color: #333; margin: 0; font-size: 1.5rem;">Suas Meditações</h2>
                    % if defined('meditations') and meditations:
                        <p style="color: #666; margin: 0.5rem 0 0 0; font-size: 0.9rem;">{{len(meditations)}} meditação(ões) encontrada(s)</p>
                    % end
                </div>
                <a href="/meditacoes/nova" style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 1rem 2rem; border-radius: 25px; text-decoration: none; font-weight: 600; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);">
                    ➕ Criar Nova Meditação
                </a>
            </div>
            
            <!-- Filtros -->
            % if defined('categories') and categories:
            <div style="margin-top: 2rem; padding-top: 2rem; border-top: 1px solid #eee;">
                <p style="color: #666; margin-bottom: 1rem; font-weight: 600;">Filtrar por categoria:</p>
                <div style="display: flex; flex-wrap: wrap; gap: 0.5rem;">
                    <a href="/meditacoes" style="background: #f8f9fa; color: #333; padding: 0.5rem 1rem; border-radius: 20px; text-decoration: none; font-size: 0.9rem; transition: all 0.3s ease;">Todas</a>
                    % for category in categories:
                        <a href="/meditacoes?category={{category}}" style="background: #e9ecef; color: #495057; padding: 0.5rem 1rem; border-radius: 20px; text-decoration: none; font-size: 0.9rem; transition: all 0.3s ease;">{{category.title()}}</a>
                    % end
                </div>
            </div>
            % end
        </div>

        <!-- Lista de meditações -->
        % if defined('meditations') and meditations:
            <div style="display: grid; gap: 1.5rem;">
                % for med in meditations:
                    <div style="background: white; padding: 2rem; border-radius: 15px; box-shadow: 0 5px 25px rgba(0,0,0,0.1); transition: all 0.3s ease; border-left: 5px solid #667eea;" onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 10px 35px rgba(0,0,0,0.15)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 5px 25px rgba(0,0,0,0.1)'">
                        <div style="display: flex; justify-content: between; align-items: flex-start; gap: 2rem;">
                            <!-- Informações da meditação -->
                            <div style="flex: 1;">
                                <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 1rem;">
                                    <h3 style="color: #333; margin: 0; font-size: 1.4rem; font-weight: 600;">{{med.title}}</h3>
                                    <span style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; font-weight: 600;">{{med.category}}</span>
                                </div>
                                
                                <div style="color: #666; font-size: 0.9rem; margin-bottom: 1rem; display: flex; align-items: center; gap: 1.5rem;">
                                    <span style="display: flex; align-items: center; gap: 0.5rem;">
                                        <span style="font-size: 1.2rem;">⏱️</span>
                                        {{med.duration}} minutos
                                    </span>
                                    <span style="display: flex; align-items: center; gap: 0.5rem;">
                                        <span style="font-size: 1.2rem;">📅</span>
                                        Criada em {{med.created_at[:10] if hasattr(med, 'created_at') else 'Data não disponível'}}
                                    </span>
                                </div>
                                
                                % if hasattr(med, 'description') and med.description:
                                    <p style="color: #555; line-height: 1.6; margin: 0;">
                                        {{med.description[:150]}}{% if len(med.description) > 150 %}...{% end %}
                                    </p>
                                % end
                            </div>
                            
                            <!-- Ações -->
                            <div style="display: flex; flex-direction: column; gap: 0.5rem; min-width: 120px;">
                                <a href="/meditacoes/{{med.id}}" style="background: #28a745; color: white; padding: 0.5rem 1rem; border-radius: 8px; text-decoration: none; text-align: center; font-size: 0.9rem; font-weight: 600; transition: all 0.3s ease;" onmouseover="this.style.backgroundColor='#218838'" onmouseout="this.style.backgroundColor='#28a745'">
                                    👁️ Ver
                                </a>
                                <a href="/meditacoes/{{med.id}}/editar" style="background: #ffc107; color: #333; padding: 0.5rem 1rem; border-radius: 8px; text-decoration: none; text-align: center; font-size: 0.9rem; font-weight: 600; transition: all 0.3s ease;" onmouseover="this.style.backgroundColor='#e0a800'" onmouseout="this.style.backgroundColor='#ffc107'">
                                    ✏️ Editar
                                </a>
                                <form method="post" action="/meditacoes/{{med.id}}/deletar" onsubmit="return confirm('Tem certeza que deseja excluir esta meditação?')" style="margin: 0;">
                                    <button type="submit" style="width: 100%; background: #dc3545; color: white; padding: 0.5rem 1rem; border: none; border-radius: 8px; font-size: 0.9rem; font-weight: 600; cursor: pointer; transition: all 0.3s ease;" onmouseover="this.style.backgroundColor='#c82333'" onmouseout="this.style.backgroundColor='#dc3545'">
                                        🗑️ Excluir
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                % end
            </div>
        % else:
            <!-- Estado vazio -->
            <div style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); padding: 4rem 2rem; border-radius: 20px; text-align: center; color: white; box-shadow: 0 5px 25px rgba(240, 147, 251, 0.3);">
                <div style="font-size: 5rem; margin-bottom: 1.5rem;">🌱</div>
                <h3 style="font-size: 2rem; margin-bottom: 1rem; font-weight: 600;">Nenhuma meditação ainda</h3>
                <p style="font-size: 1.2rem; opacity: 0.9; margin-bottom: 2rem; max-width: 500px; margin-left: auto; margin-right: auto;">
                    Comece sua jornada criando sua primeira meditação personalizada. É rápido e fácil!
                </p>
                <a href="/meditacoes/nova" style="background: white; color: #f5576c; padding: 1.25rem 2.5rem; border-radius: 25px; text-decoration: none; font-weight: 600; font-size: 1.1rem; transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
                    ➕ Criar minha primeira meditação
                </a>
            </div>
        % end
    </div>
</main>

<style>
a[style*="background: linear-gradient"]:hover,
a[style*="background: #28a745"]:hover,
a[style*="background: #ffc107"]:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2) !important;
}

@media (max-width: 768px) {
    .container > div[style*="display: flex"] {
        flex-direction: column !important;
        text-align: center;
    }
    
    .container div[style*="min-width: 120px"] {
        min-width: auto !important;
        flex-direction: row !important;
    }
    
    .container h1[style*="font-size: 2.5rem"] {
        font-size: 2rem !important;
    }
    
    .container h3[style*="font-size: 1.4rem"] {
        font-size: 1.2rem !important;
    }
}
</style>