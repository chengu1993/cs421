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
movl %ebp, %ebx
movl $-124, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl $0, %edi
pushl %edi
movl $10, %edi
pushl %edi
call initArray
movl %eax, %edi
addl $8, %esp
movl %edi, (%ebx)
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $2, %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl %ebx, %ebx
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
movl $1, %ebx
movl %ebx, %eax
jmp L0
L0:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
