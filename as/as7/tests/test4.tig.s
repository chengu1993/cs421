.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L5:
movl $10, %ebx
pushl %ebx
pushl %ebp
call L0
addl $8, %esp
movl $1, %ebx
movl %ebx, %eax
jmp L4
L4:
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
L7:
movl $0, %ebx
movl 12(%ebp), %edi
cmp %ebx, %edi
je L1
L2:
movl 12(%ebp), %ebx
movl %ebx, %ebx
movl 12(%ebp), %edi
movl %edi, %edi
movl $1, %esi
subl %esi, %edi
pushl %edi
movl 8(%ebp), %edi
pushl %edi
call L0
movl %eax, %edi
addl $8, %esp
movl %ebx, %ebx
imull %edi, %ebx
movl %ebx, %ebx
L3:
movl %ebx, %eax
jmp L6
L1:
movl $1, %ebx
movl %ebx, %ebx
jmp L3
L6:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
