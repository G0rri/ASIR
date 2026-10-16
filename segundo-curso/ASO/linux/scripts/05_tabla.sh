#!/bin/bash
# Muestra la tabla de multiplicar de un número con el formato  i x n = resultado.
read -p "Introduce un número: " n
for i in $(seq 1 10); do
    echo "$i x $n = $((i * n))"
done
