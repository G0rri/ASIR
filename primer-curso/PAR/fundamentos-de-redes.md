# 📚 Fundamentos de redes

Conceptos trabajados en el 1º y 2º trimestre: clasificación de redes, modelos de referencia, capa física, protocolos y puertos, y dos trabajos de investigación (comparativa de operadores y presupuesto de un aula).

## Índice

1. [Tipos de redes y topologías](#1-tipos-de-redes-y-topologías)
2. [Modelos OSI y TCP/IP](#2-modelos-osi-y-tcpip)
3. [Capa física](#3-capa-física)
4. [Protocolos y puertos](#4-protocolos-y-puertos)
5. [Comparativa de telecomunicaciones: Suiza y España](#5-comparativa-de-telecomunicaciones-suiza-y-españa)
6. [Presupuesto de la red de un aula](#6-presupuesto-de-la-red-de-un-aula)

## 1. Tipos de redes y topologías

| Tipo | Alcance | Ejemplo |
|---|---|---|
| **PAN** | Unos metros, alrededor de una persona | Móvil y auriculares Bluetooth |
| **LAN** | Un edificio o campus | La red de una oficina, un aula o un parque empresarial con varios edificios enlazados por fibra |
| **MAN** | Una ciudad o área metropolitana | Anillos de fibra municipales; una administración que une sus edificios por la ciudad |
| **WAN** | Países y continentes | La red de una multinacional con MPLS, las redes académicas nacionales, Internet |

**Topologías**: bus, anillo, estrella (la de las LAN Ethernet actuales), árbol, malla y **celular**, en la que el territorio se divide en celdas hexagonales con una estación base en el centro de cada una (telefonía móvil y redes inalámbricas).

Ventajas de trabajar en red: compartir ficheros, impresoras y acceso a Internet; centralizar la información, la seguridad y las copias de seguridad, y reducir costes. Inconvenientes: una configuración más compleja y la propagación más rápida de *malware*. En una red, dos equipos no pueden tener el mismo nombre ni la misma dirección IP.

## 2. Modelos OSI y TCP/IP

| # | Capa OSI | TCP/IP | Unidad de datos | Dispositivos | Protocolos |
|---|---|---|---|---|---|
| 7 | Aplicación | Aplicación | Datos | — | HTTP, FTP, SMTP, DNS, DHCP, Telnet, SSH |
| 6 | Presentación | ↑ | Datos | — | TLS, codificación |
| 5 | Sesión | ↑ | Datos | — | — |
| 4 | Transporte | Transporte | Segmento / datagrama | — | TCP, UDP |
| 3 | Red | Internet | Paquete | Router | IP, ICMP |
| 2 | Enlace de datos | Acceso a la red | Trama | Switch, bridge | Ethernet, Wi-Fi, ARP ¹ |
| 1 | Física | ↓ | Bits | Hub, repetidor, cable | — |

¹ ARP resuelve direcciones IP (capa 3) en direcciones MAC (capa 2); según el modelo se sitúa en el enlace o entre ambas capas.

## 3. Capa física

Resumen de la presentación que preparé para la unidad.

### Señales

Una señal periódica se describe como `f(t) = A · sen(ωt + φ)`: **amplitud** (*A*), **frecuencia** (ω = 2π*f*) y **fase** (φ). Se puede representar en el **dominio del tiempo** (cómo varía) o en el **de la frecuencia** (qué frecuencias la componen).

Durante la transmisión sufre **atenuación** (pierde potencia con la distancia), **distorsión** (cada frecuencia se propaga de forma distinta), **interferencias** de otras señales y **ruido**.

### Modulación y multiplexación

- **Modulación analógica**: en amplitud (AM), frecuencia (FM) o fase (PM). En digital, las equivalentes son ASK, FSK y PSK, y QAM combina amplitud y fase.
- **Modulación por pulsos**: PCM, que muestrea y cuantifica una señal analógica.
- **Multiplexación**: compartir un medio entre varias comunicaciones por frecuencia (FDM), por tiempo (TDM), por longitud de onda en fibra (WDM) o por código (CDM).

### Medios de transmisión

| Guiados | Variantes |
|---|---|
| Par trenzado | UTP (sin apantallar), FTP (pantalla global), STP (cada par apantallado), S/FTP (ambas) |
| Coaxial | Banda base (grueso y fino) y banda ancha |
| Fibra óptica | **Multimodo** (índice escalonado o gradual, distancias cortas) y **monomodo** (larga distancia) |

**No guiados**: radiofrecuencia, microondas terrestres y por satélite, e infrarrojos.

### Detección y corrección de errores

- **Paridad simple**: un bit extra para que el número de unos sea par (o impar). Detecta errores en un número impar de bits.
- **Paridad de bloque** (o cruzada): paridad por filas y por columnas de un bloque; permite localizar y corregir un bit erróneo.
- **CRC**: el emisor añade ceros al mensaje, lo divide (en módulo 2) entre un polinomio generador y envía el mensaje con el resto. El receptor divide lo recibido: si el resto es 0, no hay error.
- **Código Hamming**: bits de paridad en las posiciones potencia de 2 (1, 2, 4, 8…). Cada uno comprueba las posiciones cuya representación binaria contiene su bit: el bit 13 (`1101`) lo comprueban los de paridad 8, 4 y 1.

Ejemplo con Hamming (7,4) y paridad par, para los datos `1011`:

| Posición | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|---|---|---|---|---|---|---|---|
| Contenido | p1 | p2 | d1 | p4 | d2 | d3 | d4 |
| Valor | **0** | **1** | 1 | **0** | 0 | 1 | 1 |

- p1 comprueba 1, 3, 5, 7 → datos 1, 0, 1 → p1 = 0
- p2 comprueba 2, 3, 6, 7 → datos 1, 1, 1 → p2 = 1
- p4 comprueba 4, 5, 6, 7 → datos 0, 1, 1 → p4 = 0

Si llega `0110001` (bit 6 cambiado), al recalcular fallan las comprobaciones de p2 y p4: el **síndrome** `110` = 6 señala la posición errónea.

## 4. Protocolos y puertos

| Protocolo | Puerto | Transporte | Uso |
|---|---|---|---|
| FTP | 20 (datos), 21 (control) | TCP | Transferencia de ficheros |
| SSH | 22 | TCP | Acceso remoto cifrado |
| Telnet | 23 | TCP | Acceso remoto **en texto plano** |
| SMTP | 25 | TCP | Envío de correo |
| DNS | 53 | UDP y TCP | Resolución de nombres |
| DHCP | 67 (servidor), 68 (cliente) | UDP | Configuración automática de red |
| HTTP | 80 | TCP | Web |
| POP3 | 110 | TCP | Descarga de correo |
| HTTPS | 443 | TCP | Web cifrada |

- **TCP** es orientado a conexión: establece la comunicación con el *three-way handshake*, numera los segmentos, confirma su recepción y retransmite los perdidos. **UDP** no garantiza la entrega ni el orden, pero es más ligero (DNS, streaming, VoIP).
- **ICMP** es el protocolo que informa de errores, como un destino inalcanzable o un TTL agotado, y el que usan `ping` y `tracert`.
- **Telnet** permite administrar un equipo remoto por texto, pero viaja sin cifrar, incluidas las contraseñas; hoy se sustituye por **SSH**.

## 5. Comparativa de telecomunicaciones: Suiza y España

Trabajo de investigación sobre el mercado de telecomunicaciones de otro país.

| | Suiza | España |
|---|---|---|
| Operadores principales | Swisscom (operador histórico), UPC (cable DOCSIS, hoy integrada en Sunrise) y Salt (fibra) | Movistar, Orange y Vodafone |
| Tecnologías de acceso | Mezcla de DSL, cable y fibra, condicionada por la orografía | Fuerte despliegue de **fibra hasta el hogar (FTTH)** |
| Velocidades | Salt fue de los primeros operadores europeos en ofrecer fibra de 10 Gbit/s a particulares | Las ofertas más habituales van de 300 Mbit/s a 1 Gbit/s |

**Conclusiones**: los precios en Suiza son más altos, en línea con su renta, y su oferta es más variada tecnológicamente por la orografía; España destaca por la cobertura de fibra y una buena relación calidad-precio.

## 6. Presupuesto de la red de un aula

Presupuesto para equipar un aula de 26 puestos:

| Partida | Detalle | Importe |
|---|---|---:|
| Electrónica de red | Router Wi-Fi 6 y switch gigabit de 24 puertos | 149,89 € |
| Equipos | 26 PC, monitores, teclados y ratones | 10.830,56 € |
| Cableado y montaje | 51 latiguillos Cat 5e, *patch panel*, armario, cuadro eléctrico, canaletas, regletas, bridas y etiquetas | 617,46 € |
| Software | 26 licencias de Windows 10 | 64,74 € |
| Mano de obra | 48 h a 12,50 €/h | 600,00 € |
| **Total** | | **12.262,65 €** |

> 💡 **Revisión**: un switch de 24 puertos no basta para 26 equipos más el enlace con el router; haría falta uno de 48 o dos switches. Las licencias de Windows a 2,49 € proceden del mercado gris: un proyecto real debería presupuestar licencias educativas o por volumen.
