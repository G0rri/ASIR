#!/bin/bash
# Traduce una nota numérica (0-10) a su calificación, usando if/elif.
# Uso: bash notas_if.sh <nota>
if [ $1 -le 4 ]
	then echo suspenso
elif [ $1 -le 6 ]
	then echo aprobado
elif [ $1 -le 8 ]
	then echo notable
elif [ $1 -le 10 ]
	then echo sobresaliente
else
	echo nota no válida
fi
