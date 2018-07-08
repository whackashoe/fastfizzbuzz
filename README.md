fastfizzbuzz
===

What is the fastest we can optimize FizzBuzz to 1 million to?

The approach I took is able to operate in approximately 1/5th the time of a normally implemented FizzBuzz.

## Requirements

C++11 compiler

For other examples you may need:

* as
* ld
* python
* php
* ruby
* rust
* golang
* ghc

## Building

`make`

## Running

`./bench.sh [PROG]` will give you real time of execution, modify `$RUNS` to your liking

`./perf.sh [PROG]` will give you output from perf

`./check.sh [PROG]` will check output is correct

## Results

```
bin/asm-memcheat:             0.003
bin/cpp-ffb:                  0.017
bin/asm-table:                0.039
bin/cpp-naive:                0.075
```

asm-memcheat uses a python script to dump the fizzbuzz results string directly into the program to print. It should be nearly the fastest possible, but not very interesting. cpp-ffb is fastfizzbuzz, it is approximately 6 times faster than the cpp-naive. 

