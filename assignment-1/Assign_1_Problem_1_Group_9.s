####################### Data segment ######################################
#Rithin Manoj(17cs10043)
#Ayush Tiwari(17CS10056)
#sem -5
#assign-1
#group-9

.data
msg_input:   
		.asciiz "Enter the arguments (positive numbers): "
msg_result:   
		.asciiz "The gcd is: "
newline:   
		.asciiz "\n"



####################### Text segment ######################################

.text 
.globl main

main:
		
	la $a0, msg_input	# message string in $a0, pseudoinstruction
	li $v0, 4			# Prepare to print the message
	syscall				# print the message


	li $v0, 5			# for read_int
	syscall				# argument in $v0
	move $t0, $v0		# argument in $t0

	li $v0, 5			# for read_int
	syscall				# argument in $v0
	move $t1, $v0		# argument in $t1

	blt $t0, $zero, Exit
	blt $t1, $zero, Exit

	la $a0, msg_result	# message string in $a0, pseudoinstruction
	li $v0, 4			# Prepare to print the message
	syscall				# print the message

	beq $t0, $zero, PrintBAndExit  # if a==0 : print b and exit

	Loop:
        
        bgt $t0, $t1, AtoB		 # if a > b : a = a-b
		bge $t1, $t0, BtoA		 # if b >= a : b = b-a

		AtoB:
			sub $t0, $t0, $t1		# a = a-b 		
			bgt $t1, $zero, Loop	# if b > 0 : continue

		BtoA:
			sub $t1, $t1, $t0		# b = b-a
			bgt $t1, $zero, Loop	# if b > 0 : continue


#Print a, exit()
PrintAAndExit:
	move $a0, $t0
	li $v0, 1
	syscall
	j Exit

#Print b, exit()
PrintBAndExit:

	move $a0, $t1
	li $v0, 1
	syscall
	j Exit

#exit()		
Exit:
    li $v0, 10
    syscall # exit
