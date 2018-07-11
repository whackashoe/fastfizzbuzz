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

			.set EXIT_SUCCESS, 0

			.set ITERATIONS, 1000000
###############################################################################
.data

Buffer:
			.ascii "                                                                "
			.ascii "                                                                "
			.ascii "                                                                "
			.ascii "                                                               \n"

FizzBuzz:
			.ascii "                "
			.ascii "Buzz\n           "
			.ascii "Fizz\n           "
			.ascii "FizzBuzz\n       "

###############################################################################
.text

			.globl _start
_start:
			xorq %r12, %r12 # set main counter
			movl $3, %r13d # set 3's counter
			movl $5, %r14d # set 5's counter

			movl $9, %r15d
Loop:
			incq %r12 # increase main counter
			xorl %ebx, %ebx # clear accumulator
Test3:
			cmpq %r13, %r12
			jne Test5
			incb %bl
			addq $3, %r13 # increase 3's counter
Test5:
			shlw %bx
			cmpq %r14, %r12
			jne TestFizzBuzz
			incb %bl
			addq $5, %r14 # increase 5's counter
TestFizzBuzz:
			shlw $4, %bx
			testb %bl, %bl
			jz PrintMainCounter

			movl $5, %edx # length is 5
			cmovpl %r15d, %edx # length is 9
PrintFizzBuzz:
			leaq FizzBuzz(%rip), %rsi
			addq %rbx, %rsi
			movl $STDOUT, %edi
			movl $SYS_WRITE, %eax
			syscall
CheckMainCounter1:
			cmpq $ITERATIONS, %r12
			jne Loop
Exit:
			mov  $EXIT_SUCCESS, %rdi
			movl $SYS_EXIT, %eax
			syscall
PrintMainCounter:
			movq %r12, %rax
PrintDecimalNumber:
			leaq Buffer(%rip), %rdi # PAD
			addq $255, %rdi
			movq $10, %rbx # BASE

			xorl %ecx, %ecx
1:
			xorl %edx, %edx
			divq %rbx
			addb $0x30, %dl # '0'
2:
			decq %rdi
			movb %dl, (%rdi)
			incb %cl
			testq %rax, %rax
			jnz 1b
			leaq 1(%rcx), %rdx

			# %rdx already contains number of symbols
			movq %rdi, %rsi # string address
			movl $STDOUT, %edi
			movl $SYS_WRITE, %eax
			syscall
CheckMainCounter2:
			cmpq $ITERATIONS, %r12
			jne Loop
Exit2:
			movl $SYS_EXIT, %eax
			syscall
