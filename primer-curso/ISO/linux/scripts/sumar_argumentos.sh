#!/bin/bash
# Suma todos los números pasados como argumentos y muestra
# la suma acumulada tras cada uno.
# Uso: bash sumar_argumentos.sh <num1> [num2 ...]
for valor in $*
do
suma=$[$suma + $valor]
echo $suma
done
