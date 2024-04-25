.include "m16def.inc"

.def A=r16
.def B=r17
.def C=r18
.def D=r19
.def TEMP=r20
.cseg
.org 0

START: clr temp ;PORT B AS INPUT
out DDRB,temp ;port b as input
ser temp 
out DDRC,temp ;port c as output

Read: in temp,PINB ;read port b
mov A,temp ;store in A
lsr temp ;shift right
mov B,temp ;store in B 
lsr temp ;shift right
mov C,temp ;store in C
lsr temp
mov D,temp ;store in D

and A,BN ; A AND B' : A = A AND B'
and B,D ; B AND D : B = B AND D
or A,B ; A OR B : A = A OR B