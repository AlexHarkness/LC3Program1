;ECE 109
;PROGRAM 1 ODD SUM
;submited on 3/26/22
;This program takes input of two numbers 0-16 and sums the odds between them and returns the resualt 


    .ORIG x3000
TOP
;R1 is active dig
;new line
    AND R3 R3 #0
    AND R4 R4 #0 ; N1
    ADD R4,R4,#-1 ;SETS R4 TO NEG, WILL BI USED AS FLAG FOR WHICH REG TO STORE INPUT IN
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

    ADD R1, R0, #-10 ;checks if return is pressed before out
    BRZ SKIPENTER
    LD R6, ASCII_Q ;Q
    ADD R1, R0, R6 ;Q
    BRZ END_GAME ;Q
    OUT
SKIPENTER
;converting ascii to binary
;checking for quit

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
    ADD R1, R0, #-10 ;checks if return is pressed before out
    BRZ RETURN
    LD R6, ASCII_Q
    ADD R1, R0, R6
    BRZ END_GAME ;checking for quit
    OUT
;converting ascii to binary
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
    ADD R4, R4, #0 ; CHECKS R4 NEGATIVEFLAG
    BRN FIRST_TIME 
    BR SECOND_TIME
FIRST_TIME
    ADD R4, R2, R3 ; R4 CHANGED FLAG GONE
    AND R3,R3,#0 ; FIXES THE STUPID ERROR!!!
    AND R0 R0 #0
    ADD R0 R0 #10
    OUT
    LEA R0, ENTER_SECOND  
    PUTS
    BR GET_UR_NUMBER 
SECOND_TIME
    ADD R5, R2, R3 ;stores 

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

    ADD R2, R4, #0
    BRZ EVEN1

MIN
    ADD R2, R2, #-2
    BRN ODD1
    BRP MIN
EVEN1
    
    NOT R7, R4     ;Here we do a check to see if we have an even, even case and send to end if so
    ADD R7, R7, #1
    ADD R7, R7, R5
    BRZ ODDS_SUMMED
    ADD R4, R4, #1
ODD1

    ADD R3, R5, #0
    BRZ EVEN2
MAX
    ADD R3, R3, #-2
    BRN ODD2
    BRP MAX
EVEN2
    ADD R5, R5, #-1
ODD2
    NOT R5, R5 
    ADD R5, R5, #1 ;r5 is the negative of my max
    AND R2, R2, #0 
SUMNEXT     ;this is my sum code
    ADD R2, R2, R4 ;r2 is sum, add r2 + the odd we are on
    ADD R4, R4, #2 ; r4 is odd ffset  we increase it by 2 each loop
    ADD R7, R4, R5; use trash reg r7 to test if r4 <= max, if so we loop to top
    BRNZ SUMNEXT
ODDS_SUMMED          ;we have summed odds and now ON TO OUTPUT CODE
    AND R3, R3, #0  ; clears R3
    BR DIVSTART ; STARTS our division by ten uses jump to jump in after the first divide in case the num <10
    DIV
        ADD R3, R3, #1 ;R3 IS TENS DIG
        ADD R2, R2, #-10 ; subs 10
        DIVSTART
        ADD R7, R2, #-9 ; checks if it is less than 9
        BRP DIV ; repeates if positive
        ;R2 IS ONES DIG
    AND R0, R0, #0
    ADD R0, R0, #10 ;new line code
    OUT
    LEA R0, ENDNUMB  ;loads and prints resualt prompt
    PUTS
    LD R1, NUMB ; ascii offset

    ADD R3, R3, #0 ;checks if tens place is zero if so skips
    BRZ SKIP_D1
    ADD R0, R3, R1 ; adds offset
    OUT ;prints
SKIP_D1
    ADD R0, R2, R1 ;adds 1s place and offset
    OUT ;printss
    BR TOP


END_GAME
    AND R0, R0, #0
    ADD R0, R0, #10
    OUT
    LEA R0, END_STRING
    PUTS
    HALT

;ALL VALUES THAT WILL BE LOADED
    ENDNUMB .STRINGZ "The sum of every odd number between the two numbers is: "
    ENTER_FIRST .STRINGZ "Enter Start Number (0-16): "
    ENTER_SECOND .STRINGZ "Enter End Number (0-16): "
    END_STRING .STRINGZ "Thank you for playing!"
    ASCII_Q .FILL #-113
    ASCII .FILL #-48
    NUMB .FILL #48
.END