@echo off
chcp 65001 >nul
call :main
pause
exit /b

:main
echo ================================================
echo   Controle de Combustivel - Instalar Dependencias
echo ================================================
echo.

cd /d "%~dp0.." 2>nul

call "%~dp0_flutter_path.bat"
if %FLUTTER_FOUND% EQU 0 exit /b 1

echo.
echo Instalando dependencias (flutter pub get)...
"%FLUTTER_EXE%" pub get

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Dependencias instaladas com sucesso!
) else (
    echo.
    echo ERRO ao instalar dependencias.
)
exit /b 0
