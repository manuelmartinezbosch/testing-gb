; Save 1 in wGBC for game boy color hardware
_Start::
    cp BOOTUP_A_CGB
    jr z, .gbc
    xor a
    jr .done
.gbc
    ld a, TRUE
.done
    ld [wGBC], a
    jp Init
