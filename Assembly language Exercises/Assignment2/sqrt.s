	.globl sqrt
	
# Shifting nth root algorithm (Digit-by-digit calculation)
# %edi will contain the argument x. 
# %eax will carry the return value
sqrt:
	
	movq $0, %rax   # set rax to be 0
	
	movq $0x8000, %rdx # set 16th bit set to be 1

	movq $15, %rcx # set the counter to be 15 fo bit counts later
	
	jmp loop # jump to the loop

loop:

	orq %rdx, %rax # set 16th bit of rax to 1
	
	movq %rax, %rsi # move rax to rsi, which is a temporal variable
	
	imulq %rax, %rsi # Multiply rax and rsi, set rsi = rax*rsi
	
	cmpq %rsi, %rdi # compare rsi to the argument x
	
	jl settozero # if rsi < rdi, jump to settozero loop
	
	decq %rcx # decrease counter to the next bit

	shrq $1, %rdx # righ shift 1 to make next  bit in rdx to be 1 
	
	cmpq $0, %rcx # compare 0 to counter
	
	jge loop # if counter >= 0 , more bits to go, jump back to the loop
	
	jmp result # if counter < 0, jump to result

settozero:
	
	xorq %rdx, %rax # both rdx and rax kth bits are 1, thus xor set current bit to 0
	 						   
	shrq $1, %rdx # righ shift 1 to make next  bit in rdx to be 1 

	decq %rcx # decrement counter variable to the next bit
		
	jmp loop # jump back to loop to check next bit

result:
	
	ret # return the results in rax