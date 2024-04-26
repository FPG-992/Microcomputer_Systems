START:

MVI B,01H      
LDA 2000H       
CPI 00H         
JZ ZERO_FLAG_SET_1        
RAR             
JC CARRY_IS_SET       
INR B           
JNZ ZERO_FLAG_SET_0       
MOV A,B        
CMA             
STA 3000H       
JMP START           


ZERO_FLAG_SET_1:
CMA            
STA 3000H       
JMP START 

ZERO_FLAG_SET_0:
RAR             
JC CARRY_IS_SET       
INR B           
JNZ ZERO_FLAG_SET_0       
MOV A,B        
CMA             
STA 3000H       
JMP START           

CARRY_IS_SET:
MOV A,B
JMP ZERO_FLAG_SET_1

END