#!/bin/bash
if test $# -gt 2;
then
	echo "Hay mas de 2 parametros"
	echo "Por favor ingresa -h para consultar la ayuda"
	exit 0
fi

if  [ "$1" == "-h" ] && [ $# == 1 ] ; then
	echo "A partir de un archivo de texto, este script filtra por CUIT, DNI y nombre
Argumentos del script: <(-c,-d,-n)> <File>
Si usted invoca <File> se mostrara en detalle toda la informacion contenida en el archivo
-c) Filtra por Cuit
-d) Filtra por Dni
-n) Filtra por Nombre
Este script se muestra mejor con la pantalla completa"
	exit 0

fi

if [ -f "$1" ]; then
	awk 'BEGIN {
	FIELDWIDTHS = " 11 30 2 2 2  1 1 2"
	print "CUIT\t	DENOMINACION\t\t\tGAN\tIVA\tMON\tINT\tEMP\tACT.MON"
	print "-----------\t------------------------------\t\t---\t---\t--\t---\t-------"
	}
	{
	print substr($0,1,11)"\t"substr($0,12,30)"\t"substr($7,2,2)"\t"substr($7,4,2)"\t"substr($7,6,2)"\t"substr($7,7,1)"\t"substr($7,8,1)"\t"substr($7,9)	 
	}
	END { print "La cantidad de elementos filtrados es: "NR} ' $1
exit 0
fi

if [ ! -f "$2" ]; then

	echo "El segundo argumento no es un archivo valido
	Por favor ingresa -h para consultar la ayuda"
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
		print "-----------"
		FIELDWIDTHS = "11"	
	}
	{
	print substr($1,1,11)
	}
END { print "La cantidad de elementos filtrados es: "NR} ' $2
exit 0
fi


if [ "$1" == "-d" ]; then
 
	#echo FILTRO POR DNI
	awk 'BEGIN { 
		FIELDWIDTHS = "1 9"
		print "DNI"
		print "---------"
		resultados=0
	}
	{		
		if(substr($1,12)!="SUCESION"){
			resultados++		
			print substr($1,3,8);
		}
	
	}
END { print "La cantidad de elementos filtrados es: "resultados} ' $2
exit
fi

if [ "$1" == "-n" ]; then
 
	#echo FILTRO POR NOMBRE
	awk 'BEGIN {
	FIELDWIDTHS = "11 30"
	print "NOMBRE"
	print "------------------------------"
	resultados=0
	}
	 {
	if(substr($1,12)!="SUCESION"){
		print substr($0,12,30)
		resultados++;
	}
	
	
}
END { print "La cantidad de elementos filtrados es: "resultados} ' $2
	exit
fi

if [ "$1" != "-c" ] || [ "$1" != "-n" ] || [ "$1" != "-d" ]; then
echo "Parametro no valido, por favor ingresa -h para consultar la ayuda"
exit 
fi
