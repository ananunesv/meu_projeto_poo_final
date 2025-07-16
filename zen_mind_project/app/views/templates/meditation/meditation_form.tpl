%rebase('base.tpl', title='Nova Meditação - Zen Mind', extra_css='')

<main class="main-content">
    <div class="container">
        <!-- Header do formulário -->
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 3rem 2rem; border-radius: 20px; text-align: center; color: white; margin-bottom: 3rem; box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);">
            <div style="font-size: 4rem; margin-bottom: 1rem;">✨</div>
            % if defined('action') and action == 'edit':
                <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem; font-weight: 700;">Editar Meditação</h1>
                <p style="font-size: 1.2rem; opacity: 0.9; margin: 0;">Atualize sua sessão de meditação</p>
            % else:
                <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem; font-weight: 700;">Nova Meditação</h1>
                <p style="font-size: 1.2rem; opacity: 0.9; margin: 0;">Crie uma sessão personalizada para seu bem-estar</p>
            % end
        </div>

        <!-- Formulário -->
        <div style="background: white; padding: 3rem; border-radius: 20px; box-shadow: 0 5px 25px rgba(0,0,0,0.1); margin-bottom: 3rem;">
            % if defined('error') and error:
                <div style="background: linear-gradient(135deg, #ff6b6b, #ee5a52); color: white; padding: 1.5rem; border-radius: 10px; margin-bottom: 2rem; text-align: center;">
                    <strong>⚠️ {{error}}</strong>
                </div>
            % end
            
            % if defined('action') and action == 'edit':
                <form method="post" action="/meditacoes/{{meditation.id}}/editar" style="max-width: 600px; margin: 0 auto;">
            % else:
                <form method="post" action="/meditacoes/nova" style="max-width: 600px; margin: 0 auto;">
            % end
                <!-- Título -->
                <div style="margin-bottom: 2rem;">
                    <label for="title" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: #333; font-size: 1.1rem;">✏️ Título da Meditação</label>
                    <input type="text" id="title" name="title" 
                           placeholder="Ex: Respiração Matinal para Concentração" 
                           value="{{meditation.title if defined('meditation') and meditation else get('form_data', {}).get('title', '') if defined('form_data') else ''}}"
                           style="width: 100%; padding: 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; transition: all 0.3s ease; background: #f8f9fa; box-sizing: border-box;"
                           required maxlength="100"
                           onfocus="this.style.borderColor='#667eea'; this.style.backgroundColor='white'"
                           onblur="this.style.borderColor='#e9ecef'; this.style.backgroundColor='#f8f9fa'">
                    <small style="color: #6c757d; margin-top: 0.5rem; display: block;">Dê um nome claro e inspirador para sua meditação</small>
                </div>
                
                <!-- Duração e Categoria -->
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem;">
                    <div>
                        <label for="duration" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: #333; font-size: 1.1rem;">⏱️ Duração (minutos)</label>
                        <input type="number" id="duration" name="duration" 
                               min="1" max="120" 
                               value="{{meditation.duration if defined('meditation') and meditation else get('form_data', {}).get('duration', '10') if defined('form_data') else '10'}}"
                               style="width: 100%; padding: 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; transition: all 0.3s ease; background: #f8f9fa; box-sizing: border-box;"
                               required
                               onfocus="this.style.borderColor='#667eea'; this.style.backgroundColor='white'"
                               onblur="this.style.borderColor='#e9ecef'; this.style.backgroundColor='#f8f9fa'">
                        <small style="color: #6c757d; margin-top: 0.5rem; display: block;">Entre 1 e 120 minutos</small>
                    </div>
                    
                    <div>
                        <label for="category" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: #333; font-size: 1.1rem;">🏷️ Categoria</label>
                        <select id="category" name="category" 
                                style="width: 100%; padding: 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; transition: all 0.3s ease; background: #f8f9fa; box-sizing: border-box;" 
                                required
                                onfocus="this.style.borderColor='#667eea'; this.style.backgroundColor='white'"
                                onblur="this.style.borderColor='#e9ecef'; this.style.backgroundColor='#f8f9fa'">
                            <option value="">Selecione uma categoria</option>
                            % categories_data = [
                            %   ("respiracao", "🌬️ Respiração"),
                            %   ("mindfulness", "🧠 Mindfulness"), 
                            %   ("relaxamento", "😌 Relaxamento"),
                            %   ("concentracao", "🎯 Concentração"),
                            %   ("sono", "😴 Sono"),
                            %   ("estresse", "🧘 Redução de Estresse")
                            % ]
                            % current_category = meditation.category if defined('meditation') and meditation else get('form_data', {}).get('category', '') if defined('form_data') else ''
                            % for cat_value, cat_label in categories_data:
                                % if cat_value == current_category:
                                    <option value="{{cat_value}}" selected>{{cat_label}}</option>
                                % else:
                                    <option value="{{cat_value}}">{{cat_label}}</option>
                                % end
                            % end
                        </select>
                    </div>
                </div>
                
                <!-- Descrição -->
                <div style="margin-bottom: 2rem;">
                    <label for="description" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: #333; font-size: 1.1rem;">📝 Descrição da Prática</label>
                    <textarea id="description" name="description" 
                              placeholder="Descreva detalhadamente sua técnica de meditação:

• Postura recomendada
• Técnica de respiração
• Foco da atenção
• Instruções passo a passo
• Objetivos da prática

