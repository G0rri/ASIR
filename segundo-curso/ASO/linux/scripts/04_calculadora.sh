#!/bin/bash
# Menú con las cuatro operaciones básicas. Evita la división entre cero.
echo "1) Sumar"
echo "2) Restar"
echo "3) Multiplicar"
echo "4) Dividir"
read -p "Elige una opción: " opcion
read -p "Introduce el primer número: " n1
read -p "Introduce el segundo número: " n2
case $opcion in
    1) echo "Resultado: $((n1 + n2))" ;;
    2) echo "Resultado: $((n1 - n2))" ;;
    3) echo "Resultado: $((n1 * n2))" ;;
    4) if [ "$n2" -eq 0 ]; then
           echo "Error: no se puede dividir entre cero"
       else
           echo "Resultado: $(echo "scale=2; $n1 / $n2" | bc)"
       fi ;;
    *) echo "Opción no válida" ;;
esac
