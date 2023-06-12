#!/bin/bash

function extraer_nombres {
        # Descargar el archivo dict.csv
        wget -q https://raw.githubusercontent.com/fernandezpablo85/name_suggestions/master/assets/dict.csv -O dict.csv

        # Extraer solo los nombres sin los números utilizando grep y sed
        NOM=$(grep -oE '^[A-Za-z ]+' dict.csv | sed 's/[0-9]*$//' | sed 's/ /_/g')
        echo "$NOM"     
        return 0
}
NOMBRES=$(extraer_nombres)
echo "$NOMBRES"

