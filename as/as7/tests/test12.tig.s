.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $128, %esp
pushl %ebx
pushl %edi
pushl %esi
L4:
movl $0, %ebx
movl %ebx, -124(%ebp)
movl $0, %ebx
movl %ebx, -128(%ebp)
movl $100, %ebx
movl -128(%ebp), %edi
cmp %ebx, %edi
jle L1
L0:
movl $1, %ebx
movl %ebx, %eax
jmp L3
L1:
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
movl %ebx, -124(%ebp)
movl $100, %ebx
movl -128(%ebp), %edi
cmp %ebx, %edi
jge L0
L2:
movl -128(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
movl %ebx, -128(%ebp)
jmp L1
L3:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
