# 2. DNS

El DNS es imprescindible en un dominio: los clientes lo usan para localizar el controlador de dominio. Estas prácticas trabajan la consola *Herramientas › DNS* del servidor.

## Comprobar el servicio

En el Administrador del servidor, el apartado **DNS** muestra el estado del servicio; debe aparecer **en línea**. Desde PowerShell:

```powershell
Get-Service DNS
```

## Zona de búsqueda directa

Traduce nombres a direcciones IP. Clic derecho en *Zonas de búsqueda directa › Zona nueva*:

1. Tipo: **zona principal**, almacenada en Active Directory (la opción recomendada en un controlador de dominio, porque se replica con AD).
2. Nombre de la zona, por ejemplo `zona1.com`.
3. **Actualizaciones dinámicas**: solo seguras, para que únicamente los equipos del dominio puedan registrar sus nombres.

### Registros de host (A)

Clic derecho en la zona › **Host nuevo (A o AAAA)**. Registros del supuesto:

| Nombre | Dirección IP |
|---|---|
| `PCW1zona1` | 192.168.1.3 |
| `PCW2zona1` | 192.168.1.4 |
| `PCW3zona1` | 192.168.1.5 |
| `PCW4zona1` | 192.168.1.6 |
| `PCW5zona1` | 192.168.1.7 |

## Zonas por etapa: directas, inversas y alias

Para facilitar la gestión de la red se creó una zona directa y otra inversa para cada unidad organizativa principal, cada una con un alias que abrevia su nombre (**Z**ONA + **E**SO + **d**irecta → `ZED`):

| Etapa | Zona directa | Alias | Zona inversa | Alias |
|---|---|---|---|---|
| ESO | `ZONAESOdirecta` | `ZED` | `ZONAESOinversa` | `ZEI` |
| Bachillerato | `ZONABACHdirecta` | `ZBD` | `ZONABACHinversa` | `ZBI` |
| Ciclos | `ZONACFdirecta` | `ZCD` | `ZONACFinversa` | `ZCI` |

- Las **zonas inversas** traducen direcciones IP a nombres (registros PTR): *Zonas de búsqueda inversa › Zona nueva*.
- Los **alias** son registros **CNAME**: un nombre alternativo que apunta a otro ya existente. Se crean con clic derecho en la zona › *Alias nuevo (CNAME)*.

> En un despliegue real, las zonas inversas no llevan un nombre libre: se nombran a partir de la red, por ejemplo `1.168.192.in-addr.arpa` para `192.168.1.0/24`, y el asistente lo genera solo si se indica el identificador de red.

## Equivalente en PowerShell

```powershell
# Zona directa integrada en AD con actualizaciones seguras
Add-DnsServerPrimaryZone -Name "zona1.com" -ReplicationScope Domain -DynamicUpdate Secure

# Registro A (con su PTR si existe la zona inversa)
Add-DnsServerResourceRecordA -ZoneName "zona1.com" -Name "PCW1zona1" -IPv4Address 192.168.1.3 -CreatePtr

# Zona inversa para 192.168.1.0/24
Add-DnsServerPrimaryZone -NetworkId "192.168.1.0/24" -ReplicationScope Domain

# Alias (CNAME)
Add-DnsServerResourceRecordCName -ZoneName "zona1.com" -Name "equipo1" -HostNameAlias "PCW1zona1.zona1.com"

# Comprobación
Resolve-DnsName PCW1zona1.zona1.com
Resolve-DnsName 192.168.1.3
```
