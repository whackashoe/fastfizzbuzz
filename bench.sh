#!/bin/bash

RUNS=1

make &> /dev/null || echo "make failed"

TIMEFORMAT="%E"

if [ $# -eq 0 ]
then
    for n in `find bin/ py/ -type f -not -path '*/\.*'`;
    do
        printf "%-30s" "${n}:"
        time (for i in $(seq ${RUNS}); do ./${n} > /dev/null; done)
    done
else
    printf "%-30s" "${1}:"
    time (for i in $(seq ${RUNS}); do ./${1} > /dev/null; done)
fi
