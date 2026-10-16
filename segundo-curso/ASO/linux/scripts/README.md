# 📜 Shell scripts en Bash (ASO)

Ejercicios de *scripting* del 2º trimestre. Los originales se entregaron como capturas; aquí están **reconstruidos como ficheros ejecutables** a partir del enunciado y su descripción, y comprobados con `bash -n` y pruebas de ejecución.

| Script | Qué hace | Conceptos |
|---|---|---|
| [`01_media.sh`](01_media.sh) | Media aritmética de dos números (con decimales) | `read`, `bc` |
| [`02_mayor.sh`](02_mayor.sh) | Dice cuál de dos números es mayor | `if`/`elif`, `-gt` |
| [`03_palabras.sh`](03_palabras.sh) | Añade una palabra a `palabras.txt` sin borrar lo anterior | redirección `>>` |
| [`04_calculadora.sh`](04_calculadora.sh) | Menú con las 4 operaciones (evita dividir entre 0) | `case`, aritmética |
| [`05_tabla.sh`](05_tabla.sh) | Tabla de multiplicar de un número | `for`, `seq` |
| [`06_existe.sh`](06_existe.sh) | Función `existe`: si el fichero existe, `chmod u+x` | funciones, `-f`, `chmod` |
| [`07_comprimir.sh`](07_comprimir.sh) | `tar.gz` de un directorio con la fecha en el nombre | `date`, `tar`, `-d` |
| [`08_tabla_invertida.sh`](08_tabla_invertida.sh) | Tabla de multiplicar invertida (10→1) | `seq 10 -1 1` |
| [`09_ejecutable.sh`](09_ejecutable.sh) | Hace ejecutable un fichero para dueño y grupo | `chmod ug+x`, `ls -l` |
| [`10_tabla_seq.sh`](10_tabla_seq.sh) | Igual que el 05 recorriendo con `seq 1 10` | `for … in $(seq …)` |

## Ejemplos

```console
$ bash 01_media.sh
Introduce el primer número: 4
Introduce el segundo número: 7
La media es: 5.50

$ bash 05_tabla.sh
Introduce un número: 3
1 x 3 = 3
2 x 3 = 6
...
10 x 3 = 30

$ bash 06_existe.sh notas.txt
El fichero 'notas.txt' existe. Permiso de ejecución añadido al dueño.
```

> `01_media.sh` y la división de `04_calculadora.sh` usan **`bc`** para obtener decimales (`sudo apt install bc` si no está).
