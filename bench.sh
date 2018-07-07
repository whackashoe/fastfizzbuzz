#!/bin/bash

RUNS=100

make || echo "make failed"

#echo "cpp-ffb:"
#time (for i in $(seq ${RUNS}); do ./ffb > /dev/null; done)
#echo ""
#
#echo "cpp-naive:"
#time (for i in $(seq ${RUNS}); do ./naive > /dev/null; done)
#echo ""
#
#echo "cpp-counting:"
#time (for i in $(seq ${RUNS}); do ./counting > /dev/null; done)
#echo ""
#
#echo "cpp-bitwise:"
#time (for i in $(seq ${RUNS}); do ./bitwise > /dev/null; done)
#echo ""
#
#echo "cpp-mem:"
#time (for i in $(seq ${RUNS}); do ./mem > /dev/null; done)
#echo ""

echo "py-naive:"
time (for i in $(seq ${RUNS}); do ./naive.py > /dev/null; done)
echo ""

