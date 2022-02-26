 TITLE   8086 Code Template (for EXE file)

       #MAKE_EXE#

DSEG    SEGMENT 'DATA'

Dots	DB 126, 17, 17, 17, 126, 65, 65, 127, 65, 65, 38, 73, 73, 73, 50, 38, 73, 73, 73, 50, 126, 17, 17, 17, 126, 1, 1, 127, 1, 1, 127, 2, 4, 8, 127, 126, 17, 17, 17, 126

DOTSA   DB 64D, 96D, 112D, 120D, 124D, 126D, 1D, 1D, 1D, 2D, 6D, 14D, 30D, 62D, 126D, 17D, 17D, 17D 
DOTSI   DB 1D, 1D, 1D, 1D,1D, 3D, 7D, 15D, 31D,63D, 127D, 65D, 65D, 127D, 65D, 65D
DOTSS   DB 2,1,1,1,2,6,9,9,9,18,50,73,73,73,38
DOT_T   DB 1D, 1D, 1D, 1D, 1D, 3D, 7D, 15D,31D, 63D, 127D
DOT_N   DB 64D,96D,112D,120D,124D,126D,127D,2D,4D,8D,1D,3D,7D,15D,31D,63D,127D


SG1 DB 2,6
SG3 DB 1,3,67,71,79 
SG4 DB 2,6,38,102,102,102
SEG_7  DB  1, 3, 7 
SEG_8  DB  1,3,7,15,31,63,127  
SEG_0  DB  1,3,7,15,31,63

WC DB 5

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
    	
       
        CALL PRINTA 
        
        CALL PRINTI
           
           
        CALL PRINTS
        MOV DI, 5
        CALL PRINTS
  
        
        MOV DI, 20
        CALL PRINTA
        CALL PRINTT
                
                
        CALL PRINTN           
        MOV DI, 35           
        CALL PRINTA 
        
        
        MOV DI, 0    
        MOV SI, 0
        MOV CX, 41
        
        
SHIFTER:
        PUSH SI
        PUSH CX
        MOV CX, 40
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
    CALL CLR
    
	
	MOV AX,4C00h
    INT 21h  
	
; return to operating system:
    RET
START   ENDP

;*******************************************

DELAY PROC
    PUSH CX
    MOV CX, 10
    DELAYLOOP: LOOP DELAYLOOP
    POP CX
    RET
DELAY ENDP

CLR PROC
    PUSH CX
    PUSH DX
    PUSH AX
    MOV DX,2000H
    MOV CX, 40
    MOV AX, 0
    CLR5LOOP: OUT DX, AX
    INC DX   
    LOOP CLR5LOOP
    MOV DX, 2030H
    MOV CX,8
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
    MOV BX, 40
    DIV BL
    MOV AL, AH
    MOV AH, 0
    MOV SI,AX
    POP BX
    POP AX
    RET
MODSI ENDP


PRINTA PROC 
    
          
          MOV CX,6
          MOV SI,0 
          MOV DX,2000H
          ADD DX, DI
          PRINT_A1:  
          CALL DELAY
          MOV AL,DOTSA[SI]  
          OUT DX,AL
          
          PUSH DX 
            
          CMP DI, 20
          JE PRIN4_A
          JG SKIP_A
           
          MOV AL, 8
          MOV DX, 2070H
          OUT DX, AL
           
          MOV DX, 2030H
          MOV AL, SG4[SI]
          
          JMP PRINTEND_A   
          
          MOV AL, 9
          MOV DX, 2070H
          OUT DX, AL  
    PRIN4_A:
              
          MOV DX, 2034H
          MOV AL, SG4[SI]
 
             
    PRINTEND_A:
          OUT DX, AL
             
    SKIP_A:  
    
          POP DX 
         
          INC SI
          LOOP PRINT_A1
          MOV DX,2001H
          ADD DX, DI
          MOV SI,6
          MOV CX, 3
          PRINT_A2:
          CALL DELAY
          MOV AL,DOTSA[SI]
          OUT DX,AL 
          INC SI 
          INC DX
          LOOP PRINT_A2
          
          MOV CX,6
          MOV DX,2004H 
          ADD DX, DI
          MOV SI,9
          PRINT_A3:
          CALL DELAY
          MOV AL,DOTSA[SI]
          OUT DX,AL
          INC SI       
          
          LOOP PRINT_A3  
          
          CMP DI, 35
          JNE SKIP_R
          
          MOV AL, 15
          MOV DX, 2070H
          OUT DX, AL
          
          MOV SI, 0
          MOV CX, 7
          
      PRINT8R:
          MOV DX, 2037H
          MOV AL, SEG_8[SI]
          OUT DX, AL
          INC SI
          LOOP PRINT8R
          
      SKIP_R:
          MOV SI,15
          MOV DX,2001H
          ADD DX, DI
          MOV CX, 3
          
          
          PRINT_A4:
          CALL DELAY
          MOV AL,DOTSA[SI]
          OUT DX,AL
          INC SI
          INC DX
          LOOP PRINT_A4 
          
          RET 
