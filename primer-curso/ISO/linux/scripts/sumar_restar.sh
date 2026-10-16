#!/bin/bash
# Suma los dos argumentos si el primero es menor que el segundo
# y los resta si es mayor.
# Uso: bash sumar_restar.sh <num1> <num2>
if [ $1 -lt $2 ]
	then echo val=$[$1 + $2]
elif [ $1 -gt $2 ]
	then echo val=$[$1 - $2]
fi
