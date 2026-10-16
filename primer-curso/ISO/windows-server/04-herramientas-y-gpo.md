# 4. Herramientas y directivas de grupo

## Cuotas de disco

Limitan el espacio que cada usuario puede ocupar en un volumen NTFS.

1. *Propiedades del disco › Cuota › Habilitar la administración de cuota* (y, si se quiere imponer, *Denegar espacio en disco a usuarios que superen el límite*).
2. *Valores de cuota › Nueva entrada de cuota*, con los límites del supuesto:

| Usuario | Límite | Nivel de advertencia (ejemplo) |
|---|---|---|
| `usu1` | 25 MB | 20 MB |
| `usu2` | 15 MB | 12 MB |

Desde la línea de órdenes (valores en bytes):

```bat
fsutil quota enforce C:
fsutil quota modify C: 20971520 26214400 PRUEBA\usu1
fsutil quota modify C: 12582912 15728640 PRUEBA\usu2
```

> Para cuotas por **carpeta** en lugar de por volumen existe el rol *Administrador de recursos del servidor de archivos* (FSRM).

## Visor de eventos

Registra la actividad del sistema, las aplicaciones y la seguridad. Se abre con <kbd>Win</kbd>+<kbd>R</kbd> › `eventvwr.msc`.

| Sección | Contenido |
|---|---|
| **Vistas personalizadas** | Filtros guardados, por ejemplo, solo errores críticos o eventos administrativos |
| **Registros de Windows** | *Aplicación*, *Seguridad* (inicios de sesión y auditoría), *Instalación*, *Sistema* y *Eventos reenviados* |
| **Registros de aplicaciones y servicios** | Registros propios de cada rol o programa (DNS, Active Directory…) |
| **Suscripciones** | Recopilar eventos de otros equipos en un servidor central |

Cada evento tiene nivel (*crítico*, *error*, *advertencia*, *información*), origen, identificador y fecha. Por ejemplo, en *Seguridad* el evento **4625** es un inicio de sesión fallido.

```powershell
Get-WinEvent -LogName System -MaxEvents 20
Get-WinEvent -FilterHashtable @{ LogName = 'Security'; Id = 4625 } -MaxEvents 10
```

## Monitor de rendimiento

Muestra contadores en tiempo real y permite registrarlos para analizarlos después (`perfmon.msc`).

1. **Gráfico en tiempo real**: *Monitor de rendimiento › +* y añadir el contador *Procesador › % de tiempo de procesador*. Se puede consultar el de otro equipo del dominio indicando su nombre al añadir el contador.
2. **Recopilar datos**: *Conjuntos de recopiladores de datos › Definido por el usuario › Nuevo*, creación manual (avanzada) con **contador de rendimiento**. Se inicia, se deja funcionar un tiempo y se detiene.
3. **Informe**: en *Informes › Definido por el usuario* aparece el resultado del recopilador.
4. **Exportar**: desde el gráfico, clic derecho › *Guardar datos como* **CSV** (para abrirlo en una hoja de cálculo) o *Guardar imagen como* **GIF**.

## Copias de seguridad de Windows Server

1. *Administrar › Agregar roles y características › Características* › **Copias de seguridad de Windows Server**.
2. Abrir `wbadmin.msc` y, en el panel de acciones, **Programar copia de seguridad**: servidor completo o volúmenes concretos, hora y disco de destino.

```powershell
Install-WindowsFeature Windows-Server-Backup
wbadmin start backup -backupTarget:E: -include:C: -allCritical -quiet
```

## Directivas de grupo (GPO)

Las GPO aplican configuración a usuarios y equipos de forma centralizada. Se gestionan desde *Herramientas › Administración de directivas de grupo*.

### Aplicar una GPO solo a determinados usuarios, grupos o equipos

1. Clic derecho en el dominio › **Crear un GPO en este dominio y vincularlo aquí**.
2. En la pestaña **Ámbito**, sección *Filtrado de seguridad*, quitar *Usuarios autentificados* y añadir solo el usuario, grupo o equipo destinatario (en el supuesto, el usuario `Usu1 G1BACH`).

> ⚠️ Desde la actualización de seguridad MS16-072, los equipos leen las GPO con su propia cuenta. Si se quita *Usuarios autentificados* del filtrado, hay que mantenerle el permiso de **lectura** en la pestaña *Delegación* (o dárselo a *Equipos del dominio*); de lo contrario, la GPO no se aplica.

### Crear accesos directos por GPO

1. Editar la GPO › *Configuración de usuario › Preferencias › Configuración de Windows › Accesos directos*.
2. *Nuevo › Acceso directo*: en el supuesto, el icono de **Este equipo** en el escritorio.
3. Forzar la aplicación en el cliente sin esperar al ciclo de actualización:

   ```bat
   gpupdate /force
   ```

4. El acceso directo aparece en el escritorio del usuario. Con `gpresult /r` se puede ver qué GPO se han aplicado.