PRINTA ENDP  


PRINTI PROC
    
    MOV AL, 8
    MOV DX, 2070H
    OUT DX, AL

    MOV DX,2005H

    MOV SI,0
  
	
I_1:
	MOV AL,DOTSI[SI]
	OUT DX, AL
	
	INC SI
	INC DX
 
    CALL DELAY
    
	CMP SI, 5 
	JNE I_1     

 
    MOV DX,2007H       
I_2:
    MOV AL,DOTSI[SI]
	OUT DX, AL
	
	PUSH DX
	PUSH SI
	SUB SI, 5
	MOV DX, 2031h
	MOV AL, SEG_0[SI]
	OUT DX, AL
	
	POP SI
	POP DX	
	INC SI
		
    CALL DELAY
    
	CMP SI,11
	JB I_2      
       

    MOV DX,2005H	
I_3:
	MOV AL,DOTSI[SI]
	OUT DX, AL
	
	INC SI
	INC DX
 
    CALL DELAY
    
	CMP DX,200AH 
	JNE I_3     
    
    RET 
PRINTI ENDP    


PRINTSREV PROC
    MOV DX, 2000H
    ADD DX, DI
    ADD DX, 15
    MOV CX, 5
    PRINTER8:
    DEC DX
    MOV AL, DOTSS[SI]
    OUT DX, AL
    
    CALL DELAY
    
    INC SI
    LOOP PRINTER8
    RET 
PRINTSREV ENDP

PRINTS PROC  
    MOV AL, 9
    MOV DX, 2070H
    OUT DX, AL
    MOV SI, 0
    CALL PRINTSREV
    MOV CX, 5
    PRINTER9: 
    CALL DELAY
    MOV AL, DOTSS[SI]
    OUT DX, AL  
     
    PUSH DX 
    PUSH SI 
    SUB SI, 5 
    CMP DI, 0
    JNE PRIN3
    MOV DX, 2032H
    MOV AL, SG4[SI]
    JMP PRINTEND   
    
PRIN3:    
    MOV DX, 2033H
    MOV AL, SG3[SI]
      
    PRINTEND:
    OUT DX, AL
     
    POP SI
    POP DX
    
    INC DX
    INC SI
    LOOP PRINTER9
    MOV SI, 10
    CALL PRINTSREV
    
    RET
PRINTS ENDP 

PRINTT PROC
         
         MOV DX, 2070H
         MOV AL, 13
         OUT DX, AL
        
         MOV SI,0
         MOV DX,2019H
         MOV AL,DOT_T[SI]
         OUT DX,AL 
         CALL DELAY
         MOV SI,0
         MOV DX,2035H
         MOV AL,SEG_7[SI] 
         OUT DX,AL 
         CALL DELAY
         MOV SI,1
         MOV DX,201AH
         MOV AL,DOT_T[SI]
         OUT DX,AL 
         CALL DELAY
         MOV SI,1
         MOV DX,2035H
         MOV AL ,SEG_7[SI]
         OUT DX,AL 
         CALL DELAY
         MOV SI,2
         MOV DX,201BH
         MOV AL,DOT_T[SI]
         OUT DX,AL 
         CALL DELAY
         MOV SI,2
         MOV DX,2035H
         MOV AL,SEG_7[SI]
         OUT DX,AL 
         CALL DELAY
         MOV SI,3
         MOV DX,201CH 
         MOV AL,DOT_T[SI]
         OUT DX,AL 
         CALL DELAY
         MOV SI,4
         MOV DX,201DH 
         MOV AL,DOT_T[SI]
         OUT DX,AL 
         CALL DELAY
         MOV SI,5
         MOV DX,201BH
         PRINT_T:
         
         CALL DELAY
         MOV AL,DOT_T[SI]
         OUT DX,AL 
         
         INC SI 
         CMP SI,11
         JNE PRINT_T
           
         RET
PRINTT ENDP


PRINTN PROC
    MOV DX, 2070H
    MOV AL, 15
    OUT DX, AL
    
    MOV DX,201EH 
    MOV SI,0 
    MOV CX,7
    PRINT_N1:
    CALL DELAY
    MOV AL,DOT_N[SI]
    OUT DX,AL
    INC SI 
    LOOP PRINT_N1
    MOV SI,7
    MOV DX,201FH
    MOV CX,3
    PRINT_N2:
    CALL DELAY
    MOV AL,DOT_N[SI]
    OUT DX,AL
    INC SI 
    INC DX 
    LOOP PRINT_N2
    MOV DX,2022H
    MOV SI,11
   
    PRINT_N3:
    CALL DELAY
    MOV AL,DOT_N[SI]
    OUT DX,AL
    PUSH DX
    PUSH SI
    SUB SI, 11 
     
          
    MOV DX, 2036H
    MOV AL, SG4[SI]
    OUT DX, AL
    POP SI
    POP DX
     
    INC SI
    CMP SI,17
    JNE PRINT_N3
      
     
    RET 

PRINTN ENDP



CSEG    ENDS 

        END    START   ; set entry point.

