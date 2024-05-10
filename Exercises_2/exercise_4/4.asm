START:
LDA 2000H ; Load dip switches' value
MVI A,B ;Copy the value to B

A0_AND_B0:
ANI 01H ; Mask the least significant bit A = A AND 00000001
MOV C,A ; Copy the result to C
MOV A,B ; Copy the value of B to A
ANI 02H ; Mask the second least significant bit A = A AND 00000010
ANA C; A = A AND C
MOV E,A ; Load the value of E to A 

A1_AND_B1:
MOV A,B ; Copy the value of B to A
ANI 04H ; Mask the third least significant bit A = A AND 00000100
MOV C,A ; Copy the result to C
MOV A,B ; Copy the value of B to A
ANI 08H ; Mask the fourth least significant bit A = A AND 00001000
ANA C; A = 4TH AND C (3RD)
MOV D,A ; Load the value of A TO D | D = 4TH AND 3RD | X1

A0B0_OR_A1B1:
ORA E ; A = A OR E
MOV E,A ; Load the value of A to E | X0

A2_XOR_B2:
MOV A,B ; Copy the value of B to A
ANI 10H ; Mask the fifth least significant bit A = A AND 00010000
MOV C,A ; Copy the result to C (C IS THE 5TH BIT)
MOV A,B ; Copy the value of B to A
ANI 20H ; Mask the sixth least significant bit A = A AND 00100000 (A IS NOW THE 6TH BIT)
XRA C ; A = A XOR C (5TH XOR 6TH)
MOV L,A ; Load the value of A to L 

A3_XOR_B3:
MOV A,B ; Copy the value of B to A
ANI 40H ; Mask the seventh least significant bit A = A AND 01000000
MOV C,A ; Copy the result to C (C IS THE 7TH BIT)
MOV A,B ; Copy the value of B to A
ANI 80H ; Mask the eighth least significant bit A = A AND 10000000 (A IS NOW THE 8TH BIT)
XRA C ; A = A XOR C (7TH XOR 8TH)
MOV H,A ; Load the value of A to H | X3

A2B2_OR_A3B3:
ORA L ; A = A OR L
MOV C,A ; Load the value of A to C | X2

; X0 X1 X2 X3 | E D C H

SET_BITS_FOR_OUTPUT:
MVI A ,00H ; Clear the accumulator

ORA E ; A = A OR E
ORA D ; A = A OR D
ORA C ; A = A OR C
ORA H ; A = A OR H

