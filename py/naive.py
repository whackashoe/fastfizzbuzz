#!/usr/bin/python2.7

for i in range(1, 1000001):
    if i % 3 == 0 and i % 5 == 0:
        print "FizzBuzz"
    elif i % 3 == 0:
        print "Fizz"
    elif i % 5 == 0:
        print "Buzz"
    else:
        print i
