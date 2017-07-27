.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $132, %esp
pushl %ebx
pushl %edi
pushl %esi
L4:
movl $10, %ebx
movl %ebx, -124(%ebp)
movl %ebp, %ebx
movl $-128, %edi
addl %edi, %ebx
movl %ebx, %ebx
leal L0, %edi
pushl %edi
movl -124(%ebp), %edi
pushl %edi
call initArray
movl %eax, %edi
addl $8, %esp
movl %edi, (%ebx)
movl $0, %ebx
movl %ebx, %ebx
movl $1, %edi
subl %edi, %ebx
movl %ebx, -132(%ebp)
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
subl %edi, %ebx
movl -132(%ebp), %edi
cmp %ebx, %edi
jl L2
L1:
movl $0, %ebx
movl %ebx, %eax
jmp L3
L2:
movl -128(%ebp), %ebx
movl %ebx, %ebx
movl -132(%ebp), %edi
movl %edi, %edi
movl $1, %esi
addl %esi, %edi
movl %edi, -132(%ebp)
movl -132(%ebp), %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl %ebx, %ebx
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
pushl %ebx
call print
addl $4, %esp
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
subl %edi, %ebx
movl -132(%ebp), %edi
cmp %ebx, %edi
jl L2
L5:
jmp L1
L3:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L0:
  .long 22
  .byte 83, 104, 111, 117, 108, 100, 32, 80, 114, 105, 110, 116, 32, 49, 48, 32, 84, 105, 109, 101, 115, 10
