.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $136, %esp
pushl %ebx
pushl %edi
pushl %esi
L27:
movl %ebp, %ebx
movl $-124, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl $8, %edi
pushl %edi
call allocRecord
movl %eax, %edi
addl $4, %esp
leal L13, %esi
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
leal L14, %ecx
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
movl %ebp, %ebx
movl $-128, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
pushl %edi
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %edi
movl %edi, %edi
movl $1, %esi
movl %esi, %esi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %esi
addl %esi, %edi
movl (%edi), %edi
movl %edi, (%ebx)
movl %ebp, %ebx
movl $-132, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
pushl %edi
movl $5, %edi
pushl %edi
call initArray
movl %eax, %edi
addl $8, %esp
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
leal L15, %ebx
pushl %ebx
call print
addl $4, %esp
movl -132(%ebp), %ebx
movl %ebx, %ebx
movl $2, %edi
movl %edi, %edi
pushl %edi
pushl %ebx
call checkArrayBounds
addl $8, %esp
movl %ebp, %esi
movl $-128, %ecx
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
movl -132(%ebp), %ebx
movl %ebx, %ebx
movl $0, %edi
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
call checkNilRecord
addl $4, %esp
movl -132(%ebp), %ebx
movl %ebx, %ebx
movl $0, %edi
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
leal L16, %ebx
pushl %ebx
call print
addl $4, %esp
movl -132(%ebp), %ebx
movl %ebx, %ebx
movl $2, %edi
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
call checkNilRecord
addl $4, %esp
movl -132(%ebp), %ebx
movl %ebx, %ebx
movl $2, %edi
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
leal L17, %ebx
pushl %ebx
call print
addl $4, %esp
movl -128(%ebp), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl -128(%ebp), %ebx
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
leal L18, %ebx
pushl %ebx
call print
addl $4, %esp
movl $0, %ebx
movl %ebx, -136(%ebp)
movl $3, %ebx
movl -136(%ebp), %edi
cmp %ebx, %edi
jle L21
L19:
movl $0, %ebx
movl -124(%ebp), %edi
cmp %ebx, %edi
jne L25
L23:
movl $0, %ebx
movl %ebx, %eax
jmp L26
L21:
movl -136(%ebp), %ebx
pushl %ebx
pushl %ebp
call L0
addl $8, %esp
movl -132(%ebp), %ebx
movl %ebx, %ebx
movl -136(%ebp), %edi
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
call checkNilRecord
addl $4, %esp
movl -132(%ebp), %ebx
movl %ebx, %ebx
movl -136(%ebp), %edi
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
leal L20, %ebx
pushl %ebx
call print
movl %eax, %ebx
addl $4, %esp
movl $3, %ebx
movl -136(%ebp), %edi
cmp %ebx, %edi
jge L19
L22:
movl -136(%ebp), %ebx
movl %ebx, %ebx
movl $1, %edi
addl %edi, %ebx
movl %ebx, -136(%ebp)
jmp L21
L25:
movl -124(%ebp), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %ebx
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
leal L24, %ebx
pushl %ebx
call print
addl $4, %esp
movl %ebp, %ebx
movl $-124, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
pushl %edi
call checkNilRecord
addl $4, %esp
movl -124(%ebp), %edi
movl %edi, %edi
movl $1, %esi
movl %esi, %esi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %esi
addl %esi, %edi
movl (%edi), %edi
movl %edi, (%ebx)
movl $0, %ebx
movl -124(%ebp), %edi
cmp %ebx, %edi
jne L25
L28:
jmp L23
L26:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L24:
  .long 1
  .byte 10
L20:
  .long 1
  .byte 10
L18:
  .long 1
  .byte 10
L17:
  .long 1
  .byte 10
L16:
  .long 1
  .byte 10
L15:
  .long 1
  .byte 10
L14:
  .long 7
  .byte 115, 101, 99, 99, 111, 110, 100
L13:
  .long 5
  .byte 102, 105, 114, 115, 116
.globl L0
	.type	L0, @function
L0:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L30:
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
jmp L29
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
L29:
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
L32:
movl $0, %ebx
movl 12(%ebp), %edi
cmp %ebx, %edi
jg L3
L4:
movl $0, %ebx
movl %ebx, %eax
jmp L31
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
L31:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L2:
  .long 1
  .byte 48
