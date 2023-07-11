#!/bin/bash

function extraer_nombres {
        # Descargar el archivo dict.csv
        wget -q https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv -O Script/dict.csv

        # Extraer solo los nombres sin los números utilizando grep y sed
       
        NOM=$(cat Script/dict.csv | sed 's/,[^,]*//g' | sed 's/ //g')
	echo "$NOM"     
        return 0
}
NOMBRES=$(extraer_nombres)
echo "$NOMBRES"

