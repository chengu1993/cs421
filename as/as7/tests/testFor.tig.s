.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $132, %esp
pushl %ebx
pushl %edi
pushl %esi
L20:
movl $1, %ebx
movl %ebx, -124(%ebp)
movl $2, %ebx
movl %ebx, -128(%ebp)
movl $0, %ebx
movl %ebx, -132(%ebp)
movl $10000, %ebx
movl -132(%ebp), %edi
cmp %ebx, %edi
jle L17
L13:
movl $0, %ebx
movl %ebx, %eax
jmp L19
L17:
movl -132(%ebp), %ebx
pushl %ebx
pushl %ebp
call L0
addl $8, %esp
leal L14, %ebx
pushl %ebx
call print
addl $4, %esp
movl $100, %ebx
movl -132(%ebp), %edi
cmp %ebx, %edi
je L15
L16:
movl $10000, %ebx
movl -132(%ebp), %edi
cmp %ebx, %edi
jge L13
L18:
movl -132(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
movl %ebx, -132(%ebp)
jmp L17
L15:
jmp L13
L19:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L14:
  .long 1
  .byte 10
.globl L0
	.type	L0, @function
L0:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L22:
movl $0, %ebx
movl 12(%ebp), %edi
cmp %ebx, %edi
jl L10
L11:
movl $0, %ebx
movl 12(%ebp), %edi
cmp %ebx, %edi
jg L7
L8:
leal L6, %ebx
pushl %ebx
call print
movl %eax, %ebx
addl $4, %esp
L9:
movl %ebx, %ebx
L12:
movl %ebx, %eax
jmp L21
L10:
leal L5, %ebx
pushl %ebx
call print
addl $4, %esp
movl $0, %ebx
movl %ebx, %ebx
movl 12(%ebp), %edi
subl %edi, %ebx
pushl %ebx
pushl %ebp
call L1
movl %eax, %ebx
addl $8, %esp
movl %ebx, %ebx
jmp L12
L7:
movl 12(%ebp), %ebx
pushl %ebx
pushl %ebp
call L1
movl %eax, %ebx
addl $8, %esp
jmp L9
L21:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L6:
  .long 1
  .byte 48
L5:
  .long 1
  .byte 45
.globl L1
	.type	L1, @function
L1:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L24:
movl $0, %ebx
movl 12(%ebp), %edi
cmp %ebx, %edi
jg L3
L4:
movl $0, %ebx
movl %ebx, %eax
jmp L23
L3:
movl $0, %edx
movl 12(%ebp), %ebx
movl %ebx, %eax
movl $10, %ebx
idivl %ebx
pushl %eax
movl 8(%ebp), %ebx
pushl %ebx
call L1
addl $8, %esp
movl 12(%ebp), %ebx
movl %ebx, %ebx
movl $0, %edx
movl 12(%ebp), %edi
movl %edi, %eax
movl $10, %edi
idivl %edi
movl %eax, %edi
movl $10, %esi
imull %esi, %edi
subl %edi, %ebx
movl %ebx, %ebx
leal L2, %edi
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
movl %eax, %ebx
addl $4, %esp
jmp L4
L23:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L2:
  .long 1
  .byte 48
