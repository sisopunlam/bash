#!/bin/bash
#Los errores van a /dev/null
#Limpiando la pantalla
clear
#Las respuestas a la parte teorica
#a)¿Qué significa la linea '#!/bin/bash'?
#"La primera linea '#!/bin/bash' se denomina 'shebang' y es para indicarle 
#a la terminal que interprete debe utilizar para interpretar lo que sigue. 
#En este caso, indica que 'lo que sigue' se tiene que leer con BASH"

#b)¿Con qué comando y de que manera otorgó los permisos de ejecución al script?
#Los permisos de ejecución se otorgaron con el siguiente comando:
#chmod 755 ./(nombre del script).sh
#en donde '755' indica (en base octal) que: el owner tiene permisos de leer/escribir/ejecutar (rwx)
#el script y, tanto el grupo al que pertenece el owner como otros usuarios tienen permisos de leer/ejecutar el script (r-x)

#c)Explique el objetivo general del script
#(Explicar)

#d)Explique de manera general la utilidad de AWK
#AWK es un editor de flujo capaz de leer archivos que contenga strings en su interior, detectar patrones
#y tomar acciones especiales sobre estos. Se basa en el uso de reglas (los patrones a buscar) y cada regla tiene
#una acción asociada.

#e) ¿Es posible ejecutar este script para procesar varios archivos a la vez en una única llamada? Ejemplifique
#(?)
#Saludando y tomando el control del sistema.
echo "Hola $USER! Ejecutando el Ejercicio 1 del TP de BASH"
if [ $# != 2 ]; then
  echo "..."
  exit
fi
if ! [ -f "$2" ]; then
  echo "..."
  exit
fi
X=$1

awk 'BEGIN {
       FIELDWIDTHS = "11 30"
}
$1 == "'$X'" {
         print "Nombre                         CUIT"
         print "------------------------------ ------------"
         print $2" "$1
         exit
 }' $2
#Para avisar que devuelvo el control del sistema
echo "¡Gracias por esperar, ahora, te devuelvo el control!"
