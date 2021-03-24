        addi $t0, $0, 48       #set $t0 equal to 48 
        sb $t0, 0($a1)         #store $to (48) at location 0 in $a1
        addi $t0, $0, 120      #set $t0 equal to 120
        sb $t0, 1($a1)         #store $t0 (120) at location 1 in $a1
        addi $t1, $a1, 9       #set $t1 = the address + 9

LOOP:

        andi $t0, $a0, 0xf    #$t0 = 1 if $a0 and 0xf are the same (0xf = beginning of hex)?

        slti $t2, $t0, 10     #if $t0 is less than 10, $t2 = 1, else 0
        bne $t2, $0,  DIGIT   #if $t2 does not equal 0, branch to DIGIT
        addi $t0, $t0, 48     #set $t0 equal to 48
        addi $t0, $t0, 39     #set $t0 equal to 39 (why did we just write over the 48?)
DIGIT:

        sb $t0, 0($t1)        #set $t0 equal to whatever's in location 0 of $t1

        srl $a0, $a0, 4       #shift right 4 bits

        bne $a0, $0, LOOP     #if $a0 does not equal 0, branch to LOOP
        addi $t1, $t1, -1     #set $t1 = $t1 - 1

DONE:

        jr $ra                #set the jump register back to $ra
        nop