#!/bin/bash
# Dado un directorio, muestra el número de caracteres de cada fichero.
# Uso: bash contar_caracteres.sh <directorio>
ISO=`ls $1`
echo $ISO
cd $1
for num in $ISO
do
cont=`wc -c $num`
echo $cont
done
