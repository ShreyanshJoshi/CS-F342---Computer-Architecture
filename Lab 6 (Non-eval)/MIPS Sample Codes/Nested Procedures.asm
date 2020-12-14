.data
	newLine: .asciiz "\n"
.text
	main:
	addi $s0,$zero,45
	jal increaseNumber #Calling the function
	
	#Print a new line
	li $v0,4
	la $a0,newLine
	syscall
	
	#Exit:
	li $v0,10
	syscall

	#Function that is going to be called
	increaseNumber:
		#Since we want to work with the value in $s0 register we have to first save it on the stack
		#Following two lines of code does it
		addi $sp,$sp,-8
		sw $s0,0($sp)
		sw $ra,4($sp)
		#Once we have saved it in the stack we can work with the $s0 register
		addi $s0,$s0,15
		jal printFunction
		#Now we restore the value of $s0 from the stack
		lw $ra,4($sp)
		lw $s0,0($sp)
		addi $sp,$sp,8
		#Generally $v1 registers are used for returning values
		jr $ra #go back to the function that called it
		printFunction:
			li $v0,1
			addi $a0,$s0,0
			syscall
			jr $ra