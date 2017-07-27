.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L10:
movl $0, %ebx
movl $1, %edi
cmp %ebx, %edi
je L6
L7:
movl $0, %ebx
movl $1, %edi
cmp %ebx, %edi
jne L3
L4:
movl $8, %ebx
movl %ebx, %ebx
L5:
movl %ebx, %ebx
L8:
movl $1, %ebx
movl %ebx, %eax
jmp L9
L6:
movl $1, %ebx
movl $1, %edi
cmp %ebx, %edi
je L0
L1:
movl $6, %ebx
movl %ebx, %ebx
L2:
movl %ebx, %ebx
jmp L8
L0:
movl $5, %ebx
movl %ebx, %ebx
jmp L2
L3:
movl $7, %ebx
movl %ebx, %ebx
jmp L5
L9:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
