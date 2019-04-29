#!/bin/bash
###############################################
#Nombre del archivo: ejer4.sh
#Trabajo practico: 1
#Ejercicio: 4
#
#Integrantes del grupo:
#
#DNI       |APELLIDO      |NOMBRE
#
#
#40378763   Amato        Luciano
#38435945   Annacondia     Agustin
#39097812   Del Greco     Pablo
#39463982   Meza         Julian
#37276705   Pompeo      Nicolas
#
#Entrega: #1 ENTREGA - 29/04/2019
#
##############################################
 
function ayuda(){
  cat <<-END
Descripcion:
--------
    Este Script se encarga de comparar el archivo base con otros archivos de un directorio determinado, listando aquellos que tengan una coincidencia de registros igual o mayor a la indicada por parametro
Uso:
    ./ejer4.sh [Archivo base] [Directorio a buscar*] [Porcentaje de coincidencia]
    *en caso de no indicarse ninguno, por defecto se usara el directorio actual
---
  Mostrar ayuda
   ./ejer4.sh -h | -? | -help
   
END
}
 
# Si me pasa un solo parametro, este deberia ser -h
 
if [  "$1" == "-h"  ] || [ "$1" == "-help" ] || [ "$1" == "-?" ]; then
        ayuda
        exit
fi
 
# Si me pasa dos parametros, estos deberian ser el archivo base y el porcentaje de coincidencia
 
if  [[ $# == 2 ]]; then
        if ! [ -f "$1" ]; then
                echo "El primer parametro no es un archivo valido"
                exit
        fi
        if [[ $2 -lt 0 || $2 -gt 100 ]]; then
                echo "No es un porcentaje de coincidencia valido"
                exit
        fi
        base=$1
        minimo=$2
        directorio="."
fi
 
# Si me pasa tres parametros, estos deberian ser el archivo base, el directorio a buscar
# y el porcentaje de coincidencia
 
if  [[ $# == 3 ]]; then
        if ! [ -f "$1" ]; then
                echo "El primer parametro no es un archivo valido"
                exit
        fi
        if ! [ -d "$2" ]; then
                echo "El segundo parametro no es un directorio valido"
                exit
        fi
        if [[ $3 -lt 0 || $3 -gt 100 ]]; then
                echo "No es un porcentaje de coincidencia valido"
                exit
        fi
        directorio=$2
        minimo=$3
        base=$1
fi
 
coincidencia() {
        totales=$(cut -d " " -f 1 <(wc -l $1))
        repeticiones=$(cut -d " " -f 1 <(wc -l <(comm -12 <(sort $1) <(sort $2))))
        porcentaje=$(($repeticiones*100/$totales))
        if [ $porcentaje -gt $minimo ]; then    
                echo $1 $2 $porcentaje  
        fi
}
 
for i in $(ls $directorio)
do
        if ! [ -d $directorio"/"$i ];then
                coincidencia $base $directorio"/"$i $minimo
        fi
done
