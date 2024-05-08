START:
IN 10H ;disable memory protection
MVI A,00H ; A = 0 
LXI H,0900H ; H hold the address 0900H
INCREMENT:
MOV M,A ; A stored in memory address of HL 
INX H ; increment HL pair
INR A ; A = A+1
CPI 80H ; is A<128
JNZ INCREMENT ; if yes repeat

END