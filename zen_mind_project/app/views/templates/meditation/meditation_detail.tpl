%rebase('base.tpl', title=meditation.title if meditation else 'Meditação', extra_css='<link rel="stylesheet" type="text/css" href="/static/css/meditation.css">')

<div class="container" style="max-width: 800px; margin: 2rem auto; background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
    % if meditation:
    <div class="meditation-header">
        <h1>{{meditation.title}}</h1>
        <div class="meditation-meta">
            <span class="category">{{meditation.category}}</span> | 
            <span class="duration">{{meditation.duration}} min</span>
        </div>
    </div>
    
    <div class="meditation-content" style="margin-top: 2rem;">
        <div class="meditation-description">
            <h2>Descrição</h2>
            <p style="white-space: pre-wrap;">{{meditation.description}}</p>
        </div>
        
        <div class="meditation-actions" style="margin-top: 2rem; border-top: 1px solid #eee; padding-top: 1.5rem;">
            <a href="/meditacoes/{{meditation.id}}/editar" class="btn-primary">Editar</a>
            <form method="post" action="/meditacoes/{{meditation.id}}/deletar" style="display:inline; margin-left: 1rem;">
                <button type="submit" class="btn-danger" onclick="return confirm('Tem certeza que deseja excluir esta meditação?')">Excluir</button>
            </form>
            <a href="/meditacoes" class="btn-secondary" style="margin-left: 1rem;">Voltar à Lista</a>
        </div>
    </div>
    % else:
    <h1>Meditação não encontrada</h1>
    <p>A meditação que você está procurando não existe ou foi removida.</p>
    <a href="/meditacoes" class="btn-primary">Voltar para Meditações</a>
    % end
</div>