TITLE   8086 Code Template (for EXE file)

;       AUTHOR          emu8086
;       DATE            ?
;       VERSION         1.00
;       FILE            ?.ASM

; 8086 Code Template

; Directive to make EXE output:
       #MAKE_EXE#

DSEG    SEGMENT 'DATA'

Dots	DB	00000100b, 00000110b, 00000101b, 00000110b, 00000100b ; A

	
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
    	MOV     DS, AX
    	MOV     ES, AX
        
        MOV BX, 0
        MOV SI, 0
        PUSH 2000h

NEXT:
    POP DX
	MOV AL,Dots[SI]
	out dx,al
	INC DX
	
	PUSH DX
	
		
    LED:
	MOV DX, 2070h
	MOV AL, 01h
	OUT DX, AL
	
	SG:	
	
	CALL DELAY

    MOV DX, 2030h
	MOV AL,NUMBERS[SI]
	out dx,al
	INC SI
    
	CMP SI, 5
	JNZ NEXT
	
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

CSEG    ENDS 

        END    START   ; set entry point.

