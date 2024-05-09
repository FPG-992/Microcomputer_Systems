START:
LDA 2000H ; Load from dipswitches
MVI B,01H ; Initialize B register TO 01H
MVI C,08H ; Initialize C as temp

FIND_LSB:
RRC ; Rotate right through carry
JC TURN_ON_LED ; If carry is 1, turn on LED and exit loop
DCR C ; Decrement C register by 1
JZ ALL_OFF ; If C is 0, turn off all LEDs , no 1 bit was found
INR B ; Increment B register by 1
JNC FIND_LSB ; If carry is 0, continue rotating

TURN_ON_LED: ; Turn on LED at the rightest position
MVI A,FEH ; Load 1111 1110 into A register (Reverse logic)
DCR B ; Decrement B register by 1

TURN_ON_LED_LOOP: ; Turn on LED at the rightest position
RLC ; Rotate left through carry
DCR B ; Decrement B register by 1
JNZ TURN_ON_LED_LOOP ; If B is not 0, continue rotating
STA 3000H ; Turn Leds on
JMP START ; Repeat

ALL_OFF:
MVI A,FFH ; Load 1111 1111 into A register
STA 3000H ; Turn off all LEDs
JMP START ; Repeat

END