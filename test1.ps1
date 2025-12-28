# Если ярлык передал свой путь — он будет в $args[0]
if ($args.Count -gt 0 -and (Test-Path $args[0])) {
    $shortcutPath = (Resolve-Path $args[0]).Path
} else {
    $shortcutPath = "Ярлык не передал свой путь"
}

Write-Host "Путь ярлыка:" -ForegroundColor Cyan
Write-Host $shortcutPath -ForegroundColor Yellow

Read-Host -Prompt "Нажмите Enter для выхода"
