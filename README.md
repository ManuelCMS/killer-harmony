# Parche de Traducción al Español - Danganronpa V3: Killing Harmony

Este repositorio contiene el script de instalación automática y los archivos correspondientes al parche de traducción al español para **Danganronpa V3: Killing Harmony** (versión de PC / Steam).

---

## 📌 Requisitos Previos

Antes de ejecutar el script de instalación, necesitas contar con lo siguiente:

1. **Danganronpa V3: Killing Harmony** instalado en tu PC (vía Steam u otra plataforma en Windows).
2. **Harmony Tools** instalado y accesible en tu sistema:
   * Repositorio oficial y descargas: [Harmony-Tools en GitHub](https://github.com/redssu/Harmony-Tools).
   * Asegúrate de tener `HarmonyTools.exe` agregado a las variables de entorno (`PATH`) o ubicado en su ruta por defecto (`C:\Harmony-Tools\HarmonyTools.exe`).

---

## 🚀 Instrucciones de Instalación

1. **Descarga o clona este repositorio** en cualquier carpeta de tu ordenador.
2. Haz **doble clic en `patch.bat`** (o ejecuta `patch.ps1` desde PowerShell como Administrador).
3. **Introduce la ruta de instalación del juego** cuando el script te lo solicite:
   * Ejemplo de ruta habitual: `C:\Program Files (x86)\Steam\steamapps\common\Danganronpa V3 Killing Harmony`
   * Si el script detecta automáticamente tu instalación, puedes simplemente presionar `Enter`.
4. **Selecciona la versión del parche** que deseas instalar:
   * Presiona `S` (o `Enter`) para instalar la versión más reciente (**v1.0**).
   * Presiona `N` para instalar la versión previa (**v0.1**).
5. **Espera a que el proceso termine**:
   * El script extraerá y combinará los archivos `.cpk` de `data/win`. Este proceso puede tardar varios minutos dependiendo de tu disco.
   * A continuación, aplicará los archivos traducidos y limpiará los archivos temporales y `.cpk` originales.
6. Al finalizar, verás un mensaje de confirmación en verde indicando que el parche ha sido instalado correctamente. Presiona cualquier tecla para cerrar la consola y ya podrás iniciar el juego.

---

## ℹ️ Información sobre las Versiones

* **Versión v0.1**:
  * Es la versión base que ya fue probada y jugada completamente en una serie de gameplays en YouTube: [Enlace a la serie de videos de YouTube](LINK_AQUI).
* **Versiones más recientes (v1.0 y posteriores)**:
  * Incluyen revisiones ortográficas, mejoras en el formateo de texto, fuentes y correcciones de estilo.
  * *Nota*: Estas versiones no han sido probadas exhaustivamente de principio a fin, por lo que si encuentras algún detalle visual o error tipográfico, puedes reportarlo.

---

## 🛠️ Créditos y Agradecimientos

* Herramientas de extracción y empaquetado: [Harmony Tools](https://github.com/redssu/Harmony-Tools) por **redssu**.
* Proyecto y traducción al español por la comunidad.
