


#!/bin/bash
  
# Declaracion de variables
REG_VALIDAR_OPCION="^[0-4]$" # Variable donde guardamos una expresion regular para comparar con la opcion seleccionada 
GENERAR="1) Generar imagen"
DESCOMPRIMIR="2) Descomprimir imagen"
PROCESAR="3) Procesar imagen"
COMPRIMIR="4) Comprimir imagen" 
INTENTOS=3
#------------------------------------------------------------------------------------------------------------------#
# Declaracion de funciones 
# Menu principal, imprime las opciones disponibles y pide al usuario que ingrese una
function llamar_descomprimir {
	source descomprimir.sh
	SALIDA=$?
	if [ $SALIDA -eq 0 ]
	then
      	 	 read -p "Descomprimir terminado, toque una tecla para continuar... "
                 limpiar_consola
                 menu "Descomprimir terminado"
   	 else	
		
       		read -p  "Ocurrio un error descomprimiendo, oprimi enter para continuar..."
		menu "COMENZAMOS"
    	fi
}
function menu {	

	if   [ "$1" = "COMENZAMOS" ]
	then
		echo ""
	elif [ "$1" = "Generar terminado" ]
	then
		GENERAR="$(echo -e '\e[32m1) Generar imagen\e[0m')"
	elif [ "$1" = "Descomprimir terminado" ]
        then
                DESCOMPRIMIR="$(echo -e '\e[32m2) Descomprimir imagen\e[0m')"
	elif [ "$1" = "Procesar terminado" ]
        then
                PROCESAR="$(echo -e '\e[32m3) Procesar imagen\e[0m')"
	elif [ "$1" = "Comprimir terminado" ]
        then
                COMPRIMIR="$(echo -e '\e[32m4) Comprimir imagen\e[0m')"

	elif [ $1 -ne 0 ] # En caso de que el usuario introduzca una opcion incorrecta se llamara la funcion menu pasandole como argumento la cantidad de intentos que le quedan disponibles
	then
		echo "te quedan $1 intentos"
		echo
		echo "*************************************"
		echo
		echo
		echo
	
	else


                limpiar_consola
                string_error
                echo 
                echo "Se agoraron los intentos, vuelva a probar mas tarde"
                exit 1
                               
	
	fi
	# Menu principal
	echo -e "\e[1mBienvenidos al trabajo final\e[0m"
	echo "----------------------------"
	echo ""
	echo "$GENERAR"
	echo "$DESCOMPRIMIR"
	echo "$PROCESAR"
	echo "$COMPRIMIR"
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
limpiar_consola
menu "COMENZAMOS"

#------------------------------------------------------------------------------------------------#
while [ "$OPCION" != "-1" ]

do


   if [ -n "$OPCION" ] 
   then
	# Verificamos que la opcion introducida sea correcta (entre 0 y 4)
	if [[ "$OPCION" =~ $REG_VALIDAR_OPCION ]]
	then
		if [ "$OPCION" -eq 1 ]
		then
			
			source generar.sh
                        read -p "Generar terminado, toque una tecla para continuar... "
                        limpiar_consola 
			menu "Generar terminado"
		elif [ "$OPCION" -eq 2 ] 
        	then 
                	llamar_descomprimir			 
		elif [ "$OPCION" -eq 3 ] 
        	then 
                	source procesar.sh
                        read -p "Procesar terminado, toque una tecla para continuar... "
                        limpiar_consola 
			menu "Procesar terminado"
		elif [ "$OPCION" -eq 4 ] 
        	then 
			source comprimir.sh
             		read -p "Compirmir terminado, toque una tecla para continuar... "
			limpiar_consola  
 			menu "Comprimir terminado"
		elif [ "$OPCION" -eq 0 ] 
        	then
                	echo "Cerrando sesion..."
			sleep 2
			limpiar_consola
			exit 0
		fi 
	else
			INTENTOS=$((INTENTOS - 1))
			# Limpiamos consola
			limpiar_consola
			# Mostramos error 
			string_error
			# Mostramos menu y le pasamos como argumento la cantidad de intentos restantes
			menu $INTENTOS
	fi
  else
	INTENTOS=$((INTENTOS - 1))
        # Limpiamos consola
        limpiar_consola
        # Mostramos error 
        string_error
	echo "Por favor debe ingresar algo"
        # Mostramos menu y le pasamos como argumento la cantidad de intentos restantes
	
        menu $INTENTOS
  fi	
			    
done
echo "Cierre de sistema modo seguro, esto puede tardar unos segundos..."
sleep 3
