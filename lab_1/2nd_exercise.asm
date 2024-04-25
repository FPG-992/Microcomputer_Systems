.include "m328PBdef.inc"
    
.def TEMP=r30
.def POS=r31

ldi POS,1
    
clr temp
SER TEMP ; TEMP = 11111111
OUT DDRD,TEMP ;SET DDRD AS OUTPUT    
    
START: ;THIS IS EXECUTED ONLY ONE TIME
OUT DDRD,POS ;output position
CALL DELAY
CALL DELAY
    
RJMP TO_LEFT

TO_LEFT:
LSL POS ;SHIFT LEFT
OUT DDRD,POS ;output position
CALL DELAY ; 1s delay
CALL DELAY ; 1s delay
SBRC POS,7; SKIP IF 7NTH BIT IS 0
RJMP CHANGE_DIRECTION ;Change_direction

RJMP TO_LEFT
    
TO_RIGHT:
LSR POS ;SHIFT LEFT
OUT DDRD,POS ;output position
CALL DELAY ; 1s delay
CALL DELAY ; 1s delay
SBRC POS,0; SKIP IF 0TH BIT IS 0
RJMP CHANGE_DIRECTION ;Change_direction

RJMP TO_RIGHT


CHANGE_DIRECTION:
CALL DELAY ;1 MORE SECOND 
SBRC POS,7 ;IF 7NTH BIT IS 1
RJMP TO_RIGHT ;THEN JMP TO RIGHT
RJMP TO_LEFT 
        
    
DELAY:
    ldi  r18, 10 ;original was 82
    ldi  r19, 5  ;original was 43
    ldi  r20, 0
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
    lpm
    nop
    ret