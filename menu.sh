
#!/bin/bash

#Declaracion de variables
REG_VALIDAR_OPCION="^[0-4]$"

# Declaracion de funciones 
function menu {
	if [ $# -eq 1 ]
	then
		echo "te quedan $1 intentos"
		echo
		echo "*************************************"
		echo
		echo
		echo
	
	fi
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
	read -p "Elegi una opcion: " OPCION
}

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

function limpiar_consola {
	clear
}

limpiar_consola
menu
if [[ "$OPCION" =~ $REG_VALIDAR_OPCION ]]
then
	echo "es valido"
else
	limpiar_consola
	string_error
	for i in {2..1}
	do
		limpiar_consola
		string_error
		menu $i
		if [[ "$OPCION" =~ $REG_VALIDAR_OPCION ]]
		then
        		echo "salio fo"
			break
		else
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
