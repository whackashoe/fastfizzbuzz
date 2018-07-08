#!/bin/bash

make &> /dev/null || echo "make failed"

CMP=`cat fizzbuzz.txt | sha256sum -`

if [ $# -eq 0 ]
then
    for n in `find bin/ py/ php/ ruby/ -type f -not -path '*/\.*'`;
    do
        HASH=`./${n} | sha256sum -`

        if [ "${CMP}" == "${HASH}" ]
        then
            echo "${n}: pass"
        else
            echo "${n}: fail"
        fi
    done
else
    HASH=`./${1} | sha256sum -`

    if [ "${CMP}" == "${HASH}" ]
    then
        echo "${1}: pass"
    else
        echo "${1}: fail"
    fi
fi
