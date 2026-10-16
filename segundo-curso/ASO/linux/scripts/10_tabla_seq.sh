#!/bin/bash
# Igual que 05, pero recorriendo con 'seq 1 10'.
read -p "Introduce un número: " n
for i in $(seq 1 10); do
    echo "$i x $n = $((i * n))"
done
