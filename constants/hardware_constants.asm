
; memory map
VRAM_Begin  EQU $8000
VRAM_End    EQU $a000
SRAM_Begin  EQU $a000
SRAM_End    EQU $c000
WRAM0_Begin EQU $c000
WRAM0_End   EQU $d000
WRAM1_Begin EQU $d000
WRAM1_End   EQU $e000
; hardware registers $ff00-$ff80 (see below)
HRAM_Begin  EQU $ff80
HRAM_End    EQU $ffff

; MBC1
MBC1SRamEnable      EQU $0000
MBC1RomBank         EQU $2000
MBC1SRamBank        EQU $4000
MBC1SRamBankingMode EQU $6000


; interrupt flags
LY_VBLANK EQU 145

; hardware registers
rLCDC_ENABLE EQU 7
