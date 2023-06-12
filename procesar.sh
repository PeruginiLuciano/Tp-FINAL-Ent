#!/bin/bash

# Expresion para saber si es una persona
PERSONA_EXPRESION_REG="^[A-Z][a-z]+\.[A-Za-z]+$"
CARPETA_DESTINO=$(pwd)
# Verificar si se proporcionó el nombre de la imagen como argumento
if [ $# -ne 1 ]
then
	echo "Se debe ingresar como argumento una unica imagen."
	exit 1
else
	echo "esta todo ok"
	IMAGEN="$1"
	echo "$IMAGEN"
	IMAGEN_RECORTADA="${CARPETA_DESTINO}/${IMAGEN%.*}_RECORTADA.png"

fi



# Verificar si la imagen existe
if [  -f "$IMAGEN" ]
# La imagen si existe
then
	if [[ "$IMAGEN" =~ $PERSONA_EXPRESION_REG ]]
	then
		convert "$IMAGEN" -gravity center -resize 512x512+0+0 -extent 512x512 "$IMAGEN_RECORTADA"
		
		echo "La imagen se ha convertido como $IMAGEN_RECORTADA"
		exit 0
	fi
else
	echo "La imagen no existe en el directorio"
	exit 1
fi

echo "La imagen no es un nombre de persona."
