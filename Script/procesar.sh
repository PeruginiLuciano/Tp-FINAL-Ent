

#!/bin/bash

# Expresion para saber si es una persona
PERSONA_EXPRESION_REG="^[A-Z][a-z]+[A-Z][a-z]+\.[A-Za-z]+$"
# Guardamos la ruta de nuestra carpeta actual
CARPETA_DESTINO=$(pwd)
CARPETA_IMAGENES_PROCESADAS="$(pwd)/imagenes_procesadas"
mkdir -p  "$CARPETA_IMAGENES_PROCESADAS"
DIRECTORIO_IMAGENES_GENERADAS="imagenes_generadas"

CANTIDAD_PROCESADA=0
#------------------------------------------------------------------#


for IMAGENES in "${DIRECTORIO_IMAGENES_GENERADAS}"/*.png "${DIRECTORIO_IMAGENES_GENERADAS}"/*.jpg "${DIRECTORIO_IMAGENES_GENERADAS}"/*.jpeg

do
	IMAGEN=$(echo "$IMAGENES" | sed 's/imagenes_generadas\///')
	# Verificar si el argumento es una imagen 
	if [  -f "$IMAGENES" ]
	# La imagen si existe
	then
		# Si existe corroboramos que sea el nombre de una persona
		if [[ "$IMAGEN" =~ $PERSONA_EXPRESION_REG ]]
		then
			# Creamos variable donde se guardara la imagen recortada
        		IMAGEN_RECORTADA="${CARPETA_DESTINO}/imagenes_procesadas/${IMAGEN%.*}PROCESADA.png"	
			# Usamos convert para convertir la imagen y la guardamos en imagen recortada
			convert "$IMAGENES" -gravity center -resize 512x512+0+0 -extent 512x512 "$IMAGEN_RECORTADA"
		
			echo "La imagen se ha convertido como $IMAGEN_RECORTADA"
			CANTIDAD_PROCESADA=$(( CANTIDAD_PROCESADA + 1 ))
			
		
		else
			# La imagen existe pero no es un nombre de persona 
			echo "La imagen no es un nombre de persona. $IMAGEN"
		fi
	fi
done

echo ""
echo "Se procesaron en total $CANTIDAD_PROCESADA imagenes con nombres validos" 
echo ""
echo ""
