#!/bin/bash
#Limpiando la pantalla
clear
#Primero verifico que AL MENOS tengo un argumento (--help/-?/--h)
if ! [ $# > 0 ]; then
  echo "No hay suficientes argumentos
  por favor, ingresa -? para consultar la ayuda"
fi
#Lo de arriba me genera un error que tengo que consultar

#Consulto por la ayuda, por logica, esta como primer argumento
if ! [ $1 == "-?" ]; then
  echo "A partir de un archivo de texto, este script filtra por CUIT, Nombre 
Comandos:
-c Filtra la informacion por numero de CUIT
-d Filtra la informacion por numero de DNI
-n Filtra la informacion por Nombre"
  exit
fi
