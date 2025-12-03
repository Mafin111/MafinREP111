# 1. Скачивание обоев
$imageUrl = "https://github.com/Mafin111/MafinREP111/raw/refs/heads/main/photo.jpg"
$imagePath = "C:\Users\Public\wallpaper.jpg"

try {
    # Используем Invoke-WebRequest для загрузки файла
    Invoke-WebRequest -Uri $imageUrl -OutFile $imagePath
    Write-Host "Обои успешно скачаны в: $imagePath"
} catch {
    Write-Host "Ошибка при скачивании обоев: $_"
    exit 1
}

# 2. Определение API-функции для установки обоев
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# 3. Мгновенная установка обоев
try {
    [Wallpaper]::SystemParametersInfo(20, 0, $imagePath, 0x01 -bor 0x02)
    Write-Host "Обои успешно установлены!"
} catch {
    Write-Host "Ошибка при установке обоев: $_"
}
