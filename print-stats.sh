#!/usr/bin/env bash

benchmarks="cp df dir du ginstall ls mkdir mv sort vdir"
builddir="build/tests/coreutils-8.24"

for bench in $benchmarks; do
    echo "[$bench]"
    echo 'cclyzer'
    ./compute_stats.py ${builddir}/${bench}/results/nvars-per-pt-size.tsv;
    echo 'Pearce'
    ./compute_stats.py ${builddir}/${bench}-pearce/results/nvars-per-pt-size.tsv;
done
