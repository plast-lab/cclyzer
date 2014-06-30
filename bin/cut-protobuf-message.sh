#!/bin/bash

inFile=`basename $1`
cropPattern="${inFile%*.pb}"

compUnitEnd=`grep -n "^name: \\"schema:$cropPattern\\"$" "$1" | cut -d : -f 1`

compUnitEnd=$(($compUnitEnd - 2))

tail -n+2 "$1" | head -n"$compUnitEnd"
