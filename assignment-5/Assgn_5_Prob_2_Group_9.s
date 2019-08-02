####################### Data segment ######################################

.data
get_array:
		.asciiz "Enter the 8 elements of the array : "
newline:
		.asciiz "\n"
result1:
		.asciiz "array in ascending order."
spac:
		.asciiz " "
original_arr_msg:
		.asciiz "The array you entered : "
sorted_arr_msg:
		.asciiz "The sorted array is : "
array:
		.word 0, 0, 0, 0, 0, 0, 0, 0				# Declare and initialize array


####################### Text segment ######################################

.text
.globl main

main:

	la $a0, get_array				# message string in $a0, pseudoinstruction
	li $v0, 4						# Prepare to print the message
	syscall							# print the message

	####### Calling GetElementFunction

	la $s0, array				#address of array1[0]
	addi $s1, $s0, 32			#address of array1[8]

	move $a0, $s0				# to pass &array[0] as parameter
	move $a1, $s1				# to pass &array[7] as parameter

	jal GetElementFunction

	la $a0, original_arr_msg	# message string in $a0, pseudoinstruction
	li $v0, 4									# Prepare to print the message
	syscall

	#########

	####### Calling PrintElementFunction

	la $s0, array				#address of array1[0]
	addi $s1, $s0, 32			#address of array1[8]

	move $a0, $s0				# to pass &array[0] as parameter
	move $a1, $s1				# to pass &array[7] as parameter

	jal PrintElementFunction				# call PrintElementFunction

	#######


	####### Print NewLine

	la $a0, newline							# message string in $a0, pseudoinstruction
	li $v0, 4								# Prepare to print the newline
	syscall

	#######


	#
	# ####### Print NewLine
	#
	# la $a0, newline							# message string in $a0, pseudoinstruction
	# li $v0, 4								# Prepare to print the newline
	# syscall
	#
	# #######



	####### Calling PrintElementFunction

	la $s0, array				#address of array1[0]
	addi $s1, $s0, 32			#address of array1[8]

	move $a0, $s0				# to pass &array[0] as parameter
	move $a1, $s1				# to pass &array[7] as parameter

	jal PrintElementFunction				# call PrintElementFunction

	#######

	####### Print NewLine

	la $a0, newline							# message string in $a0, pseudoinstruction
	li $v0, 4								# Prepare to print the newline
	syscall

	#######

	##########*********
	####### Calling QuickSortFunction

	la $s0, array				#address of array1[0]
	addi $s1, $s0, 32			#address of array1[8]

	move $a0, $s0
	li $a1, 0					# to pass &array[0] as parameter
	li $a2, 7					# to pass &array[7] as parameter

	jal QuickSortFunction		# call PrintElementFunction

	#######
	############*******



	####### Calling PrintElementFunction

	la $s0, array				#address of array1[0]
	addi $s1, $s0, 32			#address of array1[8]

	move $a0, $s0				# to pass &array[0] as parameter
	move $a1, $s1				# to pass &array[7] as parameter

	jal PrintElementFunction				# call PrintElementFunction

	#######

	####### Print NewLine

	la $a0, newline							# message string in $a0, pseudoinstruction
	li $v0, 4								# Prepare to print the newline
	syscall

	#######

	j Exit


QuickSortFunction:
	la $s0, array							# $s0 now points to a[0]
	move $t8, $a1							# $t8 = p
	move $t9, $a2							# $t9 = r

	blt $t8, $t9, Continue
	jr $ra

	Continue:

	######## Saving the values in stack

	addi $sp, $sp, -16						# Create space in stack
	sw $t8, 0($sp)							# store the value of p
	sw $t9, 4($sp)							# store the value of r
	sw $ra, 8($sp)							# store the return address

	########

	####### Calling PartitionFunction

	la $s0, array				# address of array1[0]
	move $a0, $s0				# to pass &array[0] as parameter

	lw $s1, 0($sp)				# $s1 = p
	lw $s2, 4($sp)				# $s2 = r

	move $a1, $s1				# $a1 = p
	move $a2, $s2				# $a2 = r

	jal PartitionFunction

	######

	move $t0, $v0				# return value of PartitionFunction
	sw $t0, 12($sp)				# store the value of q in PartitionFunction

	####### Calling QuickSortFunction1

	la $s0, array				# address of array1[0]
	move $a0, $s0				# to pass &array[0] as parameter

	lw $s1, 0($sp)				# $s1 = p
	lw $s2, 12($sp)				# $s2 = q
	addi $s2, $s2, -1			# $s2 = q-1

	move $a1, $s1
	move $a2, $s2

	jal QuickSortFunction

	######

	####### Calling QuickSortFunction2

	la $s0, array				# address of array1[0]
	move $a0, $s0				# to pass &array[0] as parameter

	lw $s1, 12($sp)				# $s1 = q
	lw $s2, 4($sp)				# $s2 = r
	addi $s1, $s1, 1			# $s1 = q+1

	move $a1, $s1
	move $a2, $s2

	jal QuickSortFunction

	######

	lw $ra, 8($sp)
	addi $sp, $sp, 16

	jr $ra



