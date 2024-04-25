.include "m16def.inc"

.def A=r16
.def B=r17
.def C=r18
.def D=r19
.def TEMP=r20
.def BACKUP_A = r21
.def BACKUP_B = r22
.def BACKUP_C = r23
.def BACKUP_D = r24
.def F1 = r25

START: clr temp ;PORT B AS INPUT

IN TEMP,PORTB

MOV A,TEMP
ANDI A,0x01
MOV BACKUP_A,A

MOV B,TEMP
LSR B ; bit 1 goes to bit 0
ANDI B,0x01 ; mask bit 0
MOV BACKUP_B,B

MOV C,TEMP 
LSR C ; bit 2 goes to bit 1
LSR C ; bit 2 goes to bit 0
ANDI C,0x01 ; mask bit 0
MOV BACKUP_C,C

MOV D,TEMP
LSR D ; bit 3 goes to bit 2
LSR D ; bit 3 goes to bit 1
LSR D ; bit 3 goes to bit 0
ANDI D,0x01 ; mask bit 0
MOV BACKUP_D,D

;THIS IS THE CALCULATION OF F0
and A,BN ; A AND B' : A = A AND B'
and B,D ; B AND D : B = B AND D
or A,B ; A OR B : A = A OR B

;THIS IS THE CALCULATION OF F1 F1= (A’+C’) ∙ (B’+D)
MOV F1, BACKUP_A
COM F1 ; F1 = NOT A
MOV TEMP, BACKUP_C
COM TEMP ; TEMP = NOT C
OR F1 , TEMP ; F1 = F1 OR TEMP = NOT A OR NOT C

MOV TEMP, BACKUP_B
COM TEMP ; TEMP = NOT B
OR TEMP, BACKUP_D ; TEMP = NOT B OR D

AND F1, TEMP ; F1 = F1 AND TEMP = (NOT A OR NOT C) AND (NOT B OR D)