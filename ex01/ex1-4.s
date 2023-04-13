#bubble sort

    .data
N:
    .word 10
A:
    .word 8
    .word 4
    .word 7
    .word 12
    .word 13
    .word 19
    .word 23
    .word 43
    .word 56
    .word 32

    .text
main:
    la $s0, A	  # A into $s0
    lw $s1, N	  # N into $s1
    li $t0, 0     # i = $t0 = 0

    loop_i:
        addi $t1, $s1, -1     	# $t1 = N-1
        beq $t0, $t1, exit	    # if(i==N-1) 

        addi $t2, $s1, -2     	# j = $t2 = N-2

        loop_j:
            ble $t0, $t2, swap	# if(i<=j)

            addi $t0, $t0, 1    # i++
            j loop_i

        swap:
            # Compare A[j] and A[j+1]
            sll $t3, $t2, 2       # $t3 = j * 4
            add $t3, $t3, $s0     # $t3 = &A[j]
            lw $t4, 0($t3)        # $t4 = A[j]

            addi $t5, $t2, 1      # $t5 = j+1
            sll $t5, $t5, 2       # $t5 = (j+1) * 4
            add $t5, $t5, $s0     # $t5 = &A[j+1]
            lw $t6, 0($t5)        # $t6 = A[j+1]
            ble $t4, $t6, no_swap   # if(A[j]<=A[j+1])

            # Swap A[j] and A[j+1]
            sw $t6, 0($t3)         # A[j] = A[j+1]
            sw $t4, 0($t5)         # A[j+1] = A[j]

        no_swap:
            addi $t2, $t2, -1   # j--
            j loop_j

    exit:
        li $v0, 10
        syscall
