# 🔧 Componentes internos del ordenador

Prácticas del 2º trimestre: identificar y entender cada componente, casi siempre con el hardware delante en el taller.

## Índice

1. [Placa base](#1-placa-base)
2. [Zócalos del procesador](#2-zócalos-del-procesador)
3. [Fuente de alimentación](#3-fuente-de-alimentación)
4. [Cajas](#4-cajas)
5. [Refrigeración](#5-refrigeración)
6. [Discos duros y almacenamiento óptico](#6-discos-duros-y-almacenamiento-óptico)
7. [SSD e interfaces](#7-ssd-e-interfaces)
8. [Periféricos](#8-periféricos)

## 1. Placa base

Identificación de componentes en dos placas: una ASUS con **zócalo LGA1151** (Intel Core de 8.ª y 9.ª generación) y una Gigabyte de la serie **B350 Gaming 3** con chipset **AMD B350** y zócalo **AM4**, ambas ATX con memoria **DDR4**.

| Elemento | Función |
|---|---|
| Zócalo (*socket*) | Aloja el procesador; determina qué CPU son compatibles |
| Chipset | Gestiona la comunicación entre CPU, memoria, almacenamiento y periféricos |
| Ranuras DIMM | Módulos de RAM (DDR4 en ambas placas) |
| ATX 24 pines y ATX12V/EPS 4-8 pines | Alimentación general y del procesador |
| CPU_FAN / CHA_FAN | Ventilador del disipador y de la caja |
| PCIe x16 / x1 | Tarjetas de expansión (gráfica, red…) |
| SATA 6 Gb/s y M.2 | Unidades de almacenamiento |
| Cabeceras USB 2.0 / USB 3.x | Puertos USB del panel frontal |
| F_PANEL | Botón de encendido, *reset* y LED de la caja |
| AAFP | Audio de alta definición del panel frontal |
| SPEAKER | Altavoz interno de avisos (pitidos del POST) |
| CLR_CMOS / CLRTC | Restablece la configuración de la BIOS a los valores de fábrica |
| TPM | Módulo de plataforma segura (claves, cifrado de disco, Windows 11) |
| CHASSIS | Detector de apertura de la caja |
| COM | Puerto serie heredado |
| M.2 Wi-Fi (clave E) | Tarjeta inalámbrica |
| Condensadores y VRM | Estabilizan y regulan la tensión que llega a la CPU |
| Panel trasero (I/O) | Conectores accesibles desde fuera de la caja |

## 2. Zócalos del procesador

Métodos para identificar el zócalo: la **serigrafía** de la placa, el **modelo** buscado en la web del fabricante, el **manual** y programas como **CPU-Z** (en un equipo que arranque).

Práctica con dos placas antiguas del taller, identificadas por el modelo serigrafiado:

| Placa | Zócalo | Procesadores |
|---|---|---|
| Gigabyte 8I845GVM-RZ | Socket 478 | Pentium 4 con Hyper-Threading |
| Gigabyte GA-8I945GMF | LGA775 | Pentium 4, Pentium D y Core 2 |

## 3. Fuente de alimentación

Práctica por parejas con una fuente **ATX de 530 W** sin selector de tensión ni certificación 80 PLUS.

**Etapas**: transformación (fusible, filtro de red y transformador) → rectificación (de alterna a continua) → filtrado (condensadores) → estabilización (regulador de tensión).

**Conectores**: ATX de 24 pines (placa base), ATX12V de 4 pines (CPU), SATA de 15 pines (discos) y Molex de 4 pines (discos antiguos y ventiladores).

**Prueba de encendido**: puenteando el cable **verde** (PS_ON) con un **negro** (masa) del conector de 24 pines, la fuente arranca sin placa base.

**Mediciones con polímetro**, todas dentro de la tolerancia de la norma ATX:

| Color | Línea | Nominal | Medido | Tolerancia |
|---|---|---:|---:|---|
| 🟠 Naranja | +3,3 V | 3,30 V | 3,29 V | ±5 % |
| 🔴 Rojo | +5 V | 5,00 V | 5,13 V | ±5 % |
| 🟡 Amarillo | +12 V | 12,00 V | 11,93 V | ±5 % |
| 🔵 Azul | −12 V | −12,00 V | −11,76 V | ±10 % |
| 🟣 Morado | +5 V *standby* | 5,00 V | 4,93 V | ±5 % |
| ⚫ Negro | Masa | 0 V | 0 V | — |

El cable **gris** (*Power Good*) indica que las tensiones son estables: debe marcar unos +5 V cuando la fuente está lista.

## 4. Cajas

| Formato | Uso típico |
|---|---|
| Microtorre / minitorre | Placas Mini-ITX y Micro-ATX, equipos compactos |
| Semitorre | La más común en sobremesa: admite ATX y deja sitio para refrigeración |
| Torre / gran torre | E-ATX, muchas bahías y ventiladores, estaciones de trabajo |
| Sobremesa y *slim* | Horizontales o delgadas, para oficina o multimedia (HTPC) |
| Mini PC / *barebone* | Equipo casi completo en muy poco espacio (tipo NUC) |
| Servidor y *rack* | Formatos de 19" medidos en unidades (U), para CPD |
| TPV | Terminal punto de venta: equipo, pantalla y periféricos de cobro integrados |

En la práctica se analizaron la caja del aula y la de un equipo doméstico: factor de forma, bahías internas y externas, ubicación y potencia de la fuente, anclajes de placa, ranuras de expansión, panel frontal, ventilación y materiales. La diferencia más clara estuvo en la refrigeración: la caja del aula solo tenía un ventilador trasero y ninguna entrada de aire, frente a cuatro ventiladores con flujo frontal en la doméstica.

## 5. Refrigeración

| Tipo | Cómo funciona | Pros y contras |
|---|---|---|
| **Aire** | Ventiladores (120/140 mm) y disipadores de aletas con *heatpipes* | Barata, fiable y suficiente para la mayoría de equipos |
| **Líquida** | Bomba, bloque sobre la CPU/GPU y radiador (AIO o circuito a medida) | Más capacidad y menos ruido, pero más cara y con mantenimiento |
| **Inmersión** | Los componentes se sumergen en un líquido dieléctrico | Máxima eficiencia; se usa en CPD y minería, no en equipos personales |

Conclusión del trabajo: con una buena circulación de aire basta en casi todos los casos; la líquida compensa sobre todo con *overclocking* o equipos de mucha potencia.

## 6. Discos duros y almacenamiento óptico

**Partes físicas** de un HDD, identificadas desmontando uno en el taller: platos, cabezales de lectura/escritura, brazo actuador, motor del eje (giro de los platos), actuador del brazo, chasis, placa controladora y conectores SATA de datos y de alimentación (y jumpers en los modelos antiguos).

**Estructura lógica**: pistas (círculos concéntricos, numeradas desde el exterior), sectores (divisiones de cada pista), cilindros (la misma pista en todas las caras) y clústeres (grupos de sectores, la unidad mínima del sistema de archivos).

**Capacidad por CHS**: 1024 cilindros × 16 cabezas × 63 sectores × 512 bytes = 528 482 304 bytes ≈ **504 MiB**, el famoso límite de las BIOS antiguas que obligó a introducir el direccionamiento LBA.

| | CD | DVD | Blu-ray |
|---|---|---|---|
| Capacidad por capa | 700 MB | 4,7 GB | 25 GB |
| Láser | Infrarrojo, 780 nm | Rojo, 650 nm | Azul-violeta, 405 nm |

Un láser de menor longitud de onda enfoca un punto más pequeño, así que caben más datos en el mismo disco; además, DVD y Blu-ray admiten varias capas. Un **DVD de dos caras y doble capa** almacena unos **17 GB**, y a **22X** (1X ≈ 1,385 MB/s) transfiere unos **30,5 MB/s**.

## 7. SSD e interfaces

| | HDD | SSD |
|---|---|---|
| Formatos | 3,5" y 2,5" | 2,5", mSATA y M.2 |
| Interfaces | IDE (PATA), SATA, USB | SATA, mSATA, M.2 (SATA o **NVMe** sobre PCIe) |

- **M.2**: el número indica el tamaño en milímetros; `2242` = 22 mm de ancho × 42 mm de largo. Formatos: 2230, 2242, 2260, 2280 y 22110.
- **SATA**: I = 1,5 Gb/s (150 MB/s), II = 3 Gb/s (300 MB/s), III = 6 Gb/s (600 MB/s). Los MB/s salen de dividir entre 10, porque la codificación 8b/10b usa 10 bits por cada byte.
- Un SSD de 2,5" se fija en una bahía de 3,5" con un **adaptador**.
- El modelo de disco instalado se consulta en el *Administrador de tareas* (pestaña Rendimiento) o en el *Administrador de dispositivos*.

## 8. Periféricos

Ficha de diez dispositivos: tipo, si es de entrada, salida o ambos, función, marca y modelo, precio y tecnologías.

| Dispositivo | Tipo | Tecnología destacada |
|---|---|---|
| Cámara de acción GoPro HERO8 | Entrada | Estabilización electrónica *HyperSmooth* |
| Raspberry Pi 400 | Ordenador en un teclado (E/S) | SoC ARM |
| Altavoz inteligente Amazon Echo | Entrada y salida | Asistente de voz y Wi-Fi |
| Batería externa Samsung | Alimentación | Carga rápida por USB-C |
| Mini PC ASUS Chromebox | Ordenador compacto | ChromeOS |
| Placa Raspberry Pi | Placa de desarrollo | GPIO para electrónica |
| Chromecast con Google TV | Salida (multimedia) | Transmisión desde el móvil por Wi-Fi |
| NAS WD My Cloud | Almacenamiento en red | Acceso por la red local e Internet |
| Impresora 3D Flashforge | Salida | Fabricación por deposición de filamento |
| Adaptadores PLC Devolo Magic 2 | Comunicación | Red por la instalación eléctrica |
