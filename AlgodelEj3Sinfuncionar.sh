#!/bin/bash

generar_numero ()
{
   local number

   while [ 1 ]
   do
     let "number = $(expr $RANDOM %99)"
     if [ ${Numbers[number]} -eq 0 ]    
     then
       let "Numbers[number]+=1"         
       break                       
     fi 
   done


   return $number
}
 #----------------------------
function contiene(){
local n=$#
local value=${!n}
for((i=1;i<$#;i++)){
	if [ "${!i}" =="${value}" ]; then
return 0
fi
}
return 1
}
#------------------------------
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
IFS=$OLDIFS # Restablece el IFS a su valor original
 
# Si el array no esta vacio muestra los resultados
if [ $A -ge 0 ] ; then
  for B in `seq 0 $A` ; do
    echo "VARIABLE[$B] = ${VARIABLE[$B]}"
  done
fi

cantCartones=${#VARIABLE[@]}
let "cantCartones/=16"
let "cantCartones-=1" 
echo $cantCartones
carton=0
nroCarton=0
bingo=0
declare -a numSalidos			#Esto habria que reemplazarlo por le trap sigusr1
let "numS*=0"
if [ $numS	-eq	0 ];	then
numSalidos[$numS]=$(expr $RANDOM %99)
let "numS+=1"
echo ${numSalidos[$numS]}
else
let "bolilla=$(expr $RANDOM %99)"
while ["contiene ${numSalidos[@]} $bolilla" -eq 0] ; do #mientras este en el array de numSalidos lo sigo generando
let "bolilla=$(expr $RANDOM %99)"
done #cuando salga quiere decir que es un numero nuevo
fi

while [ $bingo -eq 0 ]; do
j=16
i=16							#Me va a contar los -1 para saber si es bingo

while [ $carton -le $cantCartones ] ; do
aux=$i

while [ $i -lt $($aux+16) ]; do
			nroCarton=${VARIABLE[$I]}
			let"i+=1"
			if [ $bolilla -eq ${VARIABLE[$I]} ]; then
				let "VARIABLE[$i]=-1"
				fi
let"i+=1"
					done

			let "carton+=1"
done # fin del while[ $carton -lt $cantCartones ] ; do
aux2=$j
carton=0
cartonGanador=0
k=0
esBingo=0
while [ $carton -le $cantCartones ] ; do

while [ $j -lt $($aux2+16) ]; do
			nroCarton=${VARIABLE[$j]}
			let"j+=1"
				if[ ${VARIABLE[$j] -eq -1]; then
					let "esBingo+=1"
				fi
			let"j+=1"

			if [ $esBingo -eq 15 ]; then
				cartonGanador[$k]=$nroCarton
				let "k+=1"
			fi
			let "carton+=1"
			esBingo=0
	done
carton=${#cartonGanador[@]} #Esto solo ve si hay bingo, no controla linea
if((carton>0))
bingo=1
for((l=0;l<carton;l++))
do
echo "Carton Ganador"
echo ${cartonGanador[$l]}
done
fi
done	#while del bingo
