# 📄 XML

Ejercicios del 2º trimestre sobre documentos XML **bien formados**: detectar y corregir errores, diseñar la estructura de un documento a partir de un enunciado y pasar información real (un disco, un ticket, la jerarquía de directorios de Linux) a XML.

Todos los ficheros se han comprobado con `xmllint --noout`.

## Reglas de un documento bien formado

- Un único **elemento raíz** que contiene a todos los demás.
- Toda etiqueta abierta se cierra (`<a></a>` o `<a/>`) y en el orden correcto.
- XML distingue mayúsculas y minúsculas: `<Pais>` y `<pais>` son etiquetas distintas.
- Los nombres de elementos y atributos **no pueden contener espacios** ni empezar por un número, y no admiten caracteres como `/` o `"`.
- Los valores de atributo van **entre comillas** y un elemento no puede repetir el mismo atributo.
- Los caracteres especiales se escriben como entidades: `&lt;` (`<`), `&gt;` (`>`), `&amp;` (`&`).

## Actividad 1: encontrar y corregir errores

Cada fichero contiene la versión corregida y, en un comentario, la explicación del error.

| Fichero | Error original |
|---|---|
| [`ejercicio-4.xml`](actividad-1/ejercicio-4.xml) | Espacio en el nombre de un elemento y texto colocado en la etiqueta de cierre |
| [`ejercicio-5.xml`](actividad-1/ejercicio-5.xml) | Atributo repetido en el mismo elemento |
| [`ejercicio-6.xml`](actividad-1/ejercicio-6.xml) | Valores sin atributo ni elemento que los contenga |
| [`ejercicio-7.xml`](actividad-1/ejercicio-7.xml) | Un `<` sin escapar dentro de un atributo, un nombre de atributo con espacio y una etiqueta sin cerrar |

## Relación 1

| Ejercicio | Contenido |
|---|---|
| 1 | Validez de nombres de elementos (respuestas abajo) |
| [2](relacion-1/ejercicio-2.xml) | Catálogo de discos corregido (nombres con espacios sustituidos por `_`) |
| [3](relacion-1/ejercicio-3.xml) · [4](relacion-1/ejercicio-4.xml) | Estructura vacía de una tarjeta de visita y de un libro |
| [5](relacion-1/ejercicio-5.xml) | El libro del ejercicio 4 con datos |
| [6](relacion-1/ejercicio-6.xml) | Validez de distintas declaraciones XML (respuestas en el comentario) |
| [8](relacion-1/ejercicio-8.xml) | Un ticket de restaurante convertido a XML |

**Ejercicio 1**, nombres de elementos: `a`, `b`, `c`, `f` y `g` son válidos. No lo son `d` (tiene un espacio: `fecha nacimiento` → `fecha_nacimiento`), `e` (contiene `/`) ni `h` (contiene comillas).

## Relación 2

| Fichero | Contenido |
|---|---|
| [`mensaje.xml`](relacion-2/mensaje.xml) | Un correo electrónico: remitente, destinatario, asunto y texto |
| [`cds-en-oferta.xml`](relacion-2/cds-en-oferta.xml) | Catálogo de CD con título, artista, país, discográfica, precio y año |
| [`jerarquia-directorios-linux.xml`](relacion-2/jerarquia-directorios-linux.xml) | La jerarquía estándar de directorios de Linux (`/bin`, `/etc`, `/home`, `/usr`…), con la descripción de cada uno como atributo |

> 💡 **Revisión**: en `cds-en-oferta.xml` y en el ticket del ejercicio 8, los datos de cada CD o de cada línea del ticket van seguidos, sin un elemento que los agrupe, y casi todo se guarda en atributos. Una estructura más útil agruparía cada registro (`<cd>…</cd>`, `<linea>…</linea>`) y dejaría los datos como contenido de los elementos.
