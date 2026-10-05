;Copyright (c) 2026 KungFusedMike
; 
;cycle_subweapon.asm
;
;This code runs during active game on start press.
;cycles to the next sub weapon to use
;current weapon index is stored in $d9
;current weapon inventory is stored on the turtle
;turtle index is at $da
;
;weird thing with this game is you cannot transition to game over if you don't go
;actually go into pause state. so I have to check for turtle health
;
; Entry point: File Address: 0x1CE09, CPU Address: $CDF9
; Payload:     File Address: 0x1FF10, CPU Address: $FF00

; Entry Point

JMP	$FF00	;CDF9  4C 00 FF

; Payload

LDX $DA 	;FF00  A6 DA

LDA $77,X 	;FF02  B5 77	current health zero? do pause screen
BEQ $FF0A 	;FF04  F0 04

;only do weapon cycling in sub areas
LDA $5C 	;FF06  A5 5C
BNE $FF11 	;FF08  D0 07

STY $35 	;FF0A  84 35	pause and exit
LDA $FF 	;FF0C  A5 FF 	destroyed instruction from jump
JMP $CDFD 	;FF0E  4C FD CD

LDA $A8,X 	;FF11  B5 A8	get turtle quantity for current weapon
LDX $D9 	;FF13  A6 D9 	weapon index
STA $D4,X 	;FF15  95 D4 	update weapon quantity in my zp variables

;cycle to next weapon and wrap around if necessary
INX 		;FF17  E8 		
CPX #$05 	;FF18  E0 05
BCC $FF1E 	;FF1A  90 02
LDX #$01 	;FF1C  A2 01

TXA 		;FF1E  8A
PHA 		;FF1F  48

STX $D9 	;FF20  86 D9 save new weapon index

;swap weapons and quantities
LDA $D4,X 	;FF22  B5 D4 
LDX $DA 	;FF24  A6 DA
STA $A8,X 	;FF26  95 A8
PLA 		;FF28  68
STA $73,X 	;FF29  95 73

LDA $FF 	;FF2B  A5 FF   	destroyed instruction from jump
JMP $CDFD 	;FF2D  4C FD CD