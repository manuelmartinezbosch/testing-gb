; rst vectors

SECTION "rst0", ROM0[$0000]
    rst $38
    ds $08 - @, 0 ; 7 nop
    
SECTION "rst8", ROM0[$0008]
    rst $38
    ds $10 - @, 0 ; 7 nop

SECTION "rst10", ROM0[$0010]
    rst $38
    ds $18 - @, 0 ; 7 nop
    
SECTION "rst18", ROM0[$0018]
    rst $38
    ds $20 - @, 0 ; 7 nop

SECTION "rst20", ROM0[$0020]
    rst $38
    ds $28 - @, 0 ; 7 nop

SECTION "rst28", ROM0[$0028]
    rst $38
    ds $30 - @, 0 ; 7 nop
    
SECTION "rst30", ROM0[$0030]
    rst $38
    ds $38 - @, 0 ; 7 nop

SECTION "rst38", ROM0[$0038]
    rst $38
    ds $40 - @, 0 ; 7 nop

; interrupts
SECTION "vblank", ROM0[$0040]
    jp VBlank
    ds $48 - @, 0 ; 7 nop

SECTION "lcd", ROM0[$0048]
    rst $38
    ds $50 - @, 0 ; 7 nop

SECTION "timer", ROM0[$0050]
    rst $38
    ds $58 - @, 0 ; 7 nop

SECTION "serial", ROM0[$0058]
    rst $38
    ds $60 - @, 0 ; 7 nop

SECTION "joypad", ROM0[$0060]
    reti

SECTION "Header", ROM0[$0100]

; Nintendo requires all Game Boy ROMs to begin with a nop ($00) and a jp ($C3)
; to the starting address.
Start::
    nop
    jp _Start

; Header data will be patched by rgbfix    

    ds $0150 - @
