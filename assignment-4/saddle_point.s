####################### Data segment ######################################
#Rithin Manoj(17cs10043)
#Ayush Tiwari(17CS10056)
#sem -5
#assign-1
#group-9

.data
get_matrix:
                .asciiz "Enter the 16 elements of the the matrix in row major format : "
newline:
                .asciiz "\n"
display_matrix:
				.asciiz "The matrix you entered : "
result1:
                .asciiz "Saddle Points : "
spac:
                .asciiz " "
matrix:
                .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16


####################### Text segment ######################################

.text
.globl main

main:

	la $a0, get_matrix           # Loat address of message to get the elements of matrix
    	li $v0, 4                    # Prepare to pring string
    	syscall                      # syscall for printing
    	
    	
    	#### Call Print Matrix
	
	la $a0, matrix			# load matrix address into $a0 for passing to PrintMatrix
	jal PrintMatrix
	
	######
	
	#### Call Find Saddle Points
	
	la $a0, matrix
	jal FindSaddlePoints
	
	######
	
	j Exit
	
FindSaddlePoints:
	
	move $s0, $a0 			# $s0 now points to the matrix
	li $s1, 4			# $s1 now stores the value of n
	
	##########
	# Finding horizontal maximums
	
	# $t0 = i
	# $t1 = j
	# $t3 = k
	
	li $t0, 0
	
	j CheckOuterLoop
	
	InnerLoopInit:
		
		
	
	
	CheckOuterLoop:
		
		blt $t0, $s1, InnerLoopInit
		
	
	#
	#########
	
	
PrintMatrix:
	
	move $t0, $a0			# $t0 points to matrix[0]
	addi $t1, $a0, 64		# $t1 points to matrix[16]
	
	li $t8, 4
	li $t9, 0
	li $t5, 10
	
	j PrintMatrixCondition
	
	PrintMatrixLoop:
		
		##########
		# For neatly displaying the matrix
		
		div $t9, $t8
		mfhi $t7
		
		beq $t7, $zero, NewLine # If remainder is zero print newline
        	
        	j SkipNewLine
        	
        	NewLine:	
		
			la $a0, newline		# This is for printing
        		li $v0, 4		# new line
        		syscall			# 
        	
        	SkipNewLine:
      			addi $t9, $t9, 1
      			
      		lw $a0, 0($t0)		# load the value of matrix[i]
		
		bge $a0, $t5, SkipPrevSpace
		
		la $a0, spac		# This is for printing
        	li $v0, 4		# space
        	syscall
		
		SkipPrevSpace:
		
		lw $a0, 0($t0)
		li $v0, 1		# $v0 = 1, for printing integer
		syscall
		
		la $a0, spac		# This is for printing
        	li $v0, 4		# space
        	syscall
        	#
        	##########
		
		addi $t0, $t0, 4	# point to next element
	
	PrintMatrixCondition:
		
		bne $t0, $t1, PrintMatrixLoop
	
	jr $ra

Exit:

    	li $v0, 10
    	syscall
    	
PrintNewLine:

        la $a0, newline
	li $v0, 4
	syscall



        jr $ra


