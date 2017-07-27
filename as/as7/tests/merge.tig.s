.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $132, %esp
pushl %ebx
pushl %edi
pushl %esi
L56:
movl %ebp, %ebx
movl $-124, %edi
addl %edi, %ebx
movl %ebx, %ebx
call getch
movl %eax, %edi
movl %edi, (%ebx)
movl %ebp, %ebx
movl $-128, %edi
addl %edi, %ebx
movl %ebx, %ebx
pushl %ebp
call L22
movl %eax, %edi
addl $4, %esp
movl %edi, (%ebx)
movl %ebp, %ebx
movl $-132, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl %ebp, %edi
movl $-124, %esi
addl %esi, %edi
movl %edi, %edi
call getch
movl %eax, %esi
movl %esi, (%edi)
pushl %ebp
call L22
movl %eax, %edi
addl $4, %esp
movl %edi, (%ebx)
movl %ebp, %ebx
movl -132(%ebp), %edi
pushl %edi
movl -128(%ebp), %edi
pushl %edi
pushl %ebp
call L23
movl %eax, %edi
addl $12, %esp
pushl %edi
pushl %ebx
call L25
addl $8, %esp
movl $1, %ebx
movl %ebx, %eax
jmp L55
L55:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
.globl L25
	.type	L25, @function
L25:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L58:
movl $0, %ebx
movl 12(%ebp), %edi
cmp %ebx, %edi
je L52
L53:
movl 8(%ebp), %ebx
movl %ebx, %ebx
movl 12(%ebp), %edi
pushl %edi
call checkNilRecord
addl $4, %esp
movl 12(%ebp), %edi
movl %edi, %edi
movl $0, %esi
movl %esi, %esi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %esi
addl %esi, %edi
movl (%edi), %edi
pushl %edi
pushl %ebx
call L24
addl $8, %esp
leal L51, %ebx
pushl %ebx
call print
addl $4, %esp
movl 8(%ebp), %ebx
movl %ebx, %ebx
movl 12(%ebp), %edi
pushl %edi
call checkNilRecord
addl $4, %esp
movl 12(%ebp), %edi
movl %edi, %edi
movl $1, %esi
movl %esi, %esi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %esi
addl %esi, %edi
movl (%edi), %edi
pushl %edi
pushl %ebx
call L25
movl %eax, %ebx
addl $8, %esp
movl %ebx, %ebx
L54:
movl %ebx, %eax
jmp L57
L52:
leal L50, %ebx
pushl %ebx
call print
movl %eax, %ebx
addl $4, %esp
jmp L54
L57:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L51:
  .long 1
  .byte 32
L50:
  .long 1
  .byte 10
.globl L24
	.type	L24, @function
L24:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L60:
movl $0, %ebx
movl 12(%ebp), %edi
cmp %ebx, %edi
jl L47
L48:
movl $0, %ebx
movl 12(%ebp), %edi
cmp %ebx, %edi
jg L44
L45:
leal L43, %ebx
pushl %ebx
call print
movl %eax, %ebx
addl $4, %esp
L46:
movl %ebx, %ebx
L49:
movl %ebx, %eax
jmp L59
L47:
leal L42, %ebx
pushl %ebx
call print
addl $4, %esp
movl $0, %ebx
movl %ebx, %ebx
movl 12(%ebp), %edi
subl %edi, %ebx
pushl %ebx
pushl %ebp
call L38
movl %eax, %ebx
addl $8, %esp
movl %ebx, %ebx
jmp L49
L44:
movl 12(%ebp), %ebx
pushl %ebx
pushl %ebp
call L38
movl %eax, %ebx
addl $8, %esp
jmp L46
L59:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L43:
  .long 1
  .byte 48
L42:
  .long 1
  .byte 45
.globl L38
	.type	L38, @function
L38:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L62:
movl $0, %ebx
movl 12(%ebp), %edi
cmp %ebx, %edi
jg L40
L41:
movl $0, %ebx
movl %ebx, %eax
jmp L61
L40:
movl $0, %edx
movl 12(%ebp), %ebx
movl %ebx, %eax
movl $10, %ebx
idivl %ebx
pushl %eax
movl 8(%ebp), %ebx
pushl %ebx
call L38
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
leal L39, %edi
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
jmp L41
L61:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L39:
  .long 1
  .byte 48
