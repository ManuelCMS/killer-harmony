# Script de instalacion para el parche de traduccion de Danganronpa V3: Killing Harmony.
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Desactivar QuickEdit Mode en la consola de Windows para evitar que clics pausen la ejecucion
try {
    $code = @'
    using System;
    using System.Runtime.InteropServices;
    public class ConsoleHelper {
        const uint ENABLE_QUICK_EDIT = 0x0040;
        const uint ENABLE_EXTENDED_FLAGS = 0x0080;
        const int STD_INPUT_HANDLE = -10;

        [DllImport("kernel32.dll", SetLastError = true)]
        static extern IntPtr GetStdHandle(int nStdHandle);

        [DllImport("kernel32.dll", SetLastError = true)]
        static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);

        [DllImport("kernel32.dll", SetLastError = true)]
        static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint dwMode);

        public static void DisableQuickEdit() {
            IntPtr handle = GetStdHandle(STD_INPUT_HANDLE);
            if (handle == IntPtr.Zero || handle == new IntPtr(-1)) return;
            uint mode;
            if (!GetConsoleMode(handle, out mode)) return;
            mode &= ~ENABLE_QUICK_EDIT;
            mode |= ENABLE_EXTENDED_FLAGS;
            SetConsoleMode(handle, mode);
        }
    }
'@
    Add-Type -TypeDefinition $code -ErrorAction SilentlyContinue
    [ConsoleHelper]::DisableQuickEdit()
} catch {
    # Continuar normalmente si no es una consola interactiva estandar
}

function Show-Header {
    Clear-Host
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "   Parche de Traduccion al Espanol - Danganronpa V3" -ForegroundColor Green
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
}

Show-Header

# Verificar que HarmonyTools este disponible
$harmonyCmd = Get-Command "HarmonyTools.exe" -ErrorAction SilentlyContinue
if (-not $harmonyCmd) {
    if (Test-Path ".\HarmonyTools.exe") {
        $harmonyExe = (Resolve-Path ".\HarmonyTools.exe").Path
    } elseif (Test-Path "C:\Harmony-Tools\HarmonyTools.exe") {
        $harmonyExe = "C:\Harmony-Tools\HarmonyTools.exe"
    } else {
        Write-Host "[ERROR] No se encontro HarmonyTools.exe en el sistema ni en el directorio actual." -ForegroundColor Red
        Write-Host "Por favor asegurate de tener HarmonyTools instalado o configurado en el PATH." -ForegroundColor Yellow
        Write-Host ""
        Read-Host "Presiona Enter para salir"
        exit 1
    }
} else {
    $harmonyExe = $harmonyCmd.Source
}

# Solicitar la ruta del juego
$defaultPath = "C:\SteamLibrary\steamapps\common\Danganronpa V3 Killing Harmony"

Write-Host "Introduce la ruta donde tienes instalado Danganronpa V3: Killing Harmony." -ForegroundColor Yellow
if (Test-Path $defaultPath) {
    Write-Host "Ruta por defecto detectada: $defaultPath" -ForegroundColor DarkGray
    Write-Host "(Presiona Enter para usar la ruta por defecto)" -ForegroundColor DarkGray
}

$gamePath = ""
while (-not $gamePath) {
    $inputPath = Read-Host "Ruta del juego"
    if ([string]::IsNullOrWhiteSpace($inputPath)) {
        if (Test-Path $defaultPath) {
            $gamePath = $defaultPath
        } else {
            Write-Host "[!] Debes introducir una ruta valida." -ForegroundColor Yellow
            continue
        }
    } else {
        $gamePath = $inputPath.Trim('"', "'", " ")
    }

    if (-not (Test-Path $gamePath)) {
        Write-Host "[ERROR] La ruta especificada no existe: '$gamePath'" -ForegroundColor Red
        $gamePath = ""
    }
}

# Comprobar la existencia del directorio data/win
$winDir = Join-Path $gamePath "data\win"

if (-not (Test-Path $winDir)) {
    Write-Host "[ERROR] No se encontro el directorio 'data\win' en la ruta proporcionada." -ForegroundColor Red
    Write-Host "Ruta buscada: $winDir" -ForegroundColor DarkRed
    Write-Host ""
    Read-Host "Presiona Enter para salir"
    exit 1
}

Write-Host ""
Write-Host "[+] Directorio del juego validado: $winDir" -ForegroundColor Green
Write-Host ""

# Seleccion de version del parche
Write-Host "------------------------------------------------------------" -ForegroundColor Cyan
Write-Host "¿Deseas instalar la version mas reciente (v1.2)? [S/N]" -ForegroundColor Yellow
Write-Host "  [S] Instalar version mas reciente (v1.2) - Sin probar" -ForegroundColor DarkGray
Write-Host "  [N] Instalar version anterior (v0.1) - Estable con errores de texto" -ForegroundColor DarkGray
Write-Host "------------------------------------------------------------" -ForegroundColor Cyan
$verInput = Read-Host "Opcion (Por defecto: S)"

