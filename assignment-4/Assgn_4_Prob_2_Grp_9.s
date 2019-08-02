################################################
#Courtesy : Deepank Agarwal
#
#Assignment No.: 4
#Problem No.: 2
#Autumn 2019
#Group No.: 9
#Rithin Manoj
#Ayush Tiwari
##########Data Segment##########################
.data
	array: .space 64
	print_input: .asciiz "Enter the 4x4 2D-array: \n"
	print_output_failed: .asciiz "\nNo Saddle point in the 2D-array.\n"
	print_output_success: .asciiz "\nSaddle point: \n"
	newline: .asciiz "\n"
	space: .asciiz ", "
	saddle_point_indicator: .word 1
.text

main:

	li $t0, 1
	sw $t0, saddle_point_indicator

	la $a0, print_input
	li $v0, 4
	syscall

	jal read_array

	la $a0, array 	# load array in the arguement of function
	jal FindSaddle 	# function call

	lw $t0, saddle_point_indicator

	beq $t0, $zero, Exit

	PrintFailure:
		la $a0, print_output_failed
		li $v0, 4
		syscall

	j Exit

read_array:
    li $t0, 0       # count variable j
    li $t2, 16  	# loads n
    la $t1, array   # load array pointer in register
    li $t3, 0
    b readLoop
end_read:
    jr $ra

readLoop:
    beq $t0, $t2, end_read   	# branch if equal to 16, 16 items
    li $v0, 5           		# read int
    syscall

    move $t4, $v0       		# store input in array
	sw $t4, 0($t1)
    add $t1, $t1, 4
    addi $t0, $t0, 1   			# add by 1 to count
    b readLoop

FindSaddle:
	addi $sp, $sp, -12

	sw $s2, 0($sp) 				# max
	sw $s1, 4($sp)				# min
	sw $s0, 8($sp)				# array

	# Find the max in row, min in col saddle point
	max_in_row:
		li $t2, 0						# i = 0
		Loop_i:
			li $t3, 4					# j = 1
			la $a0, array 				# load array
			move $s0, $a0				# store array pointer on stack
			add $t0, $s0, $t2
			lw $s0, 0($t0)				# s0 = array[i][0] = max
			li $s3, 0					# index of max
			li $t7, 0					# count for unique

			loop_j:
				add $t1, $t0, $t3						# t0 = &array[i][j]
				lw $t4, 0($t1)							# t4 = array[i][j]
				beq $t4, $s0, max_not_unique_in_row		# if max is not unique ==> count++
				bgt $t4, $s0, update_max 				# t4 > max, update_max, count = 0
				iter_j:
					addi $t3, 4							# j = j + 1
					beq $t3, 16, end_loop_i
				b loop_j
			end_loop_i:
				beq $t7, $zero, min_in_col 				# check if max is unique, check the element in the column for unique min
				return_to_Loop_i:
					addi $t2, 16
					beq $t2, 64, min_in_row 			# vice versa definition of saddle point
					b Loop_i

	min_in_col:
		li $t0, 16				# t0 ==> row iterator
		la $s0, array 			# load array
		add $s0, $s0, $s3		# move the pointer to the column of the max in row
		lw $s1, 0($s0)  		# s1 = min
		li $s4, 0				# store row index of min
		loop_min_col:			# iterate over the array in the column
			add $t3, $s0, $t0
			lw $t1, 0($t3)
			beq $t1, $s1, min_not_unique_in_col 	# increment count if min = array[i][j]
			blt $t1, $s1, update_min 				# update min, count = 0
			iter_min_j:
				addi $t0, 16
				beq $t0, 64, end_min_col_loop
			b loop_min_col
		end_min_col_loop:
			bgt $t7, $zero, return_to_Loop_i 		# print if count = 0, else move back to max in row
			beq $s4, $t2, print_point
			b return_to_Loop_i

	# Find the min in row, max in col saddle point
	min_in_row:
		li $t2, 0						# i = 0
		min_Loop_i:
			li $t3, 4					# j = 1
			la $a0, array 				# load array
			move $s0, $a0				# store array pointer on stack
			add $t0, $s0, $t2
			lw $s0, 0($t0)				# s0 = array[i][0] = min
			li $s3, 0					# index of min
			li $t7, 0					# count for unique
			min_loop_j:
				add $t1, $t0, $t3						# t0 = &array[i][j]
				lw $t4, 0($t1)							# t0 = &array[i][j]
				beq $t4, $s0, min_not_unique_in_row		# if min is not unique ==> count++
				blt $t4, $s0, update_min_row 			# t4 < min, update min, count = 0
				min_iter_j:
					addi $t3, 4							# j = j + 1
					beq $t3, 16, min_end_loop_i
				b min_loop_j
			min_end_loop_i:
				beq $t7, $zero, max_in_col 				# check if min is unique, check the element in the column for unique max
				min_return_to_Loop_i:
					addi $t2, 16
					beq $t2, 64, end_FindSaddle			# end the function and return to main
					b min_Loop_i

	max_in_col:
		li $t0, 16				# t0 ==> row iterator
		la $s0, array 			# load array
		add $s0, $s0, $s3		# move the pointer to the column of the min in row
		lw $s1, 0($s0)  		# s1 = max
		li $s4, 0				# row index of max
		max_loop_col:			# iterate over the array in the column
			add $t3, $s0, $t0
			lw $t1, 0($t3)
			beq $t1, $s1, max_not_unique_in_col		# increment count if max = array[i][j]
			bgt $t1, $s1, update_max_col			# update max, count = 0
			max_iter_j:
				addi $t0, 16
				beq $t0, 64, max_end_col_loop
			b max_loop_col
		max_end_col_loop:
			bgt $t7, $zero, min_return_to_Loop_i	# print if count = 0, else move back to min in row
			beq $s4, $t2, print_point_min
			b min_return_to_Loop_i

	end_FindSaddle:					# return to main
		addi $sp, $sp, 12			# clear the stack
		jr $ra 						# return address

# Print functions
print_point:

	sw $zero, saddle_point_indicator

	la $a0, print_output_success
	li $v0, 4
	syscall

	srl $a0, $t2, 4 			# print row index
	li $v0, 1
	syscall

	la $a0, space
	li $v0, 4
	syscall

	srl $a0, $s3, 2				# print column index
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	move $a0, $s1				# print the value of the saddle point
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	b return_to_Loop_i

print_point_min:

	sw $zero, saddle_point_indicator

	la $a0, print_output_success
	li $v0, 4
	syscall

	srl $a0, $t2, 4				# print row index
	li $v0, 1
	syscall

	la $a0, space
	li $v0, 4
	syscall

	srl $a0, $s3, 2				# print col index
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	move $a0, $s1				# print the value of the saddle point
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	b min_return_to_Loop_i

# count updation branches
max_not_unique_in_row:
	addi $t7, 1
	b iter_j

min_not_unique_in_col:
	addi $t7, 1
	b iter_min_j

min_not_unique_in_row:
	addi $t7, 1
	b min_iter_j

max_not_unique_in_col:
	addi $t7, 1
	b max_iter_j

# update max and min functions, also store the index of max and min, count = 0 for new max or min
update_min:
	move $s1, $t1
	move $s4, $t0
	move $t7, $zero
	b iter_min_j

update_max:
	move $s0, $t4
	move $s3, $t3
	move $t7, $zero
	b iter_j

update_max_col:
	move $s1, $t1
	move $s4, $t0
	move $t7, $zero
	b max_iter_j

update_min_row:
	move $s0, $t4
	move $s3, $t3
	move $t7, $zero
	b min_iter_j

Exit:
    li $v0, 10
    syscall # exit
