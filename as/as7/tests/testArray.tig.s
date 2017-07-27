.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $128, %esp
pushl %ebx
pushl %edi
pushl %esi
L22:
movl %ebp, %ebx
movl $-124, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl $100, %edi
pushl %edi
movl $3, %edi
pushl %edi
call initArray
movl %eax, %edi
addl $8, %esp
movl %edi, (%ebx)
movl $0, %ebx
movl %ebx, -128(%ebp)
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl $2, %esi
movl %ebx, %ebx
movl %edi, %edi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %edi
addl %edi, %ebx
movl %esi, (%ebx)
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $2, %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl $3, %esi
movl %ebx, %ebx
movl %edi, %edi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %edi
addl %edi, %ebx
movl %esi, (%ebx)
movl $3, %ebx
movl -128(%ebp), %edi
cmp %ebx, %edi
jl L19
L15:
movl $3, %ebx
pushl %ebx
movl $0, %ebx
pushl %ebx
movl -124(%ebp), %ebx
pushl %ebx
pushl %ebp
call L13
addl $16, %esp
leal L20, %ebx
pushl %ebx
call print
movl %eax, %ebx
addl $4, %esp
movl %ebx, %eax
jmp L21
L19:
movl %ebp, %ebx
movl -124(%ebp), %edi
movl %edi, %edi
movl -128(%ebp), %esi
movl %esi, %esi
pushl %esi
pushl %edi
call checkArrayBounds
addl $8, %esp
movl %edi, %edi
movl %esi, %esi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %esi
addl %esi, %edi
movl (%edi), %edi
pushl %edi
pushl %ebx
call L0
addl $8, %esp
leal L16, %ebx
pushl %ebx
call print
addl $4, %esp
movl $1, %ebx
movl -128(%ebp), %edi
cmp %ebx, %edi
je L17
L18:
movl -128(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
movl %ebx, -128(%ebp)
movl $3, %ebx
movl -128(%ebp), %edi
cmp %ebx, %edi
jl L19
L23:
jmp L15
L17:
jmp L15
L21:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L20:
  .long 1
  .byte 10
L16:
  .long 1
  .byte 10
.globl L13
	.type	L13, @function
L13:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L25:
movl 8(%ebp), %ebx
movl %ebx, %ebx
movl 12(%ebp), %edi
movl %edi, %edi
movl 16(%ebp), %esi
movl %esi, %esi
pushl %esi
pushl %edi
call checkArrayBounds
addl $8, %esp
movl %edi, %edi
movl %esi, %esi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %esi
addl %esi, %edi
movl (%edi), %edi
pushl %edi
pushl %ebx
call L0
addl $8, %esp
leal L14, %ebx
pushl %ebx
call print
addl $4, %esp
movl 20(%ebp), %ebx
pushl %ebx
movl 16(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
pushl %ebx
movl 12(%ebp), %ebx
pushl %ebx
movl 8(%ebp), %ebx
pushl %ebx
call L13
movl %eax, %ebx
addl $16, %esp
movl %ebx, %eax
jmp L24
L24:
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
L27:
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
jmp L26
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
L26:
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
L29:
movl $0, %ebx
movl 12(%ebp), %edi
cmp %ebx, %edi
jg L3
L4:
movl $0, %ebx
movl %ebx, %eax
jmp L28
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
L28:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L2:
  .long 1
  .byte 48
