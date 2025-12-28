# Определить директорию запуска скрипта
if ($MyInvocation.MyCommand.Path) {
    $scriptDir = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
} elseif ($PSScriptRoot) {
    $scriptDir = $PSScriptRoot
} else {
    $scriptDir = (Get-Location).Path
}

# Получить полный путь и вывести его
$fullPath = (Resolve-Path -Path $scriptDir).Path
Write-Host "Текущий путь:" -ForegroundColor Cyan
Write-Host $fullPath -ForegroundColor Yellow

# Остановиться и ждать нажатия Enter
Write-Host ""
Read-Host -Prompt "Нажмите Enter для продолжения"
