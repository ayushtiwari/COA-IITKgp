####################### Data segment ######################################
#Rithin Manoj(17cs10043)
#Ayush Tiwari(17CS10056)
#sem -5
#assign-3
#group-9

.data
str:
		.asciiz "JingleBELLSjinglebellstoMato MonkeySuvaWEWE20"
newline:
		.asciiz "\n"
original_msg:
		.asciiz "Original String : "

result1:
		.asciiz "Converted String : "

result2:
		.asciiz "The New String is : "

old_address:
		.asciiz "The old address is : "

new_address:
		.asciiz "The new address is : "

spac:
		.asciiz " "

newstr:
		.space 50


####################### Text segment ######################################

.text
.globl main

main:

	la $a0, original_msg				# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the message
	syscall								# print the message

	la $a0, str							# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the message
	syscall								# print the message

	la $a0, newline						# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the message
	syscall

la $s0, str 							# load address of str to $s0

LowerCaseLabel:

	move $t0, $s0						# $t0 contains the address of str[0]

	li $t8, 65
	li $t9, 90

	LCLLoop:

		lb $t1, 0($t0)

		beqz $t1, EndLCLLoop			# End Loop if $t1 = 0

		blt $t1, $t8, Skip
		bgt $t1, $t9, Skip

		addi $t1, $t1, 32
		sb $t1, 0($t0)

		Skip:
			addi $t0, $t0, 1

		j LCLLoop

	EndLCLLoop:

la $s1, newstr							# $s1 contains address of new string[0]

StoreStringLabel:

	move $t1, $s1						# $t1 contains &newstr[0]
	move $t0, $s0						# $t0 contains old &str[0]

	la $a0, old_address					# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the message
	syscall								# print the message

	move $a0, $t0						# message string in $a0, pseudoinstruction
	li $v0, 1							# Prepare to print the message
	syscall

	jal PrintNewLine

	la $a0, new_address					# message string in $a0, pseudoinstruction
	li $v0, 4							# Prepare to print the message
	syscall								# print the message

	move $a0, $t1						# message string in $a0, pseudoinstruction
	li $v0, 1							# Prepare to print the message
	syscall

	jal PrintNewLine


	SSLLoop:

		lb $t5, 0($t0)					# $t5 = *($t0)

		beqz $t5, EndSSLLoop			# End Loop if $t1 = 0

		sb $t5, 0($t1)					# *($t0) = $t5

		addi $t0, $t0, 1				# Move pointer to original string element forward
		addi $t1, $t1, 1				# Move pointer to new string element forward

		j SSLLoop

	EndSSLLoop:

		lb $t5, 0($t0)					# load '\0'
		sb $t5, 0($t1)					# store '\0' in new string

		jal PrintNewString


	j Exit

PrintNewString:

	la $a0, result1							# message string in $a0, pseudoinstruction
	li $v0, 4								# Prepare to print the message
	syscall

	move $a0, $s1							# message string in $a0, pseudoinstruction
	li $v0, 4								# Prepare to print the message
	syscall

	jr $ra


Exit:
	li $v0, 10
	syscall # exit

PrintNewLine:

	la $a0, newline							# message string in $a0, pseudoinstruction
	li $v0, 4								# Prepare to print the newline
	syscall

	jr $ra
