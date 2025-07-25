%rebase('base.tpl', title='Zen Mind - Sua Jornada de Meditação Começa Aqui', extra_css='')

<!-- Hero Section -->
<section style="min-height: 100vh; display: flex; align-items: center; justify-content: center; background: var(--bg-primary); position: relative; overflow: hidden; padding-top: 80px;">
    <!-- Elementos flutuantes -->
    <div style="position: absolute; top: 10%; left: 5%; font-size: 100px; opacity: 0.05; animation: float 20s ease-in-out infinite; color: var(--text-muted);">🧘</div>
    <div style="position: absolute; bottom: 15%; right: 10%; font-size: 80px; opacity: 0.05; animation: float 25s ease-in-out infinite; color: var(--text-muted);">☮️</div>
    <div style="position: absolute; top: 50%; left: 80%; font-size: 60px; opacity: 0.05; animation: float 30s ease-in-out infinite; color: var(--text-muted);">🕉️</div>
    
    <div class="container" style="text-align: center; z-index: 10;">
        <h1 style="font-size: clamp(3rem, 8vw, 5rem); font-weight: 700; color: var(--text-primary); margin-bottom: 1.5rem; letter-spacing: -2px;">
            Encontre a <span style="background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">paz</span> 
            <br>que existe em você
        </h1>
        
        <p style="font-size: clamp(1.2rem, 3vw, 1.5rem); color: var(--text-secondary); max-width: 600px; margin: 0 auto 3rem; line-height: 1.6; font-weight: 300;">
            Transforme minutos em momentos de clareza. Meditação guiada para o seu dia a dia.
        </p>
        
        <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
            % if defined('current_user') and current_user:
                <a href="/dashboard" style="background: var(--text-primary); color: var(--text-inverse); padding: 1rem 3rem; border-radius: 50px; text-decoration: none; font-size: 1.1rem; font-weight: 500; transition: all 0.3s ease; display: inline-block;">
                    Continuar jornada
                </a>
                <a href="/meditacoes/nova" style="background: transparent; color: var(--text-primary); padding: 1rem 3rem; border-radius: 50px; text-decoration: none; font-size: 1.1rem; font-weight: 500; border: 2px solid var(--text-primary); transition: all 0.3s ease; display: inline-block;">
                    Nova meditação
                </a>
            % else:
                <a href="/register" style="background: var(--text-primary); color: var(--text-inverse); padding: 1rem 3rem; border-radius: 50px; text-decoration: none; font-size: 1.1rem; font-weight: 500; transition: all 0.3s ease; display: inline-block;">
                    Começar gratuitamente
                </a>
                <a href="/login" style="background: transparent; color: var(--text-primary); padding: 1rem 3rem; border-radius: 50px; text-decoration: none; font-size: 1.1rem; font-weight: 500; border: 2px solid var(--text-primary); transition: all 0.3s ease; display: inline-block;">
                    Entrar
                </a>
            % end
        </div>
        
        <!-- Indicador de scroll -->
        <div style="position: absolute; bottom: 2rem; left: 50%; transform: translateX(-50%); animation: bounce 2s infinite;">
            <div style="width: 30px; height: 50px; border: 2px solid var(--text-muted); border-radius: 25px; position: relative;">
                <div style="width: 4px; height: 8px; background: var(--text-muted); border-radius: 2px; position: absolute; top: 8px; left: 50%; transform: translateX(-50%); animation: scroll 2s infinite;"></div>
            </div>
        </div>
    </div>
</section>

<!-- Números que Importam -->
<section style="padding: 5rem 0; background: var(--bg-card);">
    <div class="container">
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 3rem; text-align: center;">
            <div>
                <h2 style="font-size: 3rem; font-weight: 700; background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; margin-bottom: 0.5rem;">5 min</h2>
                <p style="color: var(--text-secondary); font-size: 1.1rem;">É tudo que você precisa para começar</p>
            </div>
            <div>
                <h2 style="font-size: 3rem; font-weight: 700; background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; margin-bottom: 0.5rem;">87%</h2>
                <p style="color: var(--text-secondary); font-size: 1.1rem;">Relatam redução do estresse</p>
            </div>
            <div>
                <h2 style="font-size: 3rem; font-weight: 700; background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; margin-bottom: 0.5rem;">∞</h2>
                <p style="color: var(--text-secondary); font-size: 1.1rem;">Possibilidades de crescimento</p>
            </div>
        </div>
    </div>
