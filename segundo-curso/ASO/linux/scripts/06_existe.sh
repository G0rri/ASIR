#!/bin/bash
# Función 'existe': recibe el nombre de un fichero (argumento del script).
# Si existe, le da permiso de ejecución al dueño; si no, muestra un error.
# Uso: bash 06_existe.sh <fichero>
existe() {
    if [ -f "$1" ]; then
        chmod u+x "$1"
        echo "El fichero '$1' existe. Permiso de ejecución añadido al dueño."
    else
        echo "Error: el fichero '$1' no existe."
    fi
}
existe "$1"
