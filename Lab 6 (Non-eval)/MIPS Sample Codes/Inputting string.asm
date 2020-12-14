.data
	userInput: .space 20
.text
	#To get the input
	li $v0,8
	la $a0,userInput
	la $a1,20
	syscall
	#To print the input
	li $v0,4
	la $a0,userInput
	syscall 