; Game initialization
; 1. Disable interrupts and clear registers
; 2. Disable LCD display
; 3. new sp to WRAM
; 4. clear WRAM
; 5. clear VRAM
; 6. clear HRAM
; 7. clear OAM Sprites
; 8. prepare DMA transfer
Init::

; * LCD enabled
; * Window tile map at $9C00
; * Window display disabled
; * BG and window tile data at $8800
; * BG tile map at $9800
; * 8x8 OBJ size
; * OBJ display enabled
; * BG display disabled    

;rLCDC_DEFAULT EQU %11000010

rLCDC_DEFAULT EQU LCDCF_ON \
                + LCDCF_WIN9C00 \
                + LCDCF_WINOFF \
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
	ld a, LCDCF_ON			; only LCD on, reset other bits
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

; TODO clear rSTAT, hSCX, hSCY, rIF
; TODO enable VBLANK interruption
; TODO window layer off-screen
; TODO clear BG Map...
; TODO set rLCDC_DEFAULT (on-screen)
