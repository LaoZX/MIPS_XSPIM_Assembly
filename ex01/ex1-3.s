    .data
N:
    .word 10    # The length of Array
A:
    .word 8     # A[0] = 8
    .word 4     # A[1] = 4
    .word 7
    .word 12
    .word 13
    .word 19
    .word 23
    .word 43
    .word 56    # A[8] = 56
    .word 32    # A[9] = 32
B:
    .space 40   # The storage size of array B is 40 byte.
    .text

main:
    lw $8, N      # N into $t0
    la $9, A      # A into $t1
    la $10, B      # B into $t2
    li $11, 0	 # i=0

loop:
    beq $11, $8, exit	# if i=n,exit
    lw $12, 0($9)   	# load A[i] into $t4
    sw $12, 0($10)   	# store t4 into B[i]
    addi $9, $9, 4    	# A++
    addi $10, $10, 4    # B++
    addi $11, $11, 1    # i++
    j loop          	# jump back to loop

exit:
    j exit
