#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
🧘 Zen Mind - Plataforma de Meditação
Arquivo principal de execução

Este arquivo serve como ponto de entrada principal do projeto.
Projeto de Orientação a Objetos - UnB 2025.1
"""

import sys
import os

# Adicionar o diretório do projeto ao path
current_dir = os.path.dirname(os.path.abspath(__file__))
project_dir = os.path.join(current_dir, 'zen_mind_project')
sys.path.insert(0, project_dir)

if __name__ == '__main__':
    try:
        print("🧘 Inicializando Zen Mind...")
        
        # Importar a aplicação do route.py
        from route import app
        from app.config.settings import HOST, PORT, DEBUG
        from bottle import run
        
        # Corrigir HOST para localhost no Windows
        display_host = HOST if HOST != '0.0.0.0' else 'localhost'
        
        print("✨ Zen Mind iniciando...")
        print(f"📍 Servidor: http://{display_host}:{PORT}")
        print(f"📚 Helper: http://{display_host}:{PORT}/helper")
        print(f"🔑 Login: http://{display_host}:{PORT}/login")
        print("✨ Funcionalidades disponíveis:")
        print("   - Sistema de login/registro")
        print("   - CRUD de meditações")
        print("   - Fórum da comunidade")
        print("   - Dashboard personalizado")
        print("\n🚀 Pressione Ctrl+C para parar o servidor")
        print(f"🌐 Acesse no navegador: http://{display_host}:{PORT}")
        
        run(app, host=HOST, port=PORT, debug=DEBUG, reloader=DEBUG)
        
    except ImportError as e:
        print(f"❌ Erro ao importar módulos: {e}")
        print("💡 Certifique-se de que as dependências estão instaladas:")
        print("   pip install -r requirements.txt")
        sys.exit(1)
    except Exception as e:
        print(f"❌ Erro ao iniciar o servidor: {e}")
        sys.exit(1) 