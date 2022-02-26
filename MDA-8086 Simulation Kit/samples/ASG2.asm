TITLE   8086 Code Template (for EXE file)

;       AUTHOR          emu8086
;       DATE            ?
;       VERSION         1.00
;       FILE            ?.ASM

; Note: Set the delay to 100 ms in Emu 8086 and to 10 ms 
;       in I/O Emulation Kit to get best results for this sample
;       (i.e., the delay of I/O Emulation Kit is much smaller than
;        the delay of Emu8086).

; 8086 Code Template

; Directive to make EXE output:
       #MAKE_EXE#

DSEG    SEGMENT 'DATA'

; TODO: add your data here!!!!

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


	MOV DX, 2070h
	MOV AL, 0h
	OUT DX, AL
	CALL DELAY
	
	;; 0001 - R1
	;; 0010 - Y
	;; 0100 - G
	;; 1000 - R2


;;R2ON
MOV AL, 1000b
OUT DX, AL
CALL DELAY
	
;;R2YON
OR AL, 0010b
OUT DX, AL
CALL DELAY

;;R2YGON
OR AL,0100b
OUT DX, AL
CALL DELAY

;;YOFFR2GON
AND AL, 1101b 
OUT DX, AL
CALL DELAY


;;R2GONR1ON
OR AL, 0001b
OUT DX, AL 
CALL DELAY

	
	

; return to operating system:
	RET
START   ENDP

;*******************************************
DELAY PROC
    PUSH CX
    MOV CX, 80
    DELAYLOOP: LOOP DELAYLOOP
    POP CX
    RET
DELAY ENDP

CSEG    ENDS 

        END    START    ; set entry point.

