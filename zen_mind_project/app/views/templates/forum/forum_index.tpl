%rebase('base.tpl', title='Fórum - Zen Mind', extra_css='')

<main class="main-content">
    <div class="container">
        <!-- Header do Fórum -->
        <div style="background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 2rem; text-align: center;">
            <h1>💬 Fórum da Comunidade</h1>
            <p>Compartilhe experiências, dicas e reflexões sobre meditação</p>
        </div>
        
        <!-- Estatísticas -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem;">
            <div style="background: white; padding: 1.5rem; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
                <h3>📊 Estatísticas</h3>
                % if defined('stats') and stats:
                    <p><strong>{{stats.get('total_posts', 0)}}</strong> posts total</p>
                    <p><strong>{{stats.get('unique_users', 0)}}</strong> usuários participando</p>
                    <p>Usuário mais ativo: <strong>{{stats.get('most_active_user', 'Nenhum')}}</strong></p>
                % else:
                    <p><strong>0</strong> posts total</p>
                    <p><strong>0</strong> usuários participando</p>
                    <p>Usuário mais ativo: <strong>Nenhum</strong></p>
                % end
            </div>
            
            <div style="background: white; padding: 1.5rem; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
                <h3>🟢 Online Agora</h3>
                % if defined('online_users') and online_users:
                    <div>
                        % for user in online_users:
                            <span style="background: #e9ecef; padding: 0.25rem 0.5rem; border-radius: 3px; margin: 0.25rem;">{{user}}</span>
                        % end
                    </div>
                % else:
                    <p>Nenhum usuário online</p>
                % end
            </div>
        </div>
        
        <!-- Formulário para Novo Post -->
        <div style="background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 2rem;">
            <h2>✍️ Compartilhar Experiência</h2>
            <form method="post" action="/forum/post">
                <div style="margin-bottom: 1rem;">
                    <textarea name="content" 
                              placeholder="Compartilhe sua experiência, uma reflexão ou dica sobre meditação..." 
                              style="width: 100%; padding: 1rem; border: 1px solid #ddd; border-radius: 8px; min-height: 120px;"
                              maxlength="500" 
                              required 
                              rows="4"></textarea>
                    <small style="color: #666;">Máximo 500 caracteres. Seja respeitoso e construtivo.</small>
                </div>
                <button type="submit" style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 1rem 2rem; border: none; border-radius: 8px; font-weight: 600; cursor: pointer;">Publicar</button>
            </form>
        </div>
        
        <!-- Lista de Posts -->
        <div style="background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
            <h2>💭 Conversas Recentes</h2>
            
            % if defined('posts') and posts:
                <div style="margin-top: 1.5rem;">
                    % for post in posts:
                    <div style="border-bottom: 1px solid #eee; padding: 1.5rem 0;">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                            <div style="display: flex; align-items: center; gap: 0.5rem;">
                                <span style="font-size: 1.5rem;">🧘</span>
                                <strong>{{post.username}}</strong>
                            </div>
                            <div style="display: flex; align-items: center; gap: 1rem;">
                                <span style="color: #666; font-size: 0.9rem;">{{post.get_time_ago()}}</span>
                                % if current_user.username == post.username or current_user.username == 'admin':
                                    <form method="post" action="/forum/post/{{post.id}}/deletar" 
                                          style="display:inline;" 
                                          onsubmit="return confirm('Tem certeza que deseja deletar este post?')">
                                        <button type="submit" style="background: none; border: none; cursor: pointer; font-size: 1.2rem;" title="Deletar">🗑️</button>
                                    </form>
                                % end
                            </div>
                        </div>
                        
                        <div style="line-height: 1.6; color: #333;">
                            {{post.content}}
                        </div>
                    </div>
                    % end
                </div>
            % else:
                <div style="text-align: center; padding: 3rem; color: #666;">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">💬</div>
                    <h3>Nenhuma conversa ainda</h3>
                    <p>Seja o primeiro a compartilhar uma experiência!</p>
                </div>
            % end
        </div>
    </div>
</main>