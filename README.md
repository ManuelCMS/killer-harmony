# Parche de Traducción al Español - Danganronpa V3: Killing Harmony v2.2

Este repositorio contiene el script de instalación automática y los archivos correspondientes al parche de traducción al español para **Danganronpa V3: Killing Harmony** (versión de PC). 

> Esta traducción la hice yo solo, para mi comunidad en Youtube. Es mi primera traducción, y estaba originalmente pensada para mi propio uso y el de mi comunidad, comprendiendo que la calidad no es profesional. 

Lee el final de este documento para saber [cómo](#cómo-contribuir-al-proyecto) contribuir. Si descargaste una versión anterior del parche y tienes algún problema, revisa que no haya una versión más reciente. 
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
   * Presiona `S` (o `Enter`) para instalar la versión más reciente (**v1.2**).
   * Presiona `N` para instalar la versión previa (**v0.1**).
5. **Espera a que el proceso termine**:
   * El script extraerá y combinará los archivos `.cpk` de `data/win`. Este proceso puede tardar varios minutos dependiendo de tu disco.
   * A continuación, aplicará los archivos traducidos y limpiará los archivos temporales y `.cpk` originales.
6. Al finalizar, verás un mensaje de confirmación en verde indicando que el parche ha sido instalado correctamente. Presiona cualquier tecla para cerrar la consola y ya podrás iniciar el juego.

> **¿Ya tienes un parche anterior instalado?**
> Si los archivos `.cpk` originales ya no están presentes (porque fueron eliminados al aplicar un parche previo), el script lo detectará automáticamente y te preguntará si deseas omitir la extracción. Confirma con `S` (opción por defecto) y el instalador aplicará únicamente los nuevos archivos del parche sobre los datos ya extraídos, sin necesidad de volver a extraer nada.

---

## ℹ️ Información sobre las Versiones

* **Versión v0.1**:
  * Es la versión base que ya fue probada y jugada completamente en una serie de gameplays en YouTube en [mi canal](https://www.youtube.com/@killerkoiking).
* **Versiones más recientes (v1.0 y posteriores)**:
  * Incluyen revisiones ortográficas, mejoras en el formateo de texto, fuentes y correcciones de estilo.
  * *Nota*: Estas versiones no han sido probadas exhaustivamente de principio a fin, por lo que si encuentras algún detalle visual o error tipográfico, puedes reportarlo.

---
## Cómo contribuir al proyecto
¿Quieres apoyar a este proyecto? Si estás jugando la versión más reciente y encuentras un error, [Abre un ticket](https://github.com/ManuelCMS/killer-harmony/issues) para que lo vea. Necesitarás una cuenta de Github para ello, pero es gratis. De lo contrario, puedes seguirme en Youtube y dejar un comentario en el [video](https://youtu.be/kRzn5imhHJc) más reciente del parche, o escríbeme en [Twitter](https://x.com/killerkoikingtv). Ten en cuenta que mensajes y comentarios se pierden, entonces lo mejor es abrir el ticket aquí.

Si quieres hacer una corrección directa del parche, mira la segunda mitad de este [video](https://youtu.be/kRzn5imhHJc) o revisa la wiki de [Harmony Tools](https://github.com/redssu/Harmony-Tools). Puedes editar los textos y reempacar el parche, y yo revisaré los cambios antes de postearlos. 

¿Eres un artista y quieres ayudar a corregir las fuentes que no encajan al 100% en el juego, o los CGs? Abre un ticket, o sube los archivos correspondientes al parche y lo reviso. Si tienes dudas, pero de verdad quieres apoyar con esto, contáctame para que te ayude a hacerlo.

---

## 🛠️ Créditos y Agradecimientos

* Herramientas de extracción y empaquetado: [Harmony Tools](https://github.com/redssu/Harmony-Tools) por **redssu**.
* Proyecto y traducción hecha por mi cuenta, con ayuda de @blackhawk42 para trabajar con algunos archivos de texto.
