.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $140, %esp
pushl %ebx
pushl %edi
pushl %esi
L34:
movl $8, %ebx
movl %ebx, -124(%ebp)
movl %ebp, %ebx
movl $-128, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl $0, %edi
pushl %edi
movl -124(%ebp), %edi
pushl %edi
call initArray
movl %eax, %edi
addl $8, %esp
movl %edi, (%ebx)
movl %ebp, %ebx
movl $-132, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl $0, %edi
pushl %edi
movl -124(%ebp), %edi
pushl %edi
call initArray
movl %eax, %edi
addl $8, %esp
movl %edi, (%ebx)
movl %ebp, %ebx
movl $-136, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl $0, %edi
pushl %edi
movl -124(%ebp), %edi
movl %edi, %edi
movl -124(%ebp), %esi
addl %esi, %edi
movl %edi, %edi
movl $1, %esi
subl %esi, %edi
pushl %edi
call initArray
movl %eax, %edi
addl $8, %esp
movl %edi, (%ebx)
movl %ebp, %ebx
movl $-140, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl $0, %edi
pushl %edi
movl -124(%ebp), %edi
movl %edi, %edi
movl -124(%ebp), %esi
addl %esi, %edi
movl %edi, %edi
movl $1, %esi
subl %esi, %edi
pushl %edi
call initArray
movl %eax, %edi
addl $8, %esp
movl %edi, (%ebx)
movl $0, %ebx
pushl %ebx
pushl %ebp
call L1
addl $8, %esp
movl $1, %ebx
movl %ebx, %eax
jmp L33
L33:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
.globl L1
	.type	L1, @function
L1:
pushl %ebp
movl %esp, %ebp
subl $124, %esp
pushl %ebx
pushl %edi
pushl %esi
L36:
movl 8(%ebp), %ebx
movl -124(%ebx), %ebx
movl 12(%ebp), %edi
cmp %ebx, %edi
je L30
L31:
movl $0, %ebx
movl %ebx, -124(%ebp)
movl 8(%ebp), %ebx
movl -124(%ebx), %ebx
movl %ebx, %ebx
movl $1, %edi
subl %edi, %ebx
movl -124(%ebp), %edi
cmp %ebx, %edi
jle L28
L15:
movl $0, %ebx
movl %ebx, %ebx
L32:
movl %ebx, %eax
jmp L35
L30:
movl 8(%ebp), %ebx
pushl %ebx
call L0
movl %eax, %ebx
addl $4, %esp
jmp L32
L28:
movl 8(%ebp), %ebx
movl -128(%ebx), %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl $0, %esi
movl %ebx, %ebx
movl %edi, %edi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %edi
addl %edi, %ebx
movl (%ebx), %ebx
cmp %esi, %ebx
je L16
L17:
movl $0, %ebx
movl %ebx, %ebx
L18:
movl $0, %edi
cmp %edi, %ebx
je L22
L21:
movl $1, %ebx
movl %ebx, %ebx
movl 8(%ebp), %edi
movl -140(%edi), %edi
movl %edi, %edi
movl -124(%ebp), %esi
movl %esi, %esi
movl $7, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
addl %ecx, %esi
movl %esi, %esi
movl 12(%ebp), %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
subl %ecx, %esi
movl %esi, %esi
pushl %esi
pushl %edi
call checkArrayBounds
addl $8, %esp
movl $0, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
movl %edi, %edi
movl %esi, %esi
movl $4, %ecx
	movl	%ecx, -12(%ebp) # save pseudo-register
	movl	-12(%ebp), %ecx # load pseudo-register
imull %ecx, %esi
addl %esi, %edi
movl (%edi), %edi
	movl	-8(%ebp), %ecx # load pseudo-register
