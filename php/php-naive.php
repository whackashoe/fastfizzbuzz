#!/usr/bin/php
<?php

for($i=1; $i < 1000001; ++$i) {
    if($i % 15 == 0) {
        echo "FizzBuzz\n";
    } else if($i % 5 == 0) {
        echo "Buzz\n";
    } else if($i % 3 == 0) {
        echo "Fizz\n";
    } else {
        echo "$i\n";
    }
}
