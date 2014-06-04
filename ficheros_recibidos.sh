#!/bin/bash

directorios=('/un/directorio' '/otro/directorio/' '/tercer/directorio');
dia=$(date +%Y%m%d)
hora=$(date +%H%M%S)
salida=recibidos_$dia\_$hora.csv
echo "directorio;fichero;tamaño;creación;modificación;" >> $salida
for directorio in ${directorios[*]}
do
        for fichero in $(ls $directorio)
        do
                tamanho=$(du -h $directorio/$fichero | awk '{ print $1 }')
                fechaCreacion=$(debugfs -R "stat <$(ls -i $directorio/$fichero | awk '{ print $1 }')>" /dev/sdxn | grep crtime | awk '{ print $7 }')
                fechaModificacion=$(ls -lAh --full-time $directorio/$fichero | awk '{ print $7 }' | cut -d "." -f1)
                echo $directorio";"$fichero";"$tamanho";"$fechaCreacion";"$fechaModificacion";" >> $salida
        done
done
