#!/bin/bash
# Indica si el argumento es un dígito, una letra o cualquier otra cosa.
# Uso: bash digito_caracter.sh <valor>
case $1 in
	[a-z]) echo carácter;;
	[A-Z]) echo carácter;;
	[0-9]) echo dígito;;
	*) echo otra cosa;;
esac
