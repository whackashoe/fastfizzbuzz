#!/usr/bin/env ruby

1.upto(1000000) do |i|
    if i % 5 == 0 and i % 3 == 0
        puts "FizzBuzz"
    elsif i % 5 == 0
        puts "Buzz"
    elsif i % 3 == 0
        puts "Fizz"
    else
        puts i
    end
end
