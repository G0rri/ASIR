#!/bin/bash
# Pide dos números y muestra su media aritmética (con decimales, usando bc).
read -p "Introduce el primer número: " n1
read -p "Introduce el segundo número: " n2
media=$(echo "scale=2; ($n1 + $n2) / 2" | bc)
echo "La media es: $media"
