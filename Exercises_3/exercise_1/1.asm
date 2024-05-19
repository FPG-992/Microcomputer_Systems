START:
IN 10H

MVI A,10H  		 ;Set display
STA 0B00H 
STA 0B01H 
STA 0B02H 
STA 0B03H 
STA 0B04H 
STA 0B05H	

MVI A,2DH			;Initialize interrupt mask
SIM
EI

LXI B,00FAH

Main_loop:
jmp Main_loop

INTR_ROUTINE:
PUSH PSW
PUSH H
PUSH D
PUSH B

MVI C,5AH
EI             ; Re-enable interrupts

BLINK_LOOP:
MVI A,00H ;1 time
STA 3000H ; Turn off LEDs
CALL DELB      ; Delay for 250 ms

MVI A,FFH ;2 times
STA 3000H ; Turn on LEDs
CALL DELB      ; Delay for 250 ms

MVI A,00H ;3 times
STA 3000H ; Turn off LEDs
CALL DELB      ; Delay for 250 ms

MVI A,FFH ;4 times
STA 3000H ; Turn on LEDs
CALL DELB      ; Delay for 250 ms

DCR C	         ; Decrement counter
MOV A,C
JNZ BLINK_LOOP ; If counter is not zero, repeat blinking

; End of blinking routine
POP B
POP D
POP H
POP PSW

RET

END