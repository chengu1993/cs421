.globl tigermain
	.type	tigermain, @function
tigermain:
pushl %ebp
movl %esp, %ebp
subl $124, %esp
pushl %ebx
pushl %edi
pushl %esi
L15:
leal L0, %ebx
movl %ebx, -124(%ebp)
leal L13, %ebx
pushl %ebx
pushl %ebp
call L1
movl %eax, %ebx
addl $8, %esp
movl %ebx, %eax
jmp L14
L14:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L13:
  .long 13
  .byte 111, 117, 116, 101, 114, 32, 115, 116, 114, 105, 110, 103, 10
.globl L2
	.type	L2, @function
L2:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L17:
movl 12(%ebp), %ebx
pushl %ebx
call print
movl %eax, %eax
addl $4, %esp
jmp L16
L16:
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
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L19:
leal L3, %ebx
pushl %ebx
call print
addl $4, %esp
leal L11, %ebx
pushl %ebx
pushl %ebp
call L4
addl $8, %esp
pushl %ebp
call L5
movl %eax, %ebx
addl $4, %esp
leal L12, %ebx
pushl %ebx
call print
movl %eax, %ebx
addl $4, %esp
movl %ebx, %eax
jmp L18
L18:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L12:
  .long 23
  .byte 69, 120, 105, 116, 105, 110, 103, 32, 111, 117, 116, 101, 114, 95, 102, 117, 110, 99, 116, 105, 111, 110, 10
L11:
  .long 13
  .byte 105, 110, 110, 101, 114, 32, 115, 116, 114, 105, 110, 103, 10
.globl L5
	.type	L5, @function
L5:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L21:
leal L8, %ebx
pushl %ebx
call print
addl $4, %esp
leal L9, %ebx
pushl %ebx
movl 8(%ebp), %ebx
pushl %ebx
call L4
addl $8, %esp
movl 8(%ebp), %ebx
movl 12(%ebx), %ebx
pushl %ebx
movl 8(%ebp), %ebx
pushl %ebx
call L4
addl $8, %esp
leal L10, %ebx
pushl %ebx
call print
movl %eax, %ebx
addl $4, %esp
movl %ebx, %eax
jmp L20
L20:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L10:
  .long 28
  .byte 69, 120, 105, 116, 105, 110, 103, 32, 99, 97, 108, 108, 95, 105, 110, 110, 101, 114, 95, 102, 117, 110, 99, 116, 105, 111, 110, 10
L9:
  .long 11
  .byte 99, 97, 108, 108, 105, 110, 103, 32, 105, 110, 10
L8:
  .long 29
  .byte 69, 110, 116, 101, 114, 105, 110, 103, 32, 99, 97, 108, 108, 95, 105, 110, 110, 101, 114, 95, 102, 117, 110, 99, 116, 105, 111, 110, 10
.globl L4
	.type	L4, @function
L4:
pushl %ebp
movl %esp, %ebp
subl $120, %esp
pushl %ebx
pushl %edi
pushl %esi
L23:
leal L6, %ebx
pushl %ebx
call print
addl $4, %esp
movl 8(%ebp), %ebx
movl 12(%ebx), %ebx
pushl %ebx
call print
addl $4, %esp
movl 12(%ebp), %ebx
pushl %ebx
call print
addl $4, %esp
movl 8(%ebp), %ebx
movl 8(%ebx), %ebx
movl -124(%ebx), %ebx
pushl %ebx
call print
addl $4, %esp
leal L7, %ebx
pushl %ebx
call print
movl %eax, %ebx
addl $4, %esp
movl %ebx, %eax
jmp L22
L22:
popl %esi
popl %edi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
L7:
  .long 23
  .byte 69, 120, 105, 116, 105, 110, 103, 32, 105, 110, 110, 101, 114, 95, 102, 117, 110, 99, 116, 105, 111, 110, 10
L6:
  .long 24
  .byte 69, 110, 116, 101, 114, 105, 110, 103, 32, 105, 110, 110, 101, 114, 95, 102, 117, 110, 99, 116, 105, 111, 110, 10
L3:
  .long 24
  .byte 69, 110, 116, 101, 114, 105, 110, 103, 32, 111, 117, 116, 101, 114, 95, 102, 117, 110, 99, 116, 105, 111, 110, 10
L0:
  .long 9
  .byte 105, 116, 32, 119, 111, 114, 107, 115, 10
