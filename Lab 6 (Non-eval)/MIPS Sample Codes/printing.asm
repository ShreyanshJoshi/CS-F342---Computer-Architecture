
.data
	myCharacter: .byte 'm'	#byte is 8-bit value
	myAge: .word 20 # word is 32 bits , an integer requires 32 bits of memory
	myFloat: .float 9.99 #32 bit single precision floating point
	myDouble: .double 5.6655643333344 #64 bit double precision 
	
.text
	#Printing an integer
	li $v0,1 #load immediate and the code for printing an integer is 1
	lw $a0,myAge #load word , loads value of myAge into $a0
	syscall
	
	#Printing character
	li $v0,4 #load immediate and the code for printing a sentence or character is 4
	la $a0,myCharacter #load address of myCharacter into a0
	syscall
	
	#Printing float
	li $v0,2 #load immediate and the code for a float is 2
	lwc1 $f12,myFloat
	#load word into co-processor1 since unlike integers floats are in co-processor-1
	syscall
	
	#Printing double
	li $v0,3 # 3 is the code for printing a double
	ldc1 $f12,myDouble
	#64-bit double value will be stored in the f12 and f13 registers(2 32-bit registers)
	syscall
	
	
	