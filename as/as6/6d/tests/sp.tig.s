.globl	tigermain					# make linkable
	.type	tigermain, @function					# identify it as a function (for linking)
tigermain:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$180, %esp					# make room for 40 pseudoregs, 0 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L1:
	movl	$1, %ebx					# run MOVE statement with src: dst:t106,
	movl	$2, %esi					# run MOVE statement with src: dst:t107,
	movl	$3, %edi					# run MOVE statement with src: dst:t108,
	movl	$4, %ecx					# run MOVE statement with src: dst:t109,
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	$5, %ecx					# run MOVE statement with src: dst:t110,
	movl	%ecx, -8(%ebp)					# save pseudo-register f1
	movl	$6, %ecx					# run MOVE statement with src: dst:t111,
	movl	%ecx, -12(%ebp)					# save pseudo-register f2
	movl	$7, %ecx					# run MOVE statement with src: dst:t112,
	movl	%ecx, -16(%ebp)					# save pseudo-register f3
	movl	$8, %ecx					# run MOVE statement with src: dst:t113,
	movl	%ecx, -20(%ebp)					# save pseudo-register f4
	movl	$9, %ecx					# run MOVE statement with src: dst:t114,
	movl	%ecx, -24(%ebp)					# save pseudo-register f5
	movl	$10, %ecx					# run MOVE statement with src: dst:t115,
	movl	%ecx, -28(%ebp)					# save pseudo-register f6
	movl	$11, %ecx					# run MOVE statement with src: dst:t116,
	movl	%ecx, -32(%ebp)					# save pseudo-register f7
	movl	$12, %ecx					# run MOVE statement with src: dst:t117,
	movl	%ecx, -36(%ebp)					# save pseudo-register f8
	movl	$13, %ecx					# run MOVE statement with src: dst:t118,
	movl	%ecx, -40(%ebp)					# save pseudo-register f9
	movl	$14, %ecx					# run MOVE statement with src: dst:t119,
	movl	%ecx, -44(%ebp)					# save pseudo-register f10
	movl	$15, %ecx					# run MOVE statement with src: dst:t120,
	movl	%ecx, -48(%ebp)					# save pseudo-register f11
	movl	-48(%ebp), %ecx					# load pseudoreg `f11' to machine reg `%ecx'
	addl	$16, %ecx					# evaluate PLUS expression src: dst:t120
	movl	%ecx, -48(%ebp)					# save pseudo-register f11
	movl	-44(%ebp), %ecx					# load pseudoreg `f10' to machine reg `%ecx'
	movl	-48(%ebp), %edx					# load pseudoreg `f11' to machine reg `%edx'
	addl	%edx, %ecx					# evaluate PLUS expression src:t120, dst:t119
	movl	%ecx, -44(%ebp)					# save pseudo-register f10
	movl	-40(%ebp), %ecx					# load pseudoreg `f9' to machine reg `%ecx'
	movl	-44(%ebp), %edx					# load pseudoreg `f10' to machine reg `%edx'
	addl	%edx, %ecx					# evaluate PLUS expression src:t119, dst:t118
	movl	%ecx, -40(%ebp)					# save pseudo-register f9
	movl	-36(%ebp), %ecx					# load pseudoreg `f8' to machine reg `%ecx'
	movl	-40(%ebp), %edx					# load pseudoreg `f9' to machine reg `%edx'
	addl	%edx, %ecx					# evaluate PLUS expression src:t118, dst:t117
	movl	%ecx, -36(%ebp)					# save pseudo-register f8
	movl	-32(%ebp), %ecx					# load pseudoreg `f7' to machine reg `%ecx'
	movl	-36(%ebp), %edx					# load pseudoreg `f8' to machine reg `%edx'
	addl	%edx, %ecx					# evaluate PLUS expression src:t117, dst:t116
	movl	%ecx, -32(%ebp)					# save pseudo-register f7
	movl	-28(%ebp), %ecx					# load pseudoreg `f6' to machine reg `%ecx'
	movl	-32(%ebp), %edx					# load pseudoreg `f7' to machine reg `%edx'
	addl	%edx, %ecx					# evaluate PLUS expression src:t116, dst:t115
	movl	%ecx, -28(%ebp)					# save pseudo-register f6
	movl	-24(%ebp), %ecx					# load pseudoreg `f5' to machine reg `%ecx'
	movl	-28(%ebp), %edx					# load pseudoreg `f6' to machine reg `%edx'
	addl	%edx, %ecx					# evaluate PLUS expression src:t115, dst:t114
	movl	%ecx, -24(%ebp)					# save pseudo-register f5
	movl	-20(%ebp), %ecx					# load pseudoreg `f4' to machine reg `%ecx'
	movl	-24(%ebp), %edx					# load pseudoreg `f5' to machine reg `%edx'
	addl	%edx, %ecx					# evaluate PLUS expression src:t114, dst:t113
	movl	%ecx, -20(%ebp)					# save pseudo-register f4
	movl	-16(%ebp), %ecx					# load pseudoreg `f3' to machine reg `%ecx'
	movl	-20(%ebp), %edx					# load pseudoreg `f4' to machine reg `%edx'
	addl	%edx, %ecx					# evaluate PLUS expression src:t113, dst:t112
	movl	%ecx, -16(%ebp)					# save pseudo-register f3
	movl	-12(%ebp), %ecx					# load pseudoreg `f2' to machine reg `%ecx'
	movl	-16(%ebp), %edx					# load pseudoreg `f3' to machine reg `%edx'
	addl	%edx, %ecx					# evaluate PLUS expression src:t112, dst:t111
	movl	%ecx, -12(%ebp)					# save pseudo-register f2
	movl	-8(%ebp), %ecx					# load pseudoreg `f1' to machine reg `%ecx'
	movl	-12(%ebp), %edx					# load pseudoreg `f2' to machine reg `%edx'
	addl	%edx, %ecx					# evaluate PLUS expression src:t111, dst:t110
	movl	%ecx, -8(%ebp)					# save pseudo-register f1
	movl	-4(%ebp), %ecx					# load pseudoreg `f0' to machine reg `%ecx'
	movl	-8(%ebp), %edx					# load pseudoreg `f1' to machine reg `%edx'
	addl	%edx, %ecx					# evaluate PLUS expression src:t110, dst:t109
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	-4(%ebp), %edx					# load pseudoreg `f0' to machine reg `%edx'
	addl	%edx, %edi					# evaluate PLUS expression src:t109, dst:t108
	addl	%edi, %esi					# evaluate PLUS expression src:t108, dst:t107
	addl	%esi, %ebx					# evaluate PLUS expression src:t107, dst:t106
	movl	$1, %eax					# run MOVE statement with src: dst:t100,
	jmp	L0					# unconditional jump
L0:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function tigermain
