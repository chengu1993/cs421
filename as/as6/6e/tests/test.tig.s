.globl	tigermain					# make linkable
	.type	tigermain, @function					# identify it as a function (for linking)
tigermain:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$180, %esp					# make room for 40 pseudoregs, 0 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L2:
	movl	$L0, 0(%esp)					# argument 0 for print from src:
	call	print					# call function print, putting result in EAX
	movl	%eax, %ebx					# move result of print to desired register:t106
	movl	%ebx, %eax					# run MOVE statement with src:t106, dst:t100,
	jmp	L1					# unconditional jump
L1:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function tigermain
L0:					# string literal: "Hello World!\n"
	.long 13					# string's length
	.byte 72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33, 10					# string's bytes
