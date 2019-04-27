#!/bin/bash

#-----------------------------------------------------------------------#
# Nombre del Script: Ejercicio2.sh					#
# Trabajo Práctico Nº1							#
# Integrantes:								#
#-Amato, Luciano			DNI:  	40.378.763		#
#-Pompeo, Nicolas Ruben			DNI:	37.276.705		#
#-Annacondia, Federico Agustin		DNI:	38.435.945		#
#-Del Greco, Juan Pablo			DNI:	39.097.812		#
# Entrega 29/04/2019							#
#-----------------------------------------------------------------------#

#Evaluo que no sea el caso de que haya muchos parametros
if test $# -gt 3;
then
	echo "Hay mas de 3 parametros"
	echo "Por favor ingresa -h para consultar la ayuda"
	exit 0
fi
#Invocando a la ayuda
if  [ "$1" == "-h" ] && [ $# == 1 ] ; then
	echo "Ejercicio n°2  - Trabajo Practico n°1 BASH"
	echo  	"A partir de un archivo de texto, este script filtra por CUIT, DNI y Nombre"
	echo	 "Argumentos del script: <(-c,-d,-n)> <File> <(CUIT,DNI,NOMBRE)>"
	echo	"-c) Filtra por Cuit"
	echo 	"-d) Filtra por Dni"
	echo 	"-n) Filtra por Nombre"
	echo "Si usted invoca <File> o <(-c,-d,-n> <File> ,se mostrara en detalle toda la informacion contenida en el archivo"
	echo "Ejemplo queriendo filtrar por CUIT: ./ejercicio2.sh -c ./caso_base 20000004759"
	exit 0

fi

if [ -f "$1" ] && [ $# == 1 ]; then
	awk 'BEGIN {
	FIELDWIDTHS = " 11 30 2 2 2  1 1 2"
	print "CUIT\t	DENOMINACION\t\t\tGAN\tIVA\tMON\tINT\tEMP\tACT.MON"
	print "-----------\t------------------------------\t---\t---\t---\t--\t---\t-------"
	}
	{
	print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8	 
	}
	END { print "La cantidad de elementos filtrados es: "NR} ' $1
exit 0
fi

if [ $# == 1 ]; then
	echo "Tiene un solo argumento"
	echo "Por favor, ingresa -h para consultar la ayuda"
	exit
fi

if [ "$1" == "-c" ] && [ $# == 3 ]; then

	#echo FILTRO POR CUIT
	awk -v cuit=$3  ' BEGIN {
		print "CUIT\t	DENOMINACION\t\t\tGAN\tIVA\tMON\tINT\tEMP\tACT.MON"
		print "-----------\t------------------------------\t\t---\t---\t--\t---\t-------"
		FIELDWIDTHS = " 11 30 2 2 2  1 1 2"
		resultados  = 0		
		}		
		$1~cuit { 
		print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8
		resultados++
		} 
 	END { print "La cantidad de elementos filtrados es\t"resultados}' $2
exit 0
fi


if [ "$1" == "-d" ] && [ $# == 3 ]; then

	#echo FILTRO POR DNI
	awk -v dni=$3 ' BEGIN {
	print "DNI\t	DENOMINACION\t\t\tGAN\tIVA\tMON\tINT\tEMP\tACT.MON"
	print "-----------\t------------------------------\t\t---\t---\t--\t---\t-------"
	FIELDWIDTHS = " 11 30 2 2 2  1 1 2"
	resultados = 0
	}
	substr($1,3,10)~dni {
	print substr($1,3,10)"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8
	resultados++
	} 
END  { print "La cantidad de elementos filtrados es:\t"resultados}' $2
exit
fi

if [ "$1" == "-n" ]; then
 
	#echo FILTRO POR NOMBRE
	awk -v nombre=$3 ' BEGIN {
	FIELDWIDTHS = " 11 30 2 2 2  1 1 2"
	print "CUIT\t	DENOMINACION\t\t\tGAN\tIVA\tMON\tINT\tEMP\tACT.MON"
	print "-----------\t------------------------------\t\t---\t---\t--\t---\t-------"
	resultados=0
	}
	$2~toupper(nombre) {
	print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8
	resultados++
	} 
	
END { print "La cantidad de elementos filtrados es: "resultados} ' $2
	exit
fi

if [ "$1" != "-c" ] || [ "$1" != "-n" ] || [ "$1" != "-d" ]; then
echo "Parametro no valido, por favor ingresa -h para consultar la ayuda"
exit 
fi
