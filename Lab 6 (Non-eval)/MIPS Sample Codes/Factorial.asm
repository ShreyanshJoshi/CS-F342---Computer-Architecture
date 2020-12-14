.data
	prompt: .asciiz "Enter N"
	result: .ascii "\nFactorial is: "
	num: .word 0
	answer: .word 0
.text
	main:
		#prompt for N
		li $v0,4
		la $a0, prompt
		syscall
		
		#input N
		li $v0, 5
		syscall
		sw $v0, num
		
		#call procedure
		lw $a0, num
		jal findFactorial
		sw $v0, answer
		
		#display answer
		li $v0, 4
		la $a0, result
		syscall
		li $v0, 1
		lw $a0, answer
		syscall
		
		#exit
		li $v0, 10
		syscall
		
		findFactorial:
			subu $sp, $sp, 8
			sw $ra, ($sp)
			sw $s0, 4($sp)
			
			#check for base case
			li $v0, 1
			beq $a0, 0, factorialDone
			
			#else do recursion to get (N-1)!
			move $s0, $a0
			sub $a0, $a0, 1
			jal findFactorial
			
			#multiply with N after recursion ends
			mul $v0, $s0, $v0
			
			factorialDone:
				lw $ra, ($sp)
				lw $s0, 4($sp)
				addu $sp, $sp, 8
				jr $ra
		