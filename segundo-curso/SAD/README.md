# 🔒 SAD · Seguridad y Alta Disponibilidad

Módulo de seguridad informática: seguridad física y del entorno (SAI, videovigilancia), seguridad lógica (cifrado, control de integridad, antimalware), análisis y auditoría (nmap, sniffers, auditoría de contraseñas), recuperación de datos y alta disponibilidad (RAID, NAS, congeladores de sistema).

Todas las prácticas se hicieron en **entornos de laboratorio controlados** (máquinas virtuales propias en Proxmox/VirtualBox) con fines educativos y defensivos. No se incluyen objetivos reales ni datos de terceros.

## Índice

1. [Seguridad física y SAI](#1-seguridad-física-y-sai)
2. [Videovigilancia y RGPD](#2-videovigilancia-y-rgpd)
3. [Mecanismos de seguridad y criptografía](#3-mecanismos-de-seguridad-y-criptografía)
4. [Amenazas y malware](#4-amenazas-y-malware)
5. [Análisis y auditoría](#5-análisis-y-auditoría)
6. [Recuperación de datos](#6-recuperación-de-datos)
7. [RAID 5 y NAS](#7-raid-5-y-nas)
8. [Congeladores de sistema](#8-congeladores-de-sistema)

## 1. Seguridad física y SAI

Dimensionado de **Sistemas de Alimentación Ininterrumpida (SAI/UPS)** para un conjunto de equipos:

- **Cálculo de potencia**: se estima el consumo en vatios de cada equipo (con calculadoras de consumo) y se pasa a **voltio-amperios** (VA ≈ W × 1,4). Se deja un margen: el SAI no debe superar el **70 %** de su carga máxima.
- **Cálculo de autonomía** en minutos a máxima potencia:

  ```text
  T = (N · V · Ah · Ef / S) · 60
  ```

  donde *N* = nº de baterías, *V* = tensión, *Ah* = amperios-hora, *Ef* ≈ 0,95 (eficiencia) y *S* = potencia aparente (VA).
- **Tipos de SAI** (*offline*, *line-interactive*, *online*), tomas **IEC 60320 C13/C19** y tarjetas de red de gestión (p. ej. **NetMan 204**) para apagado remoto y monitorización.
- **Configuración del SAI en servidor Linux** (Proxmox) con su software de gestión: apagado ordenado cuando la autonomía baja de 5 minutos o se lleva más de 5 minutos sin corriente.

## 2. Videovigilancia y RGPD

Diseño de una instalación de **cámaras IP**: elección de cámaras de interior/exterior, grabador **NVR**, almacenamiento necesario (cálculo de GB según días de retención) y presupuesto.

**Marco legal** (AEPD, RGPD y LOPDGDD):

- No grabar la vía pública ni espacios de terceros desde cámaras privadas.
- Señalizar la presencia de cámaras e informar del responsable y de los derechos.
- Conservación máxima de **30 días**, salvo investigación judicial.

## 3. Mecanismos de seguridad y criptografía

- **Biometría**: tabla comparativa (iris, huella, firma, voz) por fiabilidad, facilidad de uso, prevención, aceptación y estabilidad.
- **Cifrado con herramienta del sistema**: **EFS** (*Encrypting File System*) en Windows. Un segundo usuario no puede leer el contenido; la recuperación correcta se hace **exportando e importando el certificado** con su clave privada (`certmgr.msc`). Desde consola, `cipher /d` solo descifra lo cifrado con EFS del propio usuario.
- **Cifrado con herramienta externa**: **AES-Crypt** (AES-256) en Windows y Linux; cifrado de archivos y carpetas con contraseña e intercambio seguro.

## 4. Amenazas y malware

Glosario de amenazas con la herramienta típica de **laboratorio/pentesting** asociada a cada una (uso defensivo, en entorno controlado):

| Amenaza | Descripción | Herramienta de laboratorio |
|---|---|---|
| Malware (virus, gusanos, troyanos, spyware, ransomware) | Software malicioso | Metasploit (simulación en VM) |
| Ingeniería social (scam, phishing, vishing) | Manipulación para obtener información | SET (*Social Engineering Toolkit*) |
| Botnet | Red de dispositivos controlados | (análisis, no despliegue) |
| DoS / DDoS | Saturación de un servicio | LOIC / HOIC (en VM aislada) |
| Sniffing | Captura de tráfico | **Wireshark** |
| Spoofing / Pharming | Suplantación de IP/MAC/identidad | Ettercap (demostración en VM) |
| Password cracking | Descifrado de contraseñas | **John the Ripper**, **Hydra** |

### Keyloggers

Instalación en una VM de un **keylogger** (Revealer Keylogger) para entender cómo funciona y, sobre todo, **cómo detectarlo y eliminarlo**: Windows Defender lo identifica como amenaza y lo elimina; comprobación de que tras reiniciar ya no registra pulsaciones.

### Antivirus vs antimalware

- **Antivirus**: detección basada en firmas de amenazas conocidas (análisis en tiempo real y bajo demanda).
- **Antimalware**: técnicas más amplias (heurística, comportamiento, IA) para amenazas avanzadas (ransomware, spyware).
- Son **complementarios**: p. ej. Windows Defender + Malwarebytes conviven; dos antivirus a la vez, no.

## 5. Análisis y auditoría

### Escaneo de red con nmap

```bash
nmap -F ejemplo.local               # escaneo rápido
nmap -p- -v IP                      # todos los puertos, detallado
nmap --open IP                      # solo puertos abiertos
nmap -sn 192.168.1.0/24             # hosts activos (sin escanear puertos)
nmap -O IP                          # detección de sistema operativo
nmap -p 23 IP                       # ¿está abierto un puerto concreto?
```

### Integridad del sistema y rootkits

- **SFC** (`sfc /scannow`) en Windows: comprueba y repara ficheros del sistema; registro en `CBS.log`.
- **rkhunter** en Linux: busca rootkits comparando contra una base de datos de integridad.

  ```bash
  sudo apt install rkhunter
  sudo rkhunter --check
  ```

### Auditoría de un formulario de login (Hydra + Burp Suite)

Práctica de *ethical hacking* **en un WordPress de laboratorio** proporcionado por el profesorado (dominio y credenciales de prueba dentro de la red del aula):

1. **Localizar** el servidor con `nmap` (puertos 80/443 en el rango del aula) y resolver su subdominio.
2. **Identificar** el formulario de acceso (`/wp-login.php`).
3. **Capturar** la petición POST con **Burp Suite** (proxy en `127.0.0.1:8080`).
4. **Fuerza bruta** con **Hydra** usando diccionarios de usuarios y contraseñas:

   ```bash
   hydra -L usuarios.txt -P claves.txt <host-laboratorio> \
         https-post-form "/wp-login.php:log=^USER^&pwd=^PASS^:S=bienvenida"
   ```

El objetivo didáctico es entender **por qué** un login sin límite de intentos ni 2FA es vulnerable, y cómo defenderlo (bloqueo de intentos, *rate limiting*, contraseñas robustas, 2FA).

## 6. Recuperación de datos

- **Recuva** y **EaseUS Data Recovery**: recuperación de un fichero borrado de la papelera. Regla de oro: **recuperar siempre en un disco distinto** del original para no sobrescribir.
- **Firmas de fichero (*magic numbers*)**: reparación de un GIF corrupto con el editor hexadecimal **HxD**. Una imagen GIF debe empezar por `47 49 46 38 39 61` (`GIF89a`); corrigiendo los primeros bytes el archivo vuelve a abrirse.

## 7. RAID 5 y NAS

- **RAID 5 (teoría)**: cálculo de los **bloques de paridad** (XOR de los bloques de cada franja), lectura en modo degradado (reconstruir un disco perdido con la paridad) y escritura con un disco caído. Recuperación completa de un disco a partir de los demás y la paridad.
- **RAID 5 en Windows 10 Pro** (sobre Proxmox): 3 discos dinámicos → *Espacios de almacenamiento* con resistencia por **paridad**, prueba de fallo de un disco y sustitución por otro sin perder datos.
- **NAS con TrueNAS Scale**: instalación, creación de un **pool** con RAID-Z (paridad) más un disco de caché, usuario **SMB/Samba** y *dataset* compartido, y acceso desde el cliente por `\\IP`.

## 8. Congeladores de sistema

**Deep Freeze** (Faronics): "congela" el estado del sistema de modo que **cada reinicio restaura el estado original**, descartando cualquier cambio. Útil en aulas, bibliotecas y cibercafés. Modos *Frozen* / *Thawed* (descongelado para aplicar cambios o actualizaciones) y gestión remota de equipos.
