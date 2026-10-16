# 🐧 Ubuntu Server sobre Proxmox

Administración de **Ubuntu Server 22.04** (y Xubuntu como cliente con escritorio) en **Proxmox VE**: instalación, interfaz web de administración con **Webmin**, directorio **LDAP**, compartición con **Samba**, impresión con **CUPS**, cuotas de disco, **DHCP**, acceso remoto (**SSH**, **VNC** y pasarela SSH) y filtrado con **iptables**.

> Dominios y datos de los ejemplos son de laboratorio.

## Instalación y puesta a punto

- **Ubuntu Server 22.04** en Proxmox: almacenamiento `local-lvm` con caché *write-back*, ≥2 núcleos y ≥4 GB de RAM, Qemu Agent activado y **OpenSSH** instalado durante el asistente.
- **Xubuntu** como cliente con escritorio ligero.
- **Interfaz gráfica sobre Ubuntu Server** cuando hizo falta: `sudo apt install xubuntu-desktop`. Tras problemas con *lightdm*, se cambió el gestor de sesión a **gdm3**:

  ```bash
  sudo apt install gdm3 -y
  sudo dpkg-reconfigure gdm3
  ```

## Administración básica

| Tarea | Orden |
|---|---|
| Actualizar el sistema | `sudo apt update && sudo apt upgrade` |
| ¿Nueva versión del SO? | `sudo do-release-upgrade` |
| Crear usuario / darle sudo | `sudo adduser nombre` · `sudo usermod -aG sudo nombre` |
| Cambiar contraseña | `sudo passwd nombre` |
| Comprobar usuarios | `cat /etc/passwd` |
| Fecha y hora | `date` · `timedatectl` |
| Zona horaria | `sudo timedatectl set-timezone Europe/Madrid` |
| Particiones y sistema de ficheros | `lsblk -f` |
| Permisos (dueño total, grupo r-x, otros r) | `chmod 754 carpeta` |
| Apagar a diario a las 23:59 | `crontab -e` → `59 23 * * * /sbin/shutdown now` |

Instalar y **desinstalar por completo** un servicio (ejemplo con Apache):

```bash
sudo apt install apache2
sudo systemctl enable --now apache2        # comprobar en el navegador: localhost:80
sudo systemctl stop apache2
sudo apt purge apache2                      # elimina configuración
sudo apt autoremove                         # dependencias huérfanas
```

## Webmin

Panel de administración web por el puerto **10000**. Instalación con el repositorio oficial y su clave GPG; requiere Perl. Desde Webmin se instalan y configuran el resto de módulos (LDAP, BIND, Samba…).

## LDAP con Webmin

1. **OpenLDAP** (módulo *LDAP Server*) + **BIND** (*Bind DNS Server*) para el dominio.
2. En BIND, una **Master zone** con su nombre de dominio y un **alias** (CNAME) apuntando a `maquina.dominio.local.`.
3. En OpenLDAP se crea el **árbol** (cada `dc` equivale a un punto del dominio: `dc=ejemplo,dc=local`).
4. Módulo *LDAP users and groups*: se configuran *LDAP server host*, *Bind DN* y *Base for groups*, y se crean **usuarios**, **unidades organizativas** (`ou`, clase `organizationalUnit`) y **grupos**.
5. Comprobación desde consola:

   ```bash
   ldapsearch -x -LLL -H ldap://localhost -b "dc=ejemplo,dc=local"
   ```

## Samba

Carpeta compartida de **solo lectura y ejecución**:

```bash
sudo apt install samba
sudo mkdir -p /srv/samba/solo_lectura
sudo chmod 555 /srv/samba/solo_lectura
sudo nano /etc/samba/smb.conf        # añadir el recurso y ajustar 'interfaces'
```

```ini
[Compartida]
   path = /srv/samba/solo_lectura
   read only = yes
   browsable = yes
   guest ok = yes
```

```bash
sudo systemctl restart smbd
sudo ufw allow samba
```

Desde el cliente, en *Red* aparece el servidor; el fichero se puede ver con `cat` pero `nano` da **"Permiso denegado"** al intentar guardar.

## CUPS (impresión)

```bash
sudo apt install cups
sudo systemctl status cups
sudo nano /etc/cups/cupsd.conf       # Listen en la IP del servidor, puerto 631
```

Desde `http://IP:631` se añade una impresora local, se marca **Compartir** y se hace visible en la red:

```bash
sudo cupsctl --share-printers
sudo lpadmin -p NOMBRE -o printer-is-shared=true
```

El cliente Xubuntu la detecta e imprime una página de prueba; desde Windows se accede por `\\IP` o `http://IP:631`.

## Cuotas de disco

Límite de **200 MB por usuario** en `/home` (requiere que `/home` sea su propia partición):

```bash
sudo apt install quota
# en /etc/fstab añadir 'usrquota' a la partición de /home y remontar
sudo quotacheck -cum /home
sudo quotaon /home
sudo setquota -u usuario 200M 200M 0 0 /home   # límite blando y duro
sudo repquota /home                            # comprobar
```

## DHCP

```bash
sudo apt install isc-dhcp-server
sudo nano /etc/default/isc-dhcp-server    # INTERFACESv4 = nombre de la tarjeta
sudo nano /etc/dhcp/dhcpd.conf            # subnet + range
sudo systemctl restart isc-dhcp-server
```

```conf
subnet 192.168.0.0 netmask 255.255.255.0 {
    range 192.168.0.100 192.168.0.150;
    option routers 192.168.0.1;
}
```

## Acceso remoto: SSH, VNC y pasarela

- **SSH**: `sudo apt install openssh-server` (venía ya con Ubuntu Server). Conexión desde el cliente con `ssh usuario@IP`.
- **VNC**: servidor `tigervnc` con escritorio **xfce**; se arranca con contraseña y se conecta desde un *viewer* indicando `IP:puerto`.
- **Pasarela SSH** (*tunneling*): el cliente VNC se conecta a través de un túnel SSH cifrado:

  ```bash
  ssh -L 5901:localhost:5901 usuario@IP_servidor
  # el viewer apunta a localhost:5901 y viaja cifrado por SSH
  ```

## Filtrado con iptables

```bash
# Bloquear la salida de toda la red interna al exterior
sudo iptables -A FORWARD -o <iface_externa> -j DROP
# Bloquear la entrada del exterior a la red interna
sudo iptables -A FORWARD -i <iface_externa> -j DROP
```

> Para hacerlas persistentes se usa `iptables-persistent` (o `netfilter-persistent save`).