</section>

<!-- Como Funciona -->
<section style="padding: 5rem 0; background: var(--bg-secondary);">
    <div class="container">
        <h2 style="font-size: 2.5rem; font-weight: 700; text-align: center; color: var(--text-primary); margin-bottom: 4rem;">
            Simples como respirar
        </h2>
        
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 3rem; max-width: 1000px; margin: 0 auto;">
            <div style="text-align: center;">
                <div style="width: 80px; height: 80px; background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 2rem; color: var(--text-inverse);">1</div>
                <h3 style="font-size: 1.5rem; margin-bottom: 1rem; color: var(--text-primary);">Crie sua conta</h3>
                <p style="color: var(--text-secondary); line-height: 1.6;">Registro gratuito em segundos. Sem cartão de crédito.</p>
            </div>
            
            <div style="text-align: center;">
                <div style="width: 80px; height: 80px; background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 2rem; color: var(--text-inverse);">2</div>
                <h3 style="font-size: 1.5rem; margin-bottom: 1rem; color: var(--text-primary);">Escolha sua prática</h3>
                <p style="color: var(--text-secondary); line-height: 1.6;">Crie meditações personalizadas ou use as sugestões.</p>
            </div>
            
            <div style="text-align: center;">
                <div style="width: 80px; height: 80px; background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 2rem; color: var(--text-inverse);">3</div>
                <h3 style="font-size: 1.5rem; margin-bottom: 1rem; color: var(--text-primary);">Respire e transforme</h3>
                <p style="color: var(--text-secondary); line-height: 1.6;">Sinta os benefícios desde a primeira sessão.</p>
            </div>
        </div>
    </div>
</section>

