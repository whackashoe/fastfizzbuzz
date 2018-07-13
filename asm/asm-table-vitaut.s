###############################################################################
# kernel interface:
# number of syscall in %rax
# parameters in %rdi, %rsi, %rdx, %r10, %r8, %r9
# kernel destroys %rcx and %r11
# result of syscall in %rax, value between -4095 and -1 indicates an error
###############################################################################

###############################################################################
			.set SYS_EXIT, 60
			.set SYS_WRITE, 1

			.set STDIN, 0
			.set STDOUT, 1
			.set STDERR, 2

			.set ITERATIONS, 1000000

			.set POINTER, 38504 # 1001011001101000

###############################################################################
.data

			.lcomm OutputBuffer, ITERATIONS*9
FizzBuzz:
			.byte 0, 0, 0, 0, 0, 0, 0, 0 # empty space at offset 0
			.byte 0, 0, 0, 0, 0, 0, 0, 0
			.byte 0, 0, 0, 0, 0, 0, 0, 0
			.ascii "Fizz\n   "
			.byte 0, 0, 0, 0, 0, 0, 0, 0
			.ascii "Buzz\n   "
			.ascii "Fizz\n   "
			.byte 0, 0, 0, 0, 0, 0, 0, 0
			.byte 0, 0, 0, 0, 0, 0, 0, 0
			.ascii "Fizz\n   "
			.ascii "Buzz\n   "
			.byte 0, 0, 0, 0, 0, 0, 0, 0
			.ascii "Fizz\n   "
			.byte 0, 0, 0, 0, 0, 0, 0, 0
			.byte 0, 0, 0, 0, 0, 0, 0, 0
			.ascii "FizzBuzz\n   "

Str100p:
			.word 0x3030, 0x3130, 0x3230, 0x3330, 0x3430, 0x3530, 0x3630, 0x3730, 0x3830, 0x3930
			.word 0x3031, 0x3131, 0x3231, 0x3331, 0x3431, 0x3531, 0x3631, 0x3731, 0x3831, 0x3931
			.word 0x3032, 0x3132, 0x3232, 0x3332, 0x3432, 0x3532, 0x3632, 0x3732, 0x3832, 0x3932
			.word 0x3033, 0x3133, 0x3233, 0x3333, 0x3433, 0x3533, 0x3633, 0x3733, 0x3833, 0x3933
			.word 0x3034, 0x3134, 0x3234, 0x3334, 0x3434, 0x3534, 0x3634, 0x3734, 0x3834, 0x3934
			.word 0x3035, 0x3135, 0x3235, 0x3335, 0x3435, 0x3535, 0x3635, 0x3735, 0x3835, 0x3935
			.word 0x3036, 0x3136, 0x3236, 0x3336, 0x3436, 0x3536, 0x3636, 0x3736, 0x3836, 0x3936
			.word 0x3037, 0x3137, 0x3237, 0x3337, 0x3437, 0x3537, 0x3637, 0x3737, 0x3837, 0x3937
			.word 0x3038, 0x3138, 0x3238, 0x3338, 0x3438, 0x3538, 0x3638, 0x3738, 0x3838, 0x3938
			.word 0x3039, 0x3139, 0x3239, 0x3339, 0x3439, 0x3539, 0x3639, 0x3739, 0x3839, 0x3939

###############################################################################
.text

			.globl _main
_main:

Initializing:
			xorl %r12d, %r12d # counter
			leaq OutputBuffer(%rip), %rdi # output buffer pointer
			incq %rdi
			xorl %r14d, %r14d # secondary counter ( 1 .. 15 )
			leaq FizzBuzz(%rip), %r15 # table 
			movq $POINTER, %r13 # $POINTER constant, 0 - print number, 1 - print word
			xorl %r11d, %r11d
			incb %r11b # table pointer
			cld
			leaq Str100p(%rip), %rsp # Str100p table pointer
MainLoop:
			incq %r12 # increase counter
			incb %r14b # increase secondary counter
			shlq %r11 # shift table pointer

			movq %r13, %r10
			andq %r11, %r10 # compare table pointer with $POINTER constant
			jz PrintMainCounter

			leaq (%r15, %r14, 8), %rsi # get address of string from table
			cmpb $15, %r14b # check if we're at the end of the table
			jne PrintFizzBuzz

#			xorl %r11d, %r11d # can be skipped
			incb %r11b
			xorb %r14b, %r14b # reset secondary counter
			movsb
			movsb
			movsb
			movsb
PrintFizzBuzz:
			movsb
			movsb
			movsb
			movsb
			movsb

CheckMainCounter1:
			cmpq $ITERATIONS, %r12
			jne MainLoop

#			movb $0xA, (%rdi)
#			incq %rdi
			jmp PrintBuffer
PrintMainCounter:
			movl %r12d, %eax
PrintDecimalNumber:
			movl $0xA, %esi # accumulator
			xorl %ecx, %ecx # counter
			incb %cl
			movl $100, %ebx
1:
			xorl %edx, %edx
			divq %rbx
			testl %eax, %eax
			jz 2f

			shlq $16, %rsi
			movw (%rsp, %rdx, 2), %si
			addb $2, %cl
			jmp 1b
2:
			shlq $16, %rsi
			movw (%rsp, %rdx, 2), %si

			cmpb $0x30, %sil
			jne 3f

			decq %rdi # adjust output buffer pointer - current number and buffer content will overlap
			movb $0xA, %sil # overlapped byte should always be '\n'
3:
			addb $2, %cl
			movq %rsi, (%rdi)
			addq %rcx, %rdi
CheckMainCounter2:
			cmpq $ITERATIONS, %r12
			jne MainLoop
PrintBuffer:
			movq %rdi, %rdx
			leaq OutputBuffer(%rip), %rsi
			incq %rsi
			subq %rsi, %rdx # number of symbols
			movl $STDOUT, %edi
			movl $SYS_WRITE, %eax
			syscall
Exit:
			movl $SYS_EXIT, %eax
			syscall

###############################################################################
