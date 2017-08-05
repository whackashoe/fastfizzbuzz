#!/bin/bash

RUNS=100

@make || echo "make failed"

echo "ffb:"
time (for i in $(seq ${RUNS}); do ./ffb > /dev/null; done)
echo ""

echo "naive:"
time (for i in $(seq ${RUNS}); do ./naive > /dev/null; done)
echo ""

echo "counting:"
time (for i in $(seq ${RUNS}); do ./counting > /dev/null; done)
echo ""

echo "bitwise:"
time (for i in $(seq ${RUNS}); do ./bitwise > /dev/null; done)
echo ""

