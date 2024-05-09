LXI B,0064H ;Load the delay for DELLB 0.1s

START:
LDA 2000H ;Load dipswitch data
RLC ;Rotate the data in the accumulator to get MSB
JNC IS_OFF ;If the MSB is 0, then the switch is off
JMP START ;If the MSB is 1, then the switch is on and we 
          ;loop back to START waiting for the switch to be turned off

IS_OFF:
LDA 2000H ;Load the dipswitch data
RLC ;Rotate the data in the accumulator to get the MSB
JC IS_ON ;If the MSB is 1, then the switch is on
JMP IS_OFF ;If the MSB is 0, then the switch is off and we loop back

IS_ON: 
MVI E,C8H ;Load the delay for DELAY | 200 in decimal 200*0.1s = 20s
LDA 2000H ;Load the dipswitch data
RLC ;Rotate the data in the accumulator to get the MSB
JNC LEDS_ON ;If the MSB is 0, then OPEN LEDS, MSB IS OFF
JMP IS_ON ;If the MSB is 1, then the switch is on and we loop back

LEDS_ON:
MVI A,00H ; Leds are reverse logic
STA 3000H ; Turn on the LEDs
CALL DELB ; Delay Sub routine 
DCR E ; Decrement the delay
JNZ LEDS_ON ; If the delay is not zero, loop back
MVI A,FFH ; Turn off the LEDs
STA 3000H ; Store the data in the port
JMP IS_OFF ; Jump back to IS_OFF

END