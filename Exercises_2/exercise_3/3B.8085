START:
CALL KIND
CPI 00H	;If we press 0 then go to OFF
JZ OFF
CPI 09H	;If we press 9 then go to OFF
JNC OFF
MOV B,A ; set the input to B
MVI A,00H ; set A to 0
DCR B ; decrement B
JZ TURN_ON_LED
INR A ; increment A because b was not 1 and led 1 must be turned off

PUT_0:
DCR B ; decrement B
JZ TURN_ON_LED
RLC ; rotate left get a new bit
INR A ; increment A, set it to 0
JMP PUT_0

TURN_ON_LED:
STA 3000H ; store the value of A in LEDS
JMP START ;loop

OFF:
MVI A,FFH ; set A to 1111 1111 | reverse logic
STA 3000H  ; turn off all the leds
JMP START ;loop

END 