#!/bin/bash


#-----------------------------------------------------------------------#
# Nombre del Script: Ejercicio3.sh								#
# Trabajo Práctico Nº1											#
# Integrantes:														#
#-Amato, Luciano						DNI:  	40.378.763		#
#-Pompeo, Nicolas Ruben			DNI:	37.276.705		#
#-Annacondia, Federico Agustin		DNI:	38.435.945		#
#-Del Greco, Juan Pablo				DNI:	39.097.812		#
#Meza, Julian							DNI:			#
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
USER=`whoami`

#Se valida que la cantidad de parámetros no se mayor a 1
if [[ $CANT_PARAMS -gt 1 ]]
	then
	echo "Se permite solo un parámetro de entrada"
	exit
fi

#Si existe algún parámetro
if [[ $PARAM ]]; then
	#Ayuda
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

#Valida que se haya pedido la ayuda para ejecutar el script





MIN=0		  	# Minimo numero
MAX=99    		# Maximo numero
COLS=15     	#Columnas para hacer bingo

declare -a Numeros

inicializar_Numeros (){
   local indice=0
   until [ "$indice" -gt $MAX ]
   do
     Numeros[indice]=0
     ((indice++))
   done

   Numeros[0]=1   
}


generar_numero ()
{
   local n1
   while [ 1 ]
   do
     let "n1 = $(expr $RANDOM % $MAX)"
     if [ ${Numeros[n1]} -eq 0 ]    
     then
       let "Numeros[n1]+=1"     
       break  
     fi   
   done

   return $n1
}

declare -a VARIABLE
OLDIFS=$IFS   # Valor original del IFS
A=-1          # Variable para moverse por el array
texto=$1
IFS=$'\n\t'
for LINEA in $(cat $1) ; do
  IFS='\t'  # Caracter separador
  for VALOR in $LINEA ; do
    let A=$A+1
    VARIABLE[$A]=${VALOR}
  done
  IFS=$'\n\t'
done
IFS=$OLDIFS 
cantCartones=${#VARIABLE[@]}
cantPosiciones=${#VARIABLE[@]}
let "cantCartones/=16"
let "cantCartones-=1" 
echo;echo
echo "Cantidad de Cartones En juego:"
echo $cantCartones
#-----------------------------------
RANDOM=$$  
inicializar_Numeros 
carton=0
nroCarton=0
bingo=0
while [[ "$bingo" != 1 ]]
do
   
  read -s -n1 -p "Ingresar letra para generar numero" letra
  echo

generar_numero; nuevoNumero=$?
echo $nuevoNumero

j=16					#Me va a contar los -1 para saber si es bingo
for i in {0..64}	#Hardcode
do
			if [[ "$nuevoNumero" == ${VARIABLE[$i]} ]]; then
				VARIABLE[i]=-1
				fi
done

aux2=$j
carton=0
cartonGanador=()
k=0
esBingo=0

while [[ "$carton" < "$cantCartones" ]] ; do
							posicionCarton=0
							#for i in {(0+j)..64}	#Hardcode
							let "posicionCarton+=j"
							let "posicionCarton*=(carton+1)"
							nroCarton=${VARIABLE[$posicionCarton]}
for((i=posicionCarton;i<(posicionCarton+16);i++))
do
			if [[ ${VARIABLE[$i]} == -1 ]]; then
					let "esBingo+=1"
				fi
done
if [[ "$esBingo" == 15 ]];then
bingo=1
cartonGanador+=($nroCarton)
fi
			let "carton+=1"
			esBingo=0

done
done
#--------------------------


echo "BINGO"
echo "${cartonGanador[$l]} - CARTON GANADOR"


echo; echo
echo

exit 0