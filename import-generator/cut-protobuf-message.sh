#!/bin/bash

compUnitEnd=`grep -n "^name: \\"schema:br-instruction\\"$" "$1" | cut -d : -f 1`

compUnitEnd=$(($compUnitEnd - 2))

tail -n+2 "$1" | head -n"$compUnitEnd"
