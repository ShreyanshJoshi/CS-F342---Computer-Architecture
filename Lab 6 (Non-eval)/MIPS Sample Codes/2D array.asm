.data
	array: .word 1, 2, 3
		.word 4, 5, 6
		.word 7, 8, 9
	size: .word 3
	.eqv DATA_SIZE 4
.text
	la $a0, array
	lw $a1, size
	jal sumDiagonal
	move $a0, $v0
	li $v0, 1
	syscall
	
	#exit
	li $v0, 10
	syscall
	
	sumDiagonal:
		li $v0, 0 #sum=0
		li $t0, 0 #i=0
		
		loop:
			# Addr of element = (rowIndex*size + colIndex)*DATA_SIZE + BaseAddress
			mul $t1, $t0, $a1
			add $t1, $t1, $t0
			mul $t1, $t1, DATA_SIZE
			add $t1, $t1, $a0
			
			#Get the element and add it to sum. Sum=Sum+element 
			lw $t2, ($t1)
			add $v0, $v0, $t2
			
			#increment, check condition and loop
			addi $t0, $t0, 1
			blt $t0, $a1, loop
		jr $ra
		
		