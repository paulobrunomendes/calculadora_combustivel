@echo off
:: Script auxiliar - detecta o Flutter SDK automaticamente
:: Chamado pelos outros scripts via: call _flutter_path.bat

set FLUTTER_EXE=

:: 1. Tenta pelo PATH do sistema
where flutter >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set FLUTTER_EXE=flutter
    goto :found
)

:: 2. Locais comuns de instalacao no Windows
set LOCATIONS=^
C:\src\flutter\bin\flutter.bat ^
C:\flutter\bin\flutter.bat ^
C:\tools\flutter\bin\flutter.bat ^
%LOCALAPPDATA%\flutter\bin\flutter.bat ^
%USERPROFILE%\flutter\bin\flutter.bat ^
%USERPROFILE%\development\flutter\bin\flutter.bat ^
C:\dev\flutter\bin\flutter.bat ^
D:\flutter\bin\flutter.bat ^
D:\src\flutter\bin\flutter.bat

for %%F in (%LOCATIONS%) do (
    if exist "%%F" (
        set FLUTTER_EXE=%%F
        goto :found
    )
)

:: 3. Busca em subpastas de C:\src e C:\tools
for /d %%D in (C:\src\* C:\tools\* D:\src\* D:\tools\*) do (
    if exist "%%D\bin\flutter.bat" (
        set FLUTTER_EXE=%%D\bin\flutter.bat
        goto :found
    )
)

:: Nao encontrou
echo.
echo +----------------------------------------------------------+
echo ^|          FLUTTER NAO ENCONTRADO NO SISTEMA              ^|
echo +----------------------------------------------------------+
echo ^|                                                          ^|
echo ^|  Para instalar o Flutter no Windows:                    ^|
echo ^|                                                          ^|
echo ^|  OPCAO 1 - Instalador oficial (recomendado):            ^|
echo ^|    https://docs.flutter.dev/get-started/install/windows ^|
echo ^|                                                          ^|
echo ^|  OPCAO 2 - Manual:                                      ^|
echo ^|    1. Baixe o ZIP em: https://flutter.dev/releases      ^|
echo ^|    2. Extraia em C:\src\flutter                         ^|
echo ^|    3. Adicione C:\src\flutter\bin ao PATH:              ^|
echo ^|       Painel de Controle ^> Sistema ^> Variaveis de      ^|
echo ^|       Ambiente ^> Path ^> Novo ^> C:\src\flutter\bin     ^|
echo ^|    4. Abra um novo CMD e rode: flutter doctor            ^|
echo ^|                                                          ^|
echo ^|  OPCAO 3 - Via winget (Windows Package Manager):        ^|
echo ^|    winget install Google.Flutter                         ^|
echo ^|                                                          ^|
echo +----------------------------------------------------------+
echo.
set FLUTTER_FOUND=0
exit /b 1

:found
echo [Flutter encontrado]: %FLUTTER_EXE%
set FLUTTER_FOUND=1
exit /b 0
