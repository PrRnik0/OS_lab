	.file	"factorial.c"
	.text
	.p2align 4
	.globl	factorial
	.def	factorial;	.scl	2;	.type	32;	.endef
	.seh_proc	factorial
factorial:
	.seh_endprologue
	cmpl	$1, %ecx
	jle	.L4
	leal	1(%rcx), %r8d
	andl	$1, %ecx
	movl	$2, %eax
	movl	$1, %edx
	jne	.L3
	movl	$3, %eax
	movl	$2, %edx
	cmpl	%r8d, %eax
	je	.L1
	.p2align 5
	.p2align 4
	.p2align 3
.L3:
	imull	%eax, %edx
	leal	1(%rax), %ecx
	addl	$2, %eax
	imull	%ecx, %edx
	cmpl	%r8d, %eax
	jne	.L3
.L1:
	movl	%edx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L4:
	movl	$1, %edx
	movl	%edx, %eax
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "\320\222\320\262\320\265\320\264\320\270\321\202\320\265 \321\207\320\270\321\201\320\273\320\276 \320\264\320\273\321\217 \320\262\321\213\321\207\320\270\321\201\320\273\320\265\320\275\320\270\321\217 \321\204\320\260\320\272\321\202\320\276\321\200\320\270\320\260\320\273\320\260: \0"
.LC1:
	.ascii "%d\0"
	.align 8
.LC2:
	.ascii "\320\244\320\260\320\272\321\202\320\276\321\200\320\270\320\260\320\273 %d \321\200\320\260\320\262\320\265\320\275 %d\12\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	leaq	.LC0(%rip), %rcx
	call	printf
	leaq	44(%rsp), %rdx
	leaq	.LC1(%rip), %rcx
	call	scanf
	movl	44(%rsp), %r9d
	cmpl	$1, %r9d
	jle	.L15
	leal	1(%r9), %ecx
	movl	$2, %eax
	movl	$1, %r8d
	testb	$1, %r9b
	jne	.L14
	movl	$3, %eax
	movl	$2, %r8d
	cmpl	%ecx, %eax
	je	.L13
	.p2align 5
	.p2align 4
	.p2align 3
.L14:
	imull	%eax, %r8d
	leal	1(%rax), %edx
	addl	$2, %eax
	imull	%edx, %r8d
	cmpl	%ecx, %eax
	jne	.L14
.L13:
	movl	%r9d, %edx
	leaq	.LC2(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$56, %rsp
	ret
.L15:
	movl	$1, %r8d
	jmp	.L13
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (GNU) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	scanf;	.scl	2;	.type	32;	.endef
