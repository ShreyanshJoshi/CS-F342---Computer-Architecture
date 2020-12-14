.data
	prompt: .asciiz "Enter your age:"
	message: .asciiz " \n Your age is:"
.text
	li $v0,4
	la $a0,prompt
	syscall
	
	#To get the integer input
	li $v0,5
	syscall
	
	#move the age into $t0
	move $t0,$v0
	#To print the message
	li $v0,4
	la $a0,message
	syscall
	li $v0,1
	move $a0,$t0
	syscall
