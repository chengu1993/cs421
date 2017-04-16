.globl	tigermain					# make linkable
	.type	tigermain, @function					# identify it as a function (for linking)
tigermain:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$200, %esp					# make room for 40 pseudoregs, 5 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L34:
	movl	$8, -164(%ebp)					# run MOVE statement with src:t101, dst:
	movl	%ebp, %ebx					# run MOVE statement with src:t101, dst:t120,
	addl	$-168, %ebx					# evaluate PLUS expression src: dst:t120
	movl	%ebx, %esi					# run MOVE statement with src:t120, dst:t113,
	movl	-164(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t121
	movl	%ebx, 0(%esp)					# argument 0 for initArray from src:t121,
	movl	$0, 4(%esp)					# argument 1 for initArray from src:
	call	initArray					# call function initArray, putting result in EAX
	movl	%eax, %ebx					# move result of initArray to desired register:t122
	movl	%ebx, %ebx					# run MOVE statement with src:t122, dst:t112,
	movl	%ebx, (%esi)					# run MOVE statement with src:t112,t113, dst:
	movl	%ebp, %ebx					# run MOVE statement with src:t101, dst:t123,
	addl	$-172, %ebx					# evaluate PLUS expression src: dst:t123
	movl	%ebx, %esi					# run MOVE statement with src:t123, dst:t115,
	movl	-164(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t124
	movl	%ebx, 0(%esp)					# argument 0 for initArray from src:t124,
	movl	$0, 4(%esp)					# argument 1 for initArray from src:
	call	initArray					# call function initArray, putting result in EAX
	movl	%eax, %ebx					# move result of initArray to desired register:t125
	movl	%ebx, %ebx					# run MOVE statement with src:t125, dst:t114,
	movl	%ebx, (%esi)					# run MOVE statement with src:t114,t115, dst:
	movl	%ebp, %ebx					# run MOVE statement with src:t101, dst:t126,
	addl	$-176, %ebx					# evaluate PLUS expression src: dst:t126
	movl	%ebx, %esi					# run MOVE statement with src:t126, dst:t117,
	movl	-164(%ebp), %ebx					# run MOVE statement with src:t101, dst:t128,
	addl	-164(%ebp), %ebx					# evaluate PLUS expression src:t101, dst:t128
	movl	%ebx, %ebx					# run MOVE statement with src:t128, dst:t127,
	subl	$1, %ebx					# evaluate MINUS expression src: dst:t127
	movl	%ebx, 0(%esp)					# argument 0 for initArray from src:t127,
	movl	$0, 4(%esp)					# argument 1 for initArray from src:
	call	initArray					# call function initArray, putting result in EAX
	movl	%eax, %ebx					# move result of initArray to desired register:t129
	movl	%ebx, %ebx					# run MOVE statement with src:t129, dst:t116,
	movl	%ebx, (%esi)					# run MOVE statement with src:t116,t117, dst:
	movl	%ebp, %ebx					# run MOVE statement with src:t101, dst:t130,
	addl	$-180, %ebx					# evaluate PLUS expression src: dst:t130
	movl	%ebx, %esi					# run MOVE statement with src:t130, dst:t119,
	movl	-164(%ebp), %ebx					# run MOVE statement with src:t101, dst:t132,
	addl	-164(%ebp), %ebx					# evaluate PLUS expression src:t101, dst:t132
	movl	%ebx, %ebx					# run MOVE statement with src:t132, dst:t131,
	subl	$1, %ebx					# evaluate MINUS expression src: dst:t131
	movl	%ebx, 0(%esp)					# argument 0 for initArray from src:t131,
	movl	$0, 4(%esp)					# argument 1 for initArray from src:
	call	initArray					# call function initArray, putting result in EAX
	movl	%eax, %ebx					# move result of initArray to desired register:t133
	movl	%ebx, %ebx					# run MOVE statement with src:t133, dst:t118,
	movl	%ebx, (%esi)					# run MOVE statement with src:t118,t119, dst:
	movl	%ebp, 0(%esp)					# argument 0 for L1 from src:t101,
	movl	$0, 4(%esp)					# argument 1 for L1 from src:
	call	L1					# call function L1, putting result in EAX
	movl	%eax, %ebx					# move result of L1 to desired register:t134
	movl	$1, %eax					# run MOVE statement with src: dst:t100,
	jmp	L33					# unconditional jump
L33:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function tigermain
.globl	L1					# make linkable
	.type	L1, @function					# identify it as a function (for linking)
L1:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$184, %esp					# make room for 40 pseudoregs, 1 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L36:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t135
	movl	-164(%ebx), %ebx					# evaluate MEM expression src:t135, dst:t136
	cmpl	%ebx, 12(%ebp)					# compare before conditional jump with src1:t136, src2:t101,
	je	L30
L31:
	movl	$0, -164(%ebp)					# run MOVE statement with src:t101, dst:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t138
	movl	-164(%ebx), %ebx					# run MOVE statement with src:t138, dst:t137,
	subl	$1, %ebx					# evaluate MINUS expression src: dst:t137
	cmpl	%ebx, -164(%ebp)					# compare before conditional jump with src1:t137, src2:t101,
	jle	L28
L15:
	movl	$0, %ebx					# run MOVE statement with src: dst:t111,
L32:
	movl	%ebx, %eax					# run MOVE statement with src:t111, dst:t100,
	jmp	L35					# unconditional jump
L30:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t139
	movl	%ebx, 0(%esp)					# argument 0 for L0 from src:t139,
	call	L0					# call function L0, putting result in EAX
	movl	%eax, %ebx					# move result of L0 to desired register:t140
	movl	%ebx, %ebx					# run MOVE statement with src:t140, dst:t111,
	jmp	L32					# unconditional jump
L28:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t141
	movl	-168(%ebx), %ebx					# evaluate MEM expression src:t141, dst:t142
	movl	%ebx, 0(%esp)					# argument 0 for checkArrayBounds from src:t142,
	movl	-164(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t143
	movl	%ebx, 4(%esp)					# argument 1 for checkArrayBounds from src:t143,
	call	checkArrayBounds					# call function checkArrayBounds, putting result in EAX
	movl	%eax, %ebx					# move result of checkArrayBounds to desired register:t144
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t146
	movl	-168(%ebx), %ebx					# run MOVE statement with src:t146, dst:t145,
	movl	-164(%ebp), %esi					# run MOVE statement with src:t101, dst:t147,
	imull	$4, %esi					# evaluate MUL expression src: dst:t147
	addl	%esi, %ebx					# evaluate PLUS expression src:t147, dst:t145
	cmpl	$0, (%ebx)					# compare before conditional jump with src1: src2:t145,
	je	L16
L17:
	movl	$0, %ebx					# run MOVE statement with src: dst:t107,
L18:
	cmpl	$0, %ebx					# compare before conditional jump with src1: src2:t107,
	je	L22
L21:
	movl	$1, %ebx					# run MOVE statement with src: dst:t110,
	movl	8(%ebp), %esi					# evaluate MEM expression src:t101, dst:t148
	movl	-180(%esi), %esi					# evaluate MEM expression src:t148, dst:t149
	movl	%esi, 0(%esp)					# argument 0 for checkArrayBounds from src:t149,
	movl	-164(%ebp), %esi					# run MOVE statement with src:t101, dst:t151,
	addl	$7, %esi					# evaluate PLUS expression src: dst:t151
	movl	%esi, %esi					# run MOVE statement with src:t151, dst:t150,
	subl	12(%ebp), %esi					# evaluate MINUS expression src:t101, dst:t150
	movl	%esi, 4(%esp)					# argument 1 for checkArrayBounds from src:t150,
	call	checkArrayBounds					# call function checkArrayBounds, putting result in EAX
	movl	%eax, %esi					# move result of checkArrayBounds to desired register:t152
	movl	8(%ebp), %esi					# evaluate MEM expression src:t101, dst:t154
	movl	-180(%esi), %esi					# run MOVE statement with src:t154, dst:t153,
	movl	-164(%ebp), %edi					# run MOVE statement with src:t101, dst:t157,
	addl	$7, %edi					# evaluate PLUS expression src: dst:t157
	movl	%edi, %edi					# run MOVE statement with src:t157, dst:t156,
	subl	12(%ebp), %edi					# evaluate MINUS expression src:t101, dst:t156
	movl	%edi, %edi					# run MOVE statement with src:t156, dst:t155,
	imull	$4, %edi					# evaluate MUL expression src: dst:t155
	addl	%edi, %esi					# evaluate PLUS expression src:t155, dst:t153
	cmpl	$0, (%esi)					# compare before conditional jump with src1: src2:t153,
	je	L24
L25:
	movl	$0, %ebx					# run MOVE statement with src: dst:t110,
L24:
	movl	%ebx, %ebx					# run MOVE statement with src:t110, dst:t109,
L23:
	cmpl	$0, %ebx					# compare before conditional jump with src1: src2:t109,
	je	L27
L26:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t158
	movl	-168(%ebx), %ebx					# evaluate MEM expression src:t158, dst:t159
	movl	%ebx, 0(%esp)					# argument 0 for checkArrayBounds from src:t159,
	movl	-164(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t160
	movl	%ebx, 4(%esp)					# argument 1 for checkArrayBounds from src:t160,
	call	checkArrayBounds					# call function checkArrayBounds, putting result in EAX
	movl	%eax, %ebx					# move result of checkArrayBounds to desired register:t161
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t163
	movl	-168(%ebx), %ebx					# run MOVE statement with src:t163, dst:t162,
	movl	-164(%ebp), %esi					# run MOVE statement with src:t101, dst:t164,
	imull	$4, %esi					# evaluate MUL expression src: dst:t164
	addl	%esi, %ebx					# evaluate PLUS expression src:t164, dst:t162
	movl	$1, (%ebx)					# run MOVE statement with src:t162, dst:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t165
	movl	-176(%ebx), %ebx					# evaluate MEM expression src:t165, dst:t166
	movl	%ebx, 0(%esp)					# argument 0 for checkArrayBounds from src:t166,
	movl	-164(%ebp), %ebx					# run MOVE statement with src:t101, dst:t167,
	addl	12(%ebp), %ebx					# evaluate PLUS expression src:t101, dst:t167
	movl	%ebx, 4(%esp)					# argument 1 for checkArrayBounds from src:t167,
	call	checkArrayBounds					# call function checkArrayBounds, putting result in EAX
	movl	%eax, %ebx					# move result of checkArrayBounds to desired register:t168
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t170
	movl	-176(%ebx), %ebx					# run MOVE statement with src:t170, dst:t169,
	movl	-164(%ebp), %esi					# run MOVE statement with src:t101, dst:t172,
	addl	12(%ebp), %esi					# evaluate PLUS expression src:t101, dst:t172
	movl	%esi, %esi					# run MOVE statement with src:t172, dst:t171,
	imull	$4, %esi					# evaluate MUL expression src: dst:t171
	addl	%esi, %ebx					# evaluate PLUS expression src:t171, dst:t169
	movl	$1, (%ebx)					# run MOVE statement with src:t169, dst:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t173
	movl	-180(%ebx), %ebx					# evaluate MEM expression src:t173, dst:t174
	movl	%ebx, 0(%esp)					# argument 0 for checkArrayBounds from src:t174,
	movl	-164(%ebp), %ebx					# run MOVE statement with src:t101, dst:t176,
	addl	$7, %ebx					# evaluate PLUS expression src: dst:t176
	movl	%ebx, %ebx					# run MOVE statement with src:t176, dst:t175,
	subl	12(%ebp), %ebx					# evaluate MINUS expression src:t101, dst:t175
	movl	%ebx, 4(%esp)					# argument 1 for checkArrayBounds from src:t175,
	call	checkArrayBounds					# call function checkArrayBounds, putting result in EAX
	movl	%eax, %ebx					# move result of checkArrayBounds to desired register:t177
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t179
	movl	-180(%ebx), %ebx					# run MOVE statement with src:t179, dst:t178,
	movl	-164(%ebp), %esi					# run MOVE statement with src:t101, dst:t182,
	addl	$7, %esi					# evaluate PLUS expression src: dst:t182
	movl	%esi, %esi					# run MOVE statement with src:t182, dst:t181,
	subl	12(%ebp), %esi					# evaluate MINUS expression src:t101, dst:t181
	movl	%esi, %esi					# run MOVE statement with src:t181, dst:t180,
	imull	$4, %esi					# evaluate MUL expression src: dst:t180
	addl	%esi, %ebx					# evaluate PLUS expression src:t180, dst:t178
	movl	$1, (%ebx)					# run MOVE statement with src:t178, dst:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t183
	movl	-172(%ebx), %ebx					# evaluate MEM expression src:t183, dst:t184
	movl	%ebx, 0(%esp)					# argument 0 for checkArrayBounds from src:t184,
	movl	12(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t185
	movl	%ebx, 4(%esp)					# argument 1 for checkArrayBounds from src:t185,
	call	checkArrayBounds					# call function checkArrayBounds, putting result in EAX
	movl	%eax, %ebx					# move result of checkArrayBounds to desired register:t186
	movl	-164(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t187
	movl	8(%ebp), %esi					# evaluate MEM expression src:t101, dst:t189
	movl	-172(%esi), %esi					# run MOVE statement with src:t189, dst:t188,
	movl	12(%ebp), %edi					# run MOVE statement with src:t101, dst:t190,
	imull	$4, %edi					# evaluate MUL expression src: dst:t190
	addl	%edi, %esi					# evaluate PLUS expression src:t190, dst:t188
	movl	%ebx, (%esi)					# run MOVE statement with src:t187,t188, dst:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t191
	movl	%ebx, 0(%esp)					# argument 0 for L1 from src:t191,
	movl	12(%ebp), %ebx					# run MOVE statement with src:t101, dst:t192,
	addl	$1, %ebx					# evaluate PLUS expression src: dst:t192
	movl	%ebx, 4(%esp)					# argument 1 for L1 from src:t192,
	call	L1					# call function L1, putting result in EAX
	movl	%eax, %ebx					# move result of L1 to desired register:t193
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t194
	movl	-168(%ebx), %ebx					# evaluate MEM expression src:t194, dst:t195
	movl	%ebx, 0(%esp)					# argument 0 for checkArrayBounds from src:t195,
	movl	-164(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t196
	movl	%ebx, 4(%esp)					# argument 1 for checkArrayBounds from src:t196,
	call	checkArrayBounds					# call function checkArrayBounds, putting result in EAX
	movl	%eax, %ebx					# move result of checkArrayBounds to desired register:t197
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t199
	movl	-168(%ebx), %ebx					# run MOVE statement with src:t199, dst:t198,
	movl	-164(%ebp), %esi					# run MOVE statement with src:t101, dst:t200,
	imull	$4, %esi					# evaluate MUL expression src: dst:t200
	addl	%esi, %ebx					# evaluate PLUS expression src:t200, dst:t198
	movl	$0, (%ebx)					# run MOVE statement with src:t198, dst:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t201
	movl	-176(%ebx), %ebx					# evaluate MEM expression src:t201, dst:t202
	movl	%ebx, 0(%esp)					# argument 0 for checkArrayBounds from src:t202,
	movl	-164(%ebp), %ebx					# run MOVE statement with src:t101, dst:t203,
	addl	12(%ebp), %ebx					# evaluate PLUS expression src:t101, dst:t203
	movl	%ebx, 4(%esp)					# argument 1 for checkArrayBounds from src:t203,
	call	checkArrayBounds					# call function checkArrayBounds, putting result in EAX
	movl	%eax, %ebx					# move result of checkArrayBounds to desired register:t204
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t206
	movl	-176(%ebx), %ebx					# run MOVE statement with src:t206, dst:t205,
	movl	-164(%ebp), %esi					# run MOVE statement with src:t101, dst:t208,
	addl	12(%ebp), %esi					# evaluate PLUS expression src:t101, dst:t208
	movl	%esi, %esi					# run MOVE statement with src:t208, dst:t207,
	imull	$4, %esi					# evaluate MUL expression src: dst:t207
	addl	%esi, %ebx					# evaluate PLUS expression src:t207, dst:t205
	movl	$0, (%ebx)					# run MOVE statement with src:t205, dst:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t209
	movl	-180(%ebx), %ebx					# evaluate MEM expression src:t209, dst:t210
	movl	%ebx, 0(%esp)					# argument 0 for checkArrayBounds from src:t210,
	movl	-164(%ebp), %ebx					# run MOVE statement with src:t101, dst:t212,
	addl	$7, %ebx					# evaluate PLUS expression src: dst:t212
	movl	%ebx, %ebx					# run MOVE statement with src:t212, dst:t211,
	subl	12(%ebp), %ebx					# evaluate MINUS expression src:t101, dst:t211
	movl	%ebx, 4(%esp)					# argument 1 for checkArrayBounds from src:t211,
	call	checkArrayBounds					# call function checkArrayBounds, putting result in EAX
	movl	%eax, %ebx					# move result of checkArrayBounds to desired register:t213
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t215
	movl	-180(%ebx), %ebx					# run MOVE statement with src:t215, dst:t214,
	movl	-164(%ebp), %esi					# run MOVE statement with src:t101, dst:t218,
	addl	$7, %esi					# evaluate PLUS expression src: dst:t218
	movl	%esi, %esi					# run MOVE statement with src:t218, dst:t217,
	subl	12(%ebp), %esi					# evaluate MINUS expression src:t101, dst:t217
	movl	%esi, %esi					# run MOVE statement with src:t217, dst:t216,
	imull	$4, %esi					# evaluate MUL expression src: dst:t216
	addl	%esi, %ebx					# evaluate PLUS expression src:t216, dst:t214
	movl	$0, (%ebx)					# run MOVE statement with src:t214, dst:
L27:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t220
	movl	-164(%ebx), %ebx					# run MOVE statement with src:t220, dst:t219,
	subl	$1, %ebx					# evaluate MINUS expression src: dst:t219
	cmpl	%ebx, -164(%ebp)					# compare before conditional jump with src1:t219, src2:t101,
	jge	L15
L29:
	movl	-164(%ebp), %ebx					# run MOVE statement with src:t101, dst:t221,
	addl	$1, %ebx					# evaluate PLUS expression src: dst:t221
	movl	%ebx, -164(%ebp)					# run MOVE statement with src:t221,t101, dst:
	jmp	L28					# unconditional jump
L16:
	movl	$1, %ebx					# run MOVE statement with src: dst:t108,
	movl	8(%ebp), %esi					# evaluate MEM expression src:t101, dst:t222
	movl	-176(%esi), %esi					# evaluate MEM expression src:t222, dst:t223
	movl	%esi, 0(%esp)					# argument 0 for checkArrayBounds from src:t223,
	movl	-164(%ebp), %esi					# run MOVE statement with src:t101, dst:t224,
	addl	12(%ebp), %esi					# evaluate PLUS expression src:t101, dst:t224
	movl	%esi, 4(%esp)					# argument 1 for checkArrayBounds from src:t224,
	call	checkArrayBounds					# call function checkArrayBounds, putting result in EAX
	movl	%eax, %esi					# move result of checkArrayBounds to desired register:t225
	movl	8(%ebp), %esi					# evaluate MEM expression src:t101, dst:t227
	movl	-176(%esi), %esi					# run MOVE statement with src:t227, dst:t226,
	movl	-164(%ebp), %edi					# run MOVE statement with src:t101, dst:t229,
	addl	12(%ebp), %edi					# evaluate PLUS expression src:t101, dst:t229
	movl	%edi, %edi					# run MOVE statement with src:t229, dst:t228,
	imull	$4, %edi					# evaluate MUL expression src: dst:t228
	addl	%edi, %esi					# evaluate PLUS expression src:t228, dst:t226
	cmpl	$0, (%esi)					# compare before conditional jump with src1: src2:t226,
	je	L19
L20:
	movl	$0, %ebx					# run MOVE statement with src: dst:t108,
L19:
	movl	%ebx, %ebx					# run MOVE statement with src:t108, dst:t107,
	jmp	L18					# unconditional jump
L22:
	movl	$0, %ebx					# run MOVE statement with src: dst:t109,
	jmp	L23					# unconditional jump
L35:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function L1
.globl	L0					# make linkable
	.type	L0, @function					# identify it as a function (for linking)
L0:					# entry point for function
	pushl	%ebp					# save previous frame pointer
	movl	%esp, %ebp					# set new frame pointer
	subl	$188, %esp					# make room for 40 pseudoregs, 2 locals, 3 callee-saves, and 2 maxargs,
	movl	%ebx, 8(%esp)					# callee-save register
	movl	%esi, 12(%esp)					# callee-save register
	movl	%edi, 16(%esp)					# callee-save register
L38:
	movl	$0, -164(%ebp)					# run MOVE statement with src:t101, dst:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t233
	movl	-164(%ebx), %ebx					# run MOVE statement with src:t233, dst:t232,
	subl	$1, %ebx					# evaluate MINUS expression src: dst:t232
	cmpl	%ebx, -164(%ebp)					# compare before conditional jump with src1:t232, src2:t101,
	jle	L12
L2:
	movl	$L14, 0(%esp)					# argument 0 for print from src:
	call	print					# call function print, putting result in EAX
	movl	%eax, %ebx					# move result of print to desired register:t234
	movl	%ebx, %ebx					# run MOVE statement with src:t234, dst:t231,
	movl	%ebx, %eax					# run MOVE statement with src:t231, dst:t100,
	jmp	L37					# unconditional jump
L12:
	movl	$0, -168(%ebp)					# run MOVE statement with src:t101, dst:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t236
	movl	-164(%ebx), %ebx					# run MOVE statement with src:t236, dst:t235,
	subl	$1, %ebx					# evaluate MINUS expression src: dst:t235
	cmpl	%ebx, -168(%ebp)					# compare before conditional jump with src1:t235, src2:t101,
	jle	L9
L3:
	movl	$L11, 0(%esp)					# argument 0 for print from src:
	call	print					# call function print, putting result in EAX
	movl	%eax, %ebx					# move result of print to desired register:t237
	movl	%ebx, %ebx					# run MOVE statement with src:t237, dst:t230,
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t239
	movl	-164(%ebx), %ebx					# run MOVE statement with src:t239, dst:t238,
	subl	$1, %ebx					# evaluate MINUS expression src: dst:t238
	cmpl	%ebx, -164(%ebp)					# compare before conditional jump with src1:t238, src2:t101,
	jge	L2
L13:
	movl	-164(%ebp), %ebx					# run MOVE statement with src:t101, dst:t240,
	addl	$1, %ebx					# evaluate PLUS expression src: dst:t240
	movl	%ebx, -164(%ebp)					# run MOVE statement with src:t240,t101, dst:
	jmp	L12					# unconditional jump
L9:
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t241
	movl	-172(%ebx), %ebx					# evaluate MEM expression src:t241, dst:t242
	movl	%ebx, 0(%esp)					# argument 0 for checkArrayBounds from src:t242,
	movl	-164(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t243
	movl	%ebx, 4(%esp)					# argument 1 for checkArrayBounds from src:t243,
	call	checkArrayBounds					# call function checkArrayBounds, putting result in EAX
	movl	%eax, %ebx					# move result of checkArrayBounds to desired register:t244
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t246
	movl	-172(%ebx), %ebx					# run MOVE statement with src:t246, dst:t245,
	movl	-164(%ebp), %esi					# run MOVE statement with src:t101, dst:t247,
	imull	$4, %esi					# evaluate MUL expression src: dst:t247
	addl	%esi, %ebx					# evaluate PLUS expression src:t247, dst:t245
	movl	-168(%ebp), %esi					# evaluate MEM expression src:t101, dst:t248
	cmpl	%esi, (%ebx)					# compare before conditional jump with src1:t248, src2:t245,
	je	L6
L7:
	movl	$L5, %ebx					# run MOVE statement with src: dst:t106,
L8:
	movl	%ebx, 0(%esp)					# argument 0 for print from src:t106,
	call	print					# call function print, putting result in EAX
	movl	%eax, %ebx					# move result of print to desired register:t249
	movl	8(%ebp), %ebx					# evaluate MEM expression src:t101, dst:t251
	movl	-164(%ebx), %ebx					# run MOVE statement with src:t251, dst:t250,
	subl	$1, %ebx					# evaluate MINUS expression src: dst:t250
	cmpl	%ebx, -168(%ebp)					# compare before conditional jump with src1:t250, src2:t101,
	jge	L3
L10:
	movl	-168(%ebp), %ebx					# run MOVE statement with src:t101, dst:t252,
	addl	$1, %ebx					# evaluate PLUS expression src: dst:t252
	movl	%ebx, -168(%ebp)					# run MOVE statement with src:t252,t101, dst:
	jmp	L9					# unconditional jump
L6:
	movl	$L4, %ebx					# run MOVE statement with src: dst:t106,
	jmp	L8					# unconditional jump
L37:
	movl	8(%esp), %ebx					# restore callee-saved register
	movl	12(%esp), %esi					# restore callee-saved register
	movl	16(%esp), %edi					# restore callee-saved register
	movl	%ebp, %esp					# dealloc stack frame
	popl	%ebp					# restore previous frame pointer
	ret					# return from function L0
L14:					# string literal: "\n"
	.long 1					# string's length
	.byte 10					# string's bytes
L11:					# string literal: "\n"
	.long 1					# string's length
	.byte 10					# string's bytes
L5:					# string literal: " ."
	.long 2					# string's length
	.byte 32, 46					# string's bytes
L4:					# string literal: " O"
	.long 2					# string's length
	.byte 32, 79					# string's bytes
