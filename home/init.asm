; Game initialization
; 1. Disable interrupts and clear registers
; 2. Disable LCD display
; .
; ..
; ...
Init::

; * LCD enabled
; * Window tile map at $9C00
; * Window display disabled
; * BG and window tile data at $8800
; * BG tile map at $9800
; * 8x8 OBJ size
; * OBJ display enabled
; * BG display disabled    
; example halt loop

;rLCDC_DEFAULT EQU %11000010

; TODO apply after initialization
rLCDC_DEFAULT EQU LCDCF_ON \
                + LCDCF_WIN9C00 \
                + LCDCF_WINOFF \
                + LCDCF_BG8800 \
                + LCDCF_BG9800 \
                + LCDCF_OBJ8 \
                + LCDCF_OBJON \
                + LCDCF_BGOFF

    di

	xor a
	ldh [rIF], a
	ldh [rIE], a
	ldh [rSCX], a
	ldh [rSCY], a
	ldh [rSB], a
	ldh [rSC], a
	ldh [rWX], a
	ldh [rWY], a
	ldh [rTMA], a
	ldh [rTAC], a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a

	ld a, LCDCF_ON			; only LCD on, reset other bits
	ldh [rLCDC], a
	call DisableLCD

; TODO clear VRAM, tiles DATA, BG Map...
; TODO prepare DMA transfer in HRAM
; TODO set rLCDC_DEFAULT

; template infinite loop
.loop
    halt
    jr .loop
