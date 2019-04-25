#!/bin/bash
 
if [ $# != 2 ]; then
        echo "Debe ingresar 2 parametros"
        exit
fi
 
if ! [ -f "$1" ]; then
        echo "El primer parametro no es un archivo valido"
        exit
fi
 
if ! [[ -f "$2" || -d "$2" ]]; then
        echo "El segundo parametro no es un archivo o directorio valido"
        exit
fi
 
# Si el segundo parametro es un archivo:
 
if [ -f "$2" ]; then
        totales=$(cut -d " " -f 1 <(wc -l $1))
        repeticiones=$(cut -d " " -f 1 <(wc -l <(comm -12 <(sort $1) <(sort $2))))
        porcentaje=$(($repeticiones*100/$totales))
        echo "Hay " $repeticiones " repeticiones de " $totales " palabras totales"
        echo "Hay un " $porcentaje "% de coincidencia"
fi
 
 
# Si el segundo parametro es un directorio:
 
if [ -d "$2" ]; then
 
        echo "Nada"
 
fi
 
echo "Todo OK"
