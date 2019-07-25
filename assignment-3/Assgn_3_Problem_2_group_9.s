####################### Data segment ######################################
#Rithin Manoj(17cs10043)
#Ayush Tiwari(17CS10056)
#sem -5
#assign-3
#group-9

.data

newline:
		.asciiz "\n"
prompt_array:
		.asciiz "Enter the values of array : "
prompt_size:
		.asciiz "Enter the size of array : "
prompt_window_size:
		.asciiz "Enter the size of window : "
result1:
		.asciiz "The array you entered : "
result2:
		.asciiz "The New String is : "
spac:
		.asciiz " "
newstr:
		.space 50


####################### Text segment ######################################

.text
.globl main

main:

# Prompt for array size

la $a0, prompt_size
li $v0, 4
syscall

li $v0, 5
syscall
move $t9, $v0			# $t9 stores the size of the array

# Creating Space Dynamically using sbrk system call

sll $a0, $t9, 2
li $v0, 9
syscall					# sbrk system call

move $t0, $v0			# $t0 contains &a[0]

sll $t1, $t9, 2
addi $t1, $t1, -4
add $t1, $t0, $t1		# $t1 contains &a[size-1]

# Prompt user to enter the elements of the array

la $a0, prompt_array
li $v0, 4
syscall

GetElementLabel:

		move $t3, $t0						# $t3 contains address of array1[0]

		GELLoop:
			li $v0, 5						# for read_int
			syscall							# argument in $v0
			move $s0, $v0					# argument in $s0

			sw $s0, 0($t3)					# input stored at ($t3)
			addi $t3, $t3, 4				# $t3 points to next element

			ble $t3, $t1, GELLoop			#branch if $t1 is less than or equal to $t3

	la $a0, result1							# message string in $a0, pseudoinstruction
	li $v0, 4								# Prepare to print the message
	syscall

	jal PrintElementLabel

	jal PrintNewLine


# Prompt for window size
la $a0, prompt_window_size
li $v0, 4
syscall

li $v0, 5
syscall
move $t8, $v0			# $t8 stores the size of the window


######
# Note : At this point -
# Note : $t0 points to a[0]
# Note : $t1 points to a[size-1]
# Note : $t9 stores array_size
# Note : $t8 stores window_size
######


MovingAverageLabel:

	move $s0, $t0					# $s0 stores a
	sll $t5, $t8, 2					# $t5 = 4*(window_size)
	add $s1, $s0, $t5				# $s1 stores a + window_size
	move $s3, $zero					# $s3 will store intermediate sums

	LoopForFirstSum:

		beq $s0, $s1, EndLoopForFirstSum		# if pointer reaces a + i + window_size end for loop

		lw $t5, 0($s0)							# $t5 = *($s0)
		add $s3, $s3, $t5						# accumulate sum
		addi $s0, $s0, 4						# move pointer forward

		j LoopForFirstSum

	EndLoopForFirstSum:

	move $s0, $t0 					# $s0 points to a[0]
	addi $t1, $t1, 4				# $t1 points to a[size]

	#########
	# At this point :
	# $s0 -> a[0]
	# $s1 -> a[window_size]
	# $t1 -> a[array_size]
	#########

	SecondLoop:

		lw $t5, 0($s0)					# t5 contains a[i]

		move $s4, $s3					# s4 contains sum (a[i] to a[i+window_size-1])

		div $s4, $t8
		mflo $s4						# s4 contains int ( $s4 / window_size )

		sw $s4, 0($s0)					# a[i] = int(sum(a[i] to a[i+window_size-1])/ window_size)

		beq $s1, $t1, EndSecondLoop		# Check if a + i + window_size == a + size

		lw $t6, 0($s1)					# move value at a + i + window_size to $t6

		sub $s3, $s3, $t5				# sum = sum - a[i]
	 	add $s3, $s3, $t6				# sum = sum + a[i+window_size]

		addi $s0, $s0, 4				# $s0 points to a + i + 1
		addi $s1, $s1, 4				# $s1 points to a + i + window_size + 1

		j SecondLoop

	EndSecondLoop:
		move $t1, $s0
	jal PrintNewLine
	jal PrintElementLabel
	jal PrintNewLine


Exit:
	li $v0, 10
	syscall # exit

PrintElementLabel:

	move $t3, $t0						# $t3 contains address of array1[0]

	PELLoop:
  	lw $a0, ($t3)						# move value at address pointed by $t3 to $a0
		li $v0, 1						#Prepare to print the integer
		syscall

		la $a0, spac					# move address of spac to $a0
		li $v0, 4						# Prepare to print the message
		syscall

		addi $t3, $t3, 4				# point to next element
		ble $t3, $t1, PELLoop

	la $a0, newline						# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the newline
	syscall

	jr $ra

PrintNewLine:

	la $a0, newline							# message string in $a0, pseudoinstruction
	li $v0, 4								# Prepare to print the newline
	syscall

	jr $ra
