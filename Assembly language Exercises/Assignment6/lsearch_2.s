
	#   Variable map:
	#   %rdi - The address of array int *A
	#   %esi - int n
	#   %edx - target
	#	%ecx - i
	#   %r9d - temp, to keep A[n-1]
	#	%rax - return value

	.globl	lsearch_2

lsearch_2:

	testl	%esi, %esi    #if n<=0 {return -1 }
	jle	 endif
	movslq	%esi, %rax    #A[n-1]	
	leaq	-4(%rdi,%rax,4), %rax
	movl	(%rax), %r9d   #int temp = A[n-1];
	movl	%edx, (%rax)   # A[n-1] = target;
	cmpl	(%rdi), %edx   #if A[0]=target  {i = 0; }
	je	 zeroIndex
	movl	$1, %ecx       # i=0  ##"updated to 0 by label equal later"
	
loop:
	movl	%ecx, %r8d              #while(A[i] !=target){ i++}
	addq	$1, %rcx
	cmpl	%edx, -4(%rdi,%rcx,4)
	jne	loop
found:
	movl	%r9d, (%rax)          # A[n-1] = temp;
	leal	-1(%rsi), %eax
	cmpl	%r8d, %eax            #if(i<n-1){ return n=1}
	jg	equal                    #else{return -1}
	cmpl	%edx, %r9d
	jne	endif
	rep ret
	
equal:
	movl	%r8d, %eax       #return n-1
	ret
	
zeroIndex:
	xorl	%r8d, %r8d       #i=0
	jmp	found

endif:
	movl	$-1, %eax       #return -1
	ret
	
