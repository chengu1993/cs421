.globl	tigermain					# make linkable
	.type	tigermain, @function					# identify it as a function (for linking)
tigermain:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$180, %esp					# make room for 40 pseudoregs, 0 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L5:
	movl	%ebp, 0(%esp)					# argument 0 for L0 from src:t101,
	movl	$10, 4(%esp)					# argument 1 for L0 from src:
	call	L0					# call function L0, putting result in EAX
	movl	%eax, %ebx					# move result of L0 to desired register:t107
	movl	%ebx, %eax					# run MOVE statement with src:t107, dst:t100,
	jmp	L4					# unconditional jump
L4:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function tigermain
.globl	L0					# make linkable
	.type	L0, @function					# identify it as a function (for linking)
L0:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$180, %esp					# make room for 40 pseudoregs, 0 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L7:
	cmpl	$0, 12(%ebp)					# compare before conditional jump with src1: src2:t101,
	je	L1
L2:
	movl	12(%ebp), %esi					# run MOVE statement with src:t101, dst:t109,
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t110
	movl	%ebx, 0(%esp)					# argument 0 for L0 from src:t110,
	movl	12(%ebp), %ebx					# run MOVE statement with src:t101, dst:t111,
	subl	$1, %ebx					# evaluate MINUS expression src: dst:t111
	movl	%ebx, 4(%esp)					# argument 1 for L0 from src:t111,
	call	L0					# call function L0, putting result in EAX
	movl	%eax, %ebx					# move result of L0 to desired register:t112
	movl	%ebx, %ebx					# run MOVE statement with src:t112, dst:t108,
	movl	%esi, %esi					# run MOVE statement with src:t109, dst:t113,
	imull	%ebx, %esi					# evaluate MUL expression src:t108, dst:t113
	movl	%esi, %ebx					# run MOVE statement with src:t113, dst:t106,
L3:
	movl	%ebx, %eax					# run MOVE statement with src:t106, dst:t100,
	jmp	L6					# unconditional jump
L1:
	movl	$1, %ebx					# run MOVE statement with src: dst:t106,
	jmp	L3					# unconditional jump
L6:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function L0
