# 🌐 SRI · Servicios de Red e Internet

Despliegue y configuración de los servicios de red más habituales en Linux: servidor web **Apache** (control de acceso, reescritura de URL, *virtual hosts* y autenticación) y servicio **DNS** con **BIND9** (caché, reenviador, maestro, esclavo y subdominios). También hubo una práctica en **AWS EC2** (Apache + WordPress).

## Índice

1. [Arquitectura web y HTTP](#1-arquitectura-web-y-http)
2. [Apache](#2-apache)
3. [DNS](#3-dns)
4. [AWS EC2](#4-aws-ec2)

## 1. Arquitectura web y HTTP

- **Arquitectura de tres capas**: presentación (cliente/navegador), lógica (servidor de aplicaciones) y datos (SGBD).
- **Plataformas**: **LAMP** (Linux + Apache + MySQL + PHP) y **WISA** (Windows + IIS + SQL Server + ASP).
- **HTTP**: petición (`GET`, `POST`, `TRACE`…) y respuesta con códigos **1xx** informativo, **2xx** éxito, **3xx** redirección, **4xx** error de cliente, **5xx** error de servidor.
- **TCP vs UDP**: TCP garantiza la entrega con el *three-way handshake* (SYN → SYN-ACK → ACK); UDP es más rápido pero sin garantías (DNS, DHCP, VoIP).

## 2. Apache

Servidor **Apache2** sobre Ubuntu. Rutas clave:

| Elemento | Ubicación |
|---|---|
| Configuración principal | `/etc/apache2/apache2.conf` |
| Puertos | `/etc/apache2/ports.conf` |
| Sitios disponibles / activos | `/etc/apache2/sites-available/` · `sites-enabled/` |
| Raíz de documentos | `/var/www/html` |
| Registros | `/var/log/apache2/{access,error}.log` |

```bash
sudo a2enmod rewrite          # activar un módulo
sudo a2ensite ejemplo.conf    # activar un sitio
sudo apachectl configtest     # comprobar la sintaxis
sudo systemctl restart apache2
```

### Control de acceso (`<Directory>`)

```apache
<Directory /var/www/html/dir1>
    Require ip 10.3.0.100          # permitir una IP
    Require ip 10.3.0.0/16         # permitir una red
    Require host ejemplo.intranet  # permitir un host y sus subdominios
    Require not ip 10.3.0.101      # denegar una IP
</Directory>
```

En Apache 2.4 se usa `Require` (`all granted` / `all denied` / `ip` / `host`); la sintaxis antigua `Order Allow,Deny` sigue disponible con `mod_access_compat`.

### Reescritura de URL (`mod_rewrite`)

URL amigables que se traducen a parámetros de un script. Ejemplo: `suma/5/3` → `operacion.php?op=suma&op1=5&op2=3`.

```apache
RewriteEngine On
RewriteBase /
RewriteRule ^([a-z]+)/([0-9]+)/([0-9]+)$ operacion.php?op=$1&op1=$2&op2=$3
```

Para usar ficheros `.htaccess` hay que poner `AllowOverride All` en el `<Directory>` correspondiente.

### Virtual hosts

Varios sitios en el mismo servidor, cada uno con su `DocumentRoot`:

```bash
sudo mkdir -p /var/www/ejemplo.com/public_html
sudo nano /etc/apache2/sites-available/ejemplo.com.conf
sudo a2ensite ejemplo.com.conf
```

```apache
<VirtualHost *:80>
    ServerName ejemplo.com
    DocumentRoot /var/www/ejemplo.com/public_html
</VirtualHost>
```

### Autenticación

- **Básica** (`mod_auth_basic`): usuarios en un fichero con `htpasswd`, grupos, y la directiva `Satisfy` para combinar autenticación por host (`Require ip`) y por usuario (`Require user`).

  ```apache
  AuthType Basic
  AuthName "Área restringida"
  AuthUserFile /etc/apache2/.htpasswd
  Require valid-user
  ```

- **Digest** (`mod_auth_digest`): las credenciales viajan cifradas con un *hash*; usuarios por **dominio (realm)** con `htdigest`. Se combinó con la instalación de **phpMyAdmin**.

### Otras directivas practicadas

Escuchar en el **puerto 81** además del 80; ocultar la versión del servidor con `ServerTokens Prod` y `ServerSignature Off`; **redirecciones** de carpeta o de página concreta (`Redirect`); y `UserDir` para carpetas web por usuario.

## 3. DNS

### Teoría (nslookup, dig)

- **TLD**, **FQDN**, **servidores raíz** (13 identificadores lógicos, distribuidos por *anycast*) y **ficheros de zona** (registros SOA, NS, A, AAAA, MX, CNAME, PTR).
- **`nslookup`** y **`dig`** para consultar registros:

  ```bash
  dig ejemplo.com MX +noall +answer      # servidores de correo
  dig -t NS ejemplo.com +noall +answer   # servidores de nombres
  dig -x 8.8.8.8                         # resolución inversa
  dig ejemplo.com ANY +noall +answer     # todos los registros
  nslookup -type=soa ejemplo.com         # servidor primario, serie, admin
  ```

### BIND9

Configuración progresiva de un servidor DNS con **BIND9** sobre Ubuntu:

| Tipo | Qué hace |
|---|---|
| **Caché** | Resuelve y guarda respuestas para acelerar consultas posteriores |
| **Reenviador** (*forwarding*) | Delega las consultas en otro DNS (`forwarders`) |
| **Maestro** (*master*) | Autoritativo: aloja el fichero de zona de un dominio |
| **Esclavo** (*slave*) | Copia la zona del maestro mediante **transferencia de zona** |

```bash
sudo apt install bind9
sudo named-checkconf                     # comprobar named.conf
sudo named-checkzone dominio db.dominio  # comprobar el fichero de zona
sudo systemctl restart bind9
tail -f /var/log/syslog                  # ver transferencias y errores
```

Ejercicio completo: zona directa e inversa para un dominio de laboratorio con los FQDN `ns1`, `ftp1`, `mail1`, `mail2`, `www` y `departamentos`, comprobando la resolución directa e inversa (SOA, NS, A, MX, PTR) desde un cliente. Después, un **servidor esclavo** en otra máquina y la verificación de la transferencia de zona al subir el número de serie del SOA.

**Subdominios**: delegación de un subdominio (`informatica.dominio`) y uso de la directiva `$INCLUDE` para separar su definición en otro fichero.

> 💡 **Nota práctica recurrente**: cuando `dig`/`nslookup` resuelven el dominio pero `ping` o el navegador no, el problema suele estar en `/etc/nsswitch.conf` (la línea `hosts:` con `mdns4_minimal`). Cambiarla a `hosts: files dns` lo soluciona.

## 4. AWS EC2

Práctica en la nube: lanzar una **instancia EC2**, instalar **Apache** y desplegar **WordPress** sobre ella, abriendo los puertos necesarios en el grupo de seguridad.

> Los dominios (`ejemplo.intranet`) y las IP de los ejemplos son de laboratorio.
