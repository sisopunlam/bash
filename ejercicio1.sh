#!/bin/bash

#-----------------------------------------------------------------------#
# Nombre del Script: Ejercicio3.sh					#
# Trabajo Práctico Nº1							#
# Integrantes:								#
#-Amato, Luciano			DNI:  	40.378.763		#
#-Pompeo, Nicolas Ruben			DNI:	37.276.705		#
#-Annacondia, Federico Agustin		DNI:	38.435.945		#
#-Del Greco, Juan Pablo			DNI:	39.097.812		#
# Entrega 29/04/2019							#
#-----------------------------------------------------------------------#


#Este 'if' comprueba que el script recibe 2 argumentos, de otra manera, no se ejecuta
if [ $# != 2 ]; then
  echo "El Script necesita 2 argumentos.
  Por favor, intentalo nuevamente"
  exit
fi
#Este 'if' lo que hace es comprobar que el segundo argumento (archivo fuente) es un archivo normal y
#no es un archivo especial (unidades de disco) o carpetas
if ! [ -f "$2" ]; then
  echo "Por favor: Este script solo funciona con archivos regulares.
  Por favor, intentalo nuevamente."
  exit
fi
#$1 es el modificador de AWK que busco
CUIT=$1

awk 'BEGIN {
       FIELDWIDTHS = "11 30"
}
$1 == "'$CUIT'" {
         print "Nombre                         CUIT"
         print "------------------------------ ------------"
         print $2" "$1
         exit
 }' $2
#Las respuestas a la parte teorica
#a)¿Qué significa la linea '#!/bin/bash'?
#La primera linea '#!/bin/bash' se denomina 'shebang' y es para indicarle 
#a la terminal que interprete debe utilizar para interpretar lo que sigue. 
#En este caso, indica que 'lo que sigue' se tiene que leer con BASH

#b)¿Con qué comando y de que manera otorgó los permisos de ejecución al script?
#Los permisos de ejecución se otorgaron con el siguiente comando:
#chmod 755 ./(nombre del script).sh
#en donde '755' indica (en base octal) que: el owner tiene permisos de leer/escribir/ejecutar (rwx)
#el script y, tanto el grupo al que pertenece el owner como otros usuarios tienen permisos de leer/ejecutar el script (r-x)

#c)Explique el objetivo general del script
#El objetivo general del script es, a partir de un archivo de texto, el filtrado de datos buscando por CUIT
#(en este caso particular)

#d)Explique de manera general la utilidad de AWK
#AWK es un editor de flujo capaz de leer archivos que contenga strings en su interior, detectar patrones
#y tomar acciones especiales sobre estos. Se basa en el uso de reglas (los patrones a buscar) y cada regla tiene
#una acción asociada.

#e) ¿Es posible ejecutar este script para procesar varios archivos a la vez en una única llamada? Ejemplifique
#En este caso particular, no es posible realizar más de una llamada a la vez de AWK, ya que, al analizar el código
#en la linea (Refiriendonos a la linea 26 del código, si hubiera sido archivo_especifico.txt solo hubiera procesado ese archivo 
#(si existiese)).
#Para poder procesar multiples archivos, uno podria separar el script en 2:
#En un archivo (preferentemente .awk para poderlo identificar mejor) las lineas 18 a 26 (propias del AWK)
#En un archivo separado (.sh) un script en donde guarde un array de archivos a procesar y tenga un loop
#que, por cada elemento (archivo), vaya realizando una llamada al script .awk creado (una solución elegante)
