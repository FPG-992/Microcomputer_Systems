.include "m328PBdef.inc" ; Include the definition file for the ATmega328PB

.def counter = r30; Define the register r30 as counter

.org 0x0 ; Start the code at address 0x0
rjmp reset

.org 0x4 ; Interrupt vector for INT1
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

;enable INT1 interrupt (EXETERNAL!!!)
ldi r24, (1<<INT1)
out EIMSK, r24

sei

clr r24
out PORTC, r24

main:

mov r24, counter
andi r24, 0x0F
out PORTC, r24

rjmp main

;external interrupt 1 service routine
isr1:

sbic PIND, 7 ; Skip if MSB of PIND is 0
inc counter ; Increment counter if MSB of PIND is 1

cpi counter, 16; Compare counter with 16
brne skip_reset ;skip if counter is not 16
ldi counter, 1

skip_reset:
;Delay 100 mS
 ldi r24, low(16*100) ; Init r25, r24 for delay 100 mS
 ldi r25, high(16*100) ; CPU frequency = 16 MHz
delay1:
 ldi r23, 249 ; (1 cycle)
delay2:
 dec r23 ; 1 cycle
 nop ; 1 cycle
 brne delay2 ; 1 or 2 cycles
 sbiw r24, 1 ; 2 cycles
 brne delay1 ; 1 or 2 cycles

 ldi r24,(1<<INTF1)
 out EIFR, r24 ; Clear INTF1 flag

 reti