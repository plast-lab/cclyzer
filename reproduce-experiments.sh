#!/bin/bash

# List of benchmarks
coreutils="tests/coreutils-8.24"
postgresql="tests/postgresql-9.5.2"
benchmarks="\
${coreutils}/cp.bc
${coreutils}/df.bc
${coreutils}/du.bc
${coreutils}/ginstall.bc
${coreutils}/ls.bc
${coreutils}/mkdir.bc
${coreutils}/mv.bc
${coreutils}/sort.bc
${postgresql}/clusterdb.bc
${postgresql}/createdb.bc
${postgresql}/createlang.bc
${postgresql}/createuser.bc
${postgresql}/dropdb.bc
${postgresql}/droplang.bc
${postgresql}/dropuser.bc
${postgresql}/ecpg.bc
${postgresql}/pg_ctl.bc
${postgresql}/pg_dumpall.bc
${postgresql}/pg_isready.bc
${postgresql}/pg_rewind.bc
${postgresql}/pg_upgrade.bc
${postgresql}/psql.bc"

# Output directory
out=sas16-out

# Analyze benchmarks
for benchmark in $benchmarks; do
    # Simple benchmark name
    name=$(basename $benchmark | cut -f1 -d. )

    # Analysis output
    db=$out/structsens-$name
    dbp=$out/pearce-$name

    # Analysis logs
    log=$out/log-structsens-${name}.txt
    logp=$out/log-pearce-${name}.txt

    mkdir -p $db
    mkdir -p $dbp

    echo "Analyzing $name ..."
    cclyzer analyze $benchmark -o $db > $log
    cclyzer analyze --pearce $benchmark -o $dbp > $logp
done

function relation_size {
    bloxbatch -db $1 -predInfo $2 2>&1 | grep "size:" | cut -d: -f2 
}

function running_time {
    cat $1 | grep -e 'installed points-to' -e 'installed pearce' | sed 's/.*\.\{3\} //'
}

function pointers {
    bloxbatch -db $1 -query nonempty_var 2>/dev/null
}

function vars_of_size {
    cat $1/results/nvars-per-pt-size.tsv | egrep "^$2[[:space:]]+" | cut -f2
}

function perc {
    awk -v k="$1" -v n="$2" 'BEGIN{print 100 * k / n}'
}

# Gather statistics
for benchmark in $benchmarks; do
    # Simple benchmark name
    name=$(basename $benchmark | cut -f1 -d. )

    # Analysis output
    db=$out/structsens-$name
    dbp=$out/pearce-$name

    # Analysis logs
    log=$out/log-structsens-${name}.txt
    logp=$out/log-pearce-${name}.txt

    echo "[$name]"
    echo "size: $(du -h ${benchmark})"
    echo "call-graph edges: $(relation_size $db/db callgraph:edge )"
    echo "abstract objects (struct-sens): $(relation_size $db/db allocation )"
    echo "running time (struct-sens): $(running_time $log)"
    echo "abstract objects (pearce): $(relation_size $dbp/db allocation )"
    echo "running time (pearce): $(running_time $logp)"
    echo

    # Compute variables that can be pointers (in any of the two analyses)
    pointers="$(cat <(pointers $db/db) <(pointers $dbp/db) | sort -u | wc -l)"
    echo "variable pointers: $pointers"

    # Variables per points-to set size
    vars_ss_pt1="$(vars_of_size $db 1)"
    vars_ss_pt2="$(vars_of_size $db 2)"
    vars_ss_pt3="$(vars_of_size $db 3)"

    vars_pearce_pt1="$(vars_of_size $dbp 1)"
    vars_pearce_pt2="$(vars_of_size $dbp 2)"
    vars_pearce_pt3="$(vars_of_size $dbp 3)"

    # Print absolute numbers and percentages
    echo "variables of 1-pt-size (struct-sens): $vars_ss_pt1"
    echo "variables of 2-pt-size (struct-sens): $vars_ss_pt2"
    echo "variables of 3-pt-size (struct-sens): $vars_ss_pt3"
    echo "percentage of variables of 1-pt-size (struct-sens): $(perc $vars_ss_pt1 $pointers)%"
    echo "percentage of variables of 2-pt-size (struct-sens): $(perc $vars_ss_pt2 $pointers)%"
    echo "percentage of variables of 3-pt-size (struct-sens): $(perc $vars_ss_pt3 $pointers)%"
    echo

    echo "variables of 1-pt-size (pearce): $vars_pearce_pt1"
    echo "variables of 2-pt-size (pearce): $vars_pearce_pt2"
    echo "variables of 3-pt-size (pearce): $vars_pearce_pt3"
    echo "percentage of variables of 1-pt-size (pearce): $(perc $vars_pearce_pt1 $pointers)%"
    echo "percentage of variables of 2-pt-size (pearce): $(perc $vars_pearce_pt2 $pointers)%"
    echo "percentage of variables of 3-pt-size (pearce): $(perc $vars_pearce_pt3 $pointers)%"
    echo
done
