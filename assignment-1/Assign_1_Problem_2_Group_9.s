#Rithin Manoj(17cs10043)
#Ayush Tiwari(17CS10056)
#sem -5
#assign-2
#group-9


####################### Data segment ######################################



 .data
msg_input:   .asciiz "Enter the argument (positive number): "
msg_arg:   .asciiz "The argument is: "
msg_result:   .asciiz "The fibonacci series is: "
newline:   .asciiz "\n"

####################### Text segment ######################################
.text
.globl main
     main:

          la $a0, msg_input # message string in $a0
          li $v0, 4 # Prepare to print the message
          syscall  # print the message

          li $v0, 5 # for reading int
          syscall # argument in $v0
          move $a0, $v0 # argument in $a0
           
         
          move $t0, $a0 # temporary register $t0 contains the argument   
          li  $v0, 4 # for print_str
          la  $a0, msg_arg  # preparing to print the message
          syscall  # print the string

          li  $v0, 1 # for print_int
          move $a0, $t0 # get argument back in $a0
          syscall  # print the argument

          blt $t0, $zero, Exit
          
		      addi $t1,$zero,1 # first fibonacci number
		      addi $t2,$zero,1 # second fibonacci number
		  
		  
		      # Print a newline
          li  $v0, 4 # for print_str
          la  $a0, newline # preparing to print the newline
          syscall  # print the newline
		  
		  
		  
    		  move $a0, $t1 # get result in $a0
              li  $v0, 1 # for print_int
              syscall  # print the result
    		  beq $t0,$t1,Exit #if number is 1 print and exit
    		  
    		  li  $v0, 4 # for print_str
              la  $a0, newline # preparing to print the newline
              syscall  # print the newline
    		  
    		  
    		  move $a0, $t2 # get result in $a0
              li  $v0, 1 # for print_int
              syscall  # print the result
    		  addi $t3,$t2,1 #2 saved in $t3
    		  beq $t0,$t3,Exit #if number is 2 print and exit
    		  
    		  sub $t0,$t0,2
    		  
		  
		  
          Loop:  
			       sub $t0, $t0, 1   #n=n-1
			       add $t3, $t1, $t2  #a=b+c
			       move $t1,$t2       #c=b
             move $t2,$t3       #b=a
             li  $v0, 4 # for print_str
             la  $a0, newline # preparing to print the newline
             syscall  # print the newline
		  
      			  move $a0, $t3 # get result in $a0
                    li  $v0, 1 # for print_int
                    syscall  # print the result
      			  bgt $t0,$zero, Loop #continue if n>0
                
                move $t0, $v0 # temporarily hold value in $t0
          
         
          
         
              
        
     Exit:
          li $v0, 10
          syscall # exit
           