ORG 0000H
MOV P2,#0FFH
MOV R7,#00H
MOV P1,#0FFH
MOV R1,#00H
MOV R2,#00H
MOV P0,#0C0H
MOV P3,#0C0H
AJMP START
BEGIN:
MOV P1,#0FFH
MOV P2,#0FFH
INC R7					;ROUND +1
CJNE R7,#3,START		;IF ROUND=3,GAMEOVER
MOV A,R1				;WHO IS FINAL WINNER
CLR C
SUBB A,R2
JB ACC.7,WIN2
JZ DRAW
AJMP WIN1
WIN1:
MOV P0,#00000000B
MOV P3,#11111111B
MOV R5,#20          ;SET DELAY TO 2S
LCALL DELAY
MOV R7,#00H
AJMP START
WIN2:
MOV P3,#00000000B
MOV P0,#11111111B
MOV R5,#20          ;SET DELAY TO 2S
LCALL DELAY
MOV R7,#00H
AJMP START
DRAW:
MOV P3,#00000000B
MOV P0,#00000000B
MOV R5,#20          ;SET DELAY TO 2S
LCALL DELAY
MOV R7,#00H
AJMP START
START: 
MOV R0,#11111110B ;select mode 1


JNB P1.0,DESIDED

MOV R0,#11111101B ;select mode 2?

JNB P1.0,DESIDED

MOV R0,#11111011B ;select mode 3

JNB P1.0,DESIDED

AJMP START

DESIDED:
MOV P2,R0         ;SEND THE NUMBER
MOV R5,#50        ;SET DELAY TO 5S
LCALL DELAY
MOV P2,#0FFH

MOV R3,#50
DITECT2:
MOV R4,#200
DITECT1:
MOV B,#230
DITECT:
JNB P2.6,SCORING1			;THE WINNER OF THIS REOUND
JNB P2.7,SCORING2
DJNZ B,DITECT
DJNZ R4,DITECT1
DJNZ R3,DITECT2
LJMP BEGIN

SCORING1:					;PLATER1 SCORE+1

INC R1

MOV A,R1

MOV DPTR,#TABLE7

MOVC A,@A+DPTR

MOV P0,A

LJMP BEGIN

SCORING2:					;PLAYER2 SCORE+1

INC R2

MOV A,R2

MOV DPTR,#TABLE7

MOVC A,@A+DPTR

MOV P3,A

LJMP BEGIN

DELAY:                       ;DELAY TIME
DL3: 
    MOV R4,#250
DL1: 
    MOV R3,#200
DL2: 
    DJNZ R3,DL2
	DJNZ R4,DL1
	DJNZ R5,DL3
    RET
TABLE7:						 ;TABLE OF 7SIGMENT
	DB 0C0H                  ;0
	DB 0F9H                  ;1
	DB 0A4H                  ;2
	DB 0B0H                  ;3
	DB 99H                   ;4
	DB 92H                   ;5
	DB 82H                   ;6
	DB 0F8H                  ;7
	DB 80H                   ;8
	DB 90H                   ;9
RET

END
