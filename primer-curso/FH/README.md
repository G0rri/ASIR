# 🖥️ FH · Fundamentos de Hardware

Del funcionamiento interno de un ordenador al diseño de una sala de servidores: arquitectura de computadores, identificación de componentes en el taller, montaje de equipos, diagnóstico, SAI y RAID.

## Documentación

| Guía | Contenido | Trimestre |
|---|---|---|
| [Arquitectura de computadores](arquitectura-de-computadores.md) | Von Neumann, buses y direccionamiento, jerarquía de memoria, MIPS, ciclo de instrucción paso a paso y modos de direccionamiento | 1º |
| [Componentes internos](componentes-internos.md) | Placa base, zócalos, fuente de alimentación (con mediciones reales), cajas, refrigeración, HDD, discos ópticos, SSD e interfaces, periféricos | 2º |
| [Montaje, diagnóstico y puesta a punto](montaje-y-diagnostico.md) | Desmontaje y montaje de un PC, BIOS/UEFI, herramientas de diagnóstico, AIDA64 y optimización de Windows | 1º y 3º |
| [CPD, SAI y RAID](cpd-sai-y-raid.md) | Diseño y presupuesto de una sala de servidores, SAI con ViewPower y NUT, RAID 5 con `mdadm`, discos en caliente e inventario de hardware | 3º |

## Prácticas

| Trimestre | Práctica | Qué se hizo |
|---|---|---|
| 1º | Arquitectura de Von Neumann | Cuestionarios sobre unidades funcionales, buses, caché y rendimiento |
| 1º | Ejecución de instrucciones | Simulación registro a registro (PC, IR, MAR, MDR, AC) de cuatro programas |
| 1º | Presentación "Toqueteando Windows" | Consejos de rendimiento, limpieza y seguridad |
| 2º | Placa base | Identificación de los componentes de dos placas (Intel LGA1151 y AMD AM4) |
| 2º | Zócalos | Identificación del zócalo de dos placas antiguas del taller |
| 2º | Fuente de alimentación | Conectores, etapas internas y medición de tensiones con polímetro (en pareja) |
| 2º | Cajas | Caja del aula frente a la de casa y catálogo de once formatos de caja |
| 2º | Refrigeración | Trabajo sobre refrigeración por aire, líquida e inmersión |
| 2º | Discos duros y SSD | Partes físicas y lógicas de un HDD desmontado, CHS, ópticos, interfaces y formatos M.2 |
| 2º | Periféricos | Ficha técnica de diez dispositivos |
| 3º | Montaje de un PC | Desmontaje y montaje completo, POST e instalación de Windows 10 |
| 3º | Parámetros hardware y software | Revisión del firmware y diagnóstico con AIDA64 y otras herramientas |
| 3º | SAI y RAID | SAI por USB en Windows y Linux, RAID 5 con `mdadm` y prueba de fallo de disco |
| 3º | CPD | Presupuesto de una sala de servidores, disco en caliente e inventario de hardware |

## Aspectos destacados

- **Mediciones reales** de una fuente ATX comparadas con las tolerancias de la norma.
- **RAID 5 por software** montado desde cero, con prueba de fallo de un disco y recuperación.
- **SAI gestionado en tres entornos**: Windows, Ubuntu Desktop y Ubuntu Server con NUT.
- Cálculos comprobados: capacidad direccionable, CHS (el límite de 504 MiB), tasas SATA y velocidad de un DVD.
