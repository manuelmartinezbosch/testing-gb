INCLUDE "constants.asm"

SECTION "NULL", ROM0
NULL::

INCLUDE "home/header.asm"

; TODO pending to use high home

SECTION "High Home", ROM0

INCLUDE "home/lcd.asm"
; INCLUDE "home/clear_sprites.asm"
; INCLUDE "home/copy.asm"

SECTION "Home", ROM0

INCLUDE "home/start.asm"
INCLUDE "home/init.asm"
INCLUDE "home/vblank.asm"
