####################### Data segment ######################################
#Rithin Manoj(17cs10043)
#Ayush Tiwari(17CS10056)
#sem -5
#assign-1
#group-9

.data
get_array:
		.asciiz "Enter the 8 elements of the array in ascending order : "
get_query:
		.asciiz "Enter the element to search for : "
newline:
		.asciiz "\n"
ascending_check:
		.asciiz "Error : elements not in ascending order"
result1:
		.asciiz "The element was found."
result2:
		.asciiz "Element not found!"
spac:
		.asciiz " "
array1:
		.word 8


####################### Text segment ######################################

.text
.globl main

main:

	la $a0, get_array			# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the message
	syscall								# print the message


	la $t1, array1				# $t1 is pointing to a[0]
	move $t0, $t1					# $t0 is pointing to a[0]
	addi $t3, $t1, 32			# $t3 is pointing to the end of array


	GetElementLoop:

		li $v0, 5						# for read_int
		syscall							# argument in $v0
		move $t2, $v0				# argument in $t0

		sw $t2, 0($t0)			# *($t0) = $t2
		addi $t0, $t0, 4		# $t0 points to next element

		bne $t0, $t3, GetElementLoop		# loop condition

	move $t0, $t1					# ($t0) points to a[0]

	PrintElementLoop:

	  lw $a0, ($t0)				# $a0 contains the value stored at address $t0
		li $v0, 1						# prepare to print int
		syscall

		la $a0, spac				# message string in $a0, pseudoinstruction
		li $v0, 4						# Prepare to print the message
		syscall

    addi $t0, $t0, 4		# $t0 points to the next element
		bne $t0, $t3, PrintElementLoop # loop until $t0 == $t3

	  la $a0, newline			# message string in $a0, pseudoinstruction
		li $v0, 4						# Prepare to print the newline
		syscall

	move $t0, $t1					# $t0 points to a[0]
	addi $t0, $t0, 4			# $t0 points to a[1]

	CheckAscending:

		lw $t4, ($t0)								# $t4 contains a[i]
		lw $t5, -4($t0)							# $t5 contains a[i-1]
		blt $t4, $t5 , Exit1				# exit if $t4 < $t5
		addi $t0, $t0, 4						# $t0 points to next element
		bne $t0, $t3, CheckAscending		#loop until $t0 == $t3


	la $a0, newline				# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the message
	syscall

	la $a0, get_query			# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the message
	syscall

	li $v0, 5							# prepare to read integer
	syscall								# read and store integer in $v0
	move $t4, $v0					# $t4 contains the read integer

	li $t5, 0
	li $t6, 7

	BinarySearchLoop:


		bgt $t5, $t6, ExitFailure			# if $t5 > $t6 exit with failure message
		sub $t7, $t6, $t5							# Calculate the
		sra $t7, $t7, 1								# Value
		add $t7, $t5, $t7							# of
		sll $t3, $t7, 2								# mid
		add $t8, $t1, $t3							# $t8 points to a[mid]
		lw $t9, ($t8)									# $t9 contains value a[mid]
		beq $t9, $t4, ExitSuccess			# exit with success message if a[mid] = query
		bgt $t9, $t4,LessThan 				# if a[mid] > query

		GreaterThan:

		  addi $t7, $t7, 1						# Start searching
			move $t5, $t7								# in higher
			j BinarySearchLoop					# part

		LessThan:

		    addi $t7, $t7, -1					# Start Searching
    		move $t6, $t7							# in lower
    		j BinarySearchLoop				# part

#exit()

Exit:

    li $v0, 10
    syscall # exit


Exit1:
	la $a0, ascending_check			# message string in $a0, pseudoinstruction
	li $v0, 4										# Prepare to print the message
	syscall
	j Exit

ExitSuccess:
	la $a0, result1							# message string in $a0, pseudoinstruction
	li $v0, 4										# Prepare to print the message
	syscall

	la $a0, newline				# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the message
	syscall

	move $a0,$t7
	li $v0,1
	syscall

	la $a0, newline				# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the message
	syscall

	j Exit

ExitFailure:
	la $a0, result2				# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the message
	syscall
	j Exit
