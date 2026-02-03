#!/bin/bash

# Script para inicializar a aplicação Flutter no Linux/macOS

echo ""
echo "========================================"
echo "  Controle de Habitos - Flutter App"
echo "========================================"
echo ""

echo "[1/5] Limpando build anterior..."
flutter clean
if [ $? -ne 0 ]; then
    echo "Erro ao limpar"
    exit 1
fi

echo "[2/5] Obtendo dependências..."
flutter pub get
if [ $? -ne 0 ]; then
    echo "Erro ao obter dependências"
    exit 1
fi

echo "[3/5] Verificando saúde do ambiente..."
flutter doctor -v
if [ $? -ne 0 ]; then
    echo "Aviso: Há problemas no ambiente. Verifique acima."
fi

echo ""
echo "[4/5] Localizando dispositivos..."
flutter devices

echo ""
echo "[5/5] Iniciando aplicação..."
echo ""
echo "Certifique-se de que:"
echo "- Tem um emulador/dispositivo conectado"
echo "- A API FastAPI está rodando em http://localhost:8000"
echo ""

flutter run
