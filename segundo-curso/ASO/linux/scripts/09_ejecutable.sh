#!/bin/bash
# Recibe un nombre de archivo, verifica que existe y es un archivo común,
# lo hace ejecutable para el dueño y el grupo, y muestra el modo final.
# Uso: bash 09_ejecutable.sh <fichero>
f="$1"
if [ -f "$f" ]; then
    chmod ug+x "$f"
    ls -l "$f"
else
    echo "Error: '$f' no existe o no es un archivo común."
fi
