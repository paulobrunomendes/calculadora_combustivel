@echo off
chcp 65001 >nul
call :main
pause
exit /b

:main
echo ================================================
echo   Controle de Combustivel - Build APK Release
echo ================================================
echo.

cd /d "%~dp0.." 2>nul

call "%~dp0_flutter_path.bat"
if %FLUTTER_FOUND% EQU 0 exit /b 1

echo.
echo Compilando APK de release (otimizado)...
"%FLUTTER_EXE%" build apk --release

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ================================================
    echo   BUILD CONCLUIDO COM SUCESSO!
    echo ================================================
    echo.
    echo APK gerado em:
    echo   build\app\outputs\flutter-apk\app-release.apk
    echo.
    echo Abrindo pasta do APK...
    explorer build\app\outputs\flutter-apk
) else (
    echo.
    echo ERRO durante o build. Verifique os logs acima.
)
exit /b 0
