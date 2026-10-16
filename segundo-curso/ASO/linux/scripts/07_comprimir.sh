#!/bin/bash
# Dado un directorio, crea un tar.gz cuyo nombre es la fecha (yyyy-mm-dd)
# seguida del nombre del directorio.  Ej: 2025-03-14documentos.tar.gz
# Uso: bash 07_comprimir.sh <directorio>
read -p "Introduce el directorio a comprimir: " dir
if [ -d "$dir" ]; then
    fecha=$(date +%Y-%m-%d)
    nombre="${fecha}$(basename "$dir").tar.gz"
    tar -czf "$nombre" "$dir"
    echo "Creado: $nombre"
else
    echo "Error: '$dir' no es un directorio."
fi
