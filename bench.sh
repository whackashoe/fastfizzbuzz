#!/bin/bash

RUNS=100

make &> /dev/null || echo "make failed"

if [ $# -eq 0 ]
then
    for n in `ls bin`;
    do
        echo "${n}:"
        time (for i in $(seq ${RUNS}); do ./bin/${n} > /dev/null; done)
        echo ""
    done
else
    time (for i in $(seq ${RUNS}); do ./${1} > /dev/null; done)
fi
