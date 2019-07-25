####################### Data segment ######################################
#Rithin Manoj(17cs10043)
#Ayush Tiwari(17CS10056)
#sem -5
#assign-1
#group-9

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
array1:
		.word 8


####################### Text segment ######################################

.text
.globl main

main:

	la $a0, get_array			# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the message
	syscall								# print the message


	la $t0, array1				#address of array1[0]
	addi $t1, $t0, 28			#address of array1[7]

GetElementLabel:

		move $t3, $t0				# $t3 contains address of array1[0]

		GELLoop:
			li $v0, 5						# for read_int
			syscall							# argument in $v0
			move $s0, $v0				# argument in $s0

			sw $s0, 0($t3)			# input stored at ($t3)
			addi $t3, $t3, 4		# $t3 points to next element

			ble $t3, $t1, GELLoop			#branch if $t1 is less than or equal to $t3

	la $a0, original_arr_msg	# message string in $a0, pseudoinstruction
	li $v0, 4									# Prepare to print the message
	syscall

	jal PrintElementLabel

	la $a0, newline					# message string in $a0, pseudoinstruction
	li $v0, 4								# Prepare to print the newline
	syscall

BubbleSortLabel:

	li $s1, 0						# $s1 = i = 0, for outer_for
	li $t9, 7						# $t9 = n-1

	outer_for:
		bge $s1, $t9, PrintAndExit		# if $s1 >= $t9 exit
		li $s2, 0
		inner_for:

			sub $s5, $t9, $s1						# $s5 = n-1-i

			bge	$s2, $s5, end_inner_for		# if $s2 >= $t9 - %s1 end_for

			sll $t4, $s2, 2							# $t4 = 4 * $s2
			add $s3, $t0, $t4						# $s3 points to a[j]

			addi $t4, $t4, 4						# $t4 = 4 * ($s2 + 1)
			add $s4, $t0, $t4						# $s4 points to a[j+1]

			lw $t7, ($s3)								# $t7 = a[j]
			lw $t8, ($s4)								# $t8 = a[j+1]

			ble $t7, $t8, noswap					# if $t7 > $t8 swap

			sw $t8, ($s3)								# a[j] = $t8
			sw $t7, ($s4)								# a[j+1] = $t7

			noswap:

			addi $s2, $s2, 1						# j = j+1
			j inner_for

		end_inner_for:
			addi $s1, $s1, 1						# i = i+1
			j outer_for


PrintElementLabel:

	move $t3, $t0					# $t3 contains address of array1[0]

	PELLoop:
  	lw $a0, ($t3)				# move value at address pointed by $t3 to $a0
		li $v0, 1						#Prepare to print the integer
		syscall

		la $a0, spac				# move address of spac to $a0
		li $v0, 4						# Prepare to print the message
		syscall

		addi $t3, $t3, 4			# point to next element
		ble $t3, $t1, PELLoop

	la $a0, newline				# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the newline
	syscall

	jr $ra

PrintAndExit:
	la $a0, sorted_arr_msg	# message string in $a0, pseudoinstruction
	li $v0, 4								# Prepare to print the message
	syscall

	jal PrintElementLabel

	j Exit

Exit:
		li $v0, 10
		syscall # exit
