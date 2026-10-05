;Copyright (c) 2026 KungFusedMike
; 
;misc.asm

;-------------------------------------------------
;ENEMY DAMAGE
;-------------------------------------------------

;I didn't feel like messing with the health logic to support > 0x80 health
;Instead, i halved all enemy dmg - values are at File Offset: 0x18B10 to 0x18BC0

;-------------------------------------------------
;STATIC WEAPON DROPS
;-------------------------------------------------

;weapons that appear in the stages ar bit masked off here if they have been collected
;just bitmask them off so they never appear
;
; scrolls = 0x08
; triple sure you cans = 0x20
; boomeragns = 0x40
;
; File Address: 0x1FE64: set to 68

;-------------------------------------------------
; Random Drops
;-------------------------------------------------

;just branch out before it drops

;File Address: 0x1475D: set to F0 23

;-------------------------------------------------
; Rescue Turtles
;-------------------------------------------------

;never check zp $56 for if turtle has been rescued. hard code to 1

;File Address: 0x13944: set to A9 01
