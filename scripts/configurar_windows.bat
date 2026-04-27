@echo off
chcp 65001 >nul
call :main
pause
exit /b

:main
echo ================================================
echo   Controle de Combustivel - Configurar Windows
echo ================================================
echo.

:: Verifica se ja tem Flutter
where flutter >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Flutter ja esta instalado!
    flutter --version
    exit /b 0
)

:: Verifica se winget esta disponivel
where winget >nul 2>&1
if %ERRORLEVEL% NEQ 0 goto :sem_winget

echo Procurando Flutter no winget...
echo.

:: Tenta IDs conhecidos do Flutter no winget
winget install --id Flutter.Flutter -e --accept-source-agreements --accept-package-agreements >nul 2>&1
if %ERRORLEVEL% EQU 0 goto :sucesso

winget install --id Google.Flutter -e --accept-source-agreements --accept-package-agreements >nul 2>&1
if %ERRORLEVEL% EQU 0 goto :sucesso

:: winget nao encontrou, tenta Chocolatey
where choco >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Instalando via Chocolatey...
    choco install flutter -y
    if %ERRORLEVEL% EQU 0 goto :sucesso
)

:sem_winget
echo.
echo Nao foi possivel instalar automaticamente.
echo.
echo +----------------------------------------------------------+
echo ^|         INSTALE O FLUTTER MANUALMENTE                   ^|
echo +----------------------------------------------------------+
echo ^|                                                          ^|
echo ^|  1. Abra o link abaixo no navegador:                    ^|
echo ^|     https://flutter.dev/releases                        ^|
echo ^|                                                          ^|
echo ^|  2. Baixe o ZIP da versao Stable para Windows           ^|
echo ^|                                                          ^|
echo ^|  3. Extraia em: C:\src\flutter                          ^|
echo ^|     (crie a pasta src em C:\ se nao existir)            ^|
echo ^|                                                          ^|
echo ^|  4. Adicione C:\src\flutter\bin ao PATH:                ^|
echo ^|     - Tecla Windows + R, digite: sysdm.cpl              ^|
echo ^|     - Aba "Avancado" > "Variaveis de Ambiente"          ^|
echo ^|     - Em "Path" clique em Editar > Novo                 ^|
echo ^|     - Digite: C:\src\flutter\bin                        ^|
echo ^|     - OK em tudo e abra um novo CMD                     ^|
echo ^|                                                          ^|
echo ^|  5. Rode: scripts\diagnostico.bat                       ^|
echo ^|                                                          ^|
echo +----------------------------------------------------------+
exit /b 1

:sucesso
echo.
echo ================================================
echo   Flutter instalado com sucesso!
echo ================================================
echo.
echo IMPORTANTE: Feche este CMD, abra um NOVO e rode:
echo   scripts\diagnostico.bat
exit /b 0
