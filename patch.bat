@echo off
chcp 65001 >nul
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0patch.ps1"
set "PS_EXIT_CODE=%ERRORLEVEL%"

if %PS_EXIT_CODE% NEQ 0 (
    echo.
    echo Ocurrio un error durante la ejecucion (Codigo: %PS_EXIT_CODE%).
    echo.
    pause
)
