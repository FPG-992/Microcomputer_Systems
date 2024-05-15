.include "m328PBdef.inc" ; Include the definition file for the ATmega328PB

.def counter = r30; Define the register r30 as counter

.org 0x0 ; Start the code at address 0x0
rjmp reset

.org 0x4 ; Interrupt vector for the reset
rjmp isr1

;program starts here after reset
reset:
ldi r24, LOW(RAMEND)
out SPL, r24
ldi r24, HIGH(RAMEND)
out SPH, r24

;for output
ser r24
out DDRC, r24 ; Init PORTC as output

clr r24
out DDRD, r24 ; Init PORTD as input

;interrupt on rising edge of INT1 pin

ldi r24, (1<<ISC11) | (1<<ISC10)
sts EICRA, r24

;enable INT1 interrupt
ldi r24, (1<<INT1)
out EIMSK, r24

sei

clr r24
out PORTC, r24

