#This algorithm tryies to add bigger number to the other to have less loops. 
#For example, if a>b, we choose a as the base ,add a for b times. 
#If b>a, then we choose b as the base ,add b for a times.

	.globl times
times:

	mov	$0, %eax	#set result to 0
	mov	$0, %ecx	#set ecx to 0
	cmpl	%edi, %esi	#Check if b is greater than a
	jg	first		#run first loop if b is greater than a

first:	cmpl	%ecx, %edi	#check if b is added to result a times
	jle	end1
	addl	%esi, %eax	#add b to result
	incl	%ecx		#increase result
	jmp	first  #run first loop
end1:
	ret #return

second:	cmpl	%ecx, %esi	#Check if a is added to result b times
	jle	end2
	addl	%edi, %eax	#add a to the result
	incl	%ecx		#increase result
	jmp	second #run second loop
end2:
	ret #return