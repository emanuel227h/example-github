<#
PowerShell script para descargar imágenes en la carpeta `images/`.
- Usa LoremFlickr para obtener imágenes por etiqueta (marca y modelo).
- Ejecuta este script en tu máquina (Windows PowerShell 5.1 o PowerShell Core).

Instrucciones de uso:
1) Abre PowerShell en la carpeta del proyecto (donde está `index.html`).
2) Ejecuta: `scripts\download-images.ps1` (si no permite ejecución, ejecuta `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` y luego el script).

Nota: Las imágenes descargadas provienen de un servicio público (LoremFlickr). Revisa licencias y sustituye por tus propias imágenes si las usas comercialmente.
#>

$images = @{
    "images/audi-a6.jpg" = "https://loremflickr.com/1200/800/audi,a6,car"
    "images/bmw-m3.jpg" = "https://loremflickr.com/1200/800/bmw,m3,car"
    "images/mercedes-s-class.jpg" = "https://loremflickr.com/1200/800/mercedes,s-class,car"
    "images/tesla-model-s.jpg" = "https://loremflickr.com/1200/800/tesla,model-s,car"
    "images/toyota-corolla.jpg" = "https://loremflickr.com/1200/800/toyota,corolla,car"
    "images/ford-mustang.jpg" = "https://loremflickr.com/1200/800/ford,mustang,car"
}

# Crear carpeta images si no existe
$imgDir = Join-Path -Path (Get-Location) -ChildPath "images"
if(-not (Test-Path $imgDir)){
    New-Item -ItemType Directory -Path $imgDir | Out-Null
    Write-Host "Creada carpeta: $imgDir"
} else {
    Write-Host "Carpeta images ya existe: $imgDir"
}

foreach($path in $images.Keys){
    $url = $images[$path]
    try{
        Write-Host "Descargando $url -> $path"
        # Use Invoke-WebRequest; en PowerShell 5.1 puede necesitar -UseBasicParsing
        Invoke-WebRequest -Uri $url -OutFile $path -UseBasicParsing -ErrorAction Stop
        Write-Host "Guardado: $path"
    } catch {
        Write-Warning "Error descargando $url : $_"
    }
}

Write-Host "
Descarga finalizada. Abre index.html en tu navegador para verificar las imágenes.
Si quieres reemplazar alguna imagen por una propia, pon el archivo en images/ con el mismo nombre."