#include <cstdint>
#include <cstdio>
#include <cstring>
#include <array>

/*
 * VITAUT_1 is based on vitaut's algorithm with two small changes.
 * The first change is that it copies character pairs in the main loop, 
 * reducing the number of store instructions. Similar to INGE_2, 
 * VITAUT_1 copies both final characters and uses pointer arithmetic 
 * to return a pointer to the string.
 *
 * https://stackoverflow.com/questions/7890194/optimized-itoa-function/32818030
 */
static constexpr std::array<std::uint16_t, 100> str100p {
    0x3030, 0x3130, 0x3230, 0x3330, 0x3430, 0x3530, 0x3630, 0x3730, 0x3830, 0x3930,
    0x3031, 0x3131, 0x3231, 0x3331, 0x3431, 0x3531, 0x3631, 0x3731, 0x3831, 0x3931,
    0x3032, 0x3132, 0x3232, 0x3332, 0x3432, 0x3532, 0x3632, 0x3732, 0x3832, 0x3932,
    0x3033, 0x3133, 0x3233, 0x3333, 0x3433, 0x3533, 0x3633, 0x3733, 0x3833, 0x3933,
    0x3034, 0x3134, 0x3234, 0x3334, 0x3434, 0x3534, 0x3634, 0x3734, 0x3834, 0x3934,
    0x3035, 0x3135, 0x3235, 0x3335, 0x3435, 0x3535, 0x3635, 0x3735, 0x3835, 0x3935,
    0x3036, 0x3136, 0x3236, 0x3336, 0x3436, 0x3536, 0x3636, 0x3736, 0x3836, 0x3936,
    0x3037, 0x3137, 0x3237, 0x3337, 0x3437, 0x3537, 0x3637, 0x3737, 0x3837, 0x3937,
    0x3038, 0x3138, 0x3238, 0x3338, 0x3438, 0x3538, 0x3638, 0x3738, 0x3838, 0x3938,
    0x3039, 0x3139, 0x3239, 0x3339, 0x3439, 0x3539, 0x3639, 0x3739, 0x3839, 0x3939
};

char * itoa_vitaut_1(char * buf, std::uint32_t val)
{
    char * p { &buf[10] };

    *p = '\n'; // instead of null to remove assignment

    while(val >= 100) {
        std::uint32_t old { val };

        p -= 2;
        val /= 100;
        std::memcpy(p, &str100p[old - (val * 100)], sizeof(std::uint16_t));
    }

    p -= 2;
    std::memcpy(p, &str100p[val], sizeof(std::uint16_t));

    return &p[val < 10];
}


int main(int argc, char ** argv)
{
    using int_t = std::uint32_t;

    // holds offset then length
    static constexpr std::array<std::uint8_t, 8> fb_buf_off_len {
        0, 9,   // fizzbuzz
        9, 5,   // buzz
        14, 5,  // fizz
        19, 11, // number
    };

    std::array<char, (4096 * 8) - 128> wbuf;

    static std::array<char, 30> fb_buf {
        'F', 'i', 'z', 'z', 'B', 'u', 'z', 'z', '\n', // 9
        'B', 'u', 'z', 'z', '\n',                     // 5
        'F', 'i', 'z', 'z', '\n',                     // 5
        // remaining places are null and will hold number
    };

    int_t m;
    std::uint32_t wbuf_i { 0 };
    std::uint32_t a { 0 };
    std::uint32_t b { 0 };

    for(std::uint32_t i=1; i < 1000001; ++i) {
        ++a;
        ++b;

        a = (a == 3) ? 0 : a;
        b = (b == 5) ? 0 : b;
        m = static_cast<int_t>((a ? 1: 0) + (b ? 2 : 0));

        if(m > 2) {
            char * s { itoa_vitaut_1(fb_buf.data() + fb_buf_off_len[(3 << 1)], i) };
            std::size_t buf_off { 0 };
            while(*(s + ++buf_off) != '\n');
            ++buf_off;

            std::memcpy(
                wbuf.data() + wbuf_i,
                s,
                buf_off
            ); wbuf_i += buf_off;
        } else {
            const std::uint8_t * fb_buf_off_ptr { fb_buf_off_len.data() + (m << 1) };
            std::memcpy(
                wbuf.data() + wbuf_i,
                fb_buf.data() + *(fb_buf_off_ptr),
                *(fb_buf_off_ptr + 1)
            ); wbuf_i += *(fb_buf_off_ptr + 1);
        }

        if(wbuf_i > wbuf.size() - 11) {
            std::fwrite(wbuf.data(), sizeof(char), wbuf_i, stdout);
            wbuf_i = 0;
        }
    }
    
    if(wbuf_i > 0) {
        std::fwrite(wbuf.data(), sizeof(char), wbuf_i, stdout);
        wbuf_i = 0;
    }

    std::fflush(stdout);
    std::fclose(stdout);

    return 0;
}
