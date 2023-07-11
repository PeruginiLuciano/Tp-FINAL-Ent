



#!/bin/bash
ARCHIVOS="$(pwd)/Archivos_nombres"
mkdir -p "$ARCHIVOS"
touch "${ARCHIVOS}/todos_los_nombres.txt"
touch "${ARCHIVOS}/nombres_validos.txt"
touch "${ARCHIVOS}/nombres_finalizan_a.txt"

PERSONA_EXPRESION_REG="^[A-Z][a-z]+[A-Z][a-z]+\.[A-Za-z]+$"
PERSONA_EXPRESION_TERMINA_A=".*a$"
for IMAGENES in "imagenes_generadas/"*.png "imagenes_generadas/"*.jpg "imagenes_generadas/"*.jpeg
do
	IMAGEN=$(echo "$IMAGENES" | sed 's/imagenes_generadas\///')	
	if [[ -f "$IMAGENES" ]]
	then
		echo  "${IMAGEN%.*}" >> "${ARCHIVOS}/todos_los_nombres.txt"
		# Si existe corroboramos que sea el nombre de una persona
       		if [[ "$IMAGEN" =~ $PERSONA_EXPRESION_REG ]]
		then
			echo "${IMAGEN%.*}" >> "${ARCHIVOS}/nombres_validos.txt"
		
			
		fi	
		if [[ "${IMAGEN%.*}" =~ $PERSONA_EXPRESION_TERMINA_A ]]
                        then   
                                echo "${IMAGEN%.*}" >> "${ARCHIVOS}/nombres_finalizan_a.txt"

                fi
		
	fi
done
if [ "$(ls -A imagenes_procesadas)" ]
then    
        tar -cvf /Script/comprimido/imagenes_procesadas.tar imagenes_procesadas Archivos_nombres
	rm -r imagenes_procesadas
	rm -r Archivos_nombres
	rm -r imagenes_generadas
	

else
        echo "no se genero zip ya que no hay archivos de imagenes" 
fi

