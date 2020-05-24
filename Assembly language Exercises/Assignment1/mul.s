.globl times

times:
	mov $0, %eax #set the returning register to be 0
	mov $0, %ecx #set a temporary register to be 0
loop: #label the begining of the loop
	cmp %esi, %ecx #Compare the temporary register to the argument b
	jge final #jump to the end if the temporary value is greater or equal to b
	add %edi, %eax #add argument a to the returning value
	inc %ecx #increase the temporary register by one
	jmp loop #jump to the start of the loop
	
final:
	ret #return the answer