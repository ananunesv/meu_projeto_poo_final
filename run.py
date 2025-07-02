#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
🧘 Zen Mind - Script de Execução Rápida
Alternativa para executar o projeto
"""

import sys
import os

def main():
    """Execução direta do projeto"""
    print("🧘 Zen Mind - Execução Rápida")
    print("=" * 40)
    
    # Verificar se main.py existe
    if not os.path.exists("main.py"):
        print("❌ Arquivo main.py não encontrado!")
        print("💡 Certifique-se de estar no diretório correto do projeto")
        return
    
    # Executar main.py
    try:
        print("🚀 Iniciando aplicação...")
        os.system(f"{sys.executable} main.py")
    except KeyboardInterrupt:
        print("\n👋 Aplicação encerrada")
    except Exception as e:
        print(f"❌ Erro: {e}")

if __name__ == "__main__":
    main() 