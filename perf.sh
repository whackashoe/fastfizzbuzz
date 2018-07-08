#!/bin/bash

if [ $# -eq 0 ]
then
    for n in `ls bin`;
    do
        perf stat -ddd ./bin/${n} > /dev/null
        echo ""
    done
else
    perf stat -ddd ${1} > /dev/null
fi
