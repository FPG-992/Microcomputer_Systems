START:	
	IN 10H	
	MVI A,0DH	
	SIM				
	EI	
	
	MVI B,06H
	LXI H,0A00H	
		
FILL:
	MVI M,10H		
	INX H			
	DCR B
	JNZ FILL

	MVI C,63H ; 99
	MVI D,80H ; 128
	MVI E,C8H ;200

	PUSH D
	LXI D,0A00H
	CALL STDM
	POP D
	CALL DCD

Main_Loop:	
	JMP Main_Loop

INTR_ROUTINE:
	DI
	CALL KIND
	STA 0A02H
	MOV B,A
	CALL KIND
	STA 0A03H	
	RLC
	RLC
	RLC
	RLC
	ADD B
	
	CMP C
	JC First_threshold
	JZ First_threshold
	JMP Check_second_threshold

First_threshold:	
	MVI A,01H
	JMP FINAL	

Check_second_threshold:
	CMP D
	JC Second_threshold
	JZ Second_threshold
	JMP Check_third_threshold

Second_threshold:
	MVI A,02H
	JMP FINAL

Check_third_threshold:
	CMP E
	JC Third_threshold
	JZ Third_threshold
	JMP LED_4

Third_threshold:
	MVI A,04H
	JMP FINAL

LED_4:
	MVI A,08H
	JMP FINAL

FINAL:
	CMA
	STA 3000H

	PUSH D
	LXI D,0A00H
	CALL STDM
	POP D
	EI
	
DISP:
	CALL DCD
	JMP DISP

END