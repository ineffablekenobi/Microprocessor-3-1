TITLE   8086 Code Template (for EXE file)

;       AUTHOR          emu8086
;       DATE            ?
;       VERSION         1.00
;       FILE            ?.ASM

; 8086 Code Template

; Directive to make EXE output:
       #MAKE_EXE#

DSEG    SEGMENT 'DATA'

Dots	DB	00000100b, 00000110b, 00000101b, 00000110b, 00000100b  ; A
	DB	0, 0, 0, 0, 0  ; B
	DB	0, 0, 0, 0, 0  ; C
	DB	0, 0, 0, 0, 0  ; D
	DB	0, 0, 0, 0, 0  ; E
	DB	0, 0, 0, 0, 0  ; F
	DB	0, 0, 0, 0, 0  ; G
	DB	0, 0, 0, 0, 0  ; H

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
	MOV     AX, DSEG
    	MOV     DS, AX
    	MOV     ES, AX


	MOV DX,2000h	; first DOT MATRIX digit
	MOV BX, 0

MAINLOOP:
	MOV SI, 0
	MOV CX, 5

NEXT:
	MOV AL,Dots[BX][SI]
	out dx,al
	INC SI
	INC DX

	CMP SI, 5
	LOOPNE NEXT

	ADD BX, 5
	CMP BX, 40
	JL MAINLOOP
	
	MOV DX, 2070h
	MOV AL, 01h
	OUT DX, AL

; return to operating system:
    RET
START   ENDP

;*******************************************

CSEG    ENDS 

        END    START    ; set entry point.

