;Copyright (c) 2026 KungFusedMike
; 
;char_select.asm
; 
;
;This code runs during attract mode/title screen
;cycles through the selected turtle, storing index in zero page $c9
;if zero page $d9 has been set, game started, so exit
;
; Entry point: File Address: 0x1C40F, CPU Address: $C3FF
; Payload:     File Address: 0x1FF40, CPU Address: $FF30


; Entry Point

JMP	$FF30	;C3FF  4C 30 FF

; Payload

;test for select and exit if not
LDX $31		;FF30  A6 31
CPX #$20	;FF32  E0 20
BNE $FF45	;FF34  D0 0F

;zero page d9 already set? exit
LDX $D9		;FF36  A6 D9
BNE $FF45	;FF38  D0 0B

;load current turtle index, increment and wrap if necessary
LDX $C9		;FF3A  A6 C9
INX		;FF3C  E8
CPX #$04	;FF3D  E0 04
BCC $FF43	;FF3F  90 02
LDX #$00	;FF41  A2 00
STX $C9		;FF43  86 C9
JSR $C413	;FF45  20 13 C4 	;destroyed instruction from jump
JMP $C402	;FF48  4C 02 C4
