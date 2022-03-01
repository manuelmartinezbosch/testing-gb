; ----------------------------------------------------
; Game initialization
; ----------------------------------------------------
; 1. Disable interrupts and clear registers
; 2. Disable LCD display
; 3. New sp to WRAM
; 4. Clear WRAM
; 5. Clear VRAM
; 6. Clear HRAM
; 7. Clear OAM Sprites
; 8. Prepare DMA transfer
; 9. Reset registers for LCD
; 10. Reset rIF and enable v-Blank interrupt
; 11. Move the window off-screen
; 12. Clear BG Maps with white space
; 13. Disable audio
; 14. Set rLCDC_DEFAULT (on-screen)
; ---------------------------------------------------
Init::

; * LCD enabled
; * Window tile map at $9C00
; * Window display enabled
; * BG and window tile data at $8800
; * BG tile map at $9800
; * 8x8 OBJ size
; * OBJ display enabled
; * BG display enabled    

rLCDC_DEFAULT EQU LCDCF_ON \
                + LCDCF_WIN9C00 \
                + LCDCF_WINON \
                + LCDCF_BG8800 \
                + LCDCF_BG9800 \
                + LCDCF_OBJ8 \
                + LCDCF_OBJON \
                + LCDCF_BGON

; 1. Disable interrupts and clear registers
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

; 2. Disable LCD display
	ld a, LCDCF_ON					; only LCD on, reset other bits
	ldh [rLCDC], a
	call DisableLCD

; 3. new stack pointer to WRAM
	ld sp, wStack
	
; 4. clear WRAM
	ld hl, WRAM0_Begin
	ld bc, WRAM1_End - WRAM0_Begin
	xor a
	ld d, a
.loop
	ld a, d
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop

; 5. clear VRAM
	ld hl, VRAM_Begin
	ld bc, VRAM_End - VRAM_Begin
	call FillMemory
	
; 6. clear HRAM
	ld hl, HRAM_Begin
	ld bc, HRAM_End - HRAM_Begin
	call FillMemory

; 7. clear OAM sprites
	call ClearSprites

; 8. prepare DMA transfer	
	ld a, BANK(WriteDMACodeToHRAM)
	ldh [hLoadedROMBank], a
	ld [MBC1RomBank], a
	call WriteDMACodeToHRAM

; 9 reset registers for LCD
	xor a
	ldh [rSTAT], a
	ldh [hSCX], a
	ldh [hSCY], a
	
; 10. reset rIF and enable v-Blank interrupt	
	ldh [rIF], a
	ld a, IEF_VBLANK
	ldh [rIE], a

; 11. Move the window off-screen	
	ld a, 144
	ldh [hWY], a
	ldh [rWY], a
	ld a, 7
	ldh [rWX], a

; 12 clear BG Maps with white space
	ld h, HIGH(vBGMap0)
	call ClearBgMap
	ld h, HIGH(vBGMap1)
	call ClearBgMap


; 13. disable audio
	ld a, AUDENA_OFF
	ldh [rAUDENA], a

; 14. set rLCDC_DEFAULT (on-screen)

	ld a, rLCDC_DEFAULT
	ldh [rLCDC], a

	ei
; example halt loop	
.haltLoop
	halt
	nop 
	nop
	nop
	jr .haltLoop
