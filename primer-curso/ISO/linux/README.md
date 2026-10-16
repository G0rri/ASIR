# 🐧 Linux: terminal y comandos

Prácticas de administración básica de Linux (Ubuntu 22.04 en VirtualBox) del 2º trimestre: manejo de ficheros y directorios, redirecciones, permisos y búsqueda de texto y ficheros. Los [shell scripts](scripts/README.md) de la misma unidad están en su propia carpeta.

Cada apartado recoge el enunciado resumido y la orden utilizada. Donde la solución original se podía mejorar, se indica con **💡 Revisión**.

## Índice

1. [Redirecciones y tuberías](#1-redirecciones-y-tuberías)
2. [Ficheros y directorios](#2-ficheros-y-directorios)
3. [Permisos](#3-permisos)
4. [grep y expresiones regulares](#4-grep-y-expresiones-regulares)
5. [find](#5-find)
6. [sort](#6-sort)

## 1. Redirecciones y tuberías

| Operador | Efecto |
|---|---|
| `orden > f` | Envía la salida estándar a `f` (lo sobrescribe) |
| `orden >> f` | Añade la salida estándar al final de `f` |
| `orden 2> f` | Envía la salida de **error** a `f` |
| `orden < f` | Toma la entrada estándar de `f` |
| `orden1 \| orden2` | La salida de `orden1` es la entrada de `orden2` |

```bash
# Líneas del manual de grep que contienen "line", en pantalla y guardadas en un fichero
man grep | grep line
man grep | grep line > f3

# Copiar un fichero sobre sí mismo da error; se guarda el mensaje en ERROR
cp fichero_de_salida fichero_de_salida 2> ERROR
cat ERROR        # cp: 'fichero_de_salida' y 'fichero_de_salida' son el mismo fichero

# Crear un fichero con contenido de dos formas
cat > Ejemplo_2            # se escribe el texto y se termina con Ctrl+D
cat f1 > Ejemplo_2         # copiando el contenido de otro fichero

# Concatenar f1 y f2 intercalando lo que se escriba por teclado ("-" es la entrada estándar)
cat f1 - f2 > f5

# Lo mismo, pero tomando el separador de un fichero preparado de antemano
cat f1 separador f2 > f5
```

### Contar líneas que contienen palabras

Con `f1` y `f2`:

```text
f1: Perico de los palotes dijo pam
    Fulanito no le respondió
    Menganito furioso contestó pum
f2: En este fichero nadie dijo pam ni pum
```

```bash
cat f1 f2 | grep -c pam              # 2 líneas contienen "pam"
cat f1 f2 | grep pam | grep -c pum   # 1 línea contiene "pam" y "pum"
```

> 💡 **Revisión**: para "pam **y** pum" la solución entregada fue `grep -c -e pam -e pum`, que cuenta las líneas que contienen **cualquiera** de las dos (3). Para exigir ambas hay que encadenar dos `grep`.

### Variables de entorno

```bash
echo "Soy $USER y mi directorio \$HOME es $HOME"
```

## 2. Ficheros y directorios

Creación de una estructura de directorios de un centro educativo y de ficheros dentro de ella:

```text
CENTRO
├── ALUMNOS
│   └── ASIR
│       ├── NO_REPETIDORES
│       └── REPETIDORES
│           └── Primero.txt
└── INSTITUTO
    ├── DIRECCION
    │   ├── DIRECTOR
    │   │   ├── Segundo.txt
    │   │   └── VICEDIRECTOR
    │   └── JEFE_DE_ESTUDIOS
    └── PROFESORES
        └── DEPARTAMENTO
            └── INFORMATICA
                └── Lista.txt
```

En la práctica se construyó carpeta a carpeta con `mkdir` y `cd`. Con `mkdir -p` y la expansión de llaves de Bash cabe en una sola orden:

```bash
mkdir -p CENTRO/ALUMNOS/ASIR/{REPETIDORES,NO_REPETIDORES} \
         CENTRO/INSTITUTO/DIRECCION/{DIRECTOR/VICEDIRECTOR,JEFE_DE_ESTUDIOS} \
         CENTRO/INSTITUTO/PROFESORES/DEPARTAMENTO/INFORMATICA
tree CENTRO
```

> Los nombres con espacios (`NO REPETIDORES`) hay que escribirlos entre comillas o con `\`; de lo contrario `mkdir` crea dos carpetas.

### Comodines, copias y movimientos

Sobre un directorio `Practica4` con los ficheros `p4p4`, `p4hola`, `p4banco` y `p4palabra`:

| Tarea | Orden |
|---|---|
| Ir al directorio y comprobarlo | `cd Practica4` y `pwd` |
| Ficheros que empiezan por `p4` y contienen una `b` | `ls p4*b*` |
| Volver al directorio personal | `cd` o `cd $HOME` |
| Copiar los que empiezan por `p4` seguido de **exactamente dos** caracteres | `cp Practica4/p4?? directorio_nuevo/` |
| Copiar todo el contenido al directorio actual | `cp ../Practica4/* .` |
| Renombrar un fichero | `mv p4p4 p4p4.cambiado` |
| Moverlo a otro directorio | `mv ../dir1/p4p4.cambiado .` |
| Borrar un directorio con su contenido | `rm -r directorio_nuevo` |

## 3. Permisos

Cada cifra octal suma lectura (**4**), escritura (**2**) y ejecución (**1**) para propietario, grupo y otros.

| Requisito | Orden | Resultado |
|---|---|---|
| Solo el propietario escribe; el resto solo ejecuta | `chmod 211 p4p4` | `--w---x--x` |
| Solo el propietario lee; nadie escribe ni ejecuta | `chmod 400 p4p4.cambiado` | `-r--------` |
| Equivalente simbólico del anterior | `chmod u=r,go= p4p4.cambiado` | `-r--------` |

## 4. grep y expresiones regulares

### Fichero `datos`

```text
gato libro atunn gotas atas
pez gaita ##%% dado oso
.excr expreso atun gota loco
Gato tierra GATA nada raton
gata canica atunnn fuente gatos
```

| # | Buscar líneas que… | Orden | Líneas |
|---|---|---|---|
| 1 | Contienen la palabra *gato* | `grep -w gato datos` | 1 |
| 2 | Empiezan por *gato* | `grep '^gato' datos` | 1 |
| 3 | Contienen *gato* o *gata* | `grep -e gato -e gata datos` | 1, 5 |
| 4 | Contienen una o más mayúsculas | `grep -E '[A-Z]+' datos` | 4 |
| 5 | Empiezan por punto | `grep '^\.' datos` | 3 |
| 6 | No empiezan por punto | `grep '^[^.]' datos` | 1, 2, 4, 5 |
| 7 | Terminan en *n* | `grep 'n$' datos` | 4 |
| 8 | Tienen tres o más *n* seguidas | `grep -E 'n{3,}' datos` | 5 |
| 9 | Tienen *a*, un carácter cualquiera y *o* | `grep 'a.o' datos` | 1, 2, 4, 5 |

### Fichero `TEXTO`

```text
a
aa
ab
aba
aaa
abab
abba
La cadena a es capicua
También es capicua la cadena aa
La cadena ab no es capicua
En una cadena capicua su final refleja su principio
Si concatenas una cadena y su reflejo el resultado es capicua.
A
AA
ABA
```

| # | Buscar líneas que… | Orden | Resultado |
|---|---|---|---|
| 1 | Contienen una *a* | `grep a TEXTO` | Las 12 primeras |
| 2 | Contienen dos *a* seguidas | `grep aa TEXTO` | `aa`, `aaa` y la frase que acaba en `aa` |
| 3 | No contienen ninguna *a* | `grep -v a TEXTO` | `A`, `AA`, `ABA` |
| 4 | No contienen mayúsculas | `grep -v '[A-Z]' TEXTO` | De `a` a `abba` |
| 5 | Empiezan por *a* | `grep '^a' TEXTO` | De `a` a `abba` |
| 6 | Empiezan por minúscula | `grep '^[a-z]' TEXTO` | De `a` a `abba` |
| 7 | Acaban en *capicua* | `grep 'capicua$' TEXTO` | Las dos frases que empiezan por `La` |
| 8 | Empiezan por *La* y acaban en *capicua* | `grep '^La.*capicua$' TEXTO` | Las mismas dos frases |

> 💡 **Revisión**: la frase que termina en `capicua.` no aparece en el ejercicio 7 porque el punto final va antes del fin de línea. En el 8, la versión entregada (`grep -E "^La | capicua$"`) usaba `|`, que significa **o**, no **y**; hace falta `.*` para enlazar principio y final.

> Las expresiones deben ir **entre comillas**: sin ellas, la shell puede expandir `[A-Z]` o `*` como comodines de ficheros antes de que `grep` las reciba. En sistemas con localización en español, `[[:upper:]]` y `[[:lower:]]` son más fiables que los rangos `A-Z` y `a-z`.

## 5. find

| Tarea | Orden |
|---|---|
| Ver la ayuda | `man find` |
| Ficheros que empiezan por *a* (recursivo) | `find . -name "a*"` |
| Solo en el directorio actual | `find . -maxdepth 1 -name "a*"` |
| Segundo carácter *r* o *t* (mayúscula o minúscula) y último carácter numérico | `find . -name "?[rRtT]*[0-9]"` |
| Contar los que empiezan por *p* y guardar el resultado | `find . -name "p*" \| wc -l > ejemplo_3` |

## 6. sort

| Tarea | Orden |
|---|---|
| Ordenar juntos dos ficheros (`plantas` y `animales`) | `sort plantas animales` |
| Listado del directorio en orden inverso, sin distinguir mayúsculas | `ls \| sort -r -f > MisFicheros` |
| Listado ordenado por propietario (3.ª columna de `ls -l`) | `ls -l \| sort -k3,3` |
| Listado ordenado por mes y, dentro del mes, por tamaño | `ls -l \| sort -k6,6M -k5,5n` |

> 💡 **Revisión**: `sort -m` solo **mezcla** ficheros que ya están ordenados; para ordenar dos ficheros cualesquiera basta con pasarlos como argumentos. La sintaxis antigua `sort +3 -5` equivale a `-k4,5` (grupo y tamaño), no al propietario, y el último apartado se resuelve con dos claves `-k`: la primera con `M` (meses) y la segunda con `n` (numérica).
