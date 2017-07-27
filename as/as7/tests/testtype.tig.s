.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L1:
movl $0, %ebx
movl %ebx, %eax
jmp L0
L0:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
