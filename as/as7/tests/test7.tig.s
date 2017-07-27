.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L6:
leal L4, %ebx
pushl %ebx
movl $0, %ebx
pushl %ebx
pushl %ebp
call L0
addl $12, %esp
movl $1, %ebx
movl %ebx, %eax
jmp L5
L5:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L4:
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
L8:
leal L2, %ebx
pushl %ebx
movl 12(%ebp), %ebx
pushl %ebx
movl 8(%ebp), %ebx
pushl %ebx
call L0
addl $12, %esp
leal L3, %ebx
movl %ebx, %eax
jmp L7
L7:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L3:
  .long 1
  .byte 32
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
L10:
movl 12(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
pushl %ebx
movl 8(%ebp), %ebx
pushl %ebx
call L1
addl $8, %esp
movl $0, %ebx
movl %ebx, %eax
jmp L9
L9:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