if ([string]::IsNullOrWhiteSpace($verInput) -or $verInput -match "^[sSyY]") {
    $versionSeleccionada = "v1.2"
} else {
    $versionSeleccionada = "v0.1"
}

Write-Host "[+] Version seleccionada para instalacion: $versionSeleccionada" -ForegroundColor Green
Write-Host ""

# Lista de archivos CPK requeridos
$cpkFiles = @(
    "partition_data_win.cpk",
    "partition_data_win_us.cpk",
    "partition_resident_win.cpk"
)

# Verificar la presencia de los CPK
$missingCpk = @()
foreach ($cpk in $cpkFiles) {
    $fullPath = Join-Path $winDir $cpk
    if (-not (Test-Path $fullPath)) {
        $missingCpk += $cpk
    }
}

$parche_previo_instalado = $false

if ($missingCpk.Count -gt 0) {
    Write-Host "[ADVERTENCIA] No se encontraron los siguientes archivos CPK:" -ForegroundColor Yellow
    foreach ($cpk in $missingCpk) {
        Write-Host "  - $cpk" -ForegroundColor Red
    }
    Write-Host ""
    Write-Host "Esto puede deberse a que ya tienes un parche anterior instalado y los CPK ya fueron extraidos y eliminados." -ForegroundColor Cyan
    Write-Host "¿Ya tienes un parche previo instalado? Se omitira la extraccion y se aplicaran solo los archivos del parche. [S/N] (Por defecto: S): " -NoNewline -ForegroundColor Yellow
    $respPrevio = Read-Host
    if ([string]::IsNullOrWhiteSpace($respPrevio) -or $respPrevio -match "^[sSyY]") {
        $parche_previo_instalado = $true
        Write-Host "[+] Se omitira la extraccion de CPK. Solo se copiaran los archivos del parche." -ForegroundColor Green
    } else {
        Write-Host "Operacion cancelada por el usuario." -ForegroundColor Gray
        exit 0
    }
}

# -------------------------------------------------------------------------
# Control de ejecucion de extraccion
# -------------------------------------------------------------------------
$ejecutarExtraccion = -not $parche_previo_instalado

if ($ejecutarExtraccion) {
    # Confirmacion antes de extraer
    Write-Host "------------------------------------------------------------" -ForegroundColor Cyan
    Write-Host "Se procedera a extraer y fusionar los archivos CPK." -ForegroundColor Cyan
    Write-Host "ADVERTENCIA: Este proceso puede tardar varios minutos dependiendo de la velocidad de tu disco." -ForegroundColor Yellow
    Write-Host "Por favor, ten paciencia y NO cierres esta ventana mientras se realiza la extraccion." -ForegroundColor Yellow
    Write-Host "------------------------------------------------------------" -ForegroundColor Cyan
    Write-Host ""

    $originalLocation = Get-Location

    try {
        Set-Location -Path $winDir

        foreach ($cpk in $cpkFiles) {
            $cpkPath = Join-Path $winDir $cpk
            if (Test-Path $cpkPath) {
                Write-Host "============================================================" -ForegroundColor Cyan
                Write-Host "Extrayendo: $cpk..." -ForegroundColor Green
                Write-Host "Por favor espera, este proceso tomara un momento..." -ForegroundColor Yellow
                Write-Host "============================================================" -ForegroundColor Cyan
                
                $null | & $harmonyExe cpk extract -f $cpkPath
                
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "[+] Se ha extraido exitosamente: $cpk" -ForegroundColor Green
                } else {
                    Write-Host "[!] Error o codigo devuelto al extraer $cpk (Codigo: $LASTEXITCODE)" -ForegroundColor Yellow
                }
                Write-Host ""
            } else {
                Write-Host "[OMITIDO] El archivo $cpk no se encuentra en el directorio." -ForegroundColor DarkGray
            }
        }

        Write-Host "------------------------------------------------------------" -ForegroundColor Green
        Write-Host "[+] Proceso de extraccion completado." -ForegroundColor Green
        Write-Host "------------------------------------------------------------" -ForegroundColor Green
    }
    finally {
        Set-Location -Path $originalLocation
    }
} else {
    Write-Host "[INFO] Extraccion de archivos CPK omitida (modo pruebas activo)." -ForegroundColor DarkGray
}

