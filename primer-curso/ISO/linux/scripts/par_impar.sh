#!/bin/bash
# Indica si cada número pasado como argumento es par o impar.
# Uso: bash par_impar.sh <num1> [num2 ...]
for num in $*
do
if [ $[$num % 2] -eq 0 ]
then echo "$num Pares"
else echo "$num Impares"
fi
done
