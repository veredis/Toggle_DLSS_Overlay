@echo off
echo Toggling PowerShell Execution Policy...
echo.

echo Current Execution Policy:
powershell -command "Get-ExecutionPolicy"
echo.

:: Toggle the execution policy
powershell -command "if ((Get-ExecutionPolicy) -eq 'Unrestricted') { Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Restricted -Force } else { Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force }"

echo New Execution Policy:
powershell -command "Get-ExecutionPolicy"
echo.

echo Execution Policy Toggled.
pause
