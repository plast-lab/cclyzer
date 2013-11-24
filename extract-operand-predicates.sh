#!/bin/bash

grep -E '.*Instruction:(Left|Right)Operand.*->.*Operand(.*).' $1 |\
 sed -E 's/^(.*:(Left|Right)Operand).*/\1/'
