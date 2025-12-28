# Определить путь скрипта; если скрипт запущен интерактивно, использовать текущую директорию
if ($PSScriptRoot) {
    $scriptDir = $PSScriptRoot
} elseif ($MyInvocation.MyCommand.Path) {
    $scriptDir = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
} else {
    $scriptDir = (Get-Location).Path
}

# Привести к полному пути и вывести сообщение
$fullPath = (Resolve-Path -Path $scriptDir).Path
Write-Host "Скрипт был запущен из директории:" -ForegroundColor Cyan
Write-Host $fullPath -ForegroundColor Yellow
