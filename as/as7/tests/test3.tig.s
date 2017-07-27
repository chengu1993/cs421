.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $124, %esp
pushl %ebx
pushl %edi
pushl %esi
L3:
movl %ebp, %ebx
movl $-124, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl $8, %edi
pushl %edi
call allocRecord
movl %eax, %edi
addl $4, %esp
leal L0, %esi
movl %esi, 0(%edi)
movl $1000, %esi
movl %esi, 4(%edi)
movl %edi, (%ebx)
movl -124(%ebp), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
leal L1, %ebx
movl -124(%ebp), %edi
movl %edi, %edi
movl $0, %esi
movl %esi, %esi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %esi
addl %esi, %edi
movl %ebx, (%edi)
movl -124(%ebp), %ebx
movl $1, %ebx
movl %ebx, %eax
jmp L2
L2:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L1:
  .long 8
  .byte 83, 111, 109, 101, 98, 111, 100, 121
L0:
  .long 6
  .byte 78, 111, 98, 111, 100, 121
