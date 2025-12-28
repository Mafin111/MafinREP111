# Определяем путь, где запущен скрипт
if ($MyInvocation.MyCommand.Path) {
    $scriptPath = $MyInvocation.MyCommand.Path
    $scriptDir  = Split-Path -Path $scriptPath -Parent
} elseif ($PSScriptRoot) {
    $scriptDir  = $PSScriptRoot
    $scriptPath = Join-Path $scriptDir (Split-Path -Leaf $MyInvocation.MyCommand.Path)
} else {
    $scriptDir  = (Get-Location).Path
    $scriptPath = $null
}

# Если скрипт запущен из файла — сформировать путь для .txt с тем же именем,
# иначе создать файл replaced_by_script.txt в текущей директории
if ($scriptPath) {
    $txtPath = [IO.Path]::ChangeExtension($scriptPath, '.txt')
} else {
    $txtPath = Join-Path $scriptDir 'replaced_by_script.txt'
}

# Записать в .txt слово "привет"
"привет" | Out-File -FilePath $txtPath -Encoding UTF8 -Force

# Если у нас есть путь к самому .ps1 — попытаться удалить/заменить его после выхода
if ($scriptPath) {
    # Команда, которую запустит фоновый PowerShell: подождать 1 секунду, затем удалить файл скрипта
    $delCommand = "Start-Sleep -Seconds 1; Remove-Item -LiteralPath '$scriptPath' -Force"

    # Запустить фоновый PowerShell, который выполнит удаление после завершения текущего процесса
    Start-Process -FilePath powershell -ArgumentList "-NoProfile","-WindowStyle","Hidden","-Command",$delCommand
}

# Сообщение и пауза (по желанию)
Write-Host "Скрипт определил директорию:" -ForegroundColor Cyan
Write-Host $scriptDir -ForegroundColor Yellow
Write-Host ""
Read-Host -Prompt "Нажмите Enter, чтобы завершить"
