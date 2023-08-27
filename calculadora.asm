 TITLE 'Trabalho'
.MODEL SMALL
.STACK 100h
.DATA

MSG0	DB  0Ah,0Dh, '$'
MSG1	DB	0Ah,0Dh, '****************************************************$'
MSG2	DB	0Ah,0Dh, '*                    Calculadora                   *$'
MSG3	DB	0Ah,0Dh, '*                                                  *$'
MSG4	DB	0Ah,0Dh, '*                Projeto de Assembly               *$'
MSG5	DB  0Ah,0Dh, '*                     Intel 8086                   *$'
MSG6	DB	0Ah,0Dh, '*                                                  *$'
MSG7	DB	0Ah,0Dh, '****************************************************$'
MSG8	DB	0Ah,0Dh, '1 - Soma$'
MSG9	DB	0Ah,0Dh, '2 - Subtracao$'
MSG10	DB	0Ah,0Dh, '3 - Multiplicacao$'
MSG11	DB	0Ah,0Dh, '4 - Divisao$'
MSG12	DB	0Ah,0Dh, '5 - Sair$'
MSG13	DB	0Ah,0Dh, 'Comando Invalido$'
MSG14	DB	0Ah,0Dh, 'Primeiro Valor: $'
MSG15	DB	0Ah,0Dh, 'Segundo Valor: $'
MSG16	DB	0Ah,0Dh, 'Resultado: $'
MSG17	DB	0Ah,0Dh, 'Resto: $'
MSG18	DB	0Ah,0Dh, 'Divisor: $'
MSG19	DB	0Ah,0Dh, 'Dividendo: $'

.CODE
MAIN PROC
;
		MOV AX,@DATA
		MOV DS,AX

;exibindo cabeçalho
		LEA DX,MSG1;	
		MOV AH,9;		
		INT 21H;		
		LEA DX,MSG2
		MOV AH,9
		INT 21H
		LEA DX,MSG3
		MOV AH,9
		INT 21H
		LEA DX,MSG4
		MOV AH,9
		INT 21H
		LEA DX,MSG5
		MOV AH,9
		INT 21H
		LEA DX,MSG6
		MOV AH,9
		INT 21H
		LEA DX,MSG7
		MOV AH,9
		INT 21H
		LEA DX,MSG0
		MOV AH,9
		INT 21H
	
;pulando linha
JUMP1:	LEA DX,MSG0
		MOV AH,9
		INT 21H
	
;apresentacao do menu	
		LEA DX,MSG8
		MOV AH,9
		INT 21H
		LEA DX,MSG9
		MOV AH,9
		INT 21H
		LEA DX,MSG10
		MOV AH,9
		INT 21H
		LEA DX,MSG11
		MOV AH,9
		INT 21H
		LEA DX,MSG12
		MOV AH,9
		INT 21H
		LEA DX,MSG0
		MOV AH,9
		INT 21H

;receber opcao do menu
		LEA DX,MSG0
		MOV AH,9
		INT 21H
		MOV AH,1
		INT 21H 
		SUB AL,30h
		LEA DX,MSG0
		MOV AH,9
		INT 21H
		
;jump para opcao selecionada pt1
;jumps divididos em duas partes para evitar erro: relative jump out of range
		CMP AL,1
		JE SOMA
		CMP AL,2
		JE SUBT
		CMP AL,3 
		JE MULT
		
		JMP JUMP2
		
;soma		
SOMA:	LEA DX,MSG14
		MOV AH,9     
		INT 21H         
        MOV AH,1   
        INT 21H     
        MOV BL,AL  
		LEA DX,MSG15 
		MOV AH,9     
		INT 21H         
        MOV AH,1    
        INT 21H        
        MOV CL,AL  
		ADD CL,BL
		SUB CL,30h
		LEA DX,MSG16
		MOV AH,9    
		INT 21H       
		MOV AH,2
        MOV DL,CL
        INT 21H
		JMP JUMP1
		

;subtracao
SUBT:	LEA DX,MSG14
		MOV AH,9     
		INT 21H         
        MOV AH,1   
        INT 21H     
        MOV BL,AL  
		ADD BL,48
		LEA DX,MSG15 
		MOV AH,9     
		INT 21H         
        MOV AH,1    
        INT 21H        
        MOV CL,AL  
		SUB BL,CL
		LEA DX,MSG16
		MOV AH,9    
		INT 21H       
		MOV AH,2
        MOV DL,BL       
        INT 21H 
		JMP JUMP1
		
;multiplicacao
MULT:	LEA DX,MSG14
		MOV AH,9     
		INT 21H         
        MOV AH,1   
        INT 21H 
		MOV BL,AL
		SUB BL,30h
		LEA DX,MSG15
		MOV AH,9
		INT 21H
		MOV AH,1
		INT 21H
		SUB AL,30h
		MUL BL
		ADD AL,30h
		LEA DX,MSG16
		MOV AH,9    
		INT 21H       
		MOV AH,2
		MOV DL,AL
		INT 21H
		JMP JUMP1

;jump pt2
JUMP2:	CMP AL,4 
		JE DIVS
		CMP AL,5
		JE FIM

;mensagem para entrada invalida		
		LEA DX,MSG13
		MOV AH,9
		INT 21H
		JMP JUMP1
		
		
;divisao
DIVS:	LEA DX,MSG19
		MOV AH,9     
		INT 21H         
        MOV AH,1   
        INT 21H
		SUB AL,30h
		MOV CL,AL
		LEA DX,MSG18
		MOV AH,9     
		INT 21H         
        MOV AH,1   
        INT 21H
		MOV BL,AL
		SUB BL,30h
		MOV AH,0
		MOV AL,CL
		DIV BL
		ADD AL,30h
		MOV CL,AH
		ADD CL,30h
		LEA DX,MSG16
		MOV AH,9    
		INT 21H       
		MOV AH,2
		MOV DL,AL
		INT 21H
		LEA DX,MSG17
		MOV AH,9    
		INT 21H       
		MOV AH,2
		MOV DL,CL
		INT 21H
		JMP JUMP1
		
		
		
		
;sair		
FIM:	MOV AH,4CH
		INT 21H

MAIN ENDP
END MAIN