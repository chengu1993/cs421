.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $124, %esp
pushl %ebx
pushl %edi
pushl %esi
L9:
movl $1, %ebx
movl %ebx, -124(%ebp)
movl $10, %ebx
movl -124(%ebp), %edi
cmp %ebx, %edi
jle L6
L0:
movl $0, %ebx
movl %ebx, %eax
jmp L8
L6:
movl $2, %ebx
movl $3, %edi
cmp %ebx, %edi
je L3
L4:
leal L2, %ebx
movl %ebx, %ebx
L5:
pushl %ebx
call print
addl $4, %esp
movl $10, %ebx
movl -124(%ebp), %edi
cmp %ebx, %edi
jge L0
L7:
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
movl %ebx, -124(%ebp)
jmp L6
L3:
leal L1, %ebx
movl %ebx, %ebx
jmp L5
L8:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L2:
  .long 6
  .byte 83, 76, 69, 69, 80, 10
L1:
  .long 8
  .byte 103, 114, 101, 97, 116, 101, 114, 10
