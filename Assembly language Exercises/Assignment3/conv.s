#This algorithm computes the reversed dot product of two arrays. 
	.globl conv

conv:
	movl $0, %eax		#sets initial return value to be 0.
	movl %edx, %ecx		#sets length of array to a temporary register
	decl %ecx			#decrease counter for setting the second array to the last element.
	addq %rcx, %rsi		#set the second array to the last element

loop1:
	cmp $0, %ecx		#checks if all elements were multiplied.
	jnge loop2			#jumps to loop 2 if %r8d < 0.
	movl $0, %r11d		#sets temprary register for the second array to 0.
	movl $0, %r10d		#sets temprary register for the first array to 0.
	movb (%rsi), %r11b	#moves the value in second array to temprary register.
	movb (%rdi), %r10b	#moves the value in first array to temprary register.
	imull %r10d, %r11d	#multiply these two values.
	addl %r11d, %eax	#adds the product to the return register.
	decl %ecx			#decreases the register.
	decq %rsi			#moves backward the pointer of the second array.
	incq %rdi			#moves forward the pointer of the first array.
	jmp loop1

loop2:
	cmp $127, %eax		#check %eax-127 ?
	jnle final			#jumps to return if %eax > 127.
	cmp $-128, %eax		#check %eax-(-128)?
	jnge final			#jumps to return if %eax < -128.
	movq $0, %rdx		#sets %rdx to 0 if and only if no overflow occurred.

final:
	ret   				#returns the result.
