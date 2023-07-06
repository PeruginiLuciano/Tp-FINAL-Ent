#!/bin/bash

# Solicitar los nombres de los archivos
read -p "Ingresa el nombre del archivo comprimido: " archivo_comprimido
read -p "Ingresa el nombre del archivo de suma de verificación: " archivo_suma_verificacion

# Verificar la existencia de los archivos
if [ ! -f "$archivo_comprimido" ]; then
    echo "Error: El archivo comprimido '$archivo_comprimido' no existe."
    exit 1
fi

if [ ! -f "$archivo_suma_verificacion" ]; then
    echo "Error: El archivo de suma de verificación '$archivo_suma_verificacion' no existe."
    exit 1
fi

# Verificar la integridad del archivo comprimido utilizando la suma de verificación
#suma_verificacion_generada=$(md5sum "$imagenes_generadas.tar.gz" | awk '{print $1}')
#suma_verificacion_guardada=$(cat "$suma_verificacion.txt")

#if [ "$suma_verificacion_generada" != "$suma_verificacion_guardada" ]; then
 #   echo "Error: La suma de verificación no coincide. El archivo comprimido puede estar corrupto."
  #  exit 1
#fi

# Descomprimir el archivo comprimido
directorio_destino="descomprimido"
mkdir -p "$directorio_destino"
tar -xf "$archivo_comprimido" -C "$directorio_destino"

echo "El archivo comprimido se ha descomprimido correctamente en el directorio '$directorio_destino'."

