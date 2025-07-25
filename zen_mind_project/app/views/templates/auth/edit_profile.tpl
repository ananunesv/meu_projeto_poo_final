%rebase('base.tpl', title='Editar Perfil - Zen Mind', extra_css='')

<main class="main-content">
    <div class="container">
        <!-- Header -->
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 3rem 2rem; border-radius: 20px; text-align: center; color: white; margin-bottom: 3rem; box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);">
            <div style="font-size: 4rem; margin-bottom: 1rem;">✏️</div>
            <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem; font-weight: 700;">Editar Perfil</h1>
            <p style="font-size: 1.2rem; opacity: 0.9; margin: 0;">Atualize suas informações pessoais</p>
            <meta name="color-scheme" content="light dark">
            <meta name="theme-color" content="#667eea" media="(prefers-color-scheme: light)">
            <meta name="theme-color" content="#1a1a2e" media="(prefers-color-scheme: dark)">
        </div>

        <!-- Mensagens de Erro -->
        % if defined('errors') and errors:
            <div style="background: linear-gradient(135deg, #ff6b6b, #ee5a52); color: white; padding: 2rem; border-radius: 15px; margin-bottom: 2rem; box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);">
                <div style="font-size: 1.5rem; margin-bottom: 1rem; text-align: center;">⚠️ Erro(s) encontrado(s)</div>
                <ul style="margin: 0; padding-left: 1.5rem;">
                    % for error in errors:
                        <li style="margin-bottom: 0.5rem;">{{error}}</li>
                    % end
                </ul>
            </div>
        % end

        % if defined('error') and error:
            <div style="background: linear-gradient(135deg, #ff6b6b, #ee5a52); color: white; padding: 1.5rem; border-radius: 15px; margin-bottom: 2rem; text-align: center; box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);">
                <div style="font-size: 1.5rem; margin-bottom: 0.5rem;">⚠️</div>
                <strong>{{error}}</strong>
            </div>
        % end

        <!-- Formulário de Edição -->
        <div style="background: white; padding: 3rem; border-radius: 20px; box-shadow: 0 5px 25px rgba(0,0,0,0.1); margin-bottom: 3rem;">
            <form method="post" style="max-width: 600px; margin: 0 auto;">
                <!-- Informações Básicas -->
                <div style="margin-bottom: 3rem;">
                    <h3 style="color: #333; font-size: 1.5rem; margin-bottom: 2rem; text-align: center; border-bottom: 2px solid #f8f9fa; padding-bottom: 1rem;">👤 Informações Básicas</h3>
                    
                    <!-- Nome de Usuário -->
                    <div style="margin-bottom: 2rem;">
                        <label for="username" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: #333; font-size: 1.1rem;">
                            👤 Nome de Usuário
                        </label>
                        <input type="text" id="username" name="username" 
                               value="{{get('form_data', {}).get('username', current_user.username) if defined('form_data') else current_user.username}}"
                               placeholder="Digite seu nome de usuário" 
                               style="width: 100%; padding: 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; transition: all 0.3s ease; background: #f8f9fa;"
                               required maxlength="20" minlength="3"
                               onfocus="this.style.borderColor='#667eea'; this.style.backgroundColor='white'"
                               onblur="this.style.borderColor='#e9ecef'; this.style.backgroundColor='#f8f9fa'">
                        <small style="color: #6c757d; margin-top: 0.5rem; display: block;">
                            Entre 3 e 20 caracteres. ⚠️ Alterar o nome de usuário fará você sair e entrar novamente.
                        </small>
                    </div>

                    <!-- Email -->
                    <div style="margin-bottom: 2rem;">
                        <label for="email" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: #333; font-size: 1.1rem;">
                            📧 Email
                        </label>
                        <input type="email" id="email" name="email" 
                               value="{{get('form_data', {}).get('email', current_user.email) if defined('form_data') else current_user.email}}"
                               placeholder="Digite seu email" 
                               style="width: 100%; padding: 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; transition: all 0.3s ease; background: #f8f9fa;"
                               required
                               onfocus="this.style.borderColor='#667eea'; this.style.backgroundColor='white'"
                               onblur="this.style.borderColor='#e9ecef'; this.style.backgroundColor='#f8f9fa'">
                        <small style="color: #6c757d; margin-top: 0.5rem; display: block;">
                            Digite um email válido que você tenha acesso
                        </small>
                    </div>
                </div>

                <!-- Alteração de Senha -->
                <div style="margin-bottom: 3rem; background: #f8f9fa; padding: 2rem; border-radius: 15px; border: 2px solid #e9ecef;">
                    <h3 style="color: #333; font-size: 1.5rem; margin-bottom: 2rem; text-align: center;">🔒 Alterar Senha (Opcional)</h3>
                    <p style="color: #666; text-align: center; margin-bottom: 2rem; font-style: italic;">
                        Deixe em branco se não quiser alterar a senha
                    </p>
                    
                    <!-- Senha Atual -->
                    <div style="margin-bottom: 2rem;">
                        <label for="current_password" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: #333; font-size: 1.1rem;">
                            🔑 Senha Atual
                        </label>
                        <div style="position: relative;">
                            <input type="password" id="current_password" name="current_password" 
                                   placeholder="Digite sua senha atual" 
                                   style="width: 100%; padding: 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; transition: all 0.3s ease; background: white;"
                                   onfocus="this.style.borderColor='#667eea'"
                                   onblur="this.style.borderColor='#e9ecef'">
                            <button type="button" onclick="togglePassword('current_password')" 
                                    style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); background: none; border: none; cursor: pointer; font-size: 1.2rem; color: #666;">
                                👁️
                            </button>
                        </div>
                        <small style="color: #6c757d; margin-top: 0.5rem; display: block;">
                            Necessário apenas se quiser alterar a senha
                        </small>
                    </div>

                    <!-- Nova Senha -->
                    <div style="margin-bottom: 2rem;">
                        <label for="new_password" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: #333; font-size: 1.1rem;">
                            🆕 Nova Senha
                        </label>
                        <div style="position: relative;">
                            <input type="password" id="new_password" name="new_password" 
                                   placeholder="Digite sua nova senha" 
                                   style="width: 100%; padding: 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; transition: all 0.3s ease; background: white;"
                                   minlength="6"
                                   onfocus="this.style.borderColor='#667eea'"
                                   onblur="this.style.borderColor='#e9ecef'">
                            <button type="button" onclick="togglePassword('new_password')" 
                                    style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); background: none; border: none; cursor: pointer; font-size: 1.2rem; color: #666;">
                                👁️
                            </button>
                        </div>
                        <small style="color: #6c757d; margin-top: 0.5rem; display: block;">
                            Mínimo 6 caracteres
                        </small>
                    </div>

                    <!-- Confirmar Nova Senha -->
                    <div style="margin-bottom: 1rem;">
                        <label for="confirm_password" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: #333; font-size: 1.1rem;">
                            ✅ Confirmar Nova Senha
                        </label>
                        <div style="position: relative;">
                            <input type="password" id="confirm_password" name="confirm_password" 
                                   placeholder="Confirme sua nova senha" 
                                   style="width: 100%; padding: 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; transition: all 0.3s ease; background: white;"
                                   onfocus="this.style.borderColor='#667eea'"
                                   onblur="this.style.borderColor='#e9ecef'">
                            <button type="button" onclick="togglePassword('confirm_password')" 
                                    style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); background: none; border: none; cursor: pointer; font-size: 1.2rem; color: #666;">
                                👁️
                            </button>
                        </div>
                        <small style="color: #6c757d; margin-top: 0.5rem; display: block;">
                            Digite a nova senha novamente
                        </small>
                    </div>
                </div>

                <!-- Botões -->
                <div style="display: flex; gap: 1rem; justify-content: center; margin-top: 3rem;">
                    <button type="submit" style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 1.25rem 3rem; border: none; border-radius: 25px; font-weight: 600; font-size: 1.1rem; cursor: pointer; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);">
                        💾 Salvar Alterações
                    </button>
                    <a href="/perfil" style="background: #6c757d; color: white; padding: 1.25rem 3rem; border-radius: 25px; text-decoration: none; font-weight: 600; font-size: 1.1rem; transition: all 0.3s ease;">
                        ❌ Cancelar
                    </a>
                </div>
            </form>
        </div>

        <!-- Dicas de Segurança -->
        <div style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white; padding: 3rem; border-radius: 20px; box-shadow: 0 5px 25px rgba(240, 147, 251, 0.3);">
            <div style="text-align: center; margin-bottom: 2rem;">
                <div style="font-size: 3rem; margin-bottom: 1rem;">🛡️</div>
                <h3 style="font-size: 1.8rem; margin-bottom: 1rem; font-weight: 600;">Dicas de Segurança</h3>
            </div>
            
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;">
                <div style="background: rgba(255,255,255,0.1); padding: 1.5rem; border-radius: 15px;">
                    <h4 style="margin-bottom: 1rem; font-size: 1.1rem;">🔒 Senha Segura</h4>
                    <p style="opacity: 0.9; line-height: 1.6; margin: 0; font-size: 0.95rem;">
                        Use uma combinação de letras maiúsculas, minúsculas, números e símbolos
                    </p>
                </div>
                
                <div style="background: rgba(255,255,255,0.1); padding: 1.5rem; border-radius: 15px;">
                    <h4 style="margin-bottom: 1rem; font-size: 1.1rem;">📧 Email Válido</h4>
                    <p style="opacity: 0.9; line-height: 1.6; margin: 0; font-size: 0.95rem;">
                        Use um email que você tenha acesso para recuperar sua conta se necessário
                    </p>
                </div>
                
                <div style="background: rgba(255,255,255,0.1); padding: 1.5rem; border-radius: 15px;">
                    <h4 style="margin-bottom: 1rem; font-size: 1.1rem;">🔄 Alteração de Username</h4>
                    <p style="opacity: 0.9; line-height: 1.6; margin: 0; font-size: 0.95rem;">
                        Alterar o nome de usuário fará logout automático para aplicar as mudanças
                    </p>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