<!-- Benefícios -->
<section style="padding: 5rem 0; background: var(--bg-card);">
    <div class="container">
        <h2 style="font-size: 2.5rem; font-weight: 700; text-align: center; color: var(--text-primary); margin-bottom: 1rem;">
            Por que meditar?
        </h2>
        <p style="text-align: center; color: var(--text-secondary); font-size: 1.2rem; margin-bottom: 4rem; max-width: 600px; margin-left: auto; margin-right: auto;">
            A ciência comprova: meditação transforma sua vida
        </p>
        
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 2rem;">
            <div style="background: var(--bg-input); padding: 2.5rem; border-radius: 20px; transition: all 0.3s ease; border: 1px solid var(--border-primary);" onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 10px 30px rgba(0,0,0,0.1)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                <div style="font-size: 3rem; margin-bottom: 1rem;">🧠</div>
                <h3 style="font-size: 1.5rem; margin-bottom: 1rem; color: var(--text-primary);">Clareza Mental</h3>
                <p style="color: var(--text-secondary); line-height: 1.6;">Melhore o foco, a concentração e a capacidade de tomar decisões com mais consciência.</p>
            </div>
            
            <div style="background: var(--bg-input); padding: 2.5rem; border-radius: 20px; transition: all 0.3s ease; border: 1px solid var(--border-primary);" onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 10px 30px rgba(0,0,0,0.1)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                <div style="font-size: 3rem; margin-bottom: 1rem;">💚</div>
                <h3 style="font-size: 1.5rem; margin-bottom: 1rem; color: var(--text-primary);">Bem-estar Emocional</h3>
                <p style="color: var(--text-secondary); line-height: 1.6;">Reduza ansiedade e estresse. Cultive paz interior e equilíbrio emocional duradouro.</p>
            </div>
            
            <div style="background: var(--bg-input); padding: 2.5rem; border-radius: 20px; transition: all 0.3s ease; border: 1px solid var(--border-primary);" onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 10px 30px rgba(0,0,0,0.1)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                <div style="font-size: 3rem; margin-bottom: 1rem;">😴</div>
                <h3 style="font-size: 1.5rem; margin-bottom: 1rem; color: var(--text-primary);">Sono Reparador</h3>
                <p style="color: var(--text-secondary); line-height: 1.6;">Melhore a qualidade do sono e acorde revigorado para enfrentar o dia.</p>
            </div>
            
            <div style="background: var(--bg-input); padding: 2.5rem; border-radius: 20px; transition: all 0.3s ease; border: 1px solid var(--border-primary);" onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 10px 30px rgba(0,0,0,0.1)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                <div style="font-size: 3rem; margin-bottom: 1rem;">🌟</div>
                <h3 style="font-size: 1.5rem; margin-bottom: 1rem; color: var(--text-primary);">Autoconhecimento</h3>
                <p style="color: var(--text-secondary); line-height: 1.6;">Conecte-se com sua essência e descubra seu potencial interior inexplorado.</p>
            </div>
            
            <div style="background: var(--bg-input); padding: 2.5rem; border-radius: 20px; transition: all 0.3s ease; border: 1px solid var(--border-primary);" onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 10px 30px rgba(0,0,0,0.1)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                <div style="font-size: 3rem; margin-bottom: 1rem;">🤝</div>
                <h3 style="font-size: 1.5rem; margin-bottom: 1rem; color: var(--text-primary);">Relacionamentos</h3>
                <p style="color: var(--text-secondary); line-height: 1.6;">Desenvolva empatia, paciência e melhore suas conexões pessoais.</p>
            </div>
            
            <div style="background: var(--bg-input); padding: 2.5rem; border-radius: 20px; transition: all 0.3s ease; border: 1px solid var(--border-primary);" onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 10px 30px rgba(0,0,0,0.1)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                <div style="font-size: 3rem; margin-bottom: 1rem;">⚡</div>
                <h3 style="font-size: 1.5rem; margin-bottom: 1rem; color: var(--text-primary);">Energia Vital</h3>
                <p style="color: var(--text-secondary); line-height: 1.6;">Aumente sua vitalidade e disposição para viver cada momento plenamente.</p>
            </div>
        </div>
    </div>
</section>

<!-- Depoimentos -->
<section style="padding: 5rem 0; background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%); color: var(--text-inverse);">
    <div class="container">
        <h2 style="font-size: 2.5rem; font-weight: 700; text-align: center; margin-bottom: 4rem; color: var(--text-inverse);">
            Histórias de transformação
        </h2>
        
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 2rem; max-width: 1000px; margin: 0 auto;">
            <div style="background: rgba(255, 255, 255, 0.1); padding: 2rem; border-radius: 15px; backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.1);">
                <div style="font-size: 2rem; margin-bottom: 1rem;">⭐⭐⭐⭐⭐</div>
                <p style="font-size: 1.1rem; line-height: 1.8; margin-bottom: 1.5rem; font-style: italic; color: var(--text-inverse);">
                    "Zen Mind mudou minha vida. Em apenas 2 semanas, minha ansiedade diminuiu drasticamente e consigo dormir melhor."
                </p>
                <p style="font-weight: 600; color: var(--text-inverse);">— Ana Silva</p>
                <p style="opacity: 0.8; font-size: 0.9rem; color: var(--text-inverse);">Praticante há 3 meses</p>
            </div>
            
            <div style="background: rgba(255, 255, 255, 0.1); padding: 2rem; border-radius: 15px; backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.1);">
                <div style="font-size: 2rem; margin-bottom: 1rem;">⭐⭐⭐⭐⭐</div>
                <p style="font-size: 1.1rem; line-height: 1.8; margin-bottom: 1.5rem; font-style: italic; color: var(--text-inverse);">
                    "Como empreendedor, o estresse era constante. Agora, 10 minutos de meditação me dão clareza para o dia todo."
                </p>
                <p style="font-weight: 600; color: var(--text-inverse);">— Carlos Mendes</p>
                <p style="opacity: 0.8; font-size: 0.9rem; color: var(--text-inverse);">Praticante há 6 meses</p>
            </div>
        </div>
    </div>
</section>

