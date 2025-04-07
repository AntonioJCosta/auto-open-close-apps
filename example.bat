@echo off

REM Replace "ProjectName" with the name of the process you want to manage
set ProcessToSearch=ProjectName

REM Replace the path below with the actual path to your application
set AppFullPath=C:\Users\Username\AppData\Local\App\app.exe

REM Call the PowerShell script with the defined variables
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0app.ps1" -ProcessToSearch "%ProcessToSearch%" -AppFullPath "%AppFullPath%"
REM Sleep for 3 seconds to allow to see the output
REM This is optional and can be removed if not needed
timeout /t 3 >nul