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

    Este Script se encarga de renombre masivamente los archivos de un directorio,teniendo un valor/caracters a
	reempblazar en el nombre de los archivos.
    Tiene 3 parámetros....

Uso:
---
  Mostrar ayuda
   ./ejer6.sh -h | -? | -help

   Para una correcta ejecución se deben enviar la ruta del directorio de los archivos
   ./ejercicio6.sh [directorio a analizar]  [patrón a buscar] [texto de reemplazo.]

Ejemplos:
--------
   ./ejer6.sh ./DirectorioA xx 20190328
   /home/julian/Escritorio/windows/Nueva carpeta/bash/lote
END
}

#Si se indican alguno de los parametros de ayuda
	if [  "$1" == "-h"  ] || [ "$1" == "-help" ] || [ "$1" == "-?" ]; then
		ayuda
	  	exit
	fi
  #Si los parametros son incorrectos
  	if [ $# -lt 3 ]; then
  		echo "Faltan parametros vea la ayuda con ./ejercicio6.sh -h "
  		exit
  	fi

#Si el directorio no existen
    if [ ! -d "$1" ]; then
      echo "El directorio \"$1\" no existe."
      exit;
    fi

#INICIO DEL PROGRAMA
#MENSAJE="Este el el valora cambiar :xx"

for FILE in $(ls $1 | grep $2)
do
  echo $FILE
	new=`echo ${FILE} | sed 's/'"$2"'/'"$3"'/g'`
  #echo $new
	if [ ! -f "$1/$new" ];then
    mv "$1/${FILE}" "$1/$new"
  fi
done
