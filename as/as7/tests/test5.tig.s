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
movl $8, %edi
pushl %edi
call allocRecord
movl %eax, %edi
addl $4, %esp
movl $0, %esi
movl %esi, 0(%edi)
movl $0, %esi
movl %esi, 4(%edi)
movl %edi, (%ebx)
movl -124(%ebp), %ebx
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
