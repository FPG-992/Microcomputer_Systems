IN 10H ;Disable memory protection :)

START:
MVI B,FFH ; COUNTER FOR COUNTING THE DECAS OF THE NUMBER SET TO -1 
LDA 2000H ;Load the number
CPI C8H ;Is it bigger >200 ?
JNC BIGGER 
CPI 63H ;Is it bigger than 99?
JNC IN_BETWEEN ;
JMP DECA ;If not go to Deca


IN_BETWEEN:
; Number is between 99 and 200
SUI 64H ;Subtract 100
JMP DECA ;Go to Deca to continue processing

BIGGER:
MVI A,0FH ; 4 MSB Leds on
STA 3000H ;Turn on leds

JMP START ;Repeat Until Number is changed

DECA:
INR B ;Increment the counter for decas, will be executed atleast once even if the number just has units
SUI 0AH ;Subtract 10
JNC DECA ;Repeat until number is less than 10
ADI 0AH ;IF NUMBER <0 ADD 10
MOV D,A ;Save the units in D
MOV A,B ;Move the tens to A
RLC 
RLC 
RLC
RLC ;Decades to the 4 MSB
ADD D ;Add the units
CMA
STA 3000H

JMP START ;Repeat. When new number is given the leds will be updated

END