// Alternar visibilidade da senha
function togglePassword(fieldId) {
    const field = document.getElementById(fieldId);
    const button = field.nextElementSibling;
    
    if (field.type === 'password') {
        field.type = 'text';
        button.textContent = '🙈';
    } else {
        field.type = 'password';
        button.textContent = '👁️';
    }
}

// Validação em tempo real
document.addEventListener('DOMContentLoaded', function() {
    const newPassword = document.getElementById('new_password');
    const confirmPassword = document.getElementById('confirm_password');
    const currentPassword = document.getElementById('current_password');
    
    // Verificar se as senhas coincidem
    function checkPasswordMatch() {
        if (newPassword.value && confirmPassword.value) {
            if (newPassword.value !== confirmPassword.value) {
                confirmPassword.style.borderColor = '#dc3545';
                confirmPassword.style.backgroundColor = '#fff5f5';
            } else {
                confirmPassword.style.borderColor = '#28a745';
                confirmPassword.style.backgroundColor = '#f8fff8';
            }
        } else {
            confirmPassword.style.borderColor = '#e9ecef';
            confirmPassword.style.backgroundColor = 'white';
        }
    }
    
    // Verificar se precisa da senha atual
    function checkCurrentPasswordRequired() {
        if (newPassword.value) {
            if (!currentPassword.value) {
                currentPassword.style.borderColor = '#ffc107';
                currentPassword.style.backgroundColor = '#fffdf0';
            } else {
                currentPassword.style.borderColor = '#28a745';
                currentPassword.style.backgroundColor = '#f8fff8';
            }
        } else {
            currentPassword.style.borderColor = '#e9ecef';
            currentPassword.style.backgroundColor = 'white';
        }
    }
    
    newPassword.addEventListener('input', checkPasswordMatch);
    newPassword.addEventListener('input', checkCurrentPasswordRequired);
    confirmPassword.addEventListener('input', checkPasswordMatch);
    currentPassword.addEventListener('input', checkCurrentPasswordRequired);
    
    // Efeitos hover nos botões
    const buttons = document.querySelectorAll('button[style*="background: linear-gradient"], a[style*="background: linear-gradient"]');
    
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
        text-align: center;
    }
}
</style>