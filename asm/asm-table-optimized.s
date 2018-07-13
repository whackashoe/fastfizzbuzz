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


###############################################################################
.text

			.globl _main
_main:

Initializing:
			xorl %r12d, %r12d # counter
			leaq OutputBuffer(%rip), %rdi # output buffer pointer
			xorl %r14d, %r14d # secondary counter ( 1 .. 15 )
			leaq FizzBuzz(%rip), %r15 # table 
			movq $POINTER, %r13 # $POINTER constant, 0 - print number, 1 - print word
			xorl %r11d, %r11d
			incb %r11b # table pointer
			cld
Loop:
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
			jne Loop
			jmp PrintBuffer
PrintMainCounter:
			movq %r12, %rax
PrintDecimalNumber:
			movq $10, %rbx # BASE
			movl $0xA, %esi # accumulator
			xorl %ecx, %ecx # counter
			incb %cl
1:
			shlq $8, %rsi

			xorl %edx, %edx
			divq %rbx
			addb $0x30, %dl # '0'

			orq %rdx, %rsi
			incb %cl
			testq %rax, %rax
			jnz 1b

			movq %rsi, (%rdi)
			addq %rcx, %rdi
CheckMainCounter2:
			cmpq $ITERATIONS, %r12
			jne Loop
PrintBuffer:
			movq %rdi, %rdx
			leaq OutputBuffer(%rip), %rsi
			subq %rsi, %rdx # number of symbols
			movl $STDOUT, %edi
			movl $SYS_WRITE, %eax
			syscall
Exit:
			movl $SYS_EXIT, %eax
			syscall
