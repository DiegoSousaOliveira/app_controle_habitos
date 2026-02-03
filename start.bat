@echo off
REM Script para inicializar a aplicação Flutter no Windows

echo.
echo ========================================
echo   Controle de Habitos - Flutter App
echo ========================================
echo.

echo [1/5] Limpando build anterior...
flutter clean
if %ERRORLEVEL% NEQ 0 (
    echo Erro ao limpar
    pause
    exit /b 1
)

echo [2/5] Obtendo dependências...
flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo Erro ao obter dependências
    pause
    exit /b 1
)

echo [3/5] Verificando saúde do ambiente...
flutter doctor -v
if %ERRORLEVEL% NEQ 0 (
    echo Aviso: Há problemas no ambiente. Verifique acima.
)

echo.
echo [4/5] Localizando dispositivos...
flutter devices

echo.
echo [5/5] Iniciando aplicação...
echo.
echo Certifique-se de que:
echo - Tem um emulador/dispositivo conectado
echo - A API FastAPI está rodando em http://localhost:8000
echo.
pause

flutter run

pause
