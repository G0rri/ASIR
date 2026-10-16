# 📜 Shell scripts en Bash

Relación de ejercicios de *shell scripting* del 2º trimestre. Los originales se entregaron como capturas de pantalla del editor; aquí están **transcritos a ficheros ejecutables** y comprobados con `bash -n` y con las mismas pruebas que aparecían en las capturas.

| Script | Qué hace | Conceptos |
|---|---|---|
| [`sumar_restar.sh`](sumar_restar.sh) | Suma los dos argumentos si el primero es menor y los resta si es mayor | `if`/`elif`, `-lt`/`-gt`, `$1 $2` |
| [`digito_caracter.sh`](digito_caracter.sh) | Dice si el argumento es una letra, un dígito u otra cosa | `case` con rangos `[a-z]` |
| [`sumar_argumentos.sh`](sumar_argumentos.sh) | Suma todos los argumentos mostrando la suma acumulada | `for … in $*`, aritmética |
| [`contar_caracteres.sh`](contar_caracteres.sh) | Muestra el número de caracteres de cada fichero de un directorio | Sustitución de órdenes, `wc -c` |
| [`notas_case.sh`](notas_case.sh) | Convierte una nota numérica en suspenso, aprobado, notable o sobresaliente | `case` con alternativas `9\|10` |
| [`notas_if.sh`](notas_if.sh) | Lo mismo que el anterior con `if`/`elif`/`else` | `-le`, estructuras alternativas |
| [`par_impar.sh`](par_impar.sh) | Indica si cada argumento es par o impar | `for`, operador `%` |
| [`usuario_cadena.sh`](usuario_cadena.sh) | Pide la cadena pasada como argumento hasta que se escriba bien | `until`, `read` |
| [`calculadora.sh`](calculadora.sh) | Calculadora con menú de cuatro operaciones | Funciones, `case`, `sleep`, `clear` |
| [`menu.sh`](menu.sh) | Menú que reúne varios de los scripts anteriores como funciones | Funciones, reutilización |

## Ejemplos de ejecución

```console
$ bash sumar_restar.sh 1 2
val=3
$ bash sumar_restar.sh 3 2
val=1

$ bash digito_caracter.sh F
carácter
$ bash digito_caracter.sh 4
dígito

$ bash sumar_argumentos.sh 1 2 3 4 5 9 4
1
3
6
10
15
24
28

$ bash notas_case.sh 7
notable
$ bash notas_if.sh 12
nota no válida

$ bash par_impar.sh 2 3 5 6
2 Pares
3 Impares
5 Impares
6 Pares
```

## Revisión posterior

Los scripts se conservan tal como se entregaron en 1º. Con lo aprendido después, estas son las mejoras que les aplicaría:

- **Aritmética moderna**: `$[ … ]` está obsoleta; la forma actual es `$(( … ))`.
- **Comillas**: sin ellas, un argumento vacío o con espacios rompe las comparaciones (`[ $1 = $cadena ]` falla si no se escribe nada). Mejor `[ "$1" = "$cadena" ]`.
- **Argumentos**: `"$@"` conserva los argumentos que contienen espacios; `$*` sin comillas los divide.
- **Validación**: comprobar el número de argumentos (`$#`) y que sean números antes de operar, y evitar la división entre cero en la calculadora.
- **Menús sin recursión**: las funciones vuelven a llamar a `menu`, así que cada operación anida una llamada más. Un bucle `while true; do … done` con `break` en la opción de salida es más limpio.
- **Casos límite**: `sumar_restar.sh` no muestra nada si los dos números son iguales, y `contar_caracteres.sh` falla con nombres de fichero que contienen espacios (`for f in "$1"/*` lo resuelve).