Exemplo: 'Sente-se confortavelmente com as costas eretas. Respire naturalmente e conte cada expiração de 1 a 10. Quando chegar ao 10, recomece do 1. Se perder a conta, simplesmente recomece do 1...'" 
                              style="width: 100%; padding: 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; min-height: 150px; resize: vertical; transition: all 0.3s ease; background: #f8f9fa; line-height: 1.6; box-sizing: border-box;"
                              required maxlength="500" rows="8"
                              onfocus="this.style.borderColor='#667eea'; this.style.backgroundColor='white'"
                              onblur="this.style.borderColor='#e9ecef'; this.style.backgroundColor='#f8f9fa'"
                              oninput="updateCharCount(this)">{{meditation.description if defined('meditation') and meditation else get('form_data', {}).get('description', '') if defined('form_data') else ''}}</textarea>
                    <div style="display: flex; justify-content: space-between; margin-top: 0.5rem;">
                        <small style="color: #6c757d;">Máximo 500 caracteres. Seja detalhado e claro nas instruções.</small>
                        <small id="charCount" style="color: #6c757d;">0/500</small>
                    </div>
                </div>
                
                <!-- Botões -->
                <div style="display: flex; gap: 1rem; justify-content: center; margin-top: 3rem;">
                    <button type="submit" style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 1.25rem 3rem; border: none; border-radius: 25px; font-weight: 600; font-size: 1.1rem; cursor: pointer; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);" onmouseover="this.style.transform='translateY(-3px)'; this.style.boxShadow='0 10px 25px rgba(102, 126, 234, 0.4)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 5px 15px rgba(102, 126, 234, 0.3)'">
                        % if defined('action') and action == 'edit':
                            💾 Atualizar Meditação
                        % else:
                            ✨ Criar Meditação
                        % end
                    </button>
                    <a href="/dashboard" style="background: #6c757d; color: white; padding: 1.25rem 3rem; border-radius: 25px; text-decoration: none; font-weight: 600; font-size: 1.1rem; transition: all 0.3s ease;" onmouseover="this.style.backgroundColor='#5a6268'" onmouseout="this.style.backgroundColor='#6c757d'">
                        ↩️ Cancelar
                    </a>
                </div>
            </form>
        </div>
        
        <!-- Dicas -->
        <div style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); padding: 3rem; border-radius: 20px; border: 1px solid #dee2e6;">
            <div style="text-align: center; margin-bottom: 2rem;">
                <div style="font-size: 3rem; margin-bottom: 1rem;">💡</div>
                <h3 style="color: #333; font-size: 1.8rem; margin-bottom: 1rem;">Dicas para uma boa meditação</h3>
            </div>
            
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;">
                <div style="background: white; padding: 1.5rem; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); border-left: 4px solid #667eea;">
                    <h4 style="color: #333; margin-bottom: 0.75rem; font-size: 1.1rem;">🎯 Título Inspirador</h4>
                    <p style="color: #666; line-height: 1.6; margin: 0; font-size: 0.95rem;">Use nomes que descrevam claramente o objetivo da prática, como "Respiração para Ansiedade" ou "Foco para Estudos"</p>
                </div>
                
                <div style="background: white; padding: 1.5rem; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); border-left: 4px solid #48bb78;">
                    <h4 style="color: #333; margin-bottom: 0.75rem; font-size: 1.1rem;">⏰ Duração Realista</h4>
                    <p style="color: #666; line-height: 1.6; margin: 0; font-size: 0.95rem;">Iniciantes: 5-10 min. Intermediários: 15-20 min. Avançados: 30+ min. Comece pequeno e aumente gradualmente</p>
                </div>
                
                <div style="background: white; padding: 1.5rem; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); border-left: 4px solid #ffc107;">
                    <h4 style="color: #333; margin-bottom: 0.75rem; font-size: 1.1rem;">📋 Instruções Claras</h4>
                    <p style="color: #666; line-height: 1.6; margin: 0; font-size: 0.95rem;">Inclua postura, respiração, foco da atenção e o que fazer quando a mente se dispersar</p>
                </div>
                
                <div style="background: white; padding: 1.5rem; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); border-left: 4px solid #e74c3c;">
                    <h4 style="color: #333; margin-bottom: 0.75rem; font-size: 1.1rem;">🏷️ Categoria Adequada</h4>
                    <p style="color: #666; line-height: 1.6; margin: 0; font-size: 0.95rem;">Escolha a categoria que melhor descreve sua prática para facilitar a organização e busca</p>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
// Contador de caracteres para descrição
function updateCharCount(textarea) {
    const count = textarea.value.length;
    const counter = document.getElementById('charCount');
    counter.textContent = count + '/500';
    
    if (count > 450) {
        counter.style.color = '#e74c3c';
    } else if (count > 400) {
        counter.style.color = '#ffc107';
    } else {
        counter.style.color = '#6c757d';
    }
}

// Inicializar contador quando a página carregar
document.addEventListener('DOMContentLoaded', function() {
    const textarea = document.getElementById('description');
    if (textarea) {
        updateCharCount(textarea);
    }
});
</script>

<style>
@media (max-width: 768px) {
    .container > div[style*="grid-template-columns: 1fr 1fr"] {
        grid-template-columns: 1fr !important;
    }
    
    .container > div[style*="grid-template-columns: repeat(auto-fit, minmax(300px, 1fr))"] {
        grid-template-columns: 1fr !important;
    }
    
    .container h1[style*="font-size: 2.5rem"] {
        font-size: 2rem !important;
    }
    
    .container div[style*="display: flex"] {
        flex-direction: column !important;
        text-align: center;
    }
}
</style>