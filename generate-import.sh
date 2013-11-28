#! /bin/bash

PRED=$(basename $1 .dlm | sed "s/-/:/g")
ARITY=$(head -n 1 $1 | awk -F$'\t' '{ print NF }')

echo -n "fromFile,\"$1\""

for i in $(seq $ARITY); do
    echo -n ",column:$i,${PRED}:$i"
done

echo

echo -n "toPredicate,$PRED"

for i in $(seq $ARITY); do
    echo -n ",${PRED}:$i"
done

echo
