@echo off
chcp 65001 >nul
call :main
pause
exit /b

:main
echo ================================================
echo   Controle de Combustivel - Setup Completo
echo ================================================
echo.

cd /d "%~dp0.." 2>nul

call "%~dp0_flutter_path.bat"
if %FLUTTER_FOUND% EQU 0 exit /b 1

echo.
echo [1/3] Instalando dependencias...
"%FLUTTER_EXE%" pub get
if %ERRORLEVEL% NEQ 0 (
    echo ERRO ao instalar dependencias.
    exit /b 1
)
echo.

echo [2/3] Verificando dispositivos...
"%FLUTTER_EXE%" devices
echo.

echo [3/3] Iniciando o app...
echo (Certifique-se de ter um dispositivo conectado ou emulador ativo)
echo.
"%FLUTTER_EXE%" run
exit /b 0
