ClearSprites::
	xor a
	ld hl, wOAMBuffer
	ld b, wOAMBufferEnd - wOAMBuffer
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret
