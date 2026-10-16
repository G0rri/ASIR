#!/bin/bash
# Calculadora con menú: suma, resta, multiplicación y división entera.
# Cada operación es una función que, al terminar, vuelve a mostrar el menú.
# Uso: bash calculadora.sh
function sumar {
valor=$[$num1 + $num2]
echo "La suma entre $num1 y $num2 es: $valor"
sleep 3
clear
menu
}

function restar {
echo "Introduce el primer número"
read num1
echo "Introduce el segundo número"
read num2
valor=$[$num1 - $num2]
echo "La resta entre $num1 y $num2 es: $valor"
sleep 3
clear
menu
}

function multiplicar {
valor=$[$num1 * $num2]
echo "La multiplicación entre $num1 y $num2 es: $valor"
sleep 3
clear
menu
}

function dividir {
echo "Introduce el primer número"
read num1
echo "Introduce el segundo número"
read num2
valor=$[$num1 / $num2]
echo "La división entre $num1 y $num2 es: $valor"
sleep 3
clear
menu
}

function menu {
echo Calculadora
echo
echo 1.Sumar
echo 2.Restar
echo 3.Multiplicar
echo 4.Dividir
echo 5.Salir
echo
echo "Introduce los números"
read operacion
case $operacion in
	1) echo "Introduce el primer número"
	read num1
	echo "Introduce el segundo número"
	read num2
	sumar;;
	2) restar;;
	3) echo "Introduce el primer número"
	read num1
	echo "Introduce el segundo número"
	read num2
	multiplicar;;
	4) dividir;;
	5) exit;;
	*) echo Opción Incorrecta;;
esac
}
menu
