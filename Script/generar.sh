
#!/bin/bash  
# Variables
EXP_CANT_IMAGENES="^[0-9]+$"
# Solicitar la cantidad de imágenes a generar
read -p "Ingrese la cantidad de imágenes a generar: " cantidad_imagenes

# Imprime un mensaje en caso que el usuario se equivoque 
function string_error {
	echo "*************************************"
	echo -e "\e[31m------------------------"
	echo -e " ERROR, OPCION INVALIDA, INGRESE UN NUMERO ENTERO"
	echo -e "------------------------\e[0m"
	echo
}

# Verificar que se proporcionó un número válido
if ! [[ "$cantidad_imagenes" =~ $EXP_CANT_IMAGENES ]]
then
  clear	
  echo "Debe ingresar un numero entero a partir del 1"	
  source Script/menu.sh "Generar error" 
fi

# Lista de nombres de personas
nombres=$(source Script/personas.sh)
# Pasa la informacion a un arreglo ya que era un string
readarray -t lista <<< "$nombres"

sleep 2


# Cargar los nombres de personas desde el archivo personas.sh
#mapfile -t nombres < <(head -n 
# Directorio para almacenar las imágenes generadas
directorio_salida="imagenes_generadas"

# Crear el directorio de salida
mkdir -p "$directorio_salida"

# Generar imágenes y asignar nombres de archivo al azar
for ((i=1; i<=cantidad_imagenes; i++)); do
  # Obtener el número total de nombres
  num_nombres=${#lista[@]}
 echo "numeros nombres $num_nombres"
	
  # Obtener un número aleatorio dentro del rango de índices
  indice_aleatorio=$(seq 0 $(($num_nombres - 1)) | shuf -n 1)
 
  sleep 2
  # Obtener un nombre aleatorio de la lista de nombres
  nombre_aleatorio=${lista[$indice_aleatorio]}

  # Genero una imagen

  wget -O "$directorio_salida/$nombre_aleatorio.jpg" "https://source.unsplash.com/random/900%C3%97700/?person"

  sleep 2
done

# Comprimo las imágenes generadas
tar -czvf imagenes_generadas.tar "$directorio_salida"

# Genero el archivo de suma de verificación
md5sum imagenes_generadas.tar > suma_verificacion.txt

echo "Imágenes generadas, comprimidas en  y suma de verificación generada."

# Borramos directorio creado para guardar las imagenes

rm -r "$directorio_salida"