cmp %ecx, %edi
je L24
L25:
movl $0, %ebx
movl %ebx, %ebx
L24:
movl %ebx, %ebx
L23:
movl $0, %edi
cmp %edi, %ebx
je L27
L26:
movl 8(%ebp), %ebx
movl -128(%ebx), %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl $1, %esi
movl %ebx, %ebx
movl %edi, %edi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %edi
addl %edi, %ebx
movl %esi, (%ebx)
movl 8(%ebp), %ebx
movl -136(%ebx), %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
movl %edi, %edi
movl 12(%ebp), %esi
addl %esi, %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl $1, %esi
movl %ebx, %ebx
movl %edi, %edi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %edi
addl %edi, %ebx
movl %esi, (%ebx)
movl 8(%ebp), %ebx
movl -140(%ebx), %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
movl %edi, %edi
movl $7, %esi
addl %esi, %edi
movl %edi, %edi
movl 12(%ebp), %esi
subl %esi, %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl $1, %esi
movl %ebx, %ebx
movl %edi, %edi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %edi
addl %edi, %ebx
movl %esi, (%ebx)
movl 8(%ebp), %ebx
movl -132(%ebx), %ebx
movl %ebx, %ebx
movl 12(%ebp), %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl %ebp, %esi
movl $-124, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
addl %ecx, %esi
movl (%esi), %esi
movl %ebx, %ebx
movl %edi, %edi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %edi
addl %edi, %ebx
movl %esi, (%ebx)
movl 12(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
pushl %ebx
movl 8(%ebp), %ebx
pushl %ebx
call L1
addl $8, %esp
movl 8(%ebp), %ebx
movl -128(%ebx), %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl $0, %esi
movl %ebx, %ebx
movl %edi, %edi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %edi
addl %edi, %ebx
movl %esi, (%ebx)
movl 8(%ebp), %ebx
movl -136(%ebx), %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
movl %edi, %edi
movl 12(%ebp), %esi
addl %esi, %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl $0, %esi
movl %ebx, %ebx
movl %edi, %edi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %edi
addl %edi, %ebx
movl %esi, (%ebx)
movl 8(%ebp), %ebx
movl -140(%ebx), %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
movl %edi, %edi
movl $7, %esi
addl %esi, %edi
movl %edi, %edi
movl 12(%ebp), %esi
subl %esi, %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl $0, %esi
movl %ebx, %ebx
movl %edi, %edi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %edi
addl %edi, %ebx
movl %esi, (%ebx)
L27:
movl 8(%ebp), %ebx
movl -124(%ebx), %ebx
movl %ebx, %ebx
movl $1, %edi
subl %edi, %ebx
movl -124(%ebp), %edi
cmp %ebx, %edi
jge L15
L29:
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
movl %ebx, -124(%ebp)
jmp L28
L16:
movl $1, %ebx
movl %ebx, %ebx
movl 8(%ebp), %edi
movl -136(%edi), %edi
movl %edi, %edi
movl -124(%ebp), %esi
movl %esi, %esi
movl 12(%ebp), %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
addl %ecx, %esi
movl %esi, %esi
pushl %esi
pushl %edi
call checkArrayBounds
addl $8, %esp
movl $0, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
movl %edi, %edi
movl %esi, %esi
movl $4, %ecx
	movl	%ecx, -12(%ebp) # save pseudo-register
	movl	-12(%ebp), %ecx # load pseudo-register
imull %ecx, %esi
addl %esi, %edi
movl (%edi), %edi
	movl	-8(%ebp), %ecx # load pseudo-register
cmp %ecx, %edi
je L19
L20:
movl $0, %ebx
movl %ebx, %ebx
L19:
movl %ebx, %ebx
jmp L18
L22:
movl $0, %ebx
movl %ebx, %ebx
jmp L23
L35:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
.globl L0
	.type	L0, @function
L0:
pushl %ebp
movl %esp, %ebp
subl $128, %esp
pushl %ebx
pushl %edi
pushl %esi
L38:
movl $0, %ebx
movl %ebx, -124(%ebp)
movl 8(%ebp), %ebx
movl -124(%ebx), %ebx
movl %ebx, %ebx
movl $1, %edi
subl %edi, %ebx
movl -124(%ebp), %edi
cmp %ebx, %edi
jle L12
L2:
leal L14, %ebx
pushl %ebx
call print
movl %eax, %ebx
addl $4, %esp
movl %ebx, %eax
jmp L37
L12:
movl $0, %ebx
movl %ebx, -128(%ebp)
movl 8(%ebp), %ebx
movl -124(%ebx), %ebx
movl %ebx, %ebx
movl $1, %edi
subl %edi, %ebx
movl -128(%ebp), %edi
cmp %ebx, %edi
jle L9
L3:
leal L11, %ebx
pushl %ebx
call print
movl %eax, %ebx
addl $4, %esp
movl 8(%ebp), %ebx
movl -124(%ebx), %ebx
movl %ebx, %ebx
movl $1, %edi
subl %edi, %ebx
movl -124(%ebp), %edi
cmp %ebx, %edi
jge L2
L13:
movl -124(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
movl %ebx, -124(%ebp)
jmp L12
L9:
movl 8(%ebp), %ebx
movl -132(%ebx), %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl -128(%ebp), %esi
movl %ebx, %ebx
movl %edi, %edi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %edi
addl %edi, %ebx
movl (%ebx), %ebx
cmp %esi, %ebx
je L6
L7:
leal L5, %ebx
movl %ebx, %ebx
L8:
pushl %ebx
call print
addl $4, %esp
movl 8(%ebp), %ebx
movl -124(%ebx), %ebx
movl %ebx, %ebx
movl $1, %edi
subl %edi, %ebx
movl -128(%ebp), %edi
cmp %ebx, %edi
jge L3
L10:
movl -128(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
movl %ebx, -128(%ebp)
jmp L9
L6:
leal L4, %ebx
movl %ebx, %ebx
jmp L8
L37:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L14:
  .long 1
  .byte 10
L11:
  .long 1
  .byte 10
L5:
  .long 2
  .byte 32, 46
L4:
  .long 2
  .byte 32, 79
