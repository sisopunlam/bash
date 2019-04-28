#!/bin/bash


#-----------------------------------------------------------------------#
# Nombre del Script: Ejercicio3.sh								#
# Trabajo Práctico Nº1											#
# Integrantes:														#
#-Amato, Luciano			DNI:  	40.378.763		#
#-Pompeo, Nicolas Ruben			DNI:	37.276.705		#
#-Annacondia, Federico Agustin		DNI:	38.435.945		#
#-Del Greco, Juan Pablo			DNI:	39.097.812		#
#Meza, Julian				DNI:			#
# Entrega 29/04/2019											#
#-----------------------------------------------------------------------#

sintaxis(){	
    echo ""
	echo "Ejercicio 3 - Versión 1"
	echo ""
	echo "Uso: ./Ejercicio3.sh  ruta/archivo  --> En la ejecucion mandar el archivo prueba de los cartones de bingo"
	echo "Ejemplo: ./Ej.sh ./Documentos/Bingo.txt"
	echo ""
	echo "En este ejercicio se generaran numeros al azar hasta que uno de los cartones en el archivo haga bingo"
	echo "Tendra que presionar cualquier letra reiteradas veces hasta que un carton haga Bingo"
	echo "El programa finalizara cuando gana alguno"
	echo ""
	
}
CANT_PARAMS=$# 
PARAM=$1
#Se valida que la cantidad de parámetros no se mayor a 1
if [[ $CANT_PARAMS -gt 1 ]]
	then
	echo "Se permite solo un parámetro de entrada"
	exit
fi

#Si existe algún parámetro
if [[ $PARAM ]]; then
#Valida que se haya pedido la ayuda para ejecutar el script
	if [[ $PARAM == "-?" || $PARAM == "-h" || $PARAM == "-help" ]] 
	then
		sintaxis
		exit 1
	else
		#Se valida el parametro con formato "ruta/archivo"
		for (( i=0; i<${#PARAM}; i++ )); do
		  	if [[ ${PARAM:$i:1} != [A-Za-Z.0-9/] ]]
				then
				echo "La ruta y el archivo deben tener el formato \"ruta/archivo\""
				exit
			fi
		done
		FILENAME=$1
	fi
fi

#Separamos la variable PATH por cada directorio

IFS=':' read -r -a array <<< $PATH

#!/bin/bash

# validar parametros

comprobarCarton ()
{
	ale=$1
	if [ $ale -ge "0" ] && [ $ale -le "9" ]
	then
		ale="0$ale"
	fi
	echo "Este es el numero sorteado: $ale"
	for carton in "${!cartones[@]}"
	do
		lineas=${cartones[$carton]}
		line1=${lineas%%|*}
		aux=${lineas#*|}
		line2=${aux%%|*}
		line3=${lineas##*|}
		echo "linea 1: $line1 ---- linea 2: $line2 ---- linea 3: $line3"
		line1=$(echo $line1 | sed 's/'$ale'//')
		line2=$(echo $line2 | sed 's/'$ale'//')
		line3=$(echo $line3 | sed 's/'$ale'//')
		
		aux1=$(echo $line1|tr -d '[[:space:]]')
		echo "numeros que qdan en linea 1: $aux1"
		if [ -z $aux1 ]
		then
			echo "carton numero $carton completo la linea 1"
		fi
		aux2=$(echo $line2|tr -d '[[:space:]]')
		echo "numeros que qdan en linea 2: $aux2"
		if [ -z $aux2 ]
		then
			echo "carton numero $carton completo la linea 2"
		fi
		aux3=$(echo $line3|tr -d '[[:space:]]')
		echo "numeros que qdan en linea 3: $aux3"
		if [ -z $aux3 ]
		then
			echo "carton numero $carton completo la linea 3"
		fi
		if [ -z $aux1 ] && [ -z $aux2 ] && [ -z $aux3 ]
		then
			echo "el carton numero $carton ha gritado BINGO!!!"
			exit 1
		fi
		cartones[$carton]="$line1|$line2|$line3"
	done

}

generar_numero ()
{
	local number
	while [ 1 ]
	do
		number=$(($RANDOM%100))
		if [ ${Numbers[number]} -eq 0 ]    
		then
			let "Numbers[number]+=1"         
			break                       
		fi 
	done
	comprobarCarton $number
}

IFS="	"
while read cod n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15
do
	echo "todos los cartones : $cod $n1	$n2	$n3	$n4	$n5|$n6	$n7	$n8	$n9	$n10|$n11	$n12	$n13	$n14	$n15"
	cartones[$cod]+="$n1	$n2	$n3	$n4	$n5|$n6	$n7	$n8	$n9	$n10|$n11	$n12	$n13	$n14	$n15"
done < "$1"
for i in {0..99}
do
	Numbers[$i]+=0
done

#trap "generar_numero" SIGUSR1
#trap "" SIGINT

generar_numero

#while [ 1 ]
#do
	#sleep 5
#done