if ($parche_previo_instalado) {
    Write-Host ""
    Write-Host "[INFO] Extraccion y fusion de CPK omitidas (parche previo detectado)." -ForegroundColor DarkGray
} else {
    # Mover y fusionar los contenidos de las carpetas extraidas a data/win
    # HarmonyTools extrae creando carpetas con nombres como: "<nombre>.cpk.decompressed" o "<nombre>"
    Write-Host ""
    Write-Host "Moviendo contenidos extraidos a la carpeta 'win'..." -ForegroundColor Cyan

    foreach ($cpk in $cpkFiles) {
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($cpk)
        
        # Lista de posibles nombres de carpetas de extraccion
        $posiblesCarpetas = @(
            "$cpk.decompressed",
            "$baseName.decompressed",
            $baseName
        )

        foreach ($folderName in $posiblesCarpetas) {
            $extractedFolder = Join-Path $winDir $folderName

            if (Test-Path $extractedFolder) {
                Write-Host "Moviendo archivos de '$folderName' a 'win'..." -ForegroundColor Gray
                
                # Recorrer todos los elementos de la carpeta extraida
                Get-ChildItem -Path $extractedFolder -Force | ForEach-Object {
                    $targetPath = Join-Path $winDir $_.Name
                    if ($_.PSIsContainer) {
                        # Si el subdirectorio no existe en win, crearlo
                        if (-not (Test-Path $targetPath)) {
                            New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
                        }
                        # Copiar todo el contenido recursivamente dentro del subdirectorio en win
                        Copy-Item -Path (Join-Path $_.FullName "*") -Destination $targetPath -Recurse -Force
                        # Borrar el subdirectorio de origen
                        Remove-Item -Path $_.FullName -Recurse -Force
                    } else {
                        # Si es un archivo, moverlo directamente sobrescribiendo si existe
                        Move-Item -Path $_.FullName -Destination $targetPath -Force
                    }
                }

                # Eliminar la carpeta extraida que ahora quedo vacia
                try {
                    Remove-Item -Path $extractedFolder -Recurse -Force -ErrorAction Stop
                    Write-Host "[+] Carpeta '$folderName' eliminada correctamente." -ForegroundColor Green
                } catch {
                    Write-Host "[!] Advertencia: No se pudo eliminar la carpeta '$folderName': $_" -ForegroundColor Yellow
                }
            }
        }
    }

    Write-Host ""
    Write-Host "La fase de extraccion y fusion ha finalizado correctamente." -ForegroundColor Cyan
}

# -------------------------------------------------------------------------
# Aplicar archivos del parche (Copiar y reemplazar desde ./<version>/win hacia data/win)
# -------------------------------------------------------------------------
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Aplicando archivos del parche de traduccion ($versionSeleccionada)..." -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan

$patchSourceDir = Join-Path (Join-Path $PSScriptRoot $versionSeleccionada) "win"
if (-not (Test-Path $patchSourceDir)) {
    # Si se ejecuta directamente desde la ruta de trabajo actual
    $patchSourceDir = ".\$versionSeleccionada\win"
}

if (Test-Path $patchSourceDir) {
    Write-Host "Copiando archivos modificados ($versionSeleccionada) a '$winDir'..." -ForegroundColor Gray
    
    # Obtener todos los archivos del parche y copiarlos manteniendo la estructura
    $patchFiles = Get-ChildItem -Path $patchSourceDir -Recurse -File
    $totalPatchFiles = $patchFiles.Count
    $copiedCount = 0

    foreach ($file in $patchFiles) {
        # Obtener ruta relativa respecto a la carpeta 'win' del parche de la version elegida
        $relativePath = $file.FullName.Substring((Resolve-Path $patchSourceDir).Path.Length).TrimStart('\', '/')
        $destinationFilePath = Join-Path $winDir $relativePath
        $destinationSubDir = Split-Path $destinationFilePath -Parent

        # Asegurarse de que el subdirectorio de destino exista
        if (-not (Test-Path $destinationSubDir)) {
            New-Item -ItemType Directory -Path $destinationSubDir -Force | Out-Null
        }

        # Copiar y reemplazar
        Copy-Item -Path $file.FullName -Destination $destinationFilePath -Force
        $copiedCount++
        Write-Host "  -> Instalado: $relativePath" -ForegroundColor DarkCyan
    }

    Write-Host ""
    Write-Host "[+] Se aplicaron con exito $copiedCount de $totalPatchFiles archivos del parche ($versionSeleccionada)." -ForegroundColor Green
} else {
    Write-Host "[ERROR] No se encontro la carpeta del parche en '$patchSourceDir'." -ForegroundColor Red
}

# -------------------------------------------------------------------------
# Eliminacion de archivos CPK originales
# -------------------------------------------------------------------------
$borrarCpkOriginales = $true

if ($borrarCpkOriginales) {
    Write-Host ""
    Write-Host "Limpiando archivos CPK originales..." -ForegroundColor Yellow
    foreach ($cpk in $cpkFiles) {
        $cpkPath = Join-Path $winDir $cpk
        if (Test-Path $cpkPath) {
            try {
                Remove-Item -Path $cpkPath -Force -ErrorAction Stop
                Write-Host "[+] Archivo eliminado: $cpk" -ForegroundColor Gray
            } catch {
                Write-Host "[!] No se pudo eliminar $cpk : $_" -ForegroundColor Red
            }
        }
    }
} else {
    # Write-Host "[INFO] Eliminacion de archivos CPK desactivada por ahora." -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "El proceso ha finalizado con exito." -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor Gray
$null = [System.Console]::ReadKey($true)

exit 0
