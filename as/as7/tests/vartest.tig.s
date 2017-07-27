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
movl $3, %ebx
movl %ebx, %ebx
movl $3, %edi
addl %edi, %ebx
movl %ebx, -124(%ebp)
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
movl %ebx, %ebx
leal L0, %edi
pushl %edi
call ord
movl %eax, %edi
addl $4, %esp
movl %ebx, %ebx
addl %edi, %ebx
pushl %ebx
call chr
movl %eax, %ebx
addl $4, %esp
pushl %ebx
call print
addl $4, %esp
leal L1, %ebx
pushl %ebx
call print
movl %eax, %ebx
addl $4, %esp
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
  .long 1
  .byte 10
L0:
  .long 1
  .byte 48
