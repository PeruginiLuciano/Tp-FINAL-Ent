
#!/bin/bash
# Variables
SALIDA=""
while true
do
	# Solicitar los nombres de los archivos
	read -p "Ingresa el nombre del archivo comprimido$SALIDA: " archivo_comprimido
	read -p "Ingresa el nombre del archivo de suma de verificación: " archivo_suma_verificacion
	
	if [ "$archivo_comprimido" = "-1" ]
	then
		echo "Cerrar manualmente..."
		sleep 3
		exit 1
	# Verificar la existencia de los archivos
	elif [ ! -f "$archivo_comprimido" ]; then
    		echo "Error: El archivo comprimido '$archivo_comprimido' no existe."
    		SALIDA=", o introduci -1 para salir"
	

	elif [ ! -f "$archivo_suma_verificacion" ]; then
    		echo "Error: El archivo de suma de verificación '$archivo_suma_verificacion' no existe."
    	
	

	# Verificar si el primer archivo es un archivo comprimido
	elif ! file -b "$archivo_comprimido" | grep -q "compressed"; then
  		echo "Error: El archivo '$archivo_comprimido' no es un archivo comprimido."
  	
	

	# Verificar si el segundo archivo es un archivo de texto
	elif ! file -b "$archivo_suma_verificacion" | grep -q "text"; then
  		echo "Error: El archivo '$archivo_suma_verificacion' no es un archivo de texto."
  	
	else 
		break
	fi
done	

# Verificar la integridad del archivo comprimido utilizando la suma de verificación
#suma_verificacion_generada=$(md5sum "$imagenes_generadas.tar.gz" | awk '{print $1}')
#suma_verificacion_guardada=$(cat "$suma_verificacion.txt")

#if [ "$suma_verificacion_generada" != "$suma_verificacion_guardada" ]; then
 #   echo "Error: La suma de verificación no coincide. El archivo comprimido puede estar corrupto."
  #  exit 1
#fi

# Descomprimir el archivo comprimido
directorio_destino=$(pwd)

tar -xf "$archivo_comprimido" -C "$directorio_destino"

echo "El archivo comprimido se ha descomprimido correctamente en el directorio '$directorio_destino'."
# Eliminar el archivo comprimido
rm "$archivo_comprimido"

