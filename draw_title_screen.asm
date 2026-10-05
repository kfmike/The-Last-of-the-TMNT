;Copyright (c) 2026 KungFusedMike
; 
;draw_title_screen.asm
; 
;
;This code runs while on the title screen
;draws current selected turtle portrait
;draws my signature
;
; Entry point: File Address: 0x1C313, CPU Address: $C303
; Payload:     File Address: 0x1FF5B, CPU Address: $FF4B


; Entry Point

JMP	$FF4B	;C303  4C 4B FF

; Payload

TXA				;FF4B  8A
PHA 			;FF4C  48 		graphical glitches if you don't preseve x

;game sub state needs to be 2 for title screen
LDA $1C 		;FF4D  A5 1C
CMP #$02 		;FF4F  C9 02
BNE $FF8B 		;FF51  D0 38

LDA $C9 		;FF53  A5 C9		current turtle index
TAX 			;FF55  AA

;draw first row of portrait
LDA #$20 		;FF56  A9 20 		set up x/y of first row of portrait tiles
STA $2006 		;FF58  8D 06 20
LDA #$93 		;FF5B  A9 93
STA $2006 		;FF5D  8D 06 20
LDA $FF93,X 	;FF60  BD 93 FF 	first row tile data stored at FF93
JSR $FF9B 		;FF63  20 9B FF

;draw second row of portrait
LDA #$20 		;FF66  A9 20 		set up x/y of second row of portrait tiles
STA $2006 		;FF68  8D 06 20
LDA #$B3 		;FF6B  A9 B3
STA $2006 		;FF6D  8D 06 20
LDA $FF97,X 	;FF70  BD 97 FF 	second row tile data stored at FF97
JSR $FF9B 		;FF73  20 9B FF

;draw signature
LDA #$22 		;FF76  A9 22 		set up x/y for signature
STA $2006 		;FF78  8D 06 20
LDA #$34 		;FF7B  A9 34
STA $2006 		;FF7D  8D 06 20
LDX #$06 		;FF80  A2 06

LDA $FFA7,X 	;FF82  BD A7 FF 	signature tile data ENDS at FFA7
STA $2007 		;FF85  8D 07 20 	loop backwards from FFA7 drawing tiles
DEX 			;FF88  CA
BNE $FF82 		;FF89  D0 F7

;exit code
PLA 			;FF8B  68
TAX 			;FF8C  AA
STX $0300 		;FF8D  8E 00 03 	;destroyed instruction from jump
JMP $C306 		;FF90  4C 06 C3

FF93 		;39 CA CD EA first row first tile ID for each turtle. inc by 1 to draw each
FF9A 		;BC DA DD ED second row first tile ID for each turtle. inc by 1 to draw each

;draw subroutine for portrait
TAY 			;FF9B  A8
STY $2007 		;FF9C  8C 07 20
INY 			;FF9F  C8
STY $2007 		;FFA0  8C 07 20
INY				;FFA3  C8
STY $2007 		;FFA4  8C 07 20
RTS 			;FFA7  60

FFA8		;B0 30 3F 3E 3D 3C signature tile data stored backwards for dex loop above