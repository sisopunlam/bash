#!/bin/bash
if test $# -gt 2;
then
	echo "HAY MAS DE 2 PARAMETROS"
	exit 0
fi

if [ "$1" == "-h" ] && [ $# == 1 ]; then
	echo "Argumentos del script: <(-c,-d,-n)> <File>"
	echo "-c) Filtra por Cuit"
	echo "-d) Filtra por Dni"
	echo "-n) Filtra por Nombre"
	exit

fi

if [ ! -f "$2" ]; then

	echo "NO ES UN FILE"
	exit
fi

if [ $# != 2 ]; then
	echo "TIENE UN SOLO ARGUMENTO"
	exit
fi

if [ "$1" == "-c" ]; then

	#echo FILTRO POR CUIT
	awk 'BEGIN { 
		FIELDWIDTHS = "11"
	}
{
	print "CUIT"
	print $1
	print "----"

}' $2
exit
fi


if [ "$1" == "-d" ]; then
 
	#echo FILTRO POR DNI
	awk 'BEGIN { 
		FIELDWIDTHS = "1 9"
	}
	{	print "DNI"	
		print $2
		print "---"
	} ' $2
exit
fi

if [ "$1" == "-n" ]; then
 
	#echo FILTRO POR NOMBRE
	awk 'BEGIN {
	FIELDWIDTHS = "11 30"
	}
	 {
	print "Nombre"
	print $2
	print "------"
	
}' $2
	exit
fi
