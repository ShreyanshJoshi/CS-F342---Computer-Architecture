.data
	num1: .word 5
	num2: .word 10
.text
	#Addition
	lw $t0,num1 #Get value of num1 into $t0
	lw $t1,num2 #Get value of num2 into $t1
	add $t2,$t0,$t1 #$t2 = $t0 + $t1
	#Printing the result
	li $v0,1
	move $a0,$t2 #move contents of $t2 into $a0
	syscall
	
	#Subtraction
	lw $t0,num1 #Get value of num1 into $t0
	lw $t1,num2 #Get value of num2 into $t1
	sub $t2,$t0,$t1 #$t2 = $t0 - $t1
	#Printing the result
	li $v0,1
	move $a0,$t2 #move contents of $t2 into $a0
	syscall
	
	#Multiplication using Mul
	mul $t2,$t0,$t1 #mul can multiply only two 16 bit-numbers
	#Printing the result
	li $v0,1
	move $a0,$t2 #move contents of $t2 into $a0
	syscall
	
	#Multiplication using Mult
	mult $t0,$t1 #$t0 = $s0*$s1
	#Printing the result
	#Register $lo will contain the lower 32 bits of the result
	#Register $hi will contain the higher 32 bits of the result
	li $v0,1
	mflo $t2 #move contents of lo into t0
	move $a0,$t2 #move contents of $t2 into $a0
	syscall
	
	#Shift left logical
	sll $t2,$t0,2
	#sll shifts the value stored in $s0 by 2 bits to the left,i.e multiply by 4
	#Print the result
	li $v0,1
	add $a0,$zero,$t2 #move contents of $t2 into $a0
	syscall
	
	
	#Division using div
	addi $s0,$zero,30
	addi $s1,$zero,10
	div  $s2,$s0,$s1
	#s2 = s0/s1
	#Print the result
	li $v0,1
	add $a0,$zero,$s2 #move contents of $s2 into $a0
	syscall
	
	#Another way to do division is by using HI and LO registers
	div $s0,$s1
	#Here lo will have the quotient and hi will have remainder
	mflo $t0
	mfhi $t1
	#Print the quotient
	li $v0,1
	add $a0,$zero,$t0 #move contents of $s2 into $a0
	syscall
	#Print the remainder
	li $v0,1
	add $a0,$zero,$t1 #move contents of $s2 into $a0
	syscall
	
	
	