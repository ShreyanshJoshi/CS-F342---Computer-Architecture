#Printing Hello world
.data
	mymessage: .asciiz "Hello World \n"
.text
	li $v0,4 #load immediate and the code for printing a sentence or character is 4
	la $a0,mymessage #load address of “mymessage” into a0
	syscall