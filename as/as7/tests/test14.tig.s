.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $124, %esp
pushl %ebx
pushl %edi
pushl %esi
L1:
movl $73, %ebx
movl %ebx, -124(%ebp)
movl -124(%ebp), %ebx
movl %ebx, %eax
jmp L0
L0:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
