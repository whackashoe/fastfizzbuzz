#!/usr/bin/python2.7

with open('fizzbuzz.txt') as f:
    print (
        ".text\n"
        ".globl      _start\n"
        "_start:\n"
        "   movl     $len,%edx\n"
        "   leaq     msg(%rip), %rsi\n"
        "   movl     $1,%edi\n"
        "   movl     $1,%eax\n"
        "   syscall\n"
        "   movl     $60,%eax\n"
        "   syscall\n"
        "   msg:     .ascii  \"{:s}\"\n"
        "   len = . - msg\n"
    ).format(f.read().replace('\n', '\\n'))
