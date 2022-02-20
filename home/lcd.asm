; Disables the LCD display
; 1. Backup rIE and disable VBlank interrupt
; 2. Wait vBlank period to disable LCD
; 3. Disable LCD
DisableLCD::
	xor a
	ldh [rIF], a
	ldh a, [rIE]
	ld b, a                 ; backup rIE in b
	res 0, a                ; disable vBlank interrupt
	ldh [rIE], a

.wait
	ldh a, [rLY]
	cp LY_VBLANK
	jr nz, .wait

	ldh a, [rLCDC]          ; disable LCD display
	and ~LCDCF_ON           
	ldh [rLCDC], a
	ld a, b
	ldh [rIE], a
	ret

; Enables the LCD display   
EnableLCD::
	ldh a, [rLCDC]
	set rLCDC_ENABLE, a
	ldh [rLCDC], a
	ret
