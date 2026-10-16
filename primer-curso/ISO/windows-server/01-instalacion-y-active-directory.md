# 1. Instalación y Active Directory

## Máquina virtual con Windows Server 2016

1. Descargar la ISO de evaluación de **Windows Server 2016** desde el Evaluation Center de Microsoft.
2. En VirtualBox, *Nueva* máquina seleccionando la ISO. En **Edición** hay que elegir la variante **(Experiencia de escritorio)**; las demás se instalan sin interfaz gráfica (*Server Core*).
3. Nombre de usuario y contraseña de la instalación desatendida. Si el asistente da error, conviene revisar que el nombre no tenga espacios.
4. Memoria y CPU dentro de la zona verde, disco virtual de tamaño dinámico y a esperar a la instalación.

> Antes de montar el dominio, el servidor necesita una **IP fija** y un **nombre de equipo** definitivo: cambiarlos después de promoverlo a controlador de dominio da muchos problemas.

## Instalar el rol AD DS

*Administrador del servidor › Administrar › Agregar roles y características*:

1. Tipo de instalación: **basada en características o en roles**.
2. Servidor de destino: el propio servidor.
3. Roles: **Servicios de dominio de Active Directory** y **Servidor DNS**.
4. Confirmar e instalar.

## Promover a controlador de dominio

Al terminar, aparece un aviso amarillo en el Administrador del servidor: **Promover este servidor a controlador de dominio**.

1. **Agregar un nuevo bosque** con el dominio raíz `prueba.local`.
2. Nivel funcional, DNS y catálogo global por defecto.
3. Contraseña del **modo de restauración de servicios de directorio** (DSRM), que se usa para recuperar AD si falla.
4. Revisar los requisitos previos, instalar y dejar que el servidor se reinicie.

La misma operación en PowerShell:

```powershell
Install-WindowsFeature AD-Domain-Services, DNS -IncludeManagementTools
Install-ADDSForest -DomainName "prueba.local" -InstallDns
```

## Unidades organizativas

Desde *Herramientas › Usuarios y equipos de Active Directory*, con el botón de **nueva unidad organizativa**. Para crear una sub-UO basta con situarse dentro de la UO padre.

Estructura del supuesto, que se reutiliza en el resto de prácticas:

```text
prueba.local
├── ESO
│   └── 1ESO
├── BACH
│   ├── 1BACH
│   └── 2BACH
└── CF
    ├── 1CF
    └── 2CF
```

- **Eliminar**: una UO nueva viene protegida contra el borrado accidental. Hay que activar *Ver › Características avanzadas* y desmarcar esa casilla en sus propiedades.
- **Mover**: clic derecho › *Mover* y elegir el nuevo contenedor.

```powershell
New-ADOrganizationalUnit -Name "BACH" -Path "DC=prueba,DC=local"
New-ADOrganizationalUnit -Name "1BACH" -Path "OU=BACH,DC=prueba,DC=local"
```

## Degradar el controlador de dominio

*Administrar › Quitar roles y características*, desmarcar AD DS y seguir el asistente:

1. El asistente avisa de que primero hay que **degradar** el controlador; el enlace del aviso abre el asistente de degradación.
2. En el laboratorio no hay otro controlador con el que replicar los cambios, así que se marca **Forzar la eliminación de este controlador de dominio**. En un dominio real se usaría la opción **Último controlador de dominio del dominio** o se degradaría con los demás controladores accesibles.
3. Avanzar hasta **Disminuir nivel**; al terminar, el servidor deja de ser controlador de dominio.
