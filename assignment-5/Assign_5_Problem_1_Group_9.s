####################### Data segment ######################################
#Rithin Manoj(17cs10043)
#Ayush Tiwari(17CS10056)
#sem -5
#assign-5
#group-9

.data
get_number:   
                .asciiz "Enter the two elements "       #string output 1
print_number:
                .asciiz "The numbers are"               #string output 1
newline:   
                .asciiz "\n"                            #newline output
result1:
                .asciiz "The gcd is"                    #result string
result2:
                .asciiz "Error in the input"            #error putput    
spac:
                .asciiz " "                             #space output


.text 
.globl main

main:
                
        la $a0, get_number             # message string in $a0, pseudoinstruction
        li $v0, 4                       # Prepare to print the message
        syscall                         # print the message
      
        li $v0,5                        #prepare to get input
        syscall                         #get input
        move $t0,$v0                    #move input stored in $vo in $to

        li $v0,5                        #prepare to get input
        syscall                         #get input
        move $t1,$v0                    #move input stored in $vo in $t1

        la $a0, print_number             # message string in $a0, pseudoinstruction
        li $v0, 4                        # Prepare to print the message
        syscall   
         

        la $a0, newline                 # message string in $a0, pseudoinstruction
        li $v0, 4                       # Prepare to print the newline
        syscall                         # output the newline
        
        move $a0,$t0                    #move the value $t0 to $a0
        li $v0,1                        #prepare to print the input
        syscall                         #print input

        la $a0, spac                    # message string in $a0, pseudoinstruction
        li $v0, 4                       # Prepare to print the message
        syscall                         #print the space
        
        move $a0,$t1                    #move the value $t1 to $a0
        li $v0,1                        #prepare to print the input
        syscall                         #print input


        move $a0,$t0                    #move the value $t0 to $a0 
        move $a1,$t1                    #move the value $t1 to $a0

        bgt $t1,$t0,swap                 #swap values if higher value is stored at $t1

        swap:
        	move $a1,$t0                #move the value $t0 to $a1 
            move $a0,$t1                #move the value $t1 to $a0

        jal check_non_negative_value     #call function to check if input is valid


        jal recursive_gcd                #call function for recursive gcd

        la $a0, newline            # message string in $a0, pseudoinstruction
        li $v0, 4                  # Prepare to print the message
        syscall                    #print newline

        la $a0,result1            # message string in $a0, pseudoinstruction
        li $v0,4                  # Prepare to print the message
        syscall                   #print message

        la $a0, spac           # message string in $a0, pseudoinstruction
        li $v0, 4                       # Prepare to print the message
        syscall   
        
        move $a0,$a2             #value in $a0=value in $a2
        li $v0,1                 #get ready to print
        syscall                  #print
             

        Exit:

    		li $v0, 10
    		syscall # exit
        


        check_non_negative_value:

              blt $a0,$zero,Error       #if $a0 is less than zero jump to error
              blt $a1,$zero,Error       #if $a1 is less than zero jump to error
              jr $ra

        Error:
        	 la $a0, newline            # message string in $a0, pseudoinstruction
             li $v0, 4                  # Prepare to print the message
             syscall    
         
             la $a0, result2           # message string in $a0, pseudoinstruction
             li $v0, 4                 # Prepare to print the message
             syscall 
             
             j Exit                    #jump to exit


        recursive_gcd:
        	bne $a1, $zero,recurse     #if $a1 is not equal to zero recursion
        	beq $a1,$zero,return01     #if $a1 is equal to zero return $a0
        	return01:
			   move $a2,$a0             #move $a0 to $a2
			   jr $ra 
            recurse:
            	sub $sp, $sp, 12    # We need to store 3 registers to stack
                sw $ra, 0($sp)      # $ra is the first register
                sw $a1, 4($sp)      #store value at $a1 in the second stack register
                div $a0,$a1         #div $a0/$a1
                mfhi $a3            #$a3=$a0%$a1
                move $a0,$a1        #$a0=$a1
                sw $a3,8($sp)       
                move $a1,$a3        #$a1=$a3
                jal recursive_gcd   #recursive call
                lw $ra, 0($sp)      # retrieve return address
                addi $sp, $sp, 12   
                jr $ra