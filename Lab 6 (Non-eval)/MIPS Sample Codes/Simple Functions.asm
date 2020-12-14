.data

.text
	main:
	# $a regsiters i.e $$a1,$a2... are used for passing values(parameters) to functions
	addi $a1,$zero,10
	addi $a2,$zero,15
	jal addNumbers #Calling the function
	li $v0,1
	addi $a0,$v1,0
	syscall
	#Whenever using functions the following 2 lines are necessary
	#These two lines basically tell the processor to exit program
	li $v0,10
	syscall
	
	#Function that is going to be called
	addNumbers:
		add $v1,$a1,$a2
		#Generally $v1 registers are used for returning values
		jr $ra #go back to the function that called it