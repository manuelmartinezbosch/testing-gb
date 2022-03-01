INCLUDE "constants.asm"

SECTION "NULL", ROM0
NULL::

INCLUDE "home/header.asm"

SECTION "High Home", ROM0

INCLUDE "home/lcd.asm"
INCLUDE "home/clear_sprites.asm"

SECTION "Home", ROM0

INCLUDE "home/start.asm"
INCLUDE "home/vcopy.asm"
INCLUDE "home/init.asm"
INCLUDE "home/vblank.asm"

INCLUDE "home/tilemap.asm"
