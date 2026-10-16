# 🪛 Montaje, diagnóstico y puesta a punto

Prácticas del 3º trimestre en el taller (desmontar y montar un PC completo, revisar el firmware y diagnosticar el equipo) y una presentación del 1º trimestre sobre optimización de Windows.

## 1. Desmontaje y montaje de un PC

Sobre un equipo de sobremesa del taller:

**Desmontaje**: disipador, disco duro, tornillos de la placa base, disquetera, fuente de alimentación y ventilador frontal.

**Montaje**, de lo más básico a lo accesorio:

1. **Fuera de la caja**, colocar la CPU en el zócalo (alineando la marca del pin 1) y los módulos de RAM en la placa.
2. Atornillar el ventilador frontal antes de meter la placa, para trabajar con más espacio.
3. Fijar la placa sobre los separadores (*standoffs*) de la caja.
4. **Pasta térmica** sobre la CPU y el disipador encima, bien atornillado.
5. Fuente de alimentación: conector **ATX de 24 pines** y **ATX12V** de la CPU. Con esto ya se puede hacer una primera prueba de encendido.
6. Unidades: disquetera y disco duro, cada uno con su cable de datos y el de alimentación.
7. Cables del panel frontal (encendido, *reset*, LED, USB y audio).

**Comprobación y averías**: si no hay imagen, lo primero es revisar el cable de vídeo y desconectar y reconectar los cables internos. Si el equipo emite **pitidos** al arrancar, la secuencia (de 1 a 12 pitidos según el fabricante de la BIOS) indica qué componente falla en el POST: RAM, gráfica, CPU…

**Sistema operativo**: desde un **pendrive de arranque** con la ISO de Windows 10, eligiéndolo en el menú de arranque del firmware (<kbd>F12</kbd> en ese equipo) o subiéndolo en la secuencia de arranque.

## 2. Firmware: BIOS o UEFI

En la configuración del firmware del equipo montado se comprobó el tipo (BIOS heredada o UEFI), el fabricante, la versión y la **secuencia de arranque** (USB, disco duro y unidad óptica, en ese orden). Conviene comparar la versión con la última publicada por el fabricante para saber si hay actualizaciones.

## 3. Herramientas de diagnóstico

| Categoría | Herramienta | Licencia |
|---|---|---|
| Información y diagnóstico de hardware | AIDA64 Extreme | Propietaria, con prueba de 30 días |
| | HWiNFO | Gratuita |
| | CPU-Z | Gratuita |
| Pruebas de estrés y del procesador | Prime95 | Gratuita |
| | Intel Processor Diagnostic Tool | Gratuita |
| Disco duro | CrystalDiskInfo | Libre (MIT) |
| | HDDScan | Gratuita |
| | HD Tune | Propietaria; versión básica gratuita |
| Memoria RAM | Diagnóstico de memoria de Windows | Incluida en Windows |
| | MemTest86 / Memtest86+ | Gratuita / Libre (GPL) |
| | RAMMon | Gratuita |

> "Gratuita" no es lo mismo que "libre": HWiNFO o CPU-Z no cuestan nada, pero no se puede acceder a su código ni redistribuirlo modificado.

### Análisis con AIDA64

Con AIDA64 se generó un informe del equipo de prácticas y se localizó cada dato en su apartado:

- **Procesador**: fabricante, núcleos, multiplicador máximo, uso y juegos de instrucciones soportados.
- **Caché** por niveles, **placa base** (ancho y velocidad real y efectiva del bus), **chipset** (controlador de memoria, latencia CAS) y **BIOS** (tipo, versión y fecha).
- **Temperaturas** de la CPU y de cada núcleo.
- **Almacenamiento**: unidades, interfaz, particiones y unidades lógicas.
- **Tarjetas** gráfica, de sonido y de red, con la MAC y la configuración IP.
- **Sistema operativo**: versión, procesos, programas instalados, programas de inicio, puertos disponibles, tiempo encendido y antivirus.
- **Pruebas de rendimiento** (*benchmarks*) de memoria y procesador comparadas con otros equipos de referencia.

> Algunos de estos datos (clave de producto, números de serie, MAC) identifican un equipo concreto, y por eso no se reproducen aquí.

## 4. Presentación: optimizar Windows

Presentación del 1º trimestre con consejos de **rendimiento**, **limpieza** y **seguridad**:

| Área | Consejo | Cómo |
|---|---|---|
| Rendimiento | Reducir animaciones visuales | `sysdm.cpl` › *Opciones avanzadas* › *Rendimiento* |
| Rendimiento | Ajustar el plan de energía | *Opciones de energía* |
| Rendimiento | Revisar el arranque | `msconfig` › *Arranque* (por ejemplo, arranque sin GUI) |
| Rendimiento | Quitar aplicaciones preinstaladas | Desinstalación desde *Configuración* o con desinstaladores que limpian restos |
| Seguridad | Mantener las aplicaciones actualizadas | `winget upgrade --all` |
| Seguridad | Antivirus sí o no | Depende del usuario: comparar en AV-TEST y, en todo caso, analizar ficheros dudosos en VirusTotal |
| Limpieza | Borrar temporales | `%temp%` y `C:\Windows\Temp`, después de crear un **punto de restauración** |
| Limpieza | Navegador | Borrar datos periódicamente y no abusar de las extensiones |

Y una comparativa de navegadores por velocidad (Edge, Chrome, Firefox), privacidad (Brave, DuckDuckGo, Tor) y personalización (Opera GX).
