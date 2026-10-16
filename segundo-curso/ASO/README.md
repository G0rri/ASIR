# 🖥️ ASO · Administración de Sistemas Operativos

Administración de servidores **Windows** y **Linux** virtualizados, principalmente sobre **Proxmox VE**: Active Directory, DNS, DHCP, NAT, compartición de archivos e impresión, cuotas, acceso remoto, directivas de grupo, copias de seguridad, LDAP, Samba, CUPS y *shell scripting*.

## Contenido

| Trimestre | Bloque | Documentación |
|---|---|---|
| 1º | Windows Server 2019 en Proxmox: AD, DNS, DHCP, NAT, carpetas compartidas y NFS, cuotas, impresión, escritorio remoto, servidor de aplicaciones, confianza entre dominios, GPO, copias de seguridad y RAID 1 | [Windows Server](windows-server.md) |
| 2º | Ubuntu Server en Proxmox: Webmin, LDAP, Samba, CUPS, cuotas, DHCP, SSH, VNC, pasarela SSH e iptables | [Ubuntu Server](linux-ubuntu.md) |
| 2º | *Shell scripting* en Bash | [10 scripts](linux/scripts/README.md) |

## Aspectos destacados

- **Dos plataformas del mismo servicio**: el mismo escenario (dominio, usuarios, carpetas compartidas, impresión, cuotas, acceso remoto) resuelto tanto en **Windows Server** como en **Ubuntu Server con Webmin/LDAP**.
- **Virtualización con Proxmox**: discos añadidos en caliente, backups de VM, RAID por software y red de dos adaptadores (NAT + interna).
- **Acceso remoto en capas**: de SSH y VNC a una **pasarela SSH** que cifra el tráfico de VNC.
- **Equivalentes en PowerShell** de las tareas de Windows hechas con asistente.
- **Scripts probados**: los ejercicios de Bash están reconstruidos a fichero y verificados.

## Estructura

```
ASO/
├── README.md
├── windows-server.md
├── linux-ubuntu.md
└── linux/
    └── scripts/
        ├── README.md
        └── *.sh (10 scripts)
```
