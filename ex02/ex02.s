    .data
R1: .word 0
R2: .word 0
    .text

main:
    addi $a0, $zero, 3      # multiplicand
    addi $a1, $zero, 5      # multiplier
    jal  Mult               # go to procedure
    add $t6, $v0, $zero
    sw $t6, R1              #store result to R1

    addi $a0, $zero, 28      # multiplicand
    addi $a1, $zero, 12      # multiplier
    jal  Mult               # go to procedure
    add $t6, $v0, $zero
    sw $t6, R2              #store result to R2
    j Exit

Mult:
    add $t0, $a0, $zero
    add $t1, $a1, $zero
    addi $t3, $zero, 0      # initialize product=0 to t3
    addi $t4, $zero, 1      # initialize control=1 to t4
    addi $t7, $zero, 0      # initialize count=0 to t7

    loop:
        
        beq $t7, 32, return #stop loop, go to return
        addi $t7,$t7,1      #count++

        and $t5, $t1, $t4   # $t5= Mlier & control
        beq	$t5, $zero, no_acction  # if t5=0, Prod no change
        add $t3, $t3, $t0    # prod=prod+Mcand
        addu $t0, $t0, $t0   # Mcands left shife
        addu $t4, $t4, $t4   # control left shift
        j loop

        no_acction:
            addu $t0, $t0, $t0   # Mcand left shift
            addu $t4, $t4, $t4   # control left shift
            j loop

        return:
            add $v0, $t3, $zero  # set return val
            jr $ra               # return

Exit:
    j Exit


