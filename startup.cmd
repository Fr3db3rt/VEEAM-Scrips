@:startup.cmd
@echo %0 running from %cd%

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'c:\scripts\updates\startup.ps1'"

pause