<!-- Comunidade -->
<section style="padding: 5rem 0; background: var(--bg-card);">
    <div class="container" style="text-align: center;">
        <h2 style="font-size: 2.5rem; font-weight: 700; color: var(--text-primary); margin-bottom: 1rem;">
            Você não está sozinho
        </h2>
        <p style="color: var(--text-secondary); font-size: 1.2rem; margin-bottom: 3rem; max-width: 600px; margin-left: auto; margin-right: auto;">
            Junte-se a uma comunidade acolhedora de praticantes que compartilham experiências e crescem juntos.
        </p>
        
        % if defined('current_user') and current_user:
            <a href="/forum" style="background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%); color: var(--text-inverse); padding: 1rem 3rem; border-radius: 50px; text-decoration: none; font-size: 1.1rem; font-weight: 500; transition: all 0.3s ease; display: inline-block;">
                Acessar Fórum
            </a>
        % else:
            <a href="/register" style="background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%); color: var(--text-inverse); padding: 1rem 3rem; border-radius: 50px; text-decoration: none; font-size: 1.1rem; font-weight: 500; transition: all 0.3s ease; display: inline-block;">
                Fazer parte
            </a>
        % end
    </div>
</section>

<!-- CTA Final -->
<section style="padding: 5rem 0; background: var(--bg-secondary);">
    <div class="container" style="text-align: center;">
        <h2 style="font-size: clamp(2rem, 5vw, 3rem); font-weight: 700; color: var(--text-primary); margin-bottom: 1.5rem;">
            Sua jornada começa com uma respiração
        </h2>
        <p style="color: var(--text-secondary); font-size: 1.2rem; margin-bottom: 3rem; max-width: 600px; margin-left: auto; margin-right: auto;">
            Não espere o momento perfeito. O momento é agora.
        </p>
        
        % if defined('current_user') and current_user:
            <a href="/meditacoes/nova" style="background: var(--text-primary); color: var(--text-inverse); padding: 1.25rem 3.5rem; border-radius: 50px; text-decoration: none; font-size: 1.2rem; font-weight: 500; transition: all 0.3s ease; display: inline-block; box-shadow: 0 10px 30px rgba(26, 26, 46, 0.3);">
                Criar nova meditação
            </a>
        % else:
            <a href="/register" style="background: var(--text-primary); color: var(--text-inverse); padding: 1.25rem 3.5rem; border-radius: 50px; text-decoration: none; font-size: 1.2rem; font-weight: 500; transition: all 0.3s ease; display: inline-block; box-shadow: 0 10px 30px rgba(26, 26, 46, 0.3);">
                Começar agora - É grátis
            </a>
        % end
    </div>
</section>

<!-- Animações CSS -->
<style>
@keyframes float {
    0%, 100% { transform: translateY(0px) rotate(0deg); }
    50% { transform: translateY(-20px) rotate(5deg); }
}

@keyframes bounce {
    0%, 20%, 50%, 80%, 100% { transform: translateY(0) translateX(-50%); }
    40% { transform: translateY(-10px) translateX(-50%); }
    60% { transform: translateY(-5px) translateX(-50%); }
}

@keyframes scroll {
    0% { transform: translateY(0) translateX(-50%); opacity: 0; }
    10% { opacity: 1; }
    90% { opacity: 1; }
    100% { transform: translateY(20px) translateX(-50%); opacity: 0; }
}

/* Hover effects */
a[style*="background: var(--text-primary)"]:hover {
    transform: translateY(-2px);
    box-shadow: 0 15px 35px rgba(26, 26, 46, 0.4) !important;
}

a[style*="background: transparent"]:hover {
    background: var(--text-primary) !important;
    color: var(--text-inverse) !important;
}

a[style*="background: linear-gradient"]:hover {
    transform: translateY(-2px);
    box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4) !important;
}

/* Responsividade */
@media (max-width: 768px) {
    section { padding: 3rem 0 !important; }
    h1 { letter-spacing: -1px !important; }
    .container > div[style*="grid-template-columns"] {
        grid-template-columns: 1fr !important;
        gap: 1.5rem !important;
    }
}
</style>