#!/bin/bash

inFile=`basename $1`
cropPattern="${inFile%.*}"

compUnitEnd=`grep -n "^name: \\"$cropPattern\\"$" "$1" | cut -d : -f 1`

compUnitEnd=$(($compUnitEnd - 2))

tail -n+2 "$1" | head -n"$compUnitEnd"
