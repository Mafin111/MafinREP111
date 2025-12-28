# Вывести текущий рабочий путь и сделать паузу
$path = (Get-Location).Path
Write-Host "Текущий путь:" -ForegroundColor Cyan
Write-Host $path -ForegroundColor Yellow

Write-Host ""
Read-Host -Prompt "Нажмите Enter для выхода"
