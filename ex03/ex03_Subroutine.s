.data
matrix1: .word 0, 0, 0, 1
         .word 0, 2, 0, 0
         .word 0, 0, 3, 0
         .word 4, 0, 0, 0

matrix2: .word 0, 1, 2, 3
         .word 4, 5, 6, 7
         .word 8, 9, 10, 11
         .word 12, 13, 14, 15

result:  .word 0, 0, 0, 0
         .word 0, 0, 0, 0
         .word 0, 0, 0, 0
         .word 0, 0, 0, 0

.text

main:
	la $s0, matrix1
	la $s1, matrix2
	la $s2, result
	
	li $t0, 0		#i=0
	li $t1, 0		#j=0
	li $t2, 0		#k=0
	li $t5, 0		#s=0

Mloop:

	lw $t3, 0($s0)		# load mat1
	lw $t4, 0($s1)		# load mat2
	add $a0, $zero, $t3
	add $a1, $zero, $t4
	jal Mult			#call Subroutine
	add $t6, $v0, $zero # t6=t3*t4
	add $t5, $t5, $t6	# s += t6

	addi $t0, $t0, 1	# i++
	beq $t0, 4, next_colum	# if(i=4), go to mat2's next colum

	addi $s0, $s0, 4	# point to mat1's right
	addi $s1, $s1, 16	# point to mat2's down

	j Mloop

	next_colum:
		sw $t5, 0($s2)			# store s to result matrix
		addi $s2, $s2, 4		# point to result matrix's next element

		addi $t1, $t1, 1		# j++
		beq $t1, 4, next_row	# if(j=4), go to mat1's next row

		addi $s0, $s0, -12	    # mat1 get back to this row's head
		addi $s1, $s1, -44		# mat2 go to next colum's head
		addi $t0, $zero, 0		# i back to 0
		addi $t5, $zero, 0		# s back to 0
		
		j Mloop

	next_row:
		addi $s0, $s0, 4		# mat1 go to next row's head
		addi $s1, $s1, -60		# mat2 back to 1st colum's head

		addi $t2, $t2, 1		# k++
		beq $t2, 4, end			# if(k=4), end

		addi $t0, $zero, 0		# i back to 0
		addi $t1, $zero, 0		# j back to 0
		addi $t5, $zero, 0		# s back to 0

		j Mloop

	   
    Mult:
    add $s3, $a0, $zero
    add $s4, $a1, $zero
    addi $s5, $zero, 0      # initialize product=0
    addi $s6, $zero, 1      # initialize control=1
    addi $s7, $zero, 0      # initialize count=0

    loop:
        
        beq $s7, 10, return #stop loop, go to return
        addi $s7,$s7,1      #count++

        and $t7, $s4, $s6   # $t7= Mlier & control
        beq	$t7, $zero, no_acction  # if t7=0, Prod no change
        add $s5, $s5, $s3    # prod=prod+Mcand
        addu $s3, $s3, $s3   # Mcands left shife
        addu $s6, $s6, $s6   # control left shift
        j loop

        no_acction:
            addu $s3, $s3, $s3   # Mcand left shift
            addu $s6, $s6, $s6   # control left shift
            j loop

        return:
            add $v0, $s5, $zero  # set return val
            jr $ra               # return


end:
	li $v0, 10
  	syscall
