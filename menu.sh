

#!/bin/bash

# Declaracion de variables
REG_VALIDAR_OPCION="^[0-4]$" # Variable donde guardamos una expresion regular para comparar con la opcion seleccionada 
#------------------------------------------------------------------------------------------------------------------#
# Declaracion de funciones 
# Menu principal, imprime las opciones disponibles y pide al usuario que ingrese una
function menu {
	if [ $# -eq 1 ] # En caso de que el usuario introduzca una opcion incorrecta se llamara la funcion menu pasandole como argumento la cantidad de intentos que le quedan disponibles
	then
		echo "te quedan $1 intentos"
		echo
		echo "*************************************"
		echo
		echo
		echo
	
	fi
	# Menu principal
	echo -e "\e[1mBienvenidos al trabajo final\e[0m"
	echo "----------------------------"
	echo ""
	echo "1) Generar imagen"
	echo "2) Descargar imagen"
	echo "3) Procesar imagen"
	echo "4) Comprimir imagen"
	echo "-----------------------------"
	echo "0) Salir"
	echo ""
	read -p "Elegi una opcion: " OPCION # Se pide que introduzca una opcion, y se guarda en la variable OPCION
}
# Imprime un mensaje en caso que el usuario se equivoque 
function string_error {
	echo "*************************************"
	echo -e "\e[31m------------------------"
	echo -e " ERROR, OPCION INVALIDA"
	echo -e "------------------------\e[0m"
	echo
	echo "'$OPCION' no es una opcion valida, vuelva a intentarlo"
        echo "--------------------------------------------"
        echo

}
# Limpia la consola
function limpiar_consola {
	clear
}
#------------------------------------------------------------------------------------------------#
# Lo primero que hacemos es limpiar la consola
limpiar_consola
# Mostramos el menu principal
menu
# Verificamos que la opcion introducida sea correcta (entre 0 y 4)
if [[ "$OPCION" =~ $REG_VALIDAR_OPCION ]]
then
	echo "es valido"
else
	# Si no es valido creamos un for para darle dos posibilidades mas 
	for i in {2..1}
	do
		# Limpiamos consola
		limpiar_consola
		# Mostramos error 
		string_error
		# Mostramos menu y le pasamos como argumento la cantidad de intentos restantes
		menu $i
		if [[ "$OPCION" =~ $REG_VALIDAR_OPCION ]]
		then
        		echo "salio fo"
			# Si es valido salimos del for
			break 
		else
			# si no es valido y ya probo 3 veces entoces cerramos el programa
			if [ $i -eq 1 ]
			then
				limpiar_consola
				string_error
				echo 
				echo "Se agoraron los intentos, vuelva a probar mas tarde"
				exit 1
			fi

		fi
	done
fi
