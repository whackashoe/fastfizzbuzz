#include <iostream>
#include <array>
#include <string>
#include <cstdint>

int main(int argc, char ** argv)
{
    std::array<std::string, 4> messages {
        "", "Fizz\n", "Buzz\n", "FizzBuzz\n"
    };

    std::uint32_t acc { 810092048 };
    for (int i=1; i < 1000001; ++i) {
        const std::uint32_t c { acc & 3 };

        if(c > 0) {
            std::cout << messages[c];
        } else {
            std::cout << i << "\n";
        }

        acc = acc >> 2 | c << 28;
    }

    return 0;
}
