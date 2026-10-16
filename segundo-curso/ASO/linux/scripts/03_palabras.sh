#!/bin/bash
# Pide una palabra y la añade (sin borrar lo anterior) a palabras.txt.
read -p "Introduce una palabra: " palabra
echo "$palabra" >> palabras.txt
echo "Añadida. Contenido actual de palabras.txt:"
cat palabras.txt
