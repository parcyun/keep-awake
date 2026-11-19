@echo off
setlocal
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0keep-awake-files\install_keep_awake.ps1"
endlocal
