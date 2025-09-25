param(
  [string]$Venv = ".venv-modbus"
)
$ErrorActionPreference = "Stop"
Write-Host "=== Modbus-MCP Windows Installer ===" -ForegroundColor Cyan
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$venv = Join-Path $root $Venv

# Ensure Python 3.13 via uv if available
$uv = "$env:APPDATA\Python\Python311\Scripts\uv.exe"
if (-not (Test-Path $uv)) { $uv = "$env:LOCALAPPDATA\Programs\Python\Python311\Scripts\uv.exe" }
if (Test-Path $uv) {
  & $uv python install 3.13.0 | Out-Null
  & $uv venv --python 3.13.0 $venv | Out-Null
} else {
  & python -m venv $venv | Out-Null
}

$py = Join-Path $venv 'Scripts/python.exe'
& $py -m ensurepip --upgrade | Out-Null
& $py -m pip install --upgrade pip | Out-Null

Write-Host "Installing modbus-mcp (editable)" -ForegroundColor Green
& $py -m pip install -e $root | Out-Null

Write-Host "Done. Activate venv: $venv\Scripts\activate" -ForegroundColor Cyan
Write-Host "Run stdio entry: `n  $py -m modbus_mcp.windows_stdio_entry" -ForegroundColor DarkCyan
