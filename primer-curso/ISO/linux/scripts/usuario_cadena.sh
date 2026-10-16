#!/bin/bash
# Pide por teclado la cadena pasada como argumento y repite
# la petición hasta que el usuario la escriba correctamente.
# Uso: bash usuario_cadena.sh <cadena>
echo "Escribe la cadena"
read cadena
until [ $1 = $cadena ]
do
echo  "Escribe de nuevo la cadena"
read cadena
done
echo "Cadena correcta"
