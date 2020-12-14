.data 
	myArray: .space 12 #3 numbers 4 bytes each
	newLine: .asciiz "\n"
	Array2: .word 200:3
.text
	main:
	addi $s0, $zero, 1
	addi $s1, $zero, 2
	addi $s2, $zero, 3
	
	#We take the index as t0 - initialize to 0
	addi $t0, $zero, 0
	
	sw $s0, myArray($t0)
	addi $t0, $t0, 4
	sw $s1, myArray($t0)
	addi $t0, $t0, 4
	sw $s2, myArray($t0)
	addi $t0, $t0, 4
	
	#Again take the index as t0 - initialize to 0
	addi $t0, $zero, 0
	
	while:
		beq $t0, 12, exit
		
		lw $t6, myArray($t0)
		addi $t0, $t0, 4
		
		#Print it
		li $v0, 1
		move $a0, $t6
		syscall
		#Print newline
		li $v0, 4
		la $a0, newLine
		syscall
		
		j while
	exit: