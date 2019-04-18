#!/bin/bash
if test $# -gt 2;
then
	echo "Hay mas de 2 parametros"
	echo "Por favor ingresa -h para consultar la ayuda"
	exit 0
fi

if  [ "$1" == "-h" ] && [ $# == 1 ] ; then
	echo "A partir de un archivo de texto, este script filtra por CUIT, DNI y nombre"
	echo "Argumentos del script: <(-c,-d,-n)> <File>"
	echo "Si usted invoca <File> se mostrara en detalle toda la informacion contenida en el archivo"
	echo "-c) Filtra por Cuit"
	echo "-d) Filtra por Dni"
	echo "-n) Filtra por Nombre"
	exit

fi

if [ -f "$1" ]; then
	awk 'BEGIN {
	FIELDWIDTHS = " 11 30 2 2 2  1 1 2"
	print "CUIT\t	DENOMINACION\t\t\tGAN\tIVA\tMON\tINT\tEMP\tACT.MON"
	}
	{
	print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8
	 }' $1
exit	
fi

if [ ! -f "$2" ]; then

	echo "El segundo argumento no es un file"
	echo "Por favor ingresa -h para consultar la ayuda"
	exit
fi

if [ $# != 2 ]; then
	echo "Tiene un solo argumento"
	echo "Por favor, ingresa -h para consultar la ayuda"
	exit
fi

if [ "$1" == "-c" ]; then

	#echo FILTRO POR CUIT
	awk 'BEGIN {
		print "CUIT" 
		FIELDWIDTHS = "11"
		

	}
{
	print $1

}' $2
exit
fi


if [ "$1" == "-d" ]; then
 
	#echo FILTRO POR DNI
	awk 'BEGIN { 
		FIELDWIDTHS = "1 9"
		print "DNI"
	}
	{		
		print $2
	
	} ' $2
exit
fi

if [ "$1" == "-n" ]; then
 
	#echo FILTRO POR NOMBRE
	awk 'BEGIN {
	FIELDWIDTHS = "11 30"
	print "NOMBRE"
	}
	 {
	print $2
	
	
}' $2
	exit
fi

if [ "$1" != "-c" ] || [ "$1" != "-n" ] || [ "$1" != "-d" ]; then
echo "Parametro no valido, por favor ingresa -h para consultar la ayuda"
exit 
fi
