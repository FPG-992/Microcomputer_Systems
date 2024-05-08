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
LXI B,0000H ; B = 0
LXI H,0900H ; H hold the address 0900H Again
MVI D,00H ; D = 0 this will be used for counting the numbers

INIT_LOOP:
MOV A,M ; A = M
MVI E,08H ; E = 8

CHECK_BIT:
RAR ; rotate right
JNC IS_ZERO ; if carry = 0
INX B ; BC = BC+1

IS_ZERO:
DCR E ; E = E-1
JNZ CHECK_BIT ; if C != 0 repeat
INX H ; increment HL pair
INR D ; D = D+1
MOV A,D ; A = D
CPI 80H ; is D<128
JNZ INIT_LOOP ; if yes repeat

CHECK_VALUE:
MVI A,00H ; A = 0
MVI D,00H ; D = 0
LXI H,0900H ; H hold the address 0900H Again
MVI B,00H ; this is for counting how many times we checked a number

RANGE:
INR B ; B = B+1
MOV A,M ; A = M(H)
CPI 10H ; is A<16
JC NEXT_NUMBER ; if yes skip number
CPI 61H ; is A<97
JNC NEXT_NUMBER ; if no jump to next number
INR D ; D = D+1

NEXT_NUMBER:
INX H ; increment HL pair
MOV A,B ; A = B
CPI 80H ; is B<128
JNZ RANGE ; if yes repeat Otherwise the program stops

END