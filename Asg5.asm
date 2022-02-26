 TITLE   8086 Code Template (for EXE file)

       #MAKE_EXE#

DSEG    SEGMENT 'DATA'

Dots	DB 68d, 66d, 255d, 64d, 64d, 38d, 73d, 73d, 73d, 50d, 8d, 12d, 10d, 255d, 8d, 38d, 73d, 73d, 73d, 50d,34d, 65d, 73d, 73d, 54d
DOTS1 DB 4d, 2d, 1d, 3d, 7d, 15d, 31d, 63d, 68d, 66d, 127d, 64d, 64d
DOTS3 DB 2,1,1,1,2,6,9,9,22,54,73,73,65,34
DOTSS DB 2,1,1,1,2,6,9,9,9,18,50,73,73,73,38
DOTS4 DB 1,3,7,15,31,63,127,2,4,8,12,10,127,8
SG1 DB 2,6
SG3 DB 1,4,7,15,79
SG4 DB 2,6,38,102,102,102,102
WC DB 5

NUMBERS	DB 00001000b, 00011000b, 00111000b, 01111000b, 01111000b

DSEG    ENDS

SSEG    SEGMENT STACK   'STACK'
        DW      100h    DUP(?)
SSEG    ENDS

CSEG    SEGMENT 'CODE'

;*******************************************

START   PROC    FAR

; Store return address to OS:
    PUSH    DS
    MOV     AX, 0
    PUSH    AX

; set segment registers:
	    MOV AX, DSEG
    	MOV DS, AX
    	MOV ES, AX 
    	
    	
    	 
WRAPPER:
    	
    	DEC WC
    	
    	CALL CLR
    	
       
        CALL PRINT1
        
        CALL PRINTS
        
    	CALL PRINT4
        
        MOV DI, 10
        CALL PRINTS
        MOV DI, 0
        
        
        MOV DX, 2070H
        MOV AL, 02H
        OUT DX, AL
        
        
        CALL PRINT3
        
        
        
            
        MOV SI, 0
        MOV CX, 26
        
        
SHIFTER:
        PUSH SI
        PUSH CX
        MOV CX, 25
        MOV BX, 0
        
        PUSH 2000h
NEXT:
    POP DX
    CALL MODSI
	MOV AL,Dots[SI]
	out dx,al
	INC DX
	PUSH DX
	INC SI
    LOOP NEXT
    
    POP DX
    POP CX
    POP SI
    ADD SI, 1
    LOOP SHIFTER
    CMP WC, 0
    JNZ WRAPPER
    
	
	MOV AX,4C00h
    INT 21h  
	
; return to operating system:
    RET
START   ENDP

;*******************************************

DELAY PROC
    PUSH CX
    MOV CX, 160
    DELAYLOOP: LOOP DELAYLOOP
    POP CX
    RET
DELAY ENDP

CLR PROC
    PUSH CX
    PUSH DX
    PUSH AX
    MOV DX,2000H
    MOV CX, 26
    MOV AX, 0
    CLR5LOOP: OUT DX, AX
    INC DX   
    LOOP CLR5LOOP
    MOV DX, 2030H
    MOV CX,3
    CLRSG: OUT DX, AL
    INC DX
    LOOP CLRSG
    
    MOV DX, 2070H
    OUT DX, AL
    
    POP AX
    POP DX
    POP CX
    RET
CLR ENDP

MODSI PROC 
    PUSH AX
    PUSH BX
    MOV AX, SI
    MOV BX, 25
    DIV BL
    MOV AL, AH
    MOV AH, 0
    MOV SI,AX
    POP BX
    POP AX
    RET
MODSI ENDP

PRINT1 PROC
    MOV CX, 2
    MOV SI, 0
    MOV DX, 2000H
    PRINTER1:
    CALL DELAY
    MOV AL, DOTS1[SI]
    OUT DX, AL
    PUSH DX
    MOV DX, 2030H
    MOV AL, SG1[SI]
    OUT DX, AL
    POP DX
    INC DX
    INC SI
    LOOP PRINTER1
    MOV CX,6
    PRINTER2:  
    CALL DELAY
    MOV AL, DOTS1[SI]
    OUT DX,AL
    INC SI
    LOOP PRINTER2
    MOV DX,2000H
    MOV CX, 5
    PRINTER3:   
    CALL DELAY
    MOV AL, DOTS1[SI]
    OUT DX, AL
    INC SI
    INC DX
    LOOP PRINTER3
    RET
PRINT1 ENDP

PRINT3 PROC
    MOV CX, 5
    MOV SI, 0
    MOV DX, 2000H
    ADD DX, 20
    PRINTER4: 
    CALL DELAY
    MOV AL, DOTS3[SI]
    OUT DX, AL
    PUSH DX
    MOV DX, 2032H
    MOV AL, SG3[SI]
    OUT DX, AL
    POP DX
    INC SI
    INC DX
    LOOP PRINTER4
    MOV CX,3
    PRINTER5:    
    CALL DELAY
    DEC DX
    MOV AL, DOTS3[SI]
    OUT DX, AL
    INC SI
    LOOP PRINTER5
    ADD DX, 2
    MOV CX, 2
    PRINTER6: 
    CALL DELAY
    MOV AL, DOTS3[SI]
    OUT DX, AL
    INC SI
    LOOP PRINTER6
    MOV CX, 4
    PRINTER7: 
    CALL DELAY
    DEC DX
    MOV AL, DOTS3[SI]
    OUT DX, AL
    INC SI
    LOOP PRINTER7
    RET
PRINT3 ENDP

PRINTSREV PROC
    MOV DX, 2000H
    ADD DX, DI
    ADD DX, 10
    MOV CX, 5
    PRINTER8: 
    CALL DELAY
    DEC DX
    MOV AL, DOTSS[SI]
    OUT DX, AL
    INC SI
    LOOP PRINTER8
    RET 
PRINTSREV ENDP

PRINTS PROC
    MOV SI, 0
    CALL PRINTSREV
    MOV CX, 5
    PRINTER9:  
    CALL DELAY
    MOV AL, DOTSS[SI]
    OUT DX, AL
    INC DX
    INC SI
    LOOP PRINTER9
    MOV SI, 10
    CALL PRINTSREV
    
    RET
PRINTS ENDP

PRINT4 PROC
    MOV SI, 0
    MOV CX, 7
    MOV DX, 2000H
    ADD DX, 13
    PRINTER10: 
    CALL DELAY
    MOV AL, DOTS4[SI]
    OUT DX, AL
    PUSH DX
    MOV DX, 2031H
    MOV AL, SG4[SI]
    OUT DX, AL
    POP DX
    INC SI
    LOOP PRINTER10
    MOV CX, 3
    PRINTER11:   
    CALL DELAY
    DEC DX
    MOV AL, DOTS4[SI]
    OUT DX, AL
    INC SI
    LOOP PRINTER11
    MOV CX, 4
    PRINTER12: 
    CALL DELAY
    INC DX
    MOV AL, DOTS4[SI]
    OUT DX, AL
    INC SI
    LOOP PRINTER12
    RET
PRINT4 ENDP

CSEG    ENDS 

        END    START   ; set entry point.

