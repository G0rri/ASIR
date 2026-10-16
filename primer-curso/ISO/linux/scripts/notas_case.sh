#!/bin/bash
# Traduce una nota numérica (0-10) a su calificación, usando case.
# Uso: bash notas_case.sh <nota>
case $1 in
	[0-4]) echo suspenso;;
	[5-6]) echo aprobado;;
	[7-8]) echo notable;;
	9|10) echo sobresaliente;;
	*) echo nota no válida;;
esac
