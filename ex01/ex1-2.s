.data
N:
    .word 10
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
S:
    .word 0
    .text
main:
    lw $8, N      # N into $t0
    la $9, A      # A into $t1
    li $10, 0      # i = 0
    li $11, 0      # s = 0

loop:
    beq $10, $8, loopend  	# if i == n, loopend
    lw $12, 0($9)   		# load A[i] into $t4
    add $11, $11, $12   	# add s+A[i]
    addi $9, $9, 4    		# A++
    addi $10, $10, 1    	# i++
    j loop          		# jump back to loop

loopend:
    sw $11, S      # store the sum in S

exit:
    j exit
