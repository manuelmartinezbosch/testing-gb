INCLUDE "constants.asm"

INCLUDE "macros/wram.asm"


INCLUDE "vram.asm"


SECTION "OAM Buffer", WRAM0

; buffer for OAM data copied by DMA
wOAMBuffer::
; wOAMBufferSprite00 - wOAMBufferSprite39

; example for first sprite

; wOAMBufferSprite00::
; wOAMBufferSprite00YCoord::     db
; wOAMBufferSprite00XCoord::     db
; wOAMBufferSprite00TileID::     db
; wOAMBufferSprite00Attributes:: db
FOR n, NUM_SPRITE_OAM_STRUCTS
wOAMBufferSprite{02d:n}:: sprite_oam_struct wOAMBufferSprite{02d:n}
ENDR
wOAMBufferEnd::

SECTION "WRAM", WRAM0

wGBC:: db

SECTION "Stack", WRAM0

    ds $100 - 1
wStack:: db

INCLUDE "hram.asm"
