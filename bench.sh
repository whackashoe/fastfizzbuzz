#!/bin/bash

RUNS=100

make &> /dev/null || echo "make failed"

if [ $# -eq 0 ]
then
    for n in `find bin/ py/ -type f -not -path '*/\.*'`;
    do
        echo "${n}:"
        time (for i in $(seq ${RUNS}); do ./${n} > /dev/null; done)
        echo ""
    done
else
    time (for i in $(seq ${RUNS}); do ./${1} > /dev/null; done)
fi
