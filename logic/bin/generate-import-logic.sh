#!/bin/bash

if [[ $# != 1 ]]; then
    echo >&2 "Usage: $0 CSVDIR"
    exit 1
fi

csvdir=$(dirname "$1/foo")

while read line; do
    fields=( $line )
    pred=${fields[0]}
    attr=${fields[1]}
    insn=${pred%%:*}

    # Compute file predicate names
    imm="_${pred}\$imm"
    var="_${pred}\$var"

    immfile="${csvdir}/${pred//:/-}-imm.dlm"
    varfile="${csvdir}/${pred//:/-}-var.dlm"

    # Indexed operands
    if [[ $attr = index ]]; then
        index=true
    fi

    cat <<EOF
// Auto-generated import logic for ${pred}

${imm}(Insn${index+, Index}, Imm) ->
    string(Insn)${index+, int[64](Index)}, string(Imm).

${var}(Insn${index+, Index}, Var) ->
    string(Insn)${index+, int[64](Index)}, string(Var).

lang:physical:delimiter[\`${imm}] = "\t".
lang:physical:delimiter[\`${var}] = "\t".
lang:physical:filePath[\`${imm}]  = "${immfile}".
lang:physical:filePath[\`${var}]  = "${varfile}".

+operand(Operand),
+operand:by_immediate[Imm] = Operand,
+${pred}[Insn${index+, Index}] = Operand
<-
    instruction:id(Insn:InsnRef),
    immediate:value(Imm:ImmRef),
    ${insn}(Insn),
    ${imm}(InsnRef${index+, Index}, ImmRef).


+operand(Operand),
+operand:by_variable[Var] = Operand,
+${pred}[Insn${index+, Index}] = Operand
<-
    instruction:id(Insn:InsnRef),
    variable:id(Var:VarRef),
    ${insn}(Insn),
    ${var}(InsnRef${index+, Index}, VarRef).

EOF
    unset index
done
