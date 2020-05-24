# This algorithm uses the data queue to store the partial sums. 
# And the queue is implemented by a stack. The two smallest
# values or partial sums were found by comparing the heads of each.
    .globl sum_float
# Q is empty in the begining
# for i from 1 to n-1:
#	x <- smallest of { head(F), head(Q) }
#	dequeue(x)
#	y <- smallest of { head(F), head(Q) }
#	then dequeue(y)
#	then enqueue(x+y) -> Q
#   return head(Q)

	  #   Variable map:
	  #   %xmm0:  total
	  #   %rdi:   F[n] (the base pointer)
	  #   %rsi:   n
	  #   %rbp:   endptr
	  #   %rdx:   counter i
	  #   %rsp:   the tail of the queue
	  #   %rcx:   the head of the queue
	  #   %xmm1:  x
	  #   %xmm2:  y
sum_float:
	push	%rbp
	mov	    %rsp, %r8			
	xorps	%xmm0, %xmm0      # let total to be 0
	leaq	(%rdi, %rsi, 4), %rbp # end pointer <- F + n
	xor	    %rdx, %rdx		      # let the  counter to be 0
	mov	$1, %rdx	     # let counter to be 1
	mov	    %rsp, %rcx		# let rcx be the head of queue		
loop:
	cmpq	%rdx, %rsi	# check if i is larger than n
	jnge 	finalloop			
	incq	%rdx		# increase i by 1
	cmpq	%rdi, %rbp		      # check if array is empty
	jng	    fisempty
	movss	(%rdi), %xmm1  # let x to the head of array
	ucomiss (%rcx), %xmm1 # check if F[head] is less than or equal to Q[head]
	jng	    qempty1		 
	movss	(%rcx), %xmm1  # set x to Q[head]
	leaq	-4(%rcx), %rcx	# set head of queue to next element
	jmp	    qnotempty	
fisempty:
	movss	(%rcx), %xmm1		# set x to Q[head]
	leaq	-4(%rcx), %rcx # set head of queue to next element
	jmp	    fisempty1	
qempty1:
	leaq	4(%rdi), %rdi    # set current element in array to next element
qnotempty:
	movss	(%rdi), %xmm2		  # put y to F[head]
	cmpq	%rcx, %rsp		      # check if queue is empty or not
	jnle	qempty2
	ucomiss (%rcx), %xmm2# check if F[head] is less than or equal to Q[head]
	jng	    qempty2
fisempty1:
	movss	(%rcx), %xmm2	# set y to Q[head]
	leaq	-4(%rcx), %rcx # put head of queue to the next element
	jmp	    calculate
qempty2:
	leaq	4(%rdi), %rdi   # put the element's address plus 4 bytes
calculate:
	addss	%xmm1, %xmm2     # y = x + y
	leaq    -4(%rsp), %rsp	# set rsp to the next address
	movss	%xmm2, (%rsp)	# put y to the tail of the queue
	jmp	loop                    
finalloop:
	movss	(%rsp), %xmm0 # put result to %xmm0
	mov		%r8, %rsp
	pop		%rbp
	ret