;Copyright (c) 2026 KungFusedMike
; 
;start_game.asm
; 
;
;This code runs on game start from the title screen.
;sets sub weapons and turtles up
;zero page $c9 holds the selected turtle on entry
;
; Entry point: File Address: 0x1CB5B, CPU Address: $CB4B
; Payload:     File Address: 0x1FEE7, CPU Address: $FED7


; Entry Point

JMP	$FED7	;CB4B  4C D7 FE

; Payload

STA $55		;FED7  85 55	set technodrome RNG (destroyed from jump)

LDX $F9		;FED9  A6 F9    get index of selected turtle 
STX $DA 	;FEDB  86 DA	save it in DA since F9 needs to be cleared for next game
LDA #$00 	;FEDD  A9 00
STA $F9 	;FEDF  85 F9

;load sub weapon quantity
LDA #$14	;FEE1  A9 14 	
STA $D5 	;FEE3  85 D5
STA $D6 	;FEE5  85 D6
STA $D7 	;FEE7  85 D7
STA $D8 	;FEE9  85 D8
STA $A8,X 	;FEEB  95 A8	save in turtle quantity

LDA #$01 	;FEED  A9 01 	default to single stars
STA $D9 	;FEEF  85 D9 	current wepaon index variable
STA $73,X 	;FEF1  95 73 	set on turtle

STX $67		;FEF3  86 67    select active turtle
LDA #$80 	;FEF5  A9 80 	set turtle to max health
STA $77,X 	;FEF7  95 77 
INC $34 	;FEF9  E6 34 	destroyed instruction #2 from entry point jump
JMP $CB4F 	;FEFB  4C 4F CB