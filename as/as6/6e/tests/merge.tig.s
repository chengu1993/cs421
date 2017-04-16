.globl	tigermain					# make linkable
	.type	tigermain, @function					# identify it as a function (for linking)
tigermain:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$192, %esp					# make room for 40 pseudoregs, 3 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L56:
	movl	%ebp, %ebx					# run MOVE statement with src:t101, dst:t131,
	addl	$-164, %ebx					# evaluate PLUS expression src: dst:t131
	movl	%ebx, %esi					# run MOVE statement with src:t131, dst:t122,
	call	getch					# call function getch, putting result in EAX
	movl	%eax, %ebx					# move result of getch to desired register:t132
	movl	%ebx, %ebx					# run MOVE statement with src:t132, dst:t121,
	movl	%ebx, (%esi)					# run MOVE statement with src:t121,t122, dst:
	movl	%ebp, %ebx					# run MOVE statement with src:t101, dst:t133,
	addl	$-168, %ebx					# evaluate PLUS expression src: dst:t133
	movl	%ebx, %esi					# run MOVE statement with src:t133, dst:t124,
	movl	%ebp, 0(%esp)					# argument 0 for L22 from src:t101,
	call	L22					# call function L22, putting result in EAX
	movl	%eax, %ebx					# move result of L22 to desired register:t134
	movl	%ebx, %ebx					# run MOVE statement with src:t134, dst:t123,
	movl	%ebx, (%esi)					# run MOVE statement with src:t123,t124, dst:
	movl	%ebp, %ebx					# run MOVE statement with src:t101, dst:t135,
	addl	$-172, %ebx					# evaluate PLUS expression src: dst:t135
	movl	%ebx, %esi					# run MOVE statement with src:t135, dst:t128,
	movl	%ebp, %ebx					# run MOVE statement with src:t101, dst:t136,
	addl	$-164, %ebx					# evaluate PLUS expression src: dst:t136
	movl	%ebx, %edi					# run MOVE statement with src:t136, dst:t126,
	call	getch					# call function getch, putting result in EAX
	movl	%eax, %ebx					# move result of getch to desired register:t137
	movl	%ebx, %ebx					# run MOVE statement with src:t137, dst:t125,
	movl	%ebx, (%edi)					# run MOVE statement with src:t125,t126, dst:
	movl	%ebp, 0(%esp)					# argument 0 for L22 from src:t101,
	call	L22					# call function L22, putting result in EAX
	movl	%eax, %ebx					# move result of L22 to desired register:t138
	movl	%ebx, %ebx					# run MOVE statement with src:t138, dst:t127,
	movl	%ebx, (%esi)					# run MOVE statement with src:t127,t128, dst:
	movl	%ebp, %esi					# run MOVE statement with src:t101, dst:t130,
	movl	%ebp, 0(%esp)					# argument 0 for L23 from src:t101,
	movl	-168(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t139
	movl	%ebx, 4(%esp)					# argument 1 for L23 from src:t139,
	movl	-172(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t140
	movl	%ebx, 8(%esp)					# argument 2 for L23 from src:t140,
	call	L23					# call function L23, putting result in EAX
	movl	%eax, %ebx					# move result of L23 to desired register:t141
	movl	%ebx, %ebx					# run MOVE statement with src:t141, dst:t129,
	movl	%esi, 0(%esp)					# argument 0 for L25 from src:t130,
	movl	%ebx, 4(%esp)					# argument 1 for L25 from src:t129,
	call	L25					# call function L25, putting result in EAX
	movl	%eax, %ebx					# move result of L25 to desired register:t142
	movl	$1, %eax					# run MOVE statement with src: dst:t100,
	jmp	L55					# unconditional jump
L55:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function tigermain
.globl	L25					# make linkable
	.type	L25, @function					# identify it as a function (for linking)
L25:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$180, %esp					# make room for 40 pseudoregs, 0 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L58:
	cmpl	$0, 12(%ebp)					# compare before conditional jump with src1: src2:t101,
	je	L52
L53:
	movl	8(%ebp), %ebx					# run MOVE statement with src:t101, dst:t143,
	movl	12(%ebp), %esi					# evaluate MEM expression src:t101, dst:t146
	movl	%esi, 0(%esp)					# argument 0 for checkNilRecord from src:t146,
	call	checkNilRecord					# call function checkNilRecord, putting result in EAX
	movl	%eax, %esi					# move result of checkNilRecord to desired register:t147
	movl	%ebx, 0(%esp)					# argument 0 for L24 from src:t143,
	movl	12(%ebp), %ebx					# run MOVE statement with src:t101, dst:t148,
	movl	$0, %esi					# run MOVE statement with src: dst:t149,
	imull	$4, %esi					# evaluate MUL expression src: dst:t149
	addl	%esi, %ebx					# evaluate PLUS expression src:t149, dst:t148
	movl	(%ebx), %ebx					# evaluate MEM expression src:t148, dst:t150
	movl	%ebx, 4(%esp)					# argument 1 for L24 from src:t150,
	call	L24					# call function L24, putting result in EAX
	movl	%eax, %ebx					# move result of L24 to desired register:t151
	movl	$L51, 0(%esp)					# argument 0 for print from src:
	call	print					# call function print, putting result in EAX
	movl	%eax, %ebx					# move result of print to desired register:t152
	movl	8(%ebp), %ebx					# run MOVE statement with src:t101, dst:t145,
	movl	12(%ebp), %esi					# evaluate MEM expression src:t101, dst:t153
	movl	%esi, 0(%esp)					# argument 0 for checkNilRecord from src:t153,
	call	checkNilRecord					# call function checkNilRecord, putting result in EAX
	movl	%eax, %esi					# move result of checkNilRecord to desired register:t154
	movl	%ebx, 0(%esp)					# argument 0 for L25 from src:t145,
	movl	12(%ebp), %ebx					# run MOVE statement with src:t101, dst:t155,
	movl	$1, %esi					# run MOVE statement with src: dst:t156,
	imull	$4, %esi					# evaluate MUL expression src: dst:t156
	addl	%esi, %ebx					# evaluate PLUS expression src:t156, dst:t155
	movl	(%ebx), %ebx					# evaluate MEM expression src:t155, dst:t157
	movl	%ebx, 4(%esp)					# argument 1 for L25 from src:t157,
	call	L25					# call function L25, putting result in EAX
	movl	%eax, %ebx					# move result of L25 to desired register:t158
	movl	%ebx, %ebx					# run MOVE statement with src:t158, dst:t144,
	movl	%ebx, %ebx					# run MOVE statement with src:t144, dst:t120,
L54:
	movl	%ebx, %eax					# run MOVE statement with src:t120, dst:t100,
	jmp	L57					# unconditional jump
L52:
	movl	$L50, 0(%esp)					# argument 0 for print from src:
	call	print					# call function print, putting result in EAX
	movl	%eax, %ebx					# move result of print to desired register:t159
	movl	%ebx, %ebx					# run MOVE statement with src:t159, dst:t120,
	jmp	L54					# unconditional jump
L57:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function L25
L51:					# string literal: " "
	.long 1					# string's length
	.byte 32					# string's bytes
L50:					# string literal: "\n"
	.long 1					# string's length
	.byte 10					# string's bytes
.globl	L24					# make linkable
	.type	L24, @function					# identify it as a function (for linking)
L24:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$180, %esp					# make room for 40 pseudoregs, 0 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L60:
	cmpl	$0, 12(%ebp)					# compare before conditional jump with src1: src2:t101,
	jl	L47
L48:
	cmpl	$0, 12(%ebp)					# compare before conditional jump with src1: src2:t101,
	jg	L44
L45:
	movl	$L43, 0(%esp)					# argument 0 for print from src:
	call	print					# call function print, putting result in EAX
	movl	%eax, %ebx					# move result of print to desired register:t161
	movl	%ebx, %ebx					# run MOVE statement with src:t161, dst:t118,
L46:
	movl	%ebx, %ebx					# run MOVE statement with src:t118, dst:t119,
L49:
	movl	%ebx, %eax					# run MOVE statement with src:t119, dst:t100,
	jmp	L59					# unconditional jump
L47:
	movl	$L42, 0(%esp)					# argument 0 for print from src:
	call	print					# call function print, putting result in EAX
	movl	%eax, %ebx					# move result of print to desired register:t162
	movl	%ebp, 0(%esp)					# argument 0 for L38 from src:t101,
	movl	$0, %ebx					# run MOVE statement with src: dst:t163,
	subl	12(%ebp), %ebx					# evaluate MINUS expression src:t101, dst:t163
	movl	%ebx, 4(%esp)					# argument 1 for L38 from src:t163,
	call	L38					# call function L38, putting result in EAX
	movl	%eax, %ebx					# move result of L38 to desired register:t164
	movl	%ebx, %ebx					# run MOVE statement with src:t164, dst:t160,
	movl	%ebx, %ebx					# run MOVE statement with src:t160, dst:t119,
	jmp	L49					# unconditional jump
L44:
	movl	%ebp, 0(%esp)					# argument 0 for L38 from src:t101,
	movl	12(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t165
	movl	%ebx, 4(%esp)					# argument 1 for L38 from src:t165,
	call	L38					# call function L38, putting result in EAX
	movl	%eax, %ebx					# move result of L38 to desired register:t166
	movl	%ebx, %ebx					# run MOVE statement with src:t166, dst:t118,
	jmp	L46					# unconditional jump
L59:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function L24
L43:					# string literal: "0"
	.long 1					# string's length
	.byte 48					# string's bytes
L42:					# string literal: "-"
	.long 1					# string's length
	.byte 45					# string's bytes
.globl	L38					# make linkable
	.type	L38, @function					# identify it as a function (for linking)
L38:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$180, %esp					# make room for 40 pseudoregs, 0 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L62:
	cmpl	$0, 12(%ebp)					# compare before conditional jump with src1: src2:t101,
	jg	L40
L41:
	movl	$0, %eax					# run MOVE statement with src: dst:t100,
	jmp	L61					# unconditional jump
L40:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t171
	movl	%ebx, 0(%esp)					# argument 0 for L38 from src:t171,
	movl	$10, %ebx					# evaluate CONST expression to t173
	movl	12(%ebp), %eax					# prepare dividend src:t101,
	movl	$0, %edx					# prepare higher order bits of dividend
	idivl	%ebx					# divide this from EAX, result->EAX, remainder->EDX; src:t173,
	movl	%eax, %ebx					# move result from EAX to new register:t172
	movl	%ebx, 4(%esp)					# argument 1 for L38 from src:t172,
	call	L38					# call function L38, putting result in EAX
	movl	%eax, %ebx					# move result of L38 to desired register:t174
	movl	12(%ebp), %ebx					# run MOVE statement with src:t101, dst:t175,
	movl	$10, %esi					# evaluate CONST expression to t178
	movl	12(%ebp), %eax					# prepare dividend src:t101,
	movl	$0, %edx					# prepare higher order bits of dividend
	idivl	%esi					# divide this from EAX, result->EAX, remainder->EDX; src:t178,
	movl	%eax, %esi					# move result from EAX to new register:t177
	movl	%esi, %esi					# run MOVE statement with src:t177, dst:t176,
	imull	$10, %esi					# evaluate MUL expression src: dst:t176
	subl	%esi, %ebx					# evaluate MINUS expression src:t176, dst:t175
	movl	%ebx, %ebx					# run MOVE statement with src:t175, dst:t170,
	movl	$L39, 0(%esp)					# argument 0 for ord from src:
	call	ord					# call function ord, putting result in EAX
	movl	%eax, %esi					# move result of ord to desired register:t179
	movl	%esi, %esi					# run MOVE statement with src:t179, dst:t169,
	movl	%ebx, %ebx					# run MOVE statement with src:t170, dst:t180,
	addl	%esi, %ebx					# evaluate PLUS expression src:t169, dst:t180
	movl	%ebx, 0(%esp)					# argument 0 for chr from src:t180,
	call	chr					# call function chr, putting result in EAX
	movl	%eax, %ebx					# move result of chr to desired register:t181
	movl	%ebx, %ebx					# run MOVE statement with src:t181, dst:t168,
	movl	%ebx, 0(%esp)					# argument 0 for print from src:t168,
	call	print					# call function print, putting result in EAX
	movl	%eax, %ebx					# move result of print to desired register:t182
	movl	%ebx, %ebx					# run MOVE statement with src:t182, dst:t167,
	jmp	L41					# unconditional jump
L61:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function L38
L39:					# string literal: "0"
	.long 1					# string's length
	.byte 48					# string's bytes
.globl	L23					# make linkable
	.type	L23, @function					# identify it as a function (for linking)
L23:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$184, %esp					# make room for 40 pseudoregs, 0 locals, 3 callee-saves, and 3 maxargs,
	movl	%ebx, 12(%esp)					# callee-save register
	movl	%esi, 16(%esp)					# callee-save register
	movl	%edi, 20(%esp)					# callee-save register
L64:
	cmpl	$0, 12(%ebp)					# compare before conditional jump with src1: src2:t101,
	je	L35
L36:
	cmpl	$0, 16(%ebp)					# compare before conditional jump with src1: src2:t101,
	je	L32
L33:
	movl	12(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t193
	movl	%ebx, 0(%esp)					# argument 0 for checkNilRecord from src:t193,
	call	checkNilRecord					# call function checkNilRecord, putting result in EAX
	movl	%eax, %ebx					# move result of checkNilRecord to desired register:t194
	movl	12(%ebp), %ebx					# run MOVE statement with src:t101, dst:t195,
	movl	$0, %esi					# run MOVE statement with src: dst:t196,
	imull	$4, %esi					# evaluate MUL expression src: dst:t196
	addl	%esi, %ebx					# evaluate PLUS expression src:t196, dst:t195
	movl	(%ebx), %ebx					# run MOVE statement with src:t195, dst:t183,
	movl	16(%ebp), %esi					# evaluate MEM expression src:t101, dst:t197
	movl	%esi, 0(%esp)					# argument 0 for checkNilRecord from src:t197,
	call	checkNilRecord					# call function checkNilRecord, putting result in EAX
	movl	%eax, %esi					# move result of checkNilRecord to desired register:t198
	movl	16(%ebp), %esi					# run MOVE statement with src:t101, dst:t199,
	movl	$0, %edi					# run MOVE statement with src: dst:t200,
	imull	$4, %edi					# evaluate MUL expression src: dst:t200
	addl	%edi, %esi					# evaluate PLUS expression src:t200, dst:t199
	cmpl	(%esi), %ebx					# compare before conditional jump with src1:t199, src2:t183,
	jl	L29
L30:
	movl	$8, 0(%esp)					# argument 0 for allocRecord from src:
	call	allocRecord					# call function allocRecord, putting result in EAX
	movl	%eax, %ebx					# move result of allocRecord to desired register:t201
	movl	%ebx, %ebx					# run MOVE statement with src:t201, dst:t114,
	movl	%ebx, %esi					# run MOVE statement with src:t114, dst:t202,
	addl	$0, %esi					# evaluate PLUS expression src: dst:t202
	movl	%esi, %edi					# run MOVE statement with src:t202, dst:t188,
	movl	16(%ebp), %esi					# evaluate MEM expression src:t101, dst:t203
	movl	%esi, 0(%esp)					# argument 0 for checkNilRecord from src:t203,
	call	checkNilRecord					# call function checkNilRecord, putting result in EAX
	movl	%eax, %esi					# move result of checkNilRecord to desired register:t204
	movl	16(%ebp), %esi					# run MOVE statement with src:t101, dst:t205,
	movl	$0, %ecx					# run MOVE statement with src: dst:t206,
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	-4(%ebp), %ecx					# load pseudoreg `f0' to machine reg `%ecx'
	imull	$4, %ecx					# evaluate MUL expression src: dst:t206
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	-4(%ebp), %edx					# load pseudoreg `f0' to machine reg `%edx'
	addl	%edx, %esi					# evaluate PLUS expression src:t206, dst:t205
	movl	(%esi), %esi					# evaluate MEM expression src:t205, dst:t207
	movl	%esi, (%edi)					# run MOVE statement with src:t207,t188, dst:
	movl	%ebx, %esi					# run MOVE statement with src:t114, dst:t208,
	addl	$4, %esi					# evaluate PLUS expression src: dst:t208
	movl	%esi, %edi					# run MOVE statement with src:t208, dst:t192,
	movl	8(%ebp), %ecx					# run MOVE statement with src:t101, dst:t191,
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	12(%ebp), %esi					# run MOVE statement with src:t101, dst:t190,
	movl	16(%ebp), %ecx					# evaluate MEM expression src:t101, dst:t209
	movl	%ecx, -8(%ebp)					# save pseudo-register f1
	movl	-8(%ebp), %edx					# load pseudoreg `f1' to machine reg `%edx'
	movl	%edx, 0(%esp)					# argument 0 for checkNilRecord from src:t209,
	call	checkNilRecord					# call function checkNilRecord, putting result in EAX
	movl	%eax, %ecx					# move result of checkNilRecord to desired register:t210
	movl	%ecx, -8(%ebp)					# save pseudo-register f1
	movl	-4(%ebp), %edx					# load pseudoreg `f0' to machine reg `%edx'
	movl	%edx, 0(%esp)					# argument 0 for L23 from src:t191,
	movl	%esi, 4(%esp)					# argument 1 for L23 from src:t190,
	movl	16(%ebp), %esi					# run MOVE statement with src:t101, dst:t211,
	movl	$1, %ecx					# run MOVE statement with src: dst:t212,
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	-4(%ebp), %ecx					# load pseudoreg `f0' to machine reg `%ecx'
	imull	$4, %ecx					# evaluate MUL expression src: dst:t212
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	-4(%ebp), %edx					# load pseudoreg `f0' to machine reg `%edx'
	addl	%edx, %esi					# evaluate PLUS expression src:t212, dst:t211
	movl	(%esi), %esi					# evaluate MEM expression src:t211, dst:t213
	movl	%esi, 8(%esp)					# argument 2 for L23 from src:t213,
	call	L23					# call function L23, putting result in EAX
	movl	%eax, %esi					# move result of L23 to desired register:t214
	movl	%esi, %esi					# run MOVE statement with src:t214, dst:t189,
	movl	%esi, (%edi)					# run MOVE statement with src:t189,t192, dst:
	movl	%ebx, %ebx					# run MOVE statement with src:t114, dst:t115,
L31:
	movl	%ebx, %ebx					# run MOVE statement with src:t115, dst:t116,
L34:
	movl	%ebx, %ebx					# run MOVE statement with src:t116, dst:t117,
L37:
	movl	%ebx, %eax					# run MOVE statement with src:t117, dst:t100,
	jmp	L63					# unconditional jump
L35:
	movl	16(%ebp), %ebx					# run MOVE statement with src:t101, dst:t117,
	jmp	L37					# unconditional jump
L32:
	movl	12(%ebp), %ebx					# run MOVE statement with src:t101, dst:t116,
	jmp	L34					# unconditional jump
L29:
	movl	$8, 0(%esp)					# argument 0 for allocRecord from src:
	call	allocRecord					# call function allocRecord, putting result in EAX
	movl	%eax, %ebx					# move result of allocRecord to desired register:t215
	movl	%ebx, %ebx					# run MOVE statement with src:t215, dst:t113,
	movl	%ebx, %esi					# run MOVE statement with src:t113, dst:t216,
	addl	$0, %esi					# evaluate PLUS expression src: dst:t216
	movl	%esi, %edi					# run MOVE statement with src:t216, dst:t184,
	movl	12(%ebp), %esi					# evaluate MEM expression src:t101, dst:t217
	movl	%esi, 0(%esp)					# argument 0 for checkNilRecord from src:t217,
	call	checkNilRecord					# call function checkNilRecord, putting result in EAX
	movl	%eax, %esi					# move result of checkNilRecord to desired register:t218
	movl	12(%ebp), %esi					# run MOVE statement with src:t101, dst:t219,
	movl	$0, %ecx					# run MOVE statement with src: dst:t220,
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	-4(%ebp), %ecx					# load pseudoreg `f0' to machine reg `%ecx'
	imull	$4, %ecx					# evaluate MUL expression src: dst:t220
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	-4(%ebp), %edx					# load pseudoreg `f0' to machine reg `%edx'
	addl	%edx, %esi					# evaluate PLUS expression src:t220, dst:t219
	movl	(%esi), %esi					# evaluate MEM expression src:t219, dst:t221
	movl	%esi, (%edi)					# run MOVE statement with src:t221,t184, dst:
	movl	%ebx, %esi					# run MOVE statement with src:t113, dst:t222,
	addl	$4, %esi					# evaluate PLUS expression src: dst:t222
	movl	%esi, %edi					# run MOVE statement with src:t222, dst:t187,
	movl	8(%ebp), %esi					# run MOVE statement with src:t101, dst:t186,
	movl	12(%ebp), %ecx					# evaluate MEM expression src:t101, dst:t223
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	-4(%ebp), %edx					# load pseudoreg `f0' to machine reg `%edx'
	movl	%edx, 0(%esp)					# argument 0 for checkNilRecord from src:t223,
	call	checkNilRecord					# call function checkNilRecord, putting result in EAX
	movl	%eax, %ecx					# move result of checkNilRecord to desired register:t224
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	%esi, 0(%esp)					# argument 0 for L23 from src:t186,
	movl	12(%ebp), %esi					# run MOVE statement with src:t101, dst:t225,
	movl	$1, %ecx					# run MOVE statement with src: dst:t226,
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	-4(%ebp), %ecx					# load pseudoreg `f0' to machine reg `%ecx'
	imull	$4, %ecx					# evaluate MUL expression src: dst:t226
	movl	%ecx, -4(%ebp)					# save pseudo-register f0
	movl	-4(%ebp), %edx					# load pseudoreg `f0' to machine reg `%edx'
	addl	%edx, %esi					# evaluate PLUS expression src:t226, dst:t225
	movl	(%esi), %esi					# evaluate MEM expression src:t225, dst:t227
	movl	%esi, 4(%esp)					# argument 1 for L23 from src:t227,
	movl	16(%ebp), %esi					# evaluate MEM expression src:t101, dst:t228
	movl	%esi, 8(%esp)					# argument 2 for L23 from src:t228,
	call	L23					# call function L23, putting result in EAX
	movl	%eax, %esi					# move result of L23 to desired register:t229
	movl	%esi, %esi					# run MOVE statement with src:t229, dst:t185,
	movl	%esi, (%edi)					# run MOVE statement with src:t185,t187, dst:
	movl	%ebx, %ebx					# run MOVE statement with src:t113, dst:t115,
	jmp	L31					# unconditional jump
L63:
	movl	12(%esp), %ebx					# restore callee-saved register
	movl	16(%esp), %esi					# restore callee-saved register
	movl	20(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function L23
.globl	L22					# make linkable
	.type	L22, @function					# identify it as a function (for linking)
L22:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$188, %esp					# make room for 40 pseudoregs, 2 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L66:
	movl	%ebp, %ebx					# run MOVE statement with src:t101, dst:t235,
	addl	$-164, %ebx					# evaluate PLUS expression src: dst:t235
	movl	%ebx, %esi					# run MOVE statement with src:t235, dst:t230,
	movl	$4, 0(%esp)					# argument 0 for allocRecord from src:
	call	allocRecord					# call function allocRecord, putting result in EAX
	movl	%eax, %ebx					# move result of allocRecord to desired register:t236
	movl	%ebx, %ebx					# run MOVE statement with src:t236, dst:t110,
	movl	$0, 0(%ebx)					# run MOVE statement with src:t110, dst:
	movl	%ebx, (%esi)					# run MOVE statement with src:t110,t230, dst:
	movl	%ebp, %ebx					# run MOVE statement with src:t101, dst:t237,
	addl	$-168, %ebx					# evaluate PLUS expression src: dst:t237
	movl	%ebx, %esi					# run MOVE statement with src:t237, dst:t232,
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t238
	movl	%ebx, 0(%esp)					# argument 0 for L0 from src:t238,
	movl	-164(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t239
	movl	%ebx, 4(%esp)					# argument 1 for L0 from src:t239,
	call	L0					# call function L0, putting result in EAX
	movl	%eax, %ebx					# move result of L0 to desired register:t240
	movl	%ebx, %ebx					# run MOVE statement with src:t240, dst:t231,
	movl	%ebx, (%esi)					# run MOVE statement with src:t231,t232, dst:
	movl	-164(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t241
	movl	%ebx, 0(%esp)					# argument 0 for checkNilRecord from src:t241,
	call	checkNilRecord					# call function checkNilRecord, putting result in EAX
	movl	%eax, %ebx					# move result of checkNilRecord to desired register:t242
	movl	-164(%ebp), %ebx					# run MOVE statement with src:t101, dst:t243,
	movl	$0, %esi					# run MOVE statement with src: dst:t244,
	imull	$4, %esi					# evaluate MUL expression src: dst:t244
	addl	%esi, %ebx					# evaluate PLUS expression src:t244, dst:t243
	cmpl	$0, (%ebx)					# compare before conditional jump with src1: src2:t243,
	je	L27
L26:
	movl	$8, 0(%esp)					# argument 0 for allocRecord from src:
	call	allocRecord					# call function allocRecord, putting result in EAX
	movl	%eax, %ebx					# move result of allocRecord to desired register:t245
	movl	%ebx, %ebx					# run MOVE statement with src:t245, dst:t111,
	movl	-168(%ebp), %esi					# evaluate MEM expression src:t101, dst:t246
	movl	%esi, 0(%ebx)					# run MOVE statement with src:t246,t111, dst:
	movl	%ebx, %esi					# run MOVE statement with src:t111, dst:t247,
	addl	$4, %esi					# evaluate PLUS expression src: dst:t247
	movl	%esi, %edi					# run MOVE statement with src:t247, dst:t234,
	movl	8(%ebp), %esi					# evaluate MEM expression src:t101, dst:t248
	movl	%esi, 0(%esp)					# argument 0 for L22 from src:t248,
	call	L22					# call function L22, putting result in EAX
	movl	%eax, %esi					# move result of L22 to desired register:t249
	movl	%esi, %esi					# run MOVE statement with src:t249, dst:t233,
	movl	%esi, (%edi)					# run MOVE statement with src:t233,t234, dst:
	movl	%ebx, %ebx					# run MOVE statement with src:t111, dst:t112,
L28:
	movl	%ebx, %eax					# run MOVE statement with src:t112, dst:t100,
	jmp	L65					# unconditional jump
L27:
	movl	$0, %ebx					# run MOVE statement with src: dst:t112,
	jmp	L28					# unconditional jump
L65:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function L22
.globl	L0					# make linkable
	.type	L0, @function					# identify it as a function (for linking)
L0:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$184, %esp					# make room for 40 pseudoregs, 1 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L68:
	movl	$0, -164(%ebp)					# run MOVE statement with src:t101, dst:
	movl	%ebp, 0(%esp)					# argument 0 for L2 from src:t101,
	call	L2					# call function L2, putting result in EAX
	movl	%eax, %ebx					# move result of L2 to desired register:t261
	movl	12(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t262
	movl	%ebx, 0(%esp)					# argument 0 for checkNilRecord from src:t262,
	call	checkNilRecord					# call function checkNilRecord, putting result in EAX
	movl	%eax, %ebx					# move result of checkNilRecord to desired register:t263
	movl	12(%ebp), %ebx					# run MOVE statement with src:t101, dst:t264,
	movl	$0, %esi					# run MOVE statement with src: dst:t265,
	imull	$4, %esi					# evaluate MUL expression src: dst:t265
	addl	%esi, %ebx					# evaluate PLUS expression src:t265, dst:t264
	movl	%ebx, %esi					# run MOVE statement with src:t264, dst:t251,
	movl	%ebp, 0(%esp)					# argument 0 for L1 from src:t101,
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t266
	movl	-164(%ebx), %ebx					# evaluate MEM expression src:t266, dst:t267
	movl	%ebx, 4(%esp)					# argument 1 for L1 from src:t267,
	call	L1					# call function L1, putting result in EAX
	movl	%eax, %ebx					# move result of L1 to desired register:t268
	movl	%ebx, %ebx					# run MOVE statement with src:t268, dst:t250,
	movl	%ebx, (%esi)					# run MOVE statement with src:t250,t251, dst:
	movl	%ebp, 0(%esp)					# argument 0 for L1 from src:t101,
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t269
	movl	-164(%ebx), %ebx					# evaluate MEM expression src:t269, dst:t270
	movl	%ebx, 4(%esp)					# argument 1 for L1 from src:t270,
	call	L1					# call function L1, putting result in EAX
	movl	%eax, %ebx					# move result of L1 to desired register:t271
	movl	%ebx, %ebx					# run MOVE statement with src:t271, dst:t252,
	cmpl	$0, %ebx					# compare before conditional jump with src1: src2:t252,
	je	L19
L21:
	movl	%ebp, %ebx					# run MOVE statement with src:t101, dst:t272,
	addl	$-164, %ebx					# evaluate PLUS expression src: dst:t272
	movl	%ebx, %esi					# run MOVE statement with src:t272, dst:t257,
	movl	-164(%ebp), %ebx					# run MOVE statement with src:t101, dst:t273,
	imull	$10, %ebx					# evaluate MUL expression src: dst:t273
	movl	%ebx, %ebx					# run MOVE statement with src:t273, dst:t254,
	movl	8(%ebp), %edi					# evaluate MEM expression src:t101, dst:t274
	movl	-164(%edi), %edi					# evaluate MEM expression src:t274, dst:t275
	movl	%edi, 0(%esp)					# argument 0 for ord from src:t275,
	call	ord					# call function ord, putting result in EAX
	movl	%eax, %edi					# move result of ord to desired register:t276
	movl	%edi, %edi					# run MOVE statement with src:t276, dst:t253,
	movl	%ebx, %ebx					# run MOVE statement with src:t254, dst:t277,
	addl	%edi, %ebx					# evaluate PLUS expression src:t253, dst:t277
	movl	%ebx, %ebx					# run MOVE statement with src:t277, dst:t256,
	movl	$L20, 0(%esp)					# argument 0 for ord from src:
	call	ord					# call function ord, putting result in EAX
	movl	%eax, %edi					# move result of ord to desired register:t278
	movl	%edi, %edi					# run MOVE statement with src:t278, dst:t255,
	movl	%ebx, %ebx					# run MOVE statement with src:t256, dst:t279,
	subl	%edi, %ebx					# evaluate MINUS expression src:t255, dst:t279
	movl	%ebx, (%esi)					# run MOVE statement with src:t279,t257, dst:
	movl	8(%ebp), %ebx					# run MOVE statement with src:t101, dst:t280,
	addl	$-164, %ebx					# evaluate PLUS expression src: dst:t280
	movl	%ebx, %esi					# run MOVE statement with src:t280, dst:t259,
	call	getch					# call function getch, putting result in EAX
	movl	%eax, %ebx					# move result of getch to desired register:t281
	movl	%ebx, %ebx					# run MOVE statement with src:t281, dst:t258,
	movl	%ebx, (%esi)					# run MOVE statement with src:t258,t259, dst:
	movl	%ebp, 0(%esp)					# argument 0 for L1 from src:t101,
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t282
	movl	-164(%ebx), %ebx					# evaluate MEM expression src:t282, dst:t283
	movl	%ebx, 4(%esp)					# argument 1 for L1 from src:t283,
	call	L1					# call function L1, putting result in EAX
	movl	%eax, %ebx					# move result of L1 to desired register:t284
	movl	%ebx, %ebx					# run MOVE statement with src:t284, dst:t260,
	cmpl	$0, %ebx					# compare before conditional jump with src1: src2:t260,
	jne	L21
L19:
	movl	-164(%ebp), %eax					# run MOVE statement with src:t101, dst:t100,
	jmp	L67					# unconditional jump
L67:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function L0
L20:					# string literal: "0"
	.long 1					# string's length
	.byte 48					# string's bytes
.globl	L2					# make linkable
	.type	L2, @function					# identify it as a function (for linking)
L2:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$180, %esp					# make room for 40 pseudoregs, 0 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L70:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t291
	movl	8(%ebx), %ebx					# evaluate MEM expression src:t291, dst:t292
	movl	-164(%ebx), %ebx					# evaluate MEM expression src:t292, dst:t293
	movl	%ebx, 0(%esp)					# argument 0 for stringEqual from src:t293,
	movl	$L10, 4(%esp)					# argument 1 for stringEqual from src:
	call	stringEqual					# call function stringEqual, putting result in EAX
	movl	%eax, %ebx					# move result of stringEqual to desired register:t294
	movl	%ebx, %ebx					# run MOVE statement with src:t294, dst:t285,
	cmpl	$0, %ebx					# compare before conditional jump with src1: src2:t285,
	je	L13
L12:
	movl	$1, %ebx					# run MOVE statement with src: dst:t108,
L14:
	cmpl	$0, %ebx					# compare before conditional jump with src1: src2:t108,
	je	L17
L18:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t296
	movl	8(%ebx), %ebx					# run MOVE statement with src:t296, dst:t295,
	addl	$-164, %ebx					# evaluate PLUS expression src: dst:t295
	movl	%ebx, %esi					# run MOVE statement with src:t295, dst:t288,
	call	getch					# call function getch, putting result in EAX
	movl	%eax, %ebx					# move result of getch to desired register:t297
	movl	%ebx, %ebx					# run MOVE statement with src:t297, dst:t287,
	movl	%ebx, (%esi)					# run MOVE statement with src:t287,t288, dst:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t298
	movl	8(%ebx), %ebx					# evaluate MEM expression src:t298, dst:t299
	movl	-164(%ebx), %ebx					# evaluate MEM expression src:t299, dst:t300
	movl	%ebx, 0(%esp)					# argument 0 for stringEqual from src:t300,
	movl	$L10, 4(%esp)					# argument 1 for stringEqual from src:
	call	stringEqual					# call function stringEqual, putting result in EAX
	movl	%eax, %ebx					# move result of stringEqual to desired register:t301
	movl	%ebx, %ebx					# run MOVE statement with src:t301, dst:t289,
	cmpl	$0, %ebx					# compare before conditional jump with src1: src2:t289,
	jne	L12
L13:
	movl	$1, %ebx					# run MOVE statement with src: dst:t109,
	movl	8(%ebp), %esi					# evaluate MEM expression src:t101, dst:t302
	movl	8(%esi), %esi					# evaluate MEM expression src:t302, dst:t303
	movl	-164(%esi), %esi					# evaluate MEM expression src:t303, dst:t304
	movl	%esi, 0(%esp)					# argument 0 for stringEqual from src:t304,
	movl	$L11, 4(%esp)					# argument 1 for stringEqual from src:
	call	stringEqual					# call function stringEqual, putting result in EAX
	movl	%eax, %esi					# move result of stringEqual to desired register:t305
	movl	%esi, %esi					# run MOVE statement with src:t305, dst:t286,
	cmpl	$0, %esi					# compare before conditional jump with src1: src2:t286,
	je	L16
L15:
	movl	%ebx, %ebx					# run MOVE statement with src:t109, dst:t108,
	jmp	L14					# unconditional jump
L16:
	movl	$0, %ebx					# run MOVE statement with src: dst:t109,
	jmp	L15					# unconditional jump
L17:
	movl	$0, %eax					# run MOVE statement with src: dst:t100,
	jmp	L69					# unconditional jump
L69:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function L2
L11:					# string literal: "\n"
	.long 1					# string's length
	.byte 10					# string's bytes
L10:					# string literal: " "
	.long 1					# string's length
	.byte 32					# string's bytes
.globl	L1					# make linkable
	.type	L1, @function					# identify it as a function (for linking)
L1:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$180, %esp					# make room for 40 pseudoregs, 0 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L72:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t312
	movl	8(%ebx), %ebx					# evaluate MEM expression src:t312, dst:t313
	movl	-164(%ebx), %ebx					# evaluate MEM expression src:t313, dst:t314
	movl	%ebx, 0(%esp)					# argument 0 for ord from src:t314,
	call	ord					# call function ord, putting result in EAX
	movl	%eax, %ebx					# move result of ord to desired register:t315
	movl	%ebx, %ebx					# run MOVE statement with src:t315, dst:t306,
	movl	%ebx, %ebx					# run MOVE statement with src:t306, dst:t308,
	movl	$L3, 0(%esp)					# argument 0 for ord from src:
	call	ord					# call function ord, putting result in EAX
	movl	%eax, %esi					# move result of ord to desired register:t316
	movl	%esi, %esi					# run MOVE statement with src:t316, dst:t307,
	cmpl	%esi, %ebx					# compare before conditional jump with src1:t307, src2:t308,
	jge	L5
L6:
	movl	$0, %ebx					# run MOVE statement with src: dst:t106,
L7:
	movl	%ebx, %eax					# run MOVE statement with src:t106, dst:t100,
	jmp	L71					# unconditional jump
L5:
	movl	$1, %ebx					# run MOVE statement with src: dst:t107,
	movl	8(%ebp), %esi					# evaluate MEM expression src:t101, dst:t317
	movl	8(%esi), %esi					# evaluate MEM expression src:t317, dst:t318
	movl	-164(%esi), %esi					# evaluate MEM expression src:t318, dst:t319
	movl	%esi, 0(%esp)					# argument 0 for ord from src:t319,
	call	ord					# call function ord, putting result in EAX
	movl	%eax, %esi					# move result of ord to desired register:t320
	movl	%esi, %esi					# run MOVE statement with src:t320, dst:t309,
	movl	%esi, %esi					# run MOVE statement with src:t309, dst:t311,
	movl	$L4, 0(%esp)					# argument 0 for ord from src:
	call	ord					# call function ord, putting result in EAX
	movl	%eax, %edi					# move result of ord to desired register:t321
	movl	%edi, %edi					# run MOVE statement with src:t321, dst:t310,
	cmpl	%edi, %esi					# compare before conditional jump with src1:t310, src2:t311,
	jle	L8
L9:
	movl	$0, %ebx					# run MOVE statement with src: dst:t107,
L8:
	movl	%ebx, %ebx					# run MOVE statement with src:t107, dst:t106,
	jmp	L7					# unconditional jump
L71:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function L1
L4:					# string literal: "9"
	.long 1					# string's length
	.byte 57					# string's bytes
L3:					# string literal: "0"
	.long 1					# string's length
	.byte 48					# string's bytes