PartitionFunction:

	move $s0, $a0							# $s0 now points to a[0]
	move $t8, $a1							# $t8 = p
	move $t9, $a2							# $t9 = r

	addi $t7, $t8, -1						# $t7 = i = p-1

	###### Calculation for A[r]

	sll $t5, $t9, 2							# $t5 = 4*r
	add $s1, $s0, $t5						# $s1 = $s0 + 4*r = &A[r]
	lw $t5, 0($s1)
	move $s1, $t5							# $s1 = x

	######

	###### $s0 = &array[0]
	###### $t7 = i
	###### $s1 = x

	move $t6, $t8							# $t6 = j = p

	###### $t6 = j

	j CheckPLoop

	PLoop:
		sll $t5, $t6, 2						# $t5 = 4*j
		add $t5, $s0, $t5					# $t5 = &A[j]

		lw $t4, 0($t5)						# $t4 = A[j]

		bgt $t4, $s1, SkipSwap				# if A[j] > x skip swap

		######## Swap(A[i], A[j])

		addi $t7, $t7, 1					# i=i+1

		sll $t3, $t7, 2						# $t3 = 4*i
		add $t3, $s0, $t3					# $t3 = &A[i]

		lw $t2, 0($t3)						# $t2 = A[i]

		sw $t2, 0($t5)
		sw $t4, 0($t3)

		#########

		SkipSwap:
			addi $t6, $t6, 1				# j=j+1

	CheckPLoop:
		blt $t6, $t9, PLoop

		####### Swap A[i+1], A[r]

		sll $t5, $t9, 2						# $t5 = 4*r
		add $t5, $s0, $t5					# $t5 = &A[j]

		lw $t4, 0($t5)						# $t4 = A[j]

		addi $t7, $t7, 1					# i=i+1

		sll $t3, $t7, 2						# $t3 = 4*i
		add $t3, $s0, $t3					# $t3 = &A[i]

		lw $t2, 0($t3)						# $t2 = A[i]

		sw $t2, 0($t5)
		sw $t4, 0($t3)

		########

	move $v0, $t7							# return i+1

	jr $ra

GetElementFunction:

		move $t0, $a0
		move $t1, $a1

		move $t3, $t0						# $t3 contains address of array1[0]

		GELLoop:
			li $v0, 5						# for read_int
			syscall							# argument in $v0
			move $t9, $v0					# argument in $s0

			sw $t9, 0($t3)					# input stored at ($t3)
			addi $t3, $t3, 4				# $t3 points to next element

			blt $t3, $t1, GELLoop			#branch if $t1 is less than or equal to $t3

		jr $ra


PrintElementFunction:

	move $t0, $a0
	move $t1, $a1

	move $t3, $t0					# $t3 contains address of array1[0]

	PELLoop:
  		lw $a0, 0($t3)				# move value at address pointed by $t3 to $a0
		li $v0, 1						#Prepare to print the integer
		syscall

		la $a0, spac				# move address of spac to $a0
		li $v0, 4						# Prepare to print the message
		syscall

		addi $t3, $t3, 4			# point to next element
		blt $t3, $t1, PELLoop

	la $a0, newline				# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the newline
	syscall

	jr $ra

PrintAndExit:
	la $a0, sorted_arr_msg	# message string in $a0, pseudoinstruction
	li $v0, 4								# Prepare to print the message
	syscall

	jal PrintElementFunction

	j Exit

Exit:
		li $v0, 10
		syscall # exit
