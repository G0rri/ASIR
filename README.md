# 🎓 ASIR · Administración de Sistemas Informáticos en Red

Prácticas, código y apuntes del ciclo formativo de grado superior en **Administración de Sistemas Informáticos en Red**, organizados por curso y por módulo.

Es el material que generé durante el ciclo, reorganizado y documentado: consultas SQL, *shell scripts*, aplicaciones web en PHP/Python/Django, configuraciones de Cisco IOS, Apache y BIND, y guías paso a paso de las prácticas de sistemas, redes y seguridad. Donde hoy resolvería algo de otra forma, lo indico con una nota de **💡 Revisión**.

> 🔒 Este repositorio no incluye, a propósito, datos personales (nombre, centro, localidad), datos de compañeros ni del profesorado, capturas de pantalla, contraseñas, direcciones MAC ni los apuntes del profesorado. Los datos de ejemplo se han anonimizado.

## Cursos

| Curso | Año | Estado | Módulos |
|---|---|---|---|
| [1º ASIR](primer-curso/README.md) | 2023-2024 | ✅ Completo | FH · GBD · ISO · LMSGI · PAR · FOL |
| [2º ASIR](segundo-curso/README.md) | 2024-2025 | ✅ Completo | ASO · ASGBD · SRI · IAW · SAD · HLC · EIE · Proyecto |

## Aspectos destacados

### Primer curso

- **Bases de datos**: [25 scripts SQL](primer-curso/GBD/README.md) sobre MySQL, desde el modelo entidad-relación (con diagramas) hasta funciones, procedimientos almacenados y disparadores de auditoría.
- **Linux**: guía de comandos con soluciones verificadas y [10 *shell scripts*](primer-curso/ISO/linux/scripts/README.md) transcritos de las capturas originales y probados.
- **Windows Server 2016**: un [dominio de Active Directory](primer-curso/ISO/windows-server/README.md) completo, con DNS, perfiles móviles y obligatorios, carpetas en red y GPO, más sus equivalentes en PowerShell.
- **Redes**: [chuleta de Cisco IOS](primer-curso/PAR/cisco-ios.md), VLAN y *trunking*, [enrutamiento estático, OSPF y RIP](primer-curso/PAR/enrutamiento.md) comparados sobre la misma topología y una [chuleta de filtros de Wireshark](primer-curso/PAR/wireshark.md).
- **Hardware y web**: montaje de PC, [RAID 5 con `mdadm`](primer-curso/FH/cpd-sai-y-raid.md), [32 páginas HTML/CSS](primer-curso/LMSGI/README.md), XML y un proyecto con Odoo y WordPress.

### Segundo curso

- **Oracle**: administración de [Oracle Database 19c](segundo-curso/ASGBD/README.md) (instancia, tablespaces, usuarios, privilegios, perfiles y roles) con chuletas SQL.
- **Servidores**: [Windows Server 2019 y Ubuntu Server sobre Proxmox](segundo-curso/ASO/README.md) (AD, DNS, DHCP, NAT, LDAP, Samba, CUPS, acceso remoto) y [Apache + BIND9](segundo-curso/SRI/README.md).
- **Desarrollo web**: aplicaciones en [PHP](segundo-curso/HLC/README.md) (agenda JSON y CRUD MySQL) y [Python/Django](segundo-curso/IAW/README.md) (dos proyectos con CRUD).
- **Seguridad**: módulo [SAD](segundo-curso/SAD/README.md) (auditoría con nmap/Hydra, cifrado, RAID, NAS) y un [proyecto de fin de ciclo sobre privacidad digital](segundo-curso/proyecto-privacidad/README.md).

## Tecnologías

| Área | Herramientas |
|---|---|
| Sistemas | Ubuntu 22.04 (Desktop y Server), Windows 10, Windows Server 2016/2019, Active Directory, LDAP, Webmin, Bash, PowerShell |
| Virtualización | **Proxmox VE**, VirtualBox (NAT, puente, solo anfitrión), clonación, discos en caliente, RAID por software |
| Redes y servicios | Cisco Packet Tracer, Cisco IOS, Apache, BIND9, Samba, CUPS, Wireshark, AWS EC2 |
| Bases de datos | MySQL / MariaDB, **Oracle Database 19c**, SQL, rutinas almacenadas |
| Desarrollo web | HTML5, CSS3, XML, **PHP**, **Python**, **Django**, Bootstrap, Odoo, WordPress, XAMPP |
| Seguridad | nmap, Hydra, Burp Suite, rkhunter, John the Ripper, TrueNAS, cifrado (EFS, AES-Crypt, VeraCrypt) |
| Hardware | Montaje y diagnóstico de PC, AIDA64, `mdadm`, NUT, SAI |

## Estructura del repositorio

```
.
├── README.md
├── primer-curso/
│   ├── FH/      Fundamentos de Hardware
│   ├── GBD/     Gestión de Bases de Datos
│   ├── ISO/     Implantación de Sistemas Operativos
│   ├── LMSGI/   Lenguajes de Marcas y Sistemas de Gestión de Información
│   ├── PAR/     Planificación y Administración de Redes
│   └── FOL/     Formación y Orientación Laboral
└── segundo-curso/
    ├── ASO/                 Administración de Sistemas Operativos
    ├── ASGBD/               Administración de SGBD (Oracle)
    ├── SRI/                 Servicios de Red e Internet
    ├── IAW/                 Implantación de Aplicaciones Web (Python · Django)
    ├── SAD/                 Seguridad y Alta Disponibilidad
    ├── HLC/                 Desarrollo web con PHP
    ├── EIE/                 Empresa e Iniciativa Emprendedora
    └── proyecto-privacidad/ Proyecto de fin de ciclo
```

Cada módulo tiene su propio `README.md` con el índice de prácticas, lo que se hizo en cada trimestre y enlaces a las guías y al código.

## Cómo usar el código

```bash
# SQL (MySQL): crear la base de datos y cargar un esquema
mysql -u root -p -e "CREATE DATABASE fruits"
mysql -u root -p fruits < primer-curso/GBD/1-ddl-y-consultas/fruits.sql

# Bash: ejecutar un script
bash primer-curso/ISO/linux/scripts/par_impar.sh 2 3 5 6

# Django (2º): levantar un proyecto
cd segundo-curso/IAW/django-club && python manage.py migrate && python manage.py runserver

# HTML: abrir cualquier página en el navegador
xdg-open primer-curso/LMSGI/html-css/05-mapa-interactivo/index.html
```
