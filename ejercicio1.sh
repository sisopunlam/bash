#!/bin/bash
#Los errores van a /dev/null
#Limpiando la pantalla
clear
#Las respuestas a la parte teorica
#a)¿Qué significa la linea '#!/bin/bash'?
#"La primera linea '#!/bin/bash' se denomina shebang y es para indicarle 
#a la terminal que interprete debe utilizar para interpretar lo que sigue. 
#En este caso, indica que 'lo que sigue' se tiene que leer con BASH"

#b)¿Con qué comando y de que manera otorgó los permisos de ejecución al script?
#Los permisos de ejecución se otorgaron con el siguiente comando:
#chmod 755 ./(nombre del script).sh
#en donde '755' indica (en base octal) que: el owner tiene permisos de leer/escribir/ejecutar (rwx)
#el script y, tanto el grupo al que pertenece el owner como otros usuarios tienen permisos de leer/ejecutar el script (r-x)

#c)Explique el objetivo general del script
#(Explicar)

#e) ¿Es posible ejecutar este script para procesar varios archivos a la vez en una única llamada? Ejemplifique
#Saludando.
echo "Hola $USER! Ahora el script va a resolver el Ejercicio 1 del Trabajo Practico de BASH"
#Para agregar la opción de ayuda en los comandos (ver fuente en la descripción del commit)
if [ ${#@} -ne 0 ] && [ "${@#"--help"}" = "" ]; then #Primero probar y agregar las otras opciones (-h, -?, -help)
  printf -- '...help...\n'; #Modificar
  exit 0;
fi;
#Para avisar que devuelvo el control del sistema
echo "¡Gracias por esperar, ahora, te devuelvo el control!"
