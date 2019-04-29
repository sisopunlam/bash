#!/bin/bash
###############################################
#Nombre del archivo: ejer3.sh
#Trabajo pr�ctico: 1
#Ejercicio: 3
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

    Este Script que generara un backup comprimido de una ruta especificada
    Tiene 3 parámetros....

Uso:
---
  Mostrar ayuda
   ./ejer5.sh -h | -? | -help

   Para una correcta ejecución se deben enviar la ruta del directorio y comprecion
   ./ejer5.sh [directorio a analizar]

Ejemplos:
--------
    ./ejer5.sh lotes -x bzip2
   ./ejer5.sh ./lotes/carp1 -t
END
}

#Si se indican alguno de los parametros de ayuda
	if [  "$1" == "-h"  ] || [ "$1" == "-help" ] || [ "$1" == "-?" ]; then
		ayuda
	  	exit
	fi
#Si los parametros son incorrectos
  	if [ $# -lt 2 ]; then
  		echo "Faltan parametros vea la ayuda con ./ejer5.sh -h "
  		exit
  	fi

#Si el directorio no existen
    if [ ! -d "$1" ]; then
      echo "El directorio \"$1\" no existe."
      exit;
    fi


#INICIO DEL PROGRAMA
TIME=`date +%d-%m-%Y-%H%M%S`
case "$2" in
"-t")#EXTENCION GENERICA
  	zip -r "$1_$TIME.zip" $1
    ext="zip"
;;
"-x") # EXTENCION ESPECIFICA
if [ $# -lt 3 ]; then
  echo "Faltan parametros vea la ayuda con ./ejer5.sh -h "
  exitFECHA=`date +%d-%m-%Y-%H:%M:%S`
fi

case "$3" in
  "rar")
  zip -r "$1_$TIME.rar" $1
  ext="rar"
  ;;
  "zip")
  zip -r "$1_$TIME.zip" $1
  ext="zip"
  ;;
  "tar")
  tar -cvf "$1_$TIME.tar" $1
  ext="tar"
  ;;
  "bzip2")
  tar -c $1 | bzip2 > $1_$TIME.tar.bz2
  ext="tar.bz2"
  ;;
  esac

;;
*)
	echo "Debe elegir un indicador [-t] [-x] "
	exit
;;
esac


#ARCHOVO LOG Y DELETE
tree -f $1>$1_$TIME.log
echo "$1_$TIME.$ext" >> .$1.log
echo "$1_$TIME.log" >> .$1.log
cant=$(wc .$1.log -l | awk '{ print $1 }')

if [[ $cant -eq 12 ]]; then
  line=$(sed -n '1p' .$1.log)
  line2=$(sed -n '2p' .$1.log)
  rm -r "$line"
  rm -r "$line2"
  sed -i -e "1d" .$1.log
  sed -i -e "1d" .$1.log
  echo "Se ha eliminado el archivo $line"
  echo "Se ha eliminado el archivo $line2"
fi
