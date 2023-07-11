#!/bin/bash

# Expresion para saber si es una persona
PERSONA_EXPRESION_REG="^[A-Z][a-z]+\.[A-Za-z]+$"
# Guardamos la ruta de nuestra carpeta actual
CARPETA_DESTINO=$(pwd)
#------------------------------------------------------------------#
# Verificar si se proporcionó el nombre de la imagen como argumento solo permitimos una
if [ $# -ne 1 ]
then
	echo "Se debe ingresar como argumento una unica imagen."
	exit 1
else
	echo "esta todo ok"
	# Creamos la variable imagen y guardamos el argumento
	IMAGEN="$1"
	# Mostramos la cariable imagen
	echo "$IMAGEN"
	# Creamos variable donde se guardara la imagen recortada
	IMAGEN_RECORTADA="${CARPETA_DESTINO}/${IMAGEN%.*}_RECORTADA.png"

fi



# Verificar si el argumento es una imagen 
if [  -f "$IMAGEN" ]
# La imagen si existe
then
	# Si existe corroboramos que sea el nombre de una persona
	if [[ "$IMAGEN" =~ $PERSONA_EXPRESION_REG ]]
	then
		# Usamos convert para convertir la imagen y la guardamos en imagen recortada
		convert "$IMAGEN" -gravity center -resize 512x512+0+0 -extent 512x512 "$IMAGEN_RECORTADA"
		
		echo "La imagen se ha convertido como $IMAGEN_RECORTADA"
		exit 0
	fi
else
	# Si el argumento no es una imagen
	echo "La imagen no existe en el directorio"
	exit 1
fi
# La imagen existe pero no es un nombre de persona 
echo "La imagen no es un nombre de persona."
