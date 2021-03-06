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
			.lcomm Buffer, 512

FizzBuzz:
			.ascii "                "
			.byte 5
			.ascii "Buzz\n          "
			.byte 5
			.ascii "Fizz\n          "
			.byte 9
			.ascii "FizzBuzz\n      "

###############################################################################
.text

			.globl _start
_start:
			xorq %r12, %r12
			movq $3, %r13
			movq $5, %r14
Loop:
			incq %r12
			movq %r12, %rax
Test3:
			xorq %rdx, %rdx
			movq %r12, %rax
			divq %r13

			testq %rdx, %rdx
			setz %r15b
			shll %r15d
Test5:
			xorq %rdx, %rdx
			movq %r12, %rax
			divq %r14

			testq %rdx, %rdx
			setz %bl
			orb %bl, %r15b
			shll $4, %r15d

			testb %r15b, %r15b
			jz PrintCounter
PrintFizzBuzz:
			xorq %rdx, %rdx
			leaq FizzBuzz(%rip), %rsi
			addq %r15, %rsi
			movb (%rsi), %dl
			incq %rsi
			movl $STDOUT, %edi
			movl $SYS_WRITE, %eax
			syscall
CheckCounter1:
			cmpq $ITERATIONS, %r12
			jne Loop
Exit:
			mov  $EXIT_SUCCESS, %rdi
			movl $SYS_EXIT, %eax
			syscall
PrintCounter:
			movq %r12, %rax
PrintDecimalNumber:
			leaq Buffer(%rip), %rdi # PAD
			addq $255, %rdi
			movq $10, %rbx # BASE

			movb $0x0A, (%rdi) # CR

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
CheckCounter2:
			cmpq $ITERATIONS, %r12
			jne Loop
