




#!/bin/bash
   
# Declaracion de variables

REG_VALIDAR_OPCION="^[0-4]$" # Variable donde guardamos una expresion regular para comparar con la opcion seleccionada 
# Creo los string para usar en la interfaz, ya que luego los voy a cambiar de color 
GENERAR="1) Generar imagen"
DESCOMPRIMIR="2) Descomprimir imagen"
PROCESAR="3) Procesar imagen"
COMPRIMIR="4) Comprimir imagen" 
# Creo variable para darle 3 intentos al usuario de equivocarse al ingresar la opcion
INTENTOS=3
# Creo variable para indicar errores al usuario
ERRORES=""
#------------------------------------------------------------------------------------------------------------------#
# Declaracion de funciones 
# Menu principal, imprime las opciones disponibles y pide al usuario que ingrese una
function menu {	
# Menu va a recibir siempre un argumento que va a ser utilizado para saber que ya se utilizo la opcion y pintarla de verde
	# Al comienzo recibe comenzamos para y no hace nada, esto lo hacemos para evitar conflictos con el if
	if   [ "$1" = "COMENZAMOS" ]
	then
		echo ""
	# Por ejemplo si se realizo la accion de la opcion 1 se llamara a menu y se enviara Generar terminado entonces entrara y pintara la opcion de verde, para que el usuarios sepa que ya la utilizo
	elif [ "$1" = "Generar terminado" ]
	then
		GENERAR="$(echo -e '\e[32m1) Generar imagen\e[0m')"
		ERRORES=""
	# Si en generar se provoco un error se pintara en rojo
	elif [ "$1" = "Generar error" ]
        then
                GENERAR="$(echo -e '\e[31m1) Generar imagen\e[0m')"
		ERRORES="Error al querer generar un numero de imagenes incorrectas"
	# Lo mismo para cada opcion..
	elif [ "$1" = "Descomprimir terminado" ]
        then
                DESCOMPRIMIR="$(echo -e '\e[32m2) Descomprimir imagen\e[0m')"
		ERRORES=""
	elif [ "$1" = "Descomprimir error" ]
        then
                DESCOMPRIMIR="$(echo -e '\e[31m2) Descomprimir imagen\e[0m')"
		ERRORES="Error al descomprimir"
	elif [ "$1" = "Procesar terminado" ]
        then
                PROCESAR="$(echo -e '\e[32m3) Procesar imagen\e[0m')"
	elif [ "$1" = "Comprimir terminado" ]
        then
                COMPRIMIR="$(echo -e '\e[32m4) Comprimir imagen\e[0m')"

	elif [ $1 -ne 0 ] # En caso de que el usuario introduzca una opcion incorrecta se llamara la funcion menu pasandole como argumento la cantidad de intentos que le quedan disponibles
	then
		# Le aviso cuanro instentos le quedan por argumento, siempre y cuando sean difrente a 0
		echo "te quedan $1 intentos"
		echo
		echo "*************************************"
		echo
		echo
		echo
	
	else

		# limpio la consola
                limpiar_consola
		# Llamo funcion error, que muestar una interfaz de error 
                string_error
                echo ""
		# Ya no le doy mas opciones de seguir intentando
                echo "Se agoraron los intentos, vuelva a probar mas tarde"
                exit 1
                               
	
	fi
	# Menu principal
	# Los caracteres antes y despues del string son para hacerlo en negrita
	echo "$ERRORES"
	echo -e "\e[1mBienvenidos al trabajo final\e[0m"
	echo "----------------------------"
	echo ""
	# Llamo a las variables que contienen los string con funciones, como ya explicamos lo hacemos asi para poder cambiarle el color luego de ser utilizada
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
	# Muestro un mensaje de error
	echo "*************************************"
	# Los caraceteres antes y despues del string son para cambiar el color
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
# Llamar descompirmir se utiliza para que el usuario pase por argumento el archivo comprimido y su suma de verificacion
function llamar_descomprimir {
	read -p "Ingrese el nombre del archivo comprimido, o ingrese 1 para que el sistema tome los ultimos generados: " archivo_comprimido
	RTA_ARG="$archivo_comprimido"
	if [ "$archivo_comprimido" == "1" ]
	then	
		RTA_ARG="ENTREEEEEE"
		source Script/descomprimir.sh imagenes_generadas.tar suma_verificacion.txt
		RTA_ARG="0"
	else
		read -p "Ingrese el nombre del archivo suma de verificación: " suma_verificacion
		if [ -f "$archivo_comprimido" ] && [ -f "$suma_verificacion" ]
		then
			source Script/descomprimir.sh "$archivo_comprimido" "$suma_verificacion"
			RTA_ARG="0"
		else 
			limpiar_consola
			RTA_ARG="1"
		fi
	fi
}


limpiar_consola
# Llamamos a la funcion menu con nuestro argumento , si menu se llamo desde generar por un error pasara como argumento generar error, sino nuestra palabla clave que es COMENZAMOS
if [ "$1" == "Generar error" ]
then
	menu "Generar error"
else
	menu "COMENZAMOS"
fi

#------------------------------------------------------------------------------------------------#
# Bucle while para que el menu se ejectute constantemente luego de cada eleccion, le damos un escape secreto que es el -1
while [ "$OPCION" != "-1" ]

do

   # Revisamos si el usuario ingresa o no una opcion 	
   if [ -n "$OPCION" ] 
   then
	# Verificamos que la opcion introducida sea correcta (entre 0 y 4)
	if [[ "$OPCION" =~ $REG_VALIDAR_OPCION ]]
	then
		if [ "$OPCION" -eq 1 ]
		then
			# si la opcion es 1, entonces ejecutamos generar.sh
			source Script/generar.sh
			# Cuando termine le pedimos que toque una tecla para continuar
                        read -p "Generar terminado, toque enter para continuar... "
			# Limpiamos consola
                        limpiar_consola 
			# Llamamos a menu con el argumento Generar terminado y asi lo pintara de verde
			menu "Generar terminado"
		# Repetimos todo para cada opcion valida
		elif [ "$OPCION" -eq 2 ] 
        	then 	
			llamar_descomprimir 
			if [ "$RTA_ARG" == "0" ]
			then
                		read -p "Descomprimir terminado, toque enter para continuar... "
                 		limpiar_consola
                 		menu "Descomprimir terminado"
			else
				limpiar_consola
				echo "ERROR, no se encontraron los archivos ingresados"
				echo "$RTA_ARG"
				menu "Descomprimir error"			 
			fi
		elif [ "$OPCION" -eq 3 ] 
        	then 
                	source Script/procesar.sh
                        read -p "Procesar terminado, toque enter para continuar... "
                        limpiar_consola 
			menu "Procesar terminado"
		elif [ "$OPCION" -eq 4 ] 
        	then 
			source Script/comprimir.sh
             		read -p "Compirmir terminado, toque enter para continuar... "
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
