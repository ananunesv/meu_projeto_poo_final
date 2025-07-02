#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
🧘 Zen Mind - Script de Configuração e Execução
"""

import os
import sys
import subprocess
import platform

def clear_screen():
    """Limpa a tela do terminal"""
    os.system('cls' if platform.system() == 'Windows' else 'clear')

def print_banner():
    """Exibe o banner do projeto"""
    print("=" * 60)
    print("🧘 ZEN MIND - PLATAFORMA DE MEDITAÇÃO")
    print("=" * 60)
    print("🔧 Script de Configuração e Execução")
    print("📚 Projeto de Orientação a Objetos - UnB 2025.1")
    print("=" * 60)
    print()

def check_python_version():
    """Verifica a versão do Python"""
    version = sys.version_info
    if version.major < 3 or (version.major == 3 and version.minor < 7):
        print("❌ Erro: Python 3.7+ é necessário")
        print(f"   Versão atual: {version.major}.{version.minor}.{version.micro}")
        return False
    print(f"✅ Python {version.major}.{version.minor}.{version.micro} - OK")
    return True

def install_requirements():
    """Instala as dependências do projeto"""
    try:
        print("📦 Instalando dependências...")
        subprocess.check_call([
            sys.executable, "-m", "pip", "install", "-r", "requirements.txt"
        ])
        print("✅ Dependências instaladas com sucesso!")
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Erro ao instalar dependências: {e}")
        return False

def check_project_structure():
    """Verifica se a estrutura do projeto está correta"""
    required_paths = [
        "zen_mind_project",
        "zen_mind_project/app",
        "zen_mind_project/route.py",
        "main.py",
        "requirements.txt"
    ]
    
    missing = []
    for path in required_paths:
        if not os.path.exists(path):
            missing.append(path)
    
    if missing:
        print("❌ Estrutura do projeto incompleta:")
        for path in missing:
            print(f"   - {path} não encontrado")
        return False
    
    print("✅ Estrutura do projeto - OK")
    return True

def run_application():
    """Executa a aplicação"""
    try:
        print("🚀 Iniciando Zen Mind...")
        print("   (Use Ctrl+C para parar o servidor)")
        print()
        
        # Executar main.py
        subprocess.run([sys.executable, "main.py"])
        
    except KeyboardInterrupt:
        print("\n👋 Zen Mind encerrado pelo usuário")
    except Exception as e:
        print(f"❌ Erro ao executar aplicação: {e}")

def main():
    """Função principal"""
    clear_screen()
    print_banner()
    
    # Verificações
    if not check_python_version():
        input("Pressione Enter para sair...")
        return
    
    if not check_project_structure():
        input("Pressione Enter para sair...")
        return
    
    # Instalação
    if not install_requirements():
        input("Pressione Enter para sair...")
        return
    
    print()
    print("🎉 Configuração concluída com sucesso!")
    print()
    
    # Executar
    try:
        response = input("Deseja executar o Zen Mind agora? (s/N): ").lower()
        if response in ['s', 'sim', 'y', 'yes']:
            print()
            run_application()
        else:
            print("💡 Para executar manualmente, use: python main.py")
    except KeyboardInterrupt:
        print("\n👋 Setup cancelado pelo usuário")

if __name__ == "__main__":
    main() 