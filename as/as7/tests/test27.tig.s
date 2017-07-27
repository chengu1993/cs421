.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $124, %esp
pushl %ebx
pushl %edi
pushl %esi
L2:
movl $0, %ebx
movl %ebx, -124(%ebp)
movl $2, %ebx
pushl %ebx
pushl %ebp
call L0
addl $8, %esp
movl $1, %ebx
movl %ebx, %eax
jmp L1
L1:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
.globl L0
	.type	L0, @function
L0:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L4:
movl 12(%ebp), %ebx
movl %ebx, %eax
jmp L3
L3:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
