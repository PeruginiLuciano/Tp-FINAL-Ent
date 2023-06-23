#!/bin/bash

function extraer_nombres {
        # Descargar el archivo dict.csv
        wget -q https://raw.githubusercontent.com/fernandezpablo85/name_suggestions/master/assets/dict.csv -O dict.csv

        # Extraer solo los nombres sin los números utilizando grep y sed
        NOM=$(grep -oE '^[A-Za-z ]+' dict.csv | sed 's/[0-9]*$//' | sed -E 's/(^|_)([a-z])/\1\u\2/g' | sed -E 's/([a-zA-Z]+)/\u&/g' | tr -d '_ ')
        echo "$NOM"     
        return 0
}
NOMBRES=$(extraer_nombres)
echo "$NOMBRES"

