START:
IN 10H

MVI A,10H  		 ;Set display
STA 0B00H 
STA 0B01H 
STA 0B02H 
STA 0B03H 
STA 0B04H 
STA 0B05H	

MVI A,0DH			;Initialize interrupt mask
SIM
EI

WAIT:
	JMP WAIT
INTR_ROUTINE:
	POP H			;POP return address so that the stack doesn't fill up
	EI				;Enable interrupts inside interrupt routine
	MVI A,00H 		;Turn on LEDs
	STA 3000H
	MVI H,06H 		;Counter for 6 iterations
	MOV A,H
	DCR A			;Set up tens
	STA 0B03H			;Store tens in the 4th segment display 
SECONDS:
	MVI A,09H			;Set up 9 secs (units)
LIGHTS_ON:
	STA 0B02H			;Store units in the 3rd segment display
	CALL DISPLAY		
	DCR A 			
	CPI 00H 			;Compare with zero
	JNZ LIGHTS_ON	 	;If Z=0 then 9 seconds passed
	CALL ZERO			;Display zero unit (1 sec)
	DCR H			;Decrease counter
	JZ EXIT			;If Z=0 end timer
	MOV A,H
	DCR A		
	STA 0B03H
	JMP SECONDS		;Reapeat for 60 seconds
EXIT:
	MVI A,FFH 		;Turn off LEDs
	STA 3000H 
	JMP WAIT			;Return to wait (main program)
DISPLAY: 	
	LXI B,0064H 		;100 msec delay
	LXI D,0B00H		;For STDM
	PUSH PSW
	PUSH H
	PUSH D
	PUSH B
	CALL STDM
	MVI A,0AH 		;10*100msec=1sec
1SEC:
	CALL DCD			
	CALL DELB
	DCR A
	CPI 00H
	JNZ 1SEC
	POP B
	POP D
	POP H
	POP PSW
	RET
ZERO: 				;Display zero in the 3rd segment display
	MVI A,00H
	STA 0B02H
	CALL DISPLAY
	CALL DELB
	RET
	
	END
	