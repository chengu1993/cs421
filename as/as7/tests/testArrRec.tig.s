.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $124, %esp
pushl %ebx
pushl %edi
pushl %esi
L4:
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
movl %edi, %esi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
addl %ecx, %esi
movl %esi, %esi
movl $8, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
pushl %ecx
call allocRecord
movl %eax, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
addl $4, %esp
leal L1, %ecx
	movl	%ecx, -12(%ebp) # save pseudo-register
	movl	-12(%ebp), %ecx # load pseudo-register
	movl	-8(%ebp), %edx # load pseudo-register
movl %ecx, 0(%edx)
movl $0, %ecx
	movl	%ecx, -12(%ebp) # save pseudo-register
	movl	-12(%ebp), %ecx # load pseudo-register
	movl	-8(%ebp), %edx # load pseudo-register
movl %ecx, 4(%edx)
	movl	-8(%ebp), %ecx # load pseudo-register
movl %ecx, (%esi)
movl %edi, (%ebx)
movl -124(%ebp), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
movl %ebx, %ebx
movl $0, %edi
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
pushl %ebx
call print
addl $4, %esp
leal L2, %ebx
pushl %ebx
call print
addl $4, %esp
movl -124(%ebp), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
movl %ebx, %ebx
movl $1, %edi
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
movl %ebx, %ebx
movl $1, %edi
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
movl %ebx, %ebx
movl $0, %edi
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
pushl %ebx
call print
movl %eax, %ebx
addl $4, %esp
movl %ebx, %eax
jmp L3
L3:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L2:
  .long 1
  .byte 10
L1:
  .long 7
  .byte 115, 101, 99, 99, 111, 110, 100
L0:
  .long 5
  .byte 102, 105, 114, 115, 116
