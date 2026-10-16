#!/bin/bash
# Pide dos números y dice cuál es el mayor (o si son iguales).
read -p "Introduce el primer número: " n1
read -p "Introduce el segundo número: " n2
if [ "$n1" -gt "$n2" ]; then
    echo "El mayor es $n1"
elif [ "$n2" -gt "$n1" ]; then
    echo "El mayor es $n2"
else
    echo "Son iguales"
fi
