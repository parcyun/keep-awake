$ErrorActionPreference = 'Stop'

$packageRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$installRoot = Join-Path $env:LOCALAPPDATA 'keep-awake'
$installedScript = Join-Path $installRoot 'keep_awake.ps1'
$startupRoot = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup'
$shortcutPath = Join-Path $startupRoot 'keep-awake.lnk'
$powershellPath = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'

New-Item -ItemType Directory -Force -Path $installRoot | Out-Null
Copy-Item -LiteralPath (Join-Path $packageRoot 'keep_awake.ps1') -Destination $installedScript -Force

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $powershellPath
$shortcut.Arguments = '-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "' + $installedScript + '"'
$shortcut.WorkingDirectory = $installRoot
$shortcut.Description = 'Keeps the display awake with periodic F15 activity'
$shortcut.Save()

Get-Process powershell -ErrorAction SilentlyContinue |
    Where-Object { $_.Path -eq $powershellPath } | Out-Null
Start-Process -FilePath $powershellPath -ArgumentList $shortcut.Arguments -WindowStyle Hidden

Write-Host 'Keep Awake installed and started.' -ForegroundColor Green
Write-Host ('Startup shortcut: ' + $shortcutPath)
Read-Host 'Press Enter to close'
