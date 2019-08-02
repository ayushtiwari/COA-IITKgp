####################### Data segment ######################################
#Rithin Manoj(17cs10043)
#Ayush Tiwari(17CS10056)
#sem -5
#assign-1
#group-9

.data
get_array:   
                .asciiz "Enter the 8 elements of the array in any order : "
newline:   
                .asciiz "\n"
result1:
                .asciiz "Array in descending order : "
spac:
                .asciiz " "
array1:
                .word 8


####################### Text segment ######################################

.text 
.globl main

main:
                
        la $a0, get_array               # message string in $a0, pseudoinstruction
        li $v0, 4                       # Prepare to print the message
        syscall                         # print the message

        la $t1, array1                  # $t1 points to a[0]
        move $s0, $t1                   # $t0 points to a[0]
        addi $s1, $t1, 32               # $t3 points to a[8], one element after end


        move $a0, $s0
        move $a1, $s1

        jal GetElementFunction
        jal PrintArrayFunction

        move $a0, $s0
        li $a1, 8

        # Call insertion sort        
        jal InsertionSort
        jal PrintNewLine

        la $a0, result1              # message string in $a0, pseudoinstruction
        li $v0, 4                       # Prepare to print the message
        syscall

        move $a0, $s0
        move $a1, $s1

        jal PrintArrayFunction   
#exit()         
                
Exit:

    li $v0, 10
    syscall # exit


GetElementFunction:
        
        move $t0, $a0
        move $t3, $a1

        GetElementLoop:
                
                li $v0, 5                       
                syscall                         
                move $t2, $v0                   

                sw $t2, 0($t0)
                addi $t0, $t0, 4

                bne $t0, $t3, GetElementLoop

        jr $ra


PrintArrayFunction:
        
        
        move $t0, $a0
        move $t3, $a1

        PrintElementLoop:
                
                lw $a0, ($t0)
                li $v0, 1
                syscall

                la $a0, spac                    # message string in $a0, pseudoinstruction
                li $v0, 4                       # Prepare to print the message
                syscall         

                addi $t0, $t0, 4
                bne $t0, $t3, PrintElementLoop

                la $a0, newline                 # message string in $a0, pseudoinstruction
                li $v0, 4                       # Prepare to print the message
                syscall

        jr $ra 


InsertionSort:
        
        


        # $t0 is &a[0]
        # $t8 is i
        # $t9 is j
        # $t6 store key
        

        move $t0, $a0
        move $t7, $a1

        li $t8, 1


        j CheckOuter

        
        Inner:
                addi $t9, $t8, -1       # $t9 stores i-1

                sll $s2, $t8, 2         # $s2 stores 4*i
                add $s2, $t0, $s2       # $s2 sotres &a[i]


                lw $s5, 0($s2)          # $s2 contains a[i]
                move $s2, $s5

                j CheckInner

        ExecuteInner:

                #######
                # At this point:
                # $s2 contains key
                # $s3 contains a[j]
                # $t9 contains j
                # $t8 contains i
                #######

                sll $s4, $t9, 2         # $s4 stores 4*(j+1)
                addi $s4, $s4, 4
                add $s4, $t0, $s4       # $s4 sotres &a[j+1]
                sw $s3, 0($s4)          # a[j+1] = a[j]

                addi $t9, $t9, -1

        CheckInner:
                
                blt $t9, $zero, skip

                sll $s3, $t9, 2         # $s3 stores 4*j
                add $s3, $t0, $s3       # $s3 sotres &a[j]
                lw $s5, 0($s3)
                move $s3, $s5          # $s3 contains a[j]

                # la $a0, newline
                # li $v0, 4
                # syscall

                # move $a0, $s3
                # li $v0, 1
                # syscall

                # la $a0, newline
                # li $v0, 4
                # syscall

                bge $s3, $s2, skip

                j ExecuteInner

                skip: 

                sll $s4, $t9, 2         # $s3 stores 4*j
                addi $s4, $s4, 4
                add $s4, $t0, $s4       # $s3 sotres &a[j]
                sw $s2, 0($s4)


                addi $t8, $t8, 1

                

        CheckOuter:
                
                blt $t8, $t7, Inner

        jr $ra


PrintNewLine:
        
        la $a0, newline
        li $v0, 4
        syscall

        jr $ra