.globl L23
	.type	L23, @function
L23:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L64:
movl $0, %ebx
movl 12(%ebp), %edi
cmp %ebx, %edi
je L35
L36:
movl $0, %ebx
movl 16(%ebp), %edi
cmp %ebx, %edi
je L32
L33:
movl 12(%ebp), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl 12(%ebp), %ebx
movl %ebx, %ebx
movl $0, %edi
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl (%ebx), %ebx
movl %ebx, %ebx
movl 16(%ebp), %edi
pushl %edi
call checkNilRecord
addl $4, %esp
movl 16(%ebp), %edi
movl %edi, %edi
movl $0, %esi
movl %esi, %esi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %esi
addl %esi, %edi
movl (%edi), %edi
cmp %edi, %ebx
jl L29
L30:
movl $8, %ebx
pushl %ebx
call allocRecord
movl %eax, %ebx
addl $4, %esp
movl %ebx, %edi
movl $0, %esi
addl %esi, %edi
movl %edi, %edi
movl 16(%ebp), %esi
pushl %esi
call checkNilRecord
addl $4, %esp
movl 16(%ebp), %esi
movl %esi, %esi
movl $0, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
movl %ecx, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
movl $4, %ecx
	movl	%ecx, -12(%ebp) # save pseudo-register
	movl	-12(%ebp), %ecx # load pseudo-register
	movl	-8(%ebp), %edx # load pseudo-register
imull %ecx, %edx
	movl	%edx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
addl %ecx, %esi
movl (%esi), %esi
movl %esi, (%edi)
movl %ebx, %edi
movl $4, %esi
addl %esi, %edi
movl %edi, %edi
movl 8(%ebp), %esi
movl %esi, %esi
movl 12(%ebp), %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
movl %ecx, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
movl 16(%ebp), %ecx
	movl	%ecx, -12(%ebp) # save pseudo-register
	movl	-12(%ebp), %ecx # load pseudo-register
pushl %ecx
call checkNilRecord
addl $4, %esp
movl 16(%ebp), %ecx
	movl	%ecx, -12(%ebp) # save pseudo-register
	movl	-12(%ebp), %ecx # load pseudo-register
movl %ecx, %ecx
	movl	%ecx, -12(%ebp) # save pseudo-register
movl $1, %ecx
	movl	%ecx, -16(%ebp) # save pseudo-register
	movl	-16(%ebp), %ecx # load pseudo-register
movl %ecx, %ecx
	movl	%ecx, -16(%ebp) # save pseudo-register
movl $4, %ecx
	movl	%ecx, -20(%ebp) # save pseudo-register
	movl	-20(%ebp), %ecx # load pseudo-register
	movl	-16(%ebp), %edx # load pseudo-register
imull %ecx, %edx
	movl	%edx, -16(%ebp) # save pseudo-register
	movl	-16(%ebp), %ecx # load pseudo-register
	movl	-12(%ebp), %edx # load pseudo-register
addl %ecx, %edx
	movl	%edx, -12(%ebp) # save pseudo-register
	movl	-12(%ebp), %ecx # load pseudo-register
movl (%ecx), %ecx
	movl	%ecx, -12(%ebp) # save pseudo-register
	movl	-12(%ebp), %ecx # load pseudo-register
pushl %ecx
	movl	-8(%ebp), %ecx # load pseudo-register
pushl %ecx
pushl %esi
call L23
movl %eax, %esi
addl $12, %esp
movl %esi, (%edi)
movl %ebx, %ebx
L31:
movl %ebx, %ebx
L34:
movl %ebx, %ebx
L37:
movl %ebx, %eax
jmp L63
L35:
movl 16(%ebp), %ebx
movl %ebx, %ebx
jmp L37
L32:
movl 12(%ebp), %ebx
movl %ebx, %ebx
jmp L34
L29:
movl $8, %ebx
pushl %ebx
call allocRecord
movl %eax, %ebx
addl $4, %esp
movl %ebx, %edi
movl $0, %esi
addl %esi, %edi
movl %edi, %edi
movl 12(%ebp), %esi
pushl %esi
call checkNilRecord
addl $4, %esp
movl 12(%ebp), %esi
movl %esi, %esi
movl $0, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
movl %ecx, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
movl $4, %ecx
	movl	%ecx, -12(%ebp) # save pseudo-register
	movl	-12(%ebp), %ecx # load pseudo-register
	movl	-8(%ebp), %edx # load pseudo-register
