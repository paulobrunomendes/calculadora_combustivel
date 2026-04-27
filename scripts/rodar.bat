@echo off
chcp 65001 >nul
call :main
pause
exit /b

:main
echo ================================================
echo   Controle de Combustivel - Rodar App
echo ================================================
echo.

cd /d "%~dp0.." 2>nul

call "%~dp0_flutter_path.bat"
if %FLUTTER_FOUND% EQU 0 exit /b 1

echo.
echo Dispositivos conectados:
"%FLUTTER_EXE%" devices
echo.

echo Iniciando o app...
echo (Conecte um dispositivo Android ou inicie um emulador antes)
echo.
"%FLUTTER_EXE%" run
exit /b 0
