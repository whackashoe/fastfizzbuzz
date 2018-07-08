#!/bin/bash

make &> /dev/null || echo "make failed"

CMP=`cat fizzbuzz.txt | sha256sum -`

for n in `ls bin`;
do
    HASH=`./bin/${n} | sha256sum -`

    if [ "${CMP}" == "${HASH}" ]
    then
        echo "${n}: pass"
    else
        echo "${n}: fail"
    fi
done
