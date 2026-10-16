#!/bin/bash
# Menú que reúne en funciones varios scripts anteriores:
# sumar/restar, dígito o carácter y sumar argumentos.
# Uso: bash menu.sh
function sr {
if [ $num1 -lt $num2 ]
	then echo val=$[$num1 + $num2]
elif [ $num1 -gt $num2 ]
	then echo val=$[$num1 - $num2]
fi
sleep 3
clear
menu
}

function doc {
echo "Introduce el digito o el carácter"
read num1
case $num1 in
	[a-z,A-Z]) echo carácter;;
	[0-9]) echo dígito;;
	*) echo otra cosa;;
esac
sleep 3
clear
menu
}

function sa {
for valor in $num
do
suma=$[$suma + $valor]
done
echo $suma
sleep 3
clear
menu
}

function menu {
echo 1.Sr
echo 2.Digito o carácter
echo 3.Sumar los argumentos
echo 4.Salir
echo
echo "Introduce los números"
read operacion
case $operacion in
	1) echo "Introduce el primer número"
	read num1
	echo "Introduce el segundo número"
	read num2
	sr;;
	2) doc;;
	3) echo "Introduce los argumentos"
	read num
	sa;;
	4) exit;;
	*) echo Opción Incorrecta;;
esac
}
menu
