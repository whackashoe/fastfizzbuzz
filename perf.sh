#!/bin/bash

make &> /dev/null || echo "make failed"

if [ $# -eq 0 ]
then
    for n in `find bin/ py/ -type f -not -path '*/\.*'`;
    do
        perf stat -ddd ./${n} > /dev/null
    done
else
    perf stat -ddd ${1} > /dev/null
fi
