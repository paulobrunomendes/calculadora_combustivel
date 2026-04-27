@echo off
chcp 65001 >nul
call :main
pause
exit /b

:main
echo ================================================
echo   Controle de Combustivel - Diagnostico
echo ================================================
echo.

cd /d "%~dp0.." 2>nul

call "%~dp0_flutter_path.bat"
if %FLUTTER_FOUND% EQU 0 exit /b 1

echo.
echo Executando flutter doctor...
echo (Mostra o estado do ambiente de desenvolvimento)
echo.
"%FLUTTER_EXE%" doctor -v

echo.
echo ================================================
echo   Dispositivos disponiveis:
echo ================================================
"%FLUTTER_EXE%" devices
exit /b 0
