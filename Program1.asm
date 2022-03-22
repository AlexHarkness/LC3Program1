.ORIG x3000
TOP
;R1 is active dig
;new line
AND R3 R3 #0
AND R4 R4 #0 ; N1
ADD R4,R4,#-1
AND R5 R5 #0 ; N2
AND R0 R0 #0
ADD R0 R0 #10
OUT
AND R0 R0 #0
;output prompt
LEA R0, ENTER_FIRST  
PUTS
;

GET_UR_NUMBER 

GET_FIRST_CHAR;grab and echo
GETC
OUT
;converting ascii to binary
;checking for quit
LD R6, ASCII_Q ;Q
ADD R1, R0, R6 ;Q
BRZ END_GAME ;Q
LD R6, ASCII ;<48
ADD R0, R0, R6 ;<48
BRN GET_FIRST_CHAR ;<48
ADD R1, R0, #-9 ;>57
BRP GET_FIRST_CHAR ;>57
ADD R2, R0, #0 ;set value
ADD R1, R2, #-1 
BRP RETURN ;if r2 > 1

GET_SECOND_CHAR;grab and echo
GETC
OUT
;converting ascii to binary
;checking for quit
LD R6, ASCII_Q
ADD R1, R0, R6
BRZ END_GAME
ADD R1, R0, #-10
BRZ RETURN
LD R6, ASCII
ADD R0, R0, R6
BRN GET_SECOND_CHAR
ADD R1, R0, #-6
BRP GET_SECOND_CHAR
ADD R3, R0, #0
ADD R1, R2, #0;if first dig is 0 skips place ajustment
BRZ RETURN
ADD R2, R2, #9 ; adds 9 to ajust for 10s place

RETURN
ADD R4, R4, #0
BRN FIRST_TIME
BR SECOND_TIME
FIRST_TIME
    ADD R4, R2, R3
    AND R0 R0 #0
    ADD R0 R0 #10
    OUT
    LEA R0, ENTER_SECOND  
    PUTS
    BR GET_UR_NUMBER 
SECOND_TIME
    ADD R5, R2, R3

NOT R5, R5
ADD R5, R5, #1
ADD R0, R4, R5
BRP R4_GREATER_R5
    NOT R5, R5
    ADD R5, R5, #1
BR NEXT
R4_GREATER_R5
    NOT R5, R5
    ADD R5, R5, #1
    ADD R0, R5, #0
    ADD R5, R4, #0
    ADD R4, R0, #0
NEXT ; 5>4

ADD R0, R4, #0 ;set r0 to r4
AND R4, R4, #0 ; clear r4
ADD R4, R4, #-1; r4 = -1
DIV1
ADD R4, R4, #1
ADD R0, R0, #-2
BRP DIV1

ADD R0, R5, #0
AND R5, R5, #0
DIV2
ADD R5, R5, #1
ADD R0, R0, #-2
BRP DIV2









END_GAME
HALT

ENTER_FIRST .stringz "Enter Start Number (0-16): "
ENTER_SECOND .STRINGZ "ENTER SECOND NUMBER "
ASCII_Q .FILL #-81
ASCII .FILL #-48


.END