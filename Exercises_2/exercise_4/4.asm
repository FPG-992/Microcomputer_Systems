START:
LDA 2000H ; Load dip switches' value
MVI A,B ;Copy the value to B

A0_AND_B0:
ANI 01H ; Mask the least significant bit A = A AND 00000001
MOV C,A ; Copy the result to C
MOV A,B ; Copy the value of B to A
ANI 02H ; Mask the second least significant bit A = A AND 00000010
RRC ; Rotate the accumulator right to get this as LSB
ANA C; A = A AND C
MOV E,A ; Load the value of E to A | A0 AND B0 IS AT LSB

A1_AND_B1:
MOV A,B ; Copy the value of B to A
ANI 04H ; Mask the third least significant bit A = A AND 00000100
MOV C,A ; Copy the result to C
MOV A,B ; Copy the value of B to A
ANI 08H ; Mask the fourth least significant bit A = A AND 00001000
RRC ; Rotate the accumulator right to get this as 3RD LSB
ANA C; A = 4TH AND C (3RD) |POS 3 
RRC ; A1 AND B1 NOW AT 2ND LSB
MOV D,A ; Load the value of A TO D | D = 4TH AND 3RD | X1 | POS 2

A0B0_OR_A1B1:
RRC ; Rotate the accumulator right to get this as 1st LSB and compare with E
ORA E ; A = A OR E
MOV E,A ; Load the value of A to E | X0 | POS 1

A2_XOR_B2:
MOV A,B ; Copy the value of B to A
ANI 10H ; Mask the fifth least significant bit A = A AND 00010000
MOV C,A ; Copy the result to C (C IS THE 5TH BIT)
MOV A,B ; Copy the value of B to A
ANI 20H ; Mask the sixth least significant bit A = A AND 00100000 (A IS NOW THE 6TH BIT)
RRC ; Rotate the accumulator right to get this as 5TH LSB
XRA C ; A = A XOR C (5TH XOR 6TH) | POS 5
RRC ; A2 XOR B2 NOW AT 4TH LSB
RRC ; A2 XOR B2 NOW AT 3RD LSB
MOV L,A ; Load the value of A to L | POS 3 

A3_XOR_B3:
MOV A,B ; Copy the value of B to A
ANI 40H ; Mask the seventh least significant bit A = A AND 01000000
MOV C,A ; Copy the result to C (C IS THE 7TH BIT)
MOV A,B ; Copy the value of B to A
ANI 80H ; Mask the eighth least significant bit A = A AND 10000000 (A IS NOW THE 8TH BIT)
RRC ; Rotate the accumulator right to get this as 7TH LSB
XRA C ; A = A XOR C (7TH XOR 8TH) | POS 7
RRC; A3 XOR B3 NOW AT 6TH LSB
RRC; A3 XOR B3 NOW AT 5TH LSB
RRC; A3 XOR B3 NOW AT 4TH LSB
MOV H,A ; Load the value of A to H | X3 | POS 4
RRC; A3 XOR B3 NOW AT 3RD LSB

A2B2_OR_A3B3:
ORA L ; A = A OR L
MOV C,A ; Load the value of A to C | X2 | POS 3

; X0 X1 X2 X3 | E D C H

SET_BITS_FOR_OUTPUT:
MVI A ,00H ; Clear the accumulator
ORA E ; Set the 1st bit
ORA D ; Set the 2nd bit
ORA C ; Set the 3rd bit
ORA H ; Set the 4th bit
CMA ; Invert the bits because of reverse logic
STA 3000H ; Store the value to the output port

END

