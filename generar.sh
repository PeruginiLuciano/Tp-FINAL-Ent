#!/bin/bash

REG_VALIDAR_CANT_IMG="^[0-9]+$"

# Imprime un mensaje en caso que el usuario se equivoque 
function string_error {
	echo "*************************************"
	echo -e "\e[31m------------------------"
	echo -e " ERROR, OPCION INVALIDA, INGRESE UN NUMERO ENTERO"
	echo -e "------------------------\e[0m"
	echo
}
# le pido al usuario la cantidad de imagenes que quiere generar
read -p "Ingrese la cantidad de imágenes: " CANT_IMG

# Valido que ingrese numeros unicamente
if ! [[ "$CANT_IMG" =~ $REG_VALIDAR_CANT_IMG ]]; then
  string_error
  exit 1
fi

# Lista de nombres de personas
nombres=("Juan" "María" "Pedro" "Ana" "Luis" "Laura")

# Directorio para almacenar las imágenes generadas
directorio_salida="imagenes_generadas"

# Crear el directorio de salida si no existe
mkdir -p "$directorio_salida"

# Generar imágenes y asignar nombres de archivo al azar
for ((i=1; i<=cantidad_imagenes; i++)); do
  # Obtener un nombre aleatorio de la lista de nombres
  nombre_aleatorio=${nombres[$RANDOM % ${#nombres[@]}]}

  # Generar una imagen usando el servicio web (reemplazar con el comando o script adecuado)
  # Por ejemplo, usando wget para descargar una imagen de una URL ficticia
  # get -O "$directorio_salida/$nombre_aleatorio.jpg" "https://source.unsplash.com/random/900%C3%97700/?person"

  sleep 3
done

# Comprimir las imágenes generadas
tar -czvf imagenes_generadas.tar.gz "$directorio_salida"

# Generar el archivo de suma de verificación
md5sum imagenes_generadas.tar.gz > suma_verificacion.txt

echo "Imágenes generadas, comprimidas y suma de verificación generada."


