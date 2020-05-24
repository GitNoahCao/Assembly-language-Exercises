#This assembly code produces the full convolved signal 
#by calling the function conv() several times, as well as 
#the function min().
#pseudocode:
#      for i from 0 to n+m-2 do
#      ladj <- min(i+1, m)
#      radj <- m - min(m+n-(i+1), m)
#      result[i] <- conv(x + (i+1-ladj), h + radj, ladj-radj)
.globl conv_arr

conv_arr:
	movq $0, %r15  #set r15 to 0
	movq %rsi, %r14
	addq %rcx, %r14#add rcx and r14
	subq $2, %r14
	jmp firstloop  #jump to firstloop

firstloop:
	cmp %r14, %r15
	jnle end       #if r15 - r14 >0 jump to end
	jmp firstmin   #else jump to firstmin

firstmin:
	push %rdi       #push to stack
	push %rsi       #push to stack
	movq $1, %rdi
	addq %r15, %rdi #add r15 and rdi
	movq %rcx, %rsi
	call min		#call function min	
	movq %rax, %r12
	jmp secondmin   #jump to secondmin
	
secondmin:
	pop %rsi        #pop from stack to rsi
	movq %rsi, %rdi #move rsi to rdi
	addq %rcx, %rdi	#rdi = rdi + rcx
	subq $1, %rdi
	subq %r15, %rdi
	push %rsi       #push to stack
	movq %rcx, %rsi	#move rcx to rsi
	call min		#call function min
	movq %rcx, %r13 #move rcx to r13
	subq %rax, %r13
	jmp convcall    #jump to convcall

convcall:
	pop %rsi        #pop from stack to rsi
	pop %rdi        #pop from stack to rdi
	push %rdi       #push to stack
	addq $1, %rdi   #rdi = rdi +1
	addq %r15, %rdi #add r15 and rdi
	subq %r12, %rdi 
	push %rsi       #push to stack
	movq %rdx, %rsi
	addq %r13, %rsi
	push %rdx       #push to stack
	movq %r12, %rdx
	subq %r13, %rdx
	push %rcx       #push to stack
	push %r8        #push to stack
	call conv       #call function conv
	jmp result 	    #jump to result

result:
	pop %r8         #pop from stack
	pop %rcx		#pop from stack
	pop %rdx        #pop from stack
	pop %rsi        #pop from stack
	pop %rdi        #pop from stack
	push %r8        #push to stack
	addq %r15, %r8  #add r15 and r8
	movb %al, (%r8)#move rax to the address of r8	
	pop %r8         #pop from stack
	incq %r15       #increment by 1 for r15
	jmp firstloop  #jump to firstloop

end:	
	ret            



