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
###############################################################################
.data

			.lcomm OutputBuffer, ITERATIONS*256
Buffer:
			.ascii "                                                                "
			.ascii "                                                                "
			.ascii "                                                                "
			.ascii "                                                               \n"
FizzBuzz:
			.byte 0, 0, 0, 0, 0, 0, 0, 0
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
			.ascii "FizzBuzz\n"

###############################################################################
.text

			.globl _start
_start:

Initializing:
			xorl %r12d, %r12d # counter
			leaq OutputBuffer(%rip), %rdi
			movq %rdi, %r13
			xorl %r14d, %r14d # secondary counter ( 1 .. 15 )
			leaq FizzBuzz(%rip), %r15
			cld
Loop:
			incq %r12 # increase counter
			incb %r14b # increase secondary counter

			leaq (%r15, %r14, 8), %rsi # get address of string from table
			cmpb $0, (%rsi) # check first byte of string
			jz PrintMainCounter

			movq $5, %rcx # set string length

			cmpb $15, %r14b # check if we're at the end of the table
			jne PrintFizzBuzz

			xorb %r14b, %r14b # reset secondary counter
			movb $9, %cl # adjust string length
PrintFizzBuzz:
			rep movsb
CheckMainCounter1:
			cmpq $ITERATIONS, %r12
			jne Loop
			jmp PrintBuffer
PrintMainCounter:
			movq %r12, %rax
PrintDecimalNumber:
			leaq Buffer(%rip), %rsi # PAD
			addq $255, %rsi
			movq $10, %rbx # BASE

			xorl %ecx, %ecx
1:
			xorl %edx, %edx
			divq %rbx
			addb $0x30, %dl # '0'
2:
			decq %rsi
			movb %dl, (%rsi)
			incb %cl
			testq %rax, %rax
			jnz 1b
			leaq 1(%rcx), %rcx

			rep movsb
CheckMainCounter2:
			cmpq $ITERATIONS, %r12
			jne Loop
PrintBuffer:
			movq %rdi, %rdx
			subq %r13, %rdx # number of symbols
			movq %r13, %rsi # string address
			movl $STDOUT, %edi
			movl $SYS_WRITE, %eax
			syscall
Exit:
			movl $SYS_EXIT, %eax
			syscall
