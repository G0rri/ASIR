# 💻 ISO · Implantación de Sistemas Operativos

Instalación, configuración y administración de sistemas operativos de escritorio y servidor, siempre sobre máquinas virtuales: arranque dual Windows/Linux, administración de Linux desde la terminal, programación de *shell scripts* y un dominio completo de **Active Directory** con Windows Server 2016.

## Contenido

| Trimestre | Bloque | Documentación |
|---|---|---|
| 1º | Virtualización con VirtualBox, VM con arranque dual Windows 10 + Ubuntu 22.04, proceso de arranque (BIOS/UEFI, GRUB) y licencias de software | [Virtualización, arranque y licencias](virtualizacion-y-arranque.md) |
| 2º | Linux: ficheros y directorios, redirecciones, permisos, `grep` y expresiones regulares, `find` y `sort` | [Terminal y comandos](linux/README.md) |
| 2º | *Shell scripting* en Bash: condicionales, bucles, argumentos, lectura de teclado, funciones y menús | [10 scripts](linux/scripts/README.md) |
| 3º | Windows Server 2016: AD DS, DNS, usuarios y grupos, carpetas en red, perfiles, herramientas de administración y GPO | [Windows Server](windows-server/README.md) |

## Aspectos destacados

- **Scripts reales**: los ejercicios de Bash se entregaron como capturas de pantalla; aquí están [transcritos a ficheros `.sh`](linux/scripts/) y comprobados.
- **Soluciones verificadas**: las órdenes de la guía de Linux se han vuelto a ejecutar para confirmar su resultado, y donde la solución original fallaba se explica por qué (💡 *Revisión*).
- **Dominio de un centro educativo** con unidades organizativas por etapa, zonas DNS por etapa, restricciones horarias, carpetas personales, unidad de red por *script*, perfiles móviles y obligatorios, y GPO con filtrado de seguridad.
- **Equivalentes en PowerShell** de las tareas que en clase se hicieron con el asistente gráfico.

## Estructura

```
ISO/
├── virtualizacion-y-arranque.md
├── linux/
│   ├── README.md
│   └── scripts/
│       ├── README.md
│       └── *.sh (10 scripts)
└── windows-server/
    ├── README.md
    ├── 01-instalacion-y-active-directory.md
    ├── 02-dns.md
    ├── 03-usuarios-carpetas-y-perfiles.md
    └── 04-herramientas-y-gpo.md
```