imull %ecx, %edx
	movl	%edx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
addl %ecx, %esi
movl (%esi), %esi
movl %esi, (%edi)
movl %ebx, %edi
movl $4, %esi
addl %esi, %edi
movl %edi, %edi
movl 8(%ebp), %esi
movl %esi, %esi
movl 12(%ebp), %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
pushl %ecx
call checkNilRecord
addl $4, %esp
movl 16(%ebp), %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
pushl %ecx
movl 12(%ebp), %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
movl %ecx, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
movl $1, %ecx
	movl	%ecx, -12(%ebp) # save pseudo-register
	movl	-12(%ebp), %ecx # load pseudo-register
movl %ecx, %ecx
	movl	%ecx, -12(%ebp) # save pseudo-register
movl $4, %ecx
	movl	%ecx, -16(%ebp) # save pseudo-register
	movl	-16(%ebp), %ecx # load pseudo-register
	movl	-12(%ebp), %edx # load pseudo-register
imull %ecx, %edx
	movl	%edx, -12(%ebp) # save pseudo-register
	movl	-12(%ebp), %ecx # load pseudo-register
	movl	-8(%ebp), %edx # load pseudo-register
addl %ecx, %edx
	movl	%edx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
movl (%ecx), %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
pushl %ecx
pushl %esi
call L23
movl %eax, %esi
addl $12, %esp
movl %esi, (%edi)
movl %ebx, %ebx
jmp L31
L63:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
.globl L22
	.type	L22, @function
L22:
pushl %ebp
movl %esp, %ebp
subl $128, %esp
pushl %ebx
pushl %edi
pushl %esi
L66:
movl %ebp, %ebx
movl $-124, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl $4, %edi
pushl %edi
call allocRecord
movl %eax, %edi
addl $4, %esp
movl $0, %esi
movl %esi, 0(%edi)
movl %edi, (%ebx)
movl %ebp, %ebx
movl $-128, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
pushl %edi
movl 8(%ebp), %edi
pushl %edi
call L0
movl %eax, %edi
addl $8, %esp
movl %edi, (%ebx)
movl -124(%ebp), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl $0, %ebx
movl -124(%ebp), %edi
movl %edi, %edi
movl $0, %esi
movl %esi, %esi
movl $4, %ecx
	movl	%ecx, -8(%ebp) # save pseudo-register
	movl	-8(%ebp), %ecx # load pseudo-register
imull %ecx, %esi
addl %esi, %edi
movl (%edi), %edi
cmp %ebx, %edi
je L27
L26:
movl $8, %ebx
pushl %ebx
call allocRecord
movl %eax, %ebx
addl $4, %esp
movl -128(%ebp), %edi
movl %edi, 0(%ebx)
movl %ebx, %edi
movl $4, %esi
addl %esi, %edi
movl %edi, %edi
movl 8(%ebp), %esi
pushl %esi
call L22
movl %eax, %esi
addl $4, %esp
movl %esi, (%edi)
movl %ebx, %ebx
L28:
movl %ebx, %eax
jmp L65
L27:
movl $0, %ebx
movl %ebx, %ebx
jmp L28
L65:
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
subl $124, %esp
pushl %ebx
pushl %edi
pushl %esi
L68:
movl $0, %ebx
movl %ebx, -124(%ebp)
pushl %ebp
call L2
addl $4, %esp
movl 12(%ebp), %ebx
pushl %ebx
call checkNilRecord
addl $4, %esp
movl 12(%ebp), %ebx
movl %ebx, %ebx
movl $0, %edi
movl %edi, %edi
movl $4, %esi
imull %esi, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl 8(%ebp), %edi
movl -124(%edi), %edi
pushl %edi
pushl %ebp
call L1
movl %eax, %edi
addl $8, %esp
movl %edi, (%ebx)
movl 8(%ebp), %ebx
movl -124(%ebx), %ebx
pushl %ebx
pushl %ebp
call L1
movl %eax, %ebx
addl $8, %esp
movl $0, %edi
cmp %edi, %ebx
je L19
L21:
movl %ebp, %ebx
movl $-124, %edi
addl %edi, %ebx
movl %ebx, %ebx
movl -124(%ebp), %edi
movl %edi, %edi
movl $10, %esi
imull %esi, %edi
movl %edi, %edi
movl 8(%ebp), %esi
movl -124(%esi), %esi
pushl %esi
call ord
movl %eax, %esi
addl $4, %esp
movl %edi, %edi
addl %esi, %edi
movl %edi, %edi
leal L20, %esi
pushl %esi
call ord
movl %eax, %esi
addl $4, %esp
movl %edi, %edi
subl %esi, %edi
movl %edi, (%ebx)
movl 8(%ebp), %ebx
movl %ebx, %ebx
movl $-124, %edi
addl %edi, %ebx
movl %ebx, %ebx
call getch
movl %eax, %edi
movl %edi, (%ebx)
movl 8(%ebp), %ebx
movl -124(%ebx), %ebx
pushl %ebx
pushl %ebp
call L1
movl %eax, %ebx
addl $8, %esp
movl $0, %edi
cmp %edi, %ebx
jne L21
L19:
movl -124(%ebp), %ebx
movl %ebx, %eax
jmp L67
L67:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L20:
  .long 1
  .byte 48
