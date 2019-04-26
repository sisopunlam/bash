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
 
coincidencia() {
        totales=$(cut -d " " -f 1 <(wc -l $1))
        repeticiones=$(cut -d " " -f 1 <(wc -l <(comm -12 <(sort $1) <(sort $2))))
        porcentaje=$(($repeticiones*100/$totales))
        echo $1 $2 $porcentaje
}
 
# Si el segundo parametro es un archivo:
 
if [ -f "$2" ]; then
        coincidencia $1 $2
fi
 
# Si el segundo parametro es un directorio:
 
if [ -d "$2" ]; then
        for i in $(ls $2)
        do
                coincidencia $1 $i
        done
fi
