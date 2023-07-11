


#!/bin/bash
# Variables
ARCHIVO_COMPRIMIDO=$1
SUMA_VERIFICACION=$2

# Descomprimir el archivo comprimido
directorio_destino=$(pwd)


# Verificamos que los argumentos sean archivos
if [ -f "$ARCHIVO_COMPRIMIDO" ] && [ -f "$SUMA_VERIFICACION" ]
then
	tar -xf "$ARCHIVO_COMPRIMIDO" -C "$directorio_destino"
	# Verificar la integridad del archivo comprimido utilizando la suma de verificación	
	touch suma_verificacion_nueva.txt
	md5sum "$ARCHIVO_COMPRIMIDO" > suma_verificacion_nueva.txt


	suma_original=$(cat "$SUMA_VERIFICACION")

	suma_nueva=$(cat suma_verificacion_nueva.txt)

	if [ "$suma_original" != "$suma_nueva" ]
        then
   		 echo "Error: La suma de verificación no coincide. El archivo comprimido puede estar corrupto."
 	else
	

		echo "El archivo comprimido se ha descomprimido correctamente en el directorio '$directorio_destino'."
		# Eliminar el archivo comprimido
		rm -r suma_verificacion_nueva.txt
		rm -r imagenes_generadas.tar

	fi

else 
	echo "ERROR con los archivos ingresados por argumento, verifiquelos y vuelva a intentarlo"
fi
