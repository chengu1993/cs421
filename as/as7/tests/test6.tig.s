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
leal L3, %ebx
pushl %ebx
movl $0, %ebx
pushl %ebx
pushl %ebp
call L0
addl $12, %esp
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
L3:
  .long 4
  .byte 115, 116, 114, 50
.globl L1
	.type	L1, @function
L1:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L7:
leal L2, %ebx
pushl %ebx
movl 12(%ebp), %ebx
pushl %ebx
movl 8(%ebp), %ebx
pushl %ebx
call L0
movl %eax, %eax
addl $12, %esp
jmp L6
L6:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L2:
  .long 3
  .byte 115, 116, 114
.globl L0
	.type	L0, @function
L0:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L9:
movl 12(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
pushl %ebx
movl 8(%ebp), %ebx
pushl %ebx
call L1
movl %eax, %eax
addl $8, %esp
jmp L8
L8:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
