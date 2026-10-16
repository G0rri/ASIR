#!/bin/bash
# Muestra los diez primeros elementos de la tabla de multiplicar invertida.
read -p "Introduce un número: " n
for i in $(seq 10 -1 1); do
    echo "$i x $n = $((i * n))"
done