.globl L2
	.type	L2, @function
L2:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L70:
leal L10, %ebx
pushl %ebx
movl 8(%ebp), %ebx
movl 8(%ebx), %ebx
movl -124(%ebx), %ebx
pushl %ebx
call stringEqual
movl %eax, %ebx
addl $8, %esp
movl $0, %edi
cmp %edi, %ebx
je L13
L12:
movl $1, %ebx
movl %ebx, %ebx
L14:
movl $0, %edi
cmp %edi, %ebx
je L17
L18:
movl 8(%ebp), %ebx
movl 8(%ebx), %ebx
movl %ebx, %ebx
movl $-124, %edi
addl %edi, %ebx
movl %ebx, %ebx
call getch
movl %eax, %edi
movl %edi, (%ebx)
leal L10, %ebx
pushl %ebx
movl 8(%ebp), %ebx
movl 8(%ebx), %ebx
movl -124(%ebx), %ebx
pushl %ebx
call stringEqual
movl %eax, %ebx
addl $8, %esp
movl $0, %edi
cmp %edi, %ebx
jne L12
L13:
movl $1, %ebx
movl %ebx, %ebx
leal L11, %edi
pushl %edi
movl 8(%ebp), %edi
movl 8(%edi), %edi
movl -124(%edi), %edi
pushl %edi
call stringEqual
movl %eax, %edi
addl $8, %esp
movl $0, %esi
cmp %esi, %edi
je L16
L15:
movl %ebx, %ebx
jmp L14
L16:
movl $0, %ebx
movl %ebx, %ebx
jmp L15
L17:
movl $0, %ebx
movl %ebx, %eax
jmp L69
L69:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L11:
  .long 1
  .byte 10
L10:
  .long 1
  .byte 32
.globl L1
	.type	L1, @function
L1:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L72:
movl 8(%ebp), %ebx
movl 8(%ebx), %ebx
movl -124(%ebx), %ebx
pushl %ebx
call ord
movl %eax, %ebx
addl $4, %esp
movl %ebx, %ebx
leal L3, %edi
pushl %edi
call ord
movl %eax, %edi
addl $4, %esp
cmp %edi, %ebx
jge L5
L6:
movl $0, %ebx
movl %ebx, %ebx
L7:
movl %ebx, %eax
jmp L71
L5:
movl $1, %ebx
movl %ebx, %ebx
movl 8(%ebp), %edi
movl 8(%edi), %edi
movl -124(%edi), %edi
pushl %edi
call ord
movl %eax, %edi
addl $4, %esp
movl %edi, %edi
leal L4, %esi
pushl %esi
call ord
movl %eax, %esi
addl $4, %esp
cmp %esi, %edi
jle L8
L9:
movl $0, %ebx
movl %ebx, %ebx
L8:
movl %ebx, %ebx
jmp L7
L71:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L4:
  .long 1
  .byte 57
L3:
  .long 1
  .byte 48
