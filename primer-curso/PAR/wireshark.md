# 🦈 Análisis de tráfico con Wireshark

Práctica guiada de **152 preguntas** realizada en pareja sobre capturas propias: manejo de la interfaz, análisis de los protocolos capa a capa, filtros de visualización y herramientas estadísticas. Este documento recoge lo aprendido en forma de chuleta; las capturas originales no se publican porque contienen direcciones y tráfico reales.

## 1. Captura

| Tarea | Cómo |
|---|---|
| Elegir interfaz | Pantalla inicial o *Captura › Opciones* (Ethernet, Wi-Fi, *loopback*…) |
| Parar tras 1000 paquetes o 5 segundos | *Captura › Opciones*, pestaña *Opciones*: *Detener captura automáticamente después de…* |
| Capturar solo UDP / TCP | **Filtro de captura** `udp` / `tcp` (sintaxis BPF, se aplica **antes** de capturar) |
| Guardar y reabrir | *Archivo › Guardar como* `ejemplo_tcp.pcap` y *Archivo › Abrir* |

> **Filtro de captura** (BPF, `tcp port 80`) ≠ **filtro de visualización** (`tcp.port == 80`): el primero decide qué se guarda; el segundo solo qué se muestra.

## 2. Interfaz y navegación

La ventana principal tiene tres paneles: **lista de paquetes**, **detalles** (árbol por protocolo, de la capa 2 hacia arriba) y **bytes** en hexadecimal. Al seleccionar un campo en el árbol se resaltan sus bytes.

| Acción | Atajo / menú |
|---|---|
| Ir a un paquete por número | <kbd>Ctrl</kbd>+<kbd>G</kbd> |
| Primer / último paquete | <kbd>Ctrl</kbd>+<kbd>Inicio</kbd> / <kbd>Ctrl</kbd>+<kbd>Fin</kbd> |
| Referencia de tiempo (paquete = tiempo 0) | <kbd>Ctrl</kbd>+<kbd>T</kbd> |
| Marcar un paquete | <kbd>Ctrl</kbd>+<kbd>M</kbd> |
| Siguiente / anterior marcado | <kbd>Ctrl</kbd>+<kbd>Mayús</kbd>+<kbd>N</kbd> / <kbd>Ctrl</kbd>+<kbd>Mayús</kbd>+<kbd>B</kbd> |
| Buscar una cadena en los paquetes | <kbd>Ctrl</kbd>+<kbd>F</kbd>, tipo *Cadena*, en *Bytes de paquete* o *Detalles* |
| Reglas de color | *Ver › Reglas de coloreado* (activar, desactivar sin borrar, cambiar colores) |
| Colorear una conversación | Clic derecho › *Colorear conversación* |
| Seguir una conversación | Clic derecho › *Seguir › Flujo TCP* |

## 3. Protocolos capa a capa

| Protocolo | Qué mirar |
|---|---|
| **Ethernet II** | MAC de origen y destino; los 3 primeros bytes (OUI) identifican al **fabricante** de la tarjeta. *EtherType* indica qué transporta: `0x0800` IPv4, `0x0806` ARP, `0x86DD` IPv6. El **preámbulo** no aparece: lo retira la tarjeta de red antes de entregar la trama. |
| **IPv4** | Cabecera de **20 bytes** sin opciones (campo IHL = 5 palabras de 32 bits), longitud total, **TTL** (el paquete solo puede atravesar tantos routers como indique) y protocolo transportado. |
| **ARP** | *Opcode* 1 = solicitud, 2 = respuesta. En la solicitud, la MAC de destino es `00:00:00:00:00:00` porque es lo que se pregunta. Carga útil de 28 bytes para IPv4 sobre Ethernet. |
| **ICMP** | Capa 3. Tipo 8 = *Echo Request*, 0 = *Echo Reply*, 3 = destino inalcanzable, 11 = TTL agotado (*Time Exceeded*). |
| **UDP** | Cabecera fija de 8 bytes: puertos de origen y destino, longitud y suma de comprobación. |
| **TCP** | Cabecera de 20 a 60 bytes, *flags* (SYN, ACK, FIN, RST, PSH), números de secuencia y confirmación (Wireshark los muestra **relativos**; los absolutos están en el detalle), ventana y opciones (**MSS**, **SACK**, escalado de ventana, *timestamps*). Una conexión que termina "por las buenas" lo hace con FIN/ACK; con RST, de forma abrupta. |
| **DHCP** | Capa de aplicación sobre UDP 67/68. Secuencia **DORA**: *Discover*, *Offer*, *Request*, *ACK*. Opciones como el tiempo de concesión (51) o el *Client Identifier* (61). |
| **DNS** | Capa de aplicación sobre UDP 53. Consultas y respuestas enlazadas por el ID de transacción; registros A, AAAA, CNAME… |

Un **socket** queda identificado por el protocolo y las parejas IP:puerto de ambos extremos.

## 4. Filtros de visualización

| Mostrar… | Filtro |
|---|---|
| Paquetes con origen en una IP | `ip.src == 192.168.1.10` |
| Paquetes de dos IP concretas | `ip.src == 192.168.1.10 \|\| ip.src == 192.168.1.20` |
| Un socket concreto | `ip.addr == 192.168.1.10 && tcp.port == 443` |
| Tráfico en el puerto 8000 | `tcp.port == 8000 \|\| udp.port == 8000` |
| Segmentos con SYN (inicio de conexión) | `tcp.flags.syn == 1 && tcp.flags.ack == 0` |
| SYN desde una IP | `tcp.flags.syn == 1 && ip.src == 192.168.1.10` |
| Conexiones reiniciadas | `tcp.flags.reset == 1` |
| Una MAC concreta | `eth.addr == aa:bb:cc:dd:ee:ff` |
| FIN desde una IP | `ip.src == 192.168.1.10 && tcp.flags.fin == 1` |
| TTL mayor que 100 / igual a 1 | `ip.ttl > 100` / `ip.ttl == 1` |
| Segmentos que anuncian MSS | `tcp.options.mss_val` |
| Ventana de más de 30 000 bytes (sin escalar) | `tcp.window_size_value > 30000` |
| Paquetes IP de más de 1000 bytes | `ip.len > 1000` |
| Un flujo concreto | `tcp.stream eq 30` |
| Inicio de ese flujo | `tcp.stream eq 30 && tcp.flags.syn == 1` |
| Paquetes que contienen un texto | `frame contains "content"` |
| Solo tramas IPv4 | `eth.type == 0x0800` |

- Un **TTL de 1** indica tráfico que no debe salir de la red local o una sonda de `traceroute`.
- **MSS y FIN nunca coinciden**: el MSS se negocia en los segmentos SYN del inicio y FIN solo aparece al cerrar.

## 5. Estadísticas

| Menú *Estadísticas* | Para qué sirve |
|---|---|
| **Gráfica de E/S** | Paquetes o bytes por intervalo de tiempo; se pueden añadir series con filtros |
| **Información experta** | Avisos agrupados por gravedad (*Error*, *Warning*, *Note*, *Chat*); cada aviso lleva al paquete |
| **Jerarquía de protocolos** | Porcentaje de tráfico de cada protocolo |
| **Longitudes de paquete** | Distribución de tamaños |
| **Conversaciones** y **Puntos finales** | Quién habla con quién y cuánto |
| **Gráfica de flujo** | Diagrama temporal de una conversación, paso a paso |

En la captura analizada había **más tráfico UDP que TCP** (descubrimiento de servicios en la red local como SSDP y mDNS) y la longitud de paquete más frecuente estaba entre **40 y 79 bytes**.
