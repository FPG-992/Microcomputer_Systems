START:

IN 10H ;disable memory protection
MVI A,00H ; A = 0 
LXI H,0900H ; H hold the address 0900H

INCREMENT:

MOV M,A ; A stored in memory address of HL 
INX H ; increment HL pair
INR A ; A = A+1
CPI 80H ; is A<128
JNZ INCREMENT ; if yes repeat


COUNTER_PROCEDURE:
MVI B, 00H ; B = 0 this will be used for counting 1's
LXI H, 0900H ; H hold the address 0900H Again
MVI D,00H ; D = 0 this will be used for counting the numbers

INIT_LOOP:
MOV A,M ; A = M
MVI C,08H ; C = 8

CHECK_BIT:
RAR ; rotate right
JNC IS_ZERO ; if carry = 0
INR B ; B = B+1, carry was 1

IS_ZERO:
DCR C ; C = C-1
JNZ CHECK_BIT ; if C != 0 repeat
INX H ; increment HL pair
INR D ; D = D+1
CPI 80H ; is D<128
JNZ INIT_LOOP ; if yes repeat

END
