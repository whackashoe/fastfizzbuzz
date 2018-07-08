#include <iostream>

int main(int argc, char ** argv)
{
    int a { 0 };
    int b { 0 };

    for(int i=1; i<1000000; ++i) {
        ++a;
        ++b;

        a = (a == 3) ? 0 : a;
        b = (b == 5) ? 0 : b;

        if(a && b) {
            std::cout << i << "\n";
        } else if(a) {
            std::cout << "Fizz\n";
        } else if(b) {
            std::cout << "Buzz\n";
        } else {
            std::cout << "FizzBuzz\n";
        }
    }

    return 0;
}

