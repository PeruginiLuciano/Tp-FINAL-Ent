#!/bin/bash
ARCHIVOS="$(pwd)/Archivos_nombres"
touch "${ARCHIVOS}/todos_los_nombres.txt"
touch "${ARCHIVOS}/nombres_validos.txt"
touch "${ARCHIVOS}/nombres_finalizan_a.txt"

PERSONA_EXPRESION_REG="^[A-Z][a-z]+\.[A-Za-z]+$"
PERSONA_EXPRESION_TERMINA_A=".*a$"
for IMAGEN in *.png *.jpg *.jpeg
do
	if [[ -f "$IMAGEN" ]]
	then
		echo  "${IMAGEN%.*}" >> "${ARCHIVOS}/todos_los_nombres.txt"
		# Si existe corroboramos que sea el nombre de una persona
       		if [[ "$IMAGEN" =~ $PERSONA_EXPRESION_REG ]]
		then
			echo "${IMAGEN%.*}" >> "${ARCHIVOS}/nombres_validos.txt"
		
			if [[ "${IMAGEN%.*}" =~ $PERSONA_EXPRESION_TERMINA_A ]]
			then   
				echo "${IMAGEN%.*}" >> "${ARCHIVOS}/nombres_finalizan_a.txt"

			fi
		fi	
	fi
done
if [ "$(ls -A Imagenes_recortadas)" ]
then    
        zip -r imagenes_recortadas.zip Imagenes_recortadas Archivos_nombres
else
        echo "no se genero zip ya que no hay archivos de imagenes" 
fi

