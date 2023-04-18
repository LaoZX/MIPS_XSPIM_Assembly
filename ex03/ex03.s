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
	li $s5, 0		#s=0

Mloop:

	lw $s3, 0($s0)		# load mat1
	lw $s4, 0($s1)		# load mat2

	mul $s6, $s3, $s4

	add $s5, $s5, $s6	# s5+=s6

	addi $t0, $t0, 1	# i++
	beq $t0, 4, next_colum	# if(i=4), go to next colum

	addi $s0, $s0, 4	# go mat1's right 
	addi $s1, $s1, 16	# go mat2's down

	j Mloop

	next_colum:
		sw $s5, 0($s2)			# store result to s2
		addi $s2, $s2, 4		# point to result matrix's next element

		addi $t1, $t1, 1		# j++
		beq $t1, 4, next_row	# if(j=4), go to mat1's next row

		addi $s0, $s0, -12	    # mat1's back to this row's head
		addi $s1, $s1, -44		# mat2 go to next colum's head
		addi $t0, $zero, 0		# i back to 0
		addi $s5, $zero, 0		# s back to 0
		
		j Mloop

	next_row:
		addi $s0, $s0, 4		# mat1 go to next row' head
		addi $s1, $s1, -60		# mat2 back to 1st colum's head

		addi $t2, $t2, 1		# k++
		beq $t2, 4, end			# if(k=4), end

		addi $t0, $zero, 0		# i back to 0
		addi $t1, $zero, 0		# j back to 0
		addi $s5, $zero, 0		# s back to 0

		j Mloop

end:
	li $v0, 10
  	syscall
