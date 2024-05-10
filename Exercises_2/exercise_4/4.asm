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
MOV D,A ; Load the value of A TO D | D = 4TH AND C (3RD)

A0B0_OR_A1B1:
ORA E ; A = A OR E
MOV E,A ; Load the value of A to E



