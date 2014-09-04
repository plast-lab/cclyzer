#!/bin/bash

declare -A llvm2base

if [ $# -ne 3 ]; then
    echo "Usage: $0 LOGICDIR PROJECTFILE PLACEHOLDER" >&2; exit 1
fi

# Compute associative aray from llvm project id to project base file
for proj in $(find $1 -type f -name '*.project' ); do
    projname=$( grep 'projectname' $proj | cut -d, -f1 | sed -e 's/^ *//' -e 's/ *$//' )
    projfile=$( basename $proj .project )
    llvm2base[$projname]=$projfile
done

# Get project name and its depencencies
projfile=$( basename $2 .project )
projname=$( grep 'projectname' $2 | cut -d, -f1 | sed -e 's/^ *//' -e 's/ *$//' )
dependencies=$( grep 'library' $2 | cut -d, -f1 | sed -e 's/^ *//' -e 's/ *$//' )

# LogicBlox Library Path
libpath=""

# Makefile rule creation that adds the necessary dependencies
target="$3"
prerequisites=""

# Loop over dependencies and compute library path and Makefile prerequisites
for i in $dependencies; do
    dep="${llvm2base[$i]}"
    prerequisite="${target/$projfile/$dep}"
    prerequisites="$prerequisites $prerequisite"
    libpath="$(dirname $prerequisite):${libpath}"
done

cat <<EOF
export LB_LIBRARY_PATH := ${libpath%:}

$target: $prerequisites

EOF
