; started as 5 before UI overhaul, now is 7
; would decrease to 3 if we wanted to use additional line for attack info
DEF MAX_NUM_MOVES EQU 7
; the category box is 2 tiles high, 12 tiles wide
; must fill in spaces to erase other text already printed
; top string goes in 8, 6, bottom in 8, 7
String_LVL_text:
	db " LVL-UP     @"
String_FIELD_text:
	db " FIELD      @"
String_EGG_text:
	db " EGG        @"		
String_MOVES_text:
	db "  MOVES     @"
String_TECH_text:
	db " TECHNICAL  @"
String_MACHINES_text:
	db "  MACHINES  @"
String_MOVE_text:
	db " MOVE       @"
String_TUTOR_text:
	db "  TUTOR     @"
Print_Category_MOVES_text:
	ld hl, String_MOVES_text
	jp Print_Category_text

DisplayDexMonMoves::
	ld a, [wTempSpecies]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call Pokedex_Clearbox

	; the byte flag that tells us which type of table we're currently on
	; 0 = Info, 1 = Stats, 2 = LVL UP, 3 = FIELD, 4 =  EGG, 5 = TMs, 6 = HMs, 7 = MTs
	
	ld a, [wPokedexEntryType]
	cp DEXENTRY_LVLUP
	jr z, .LvlUpLearnset
	cp DEXENTRY_EGG
	jr z, .EggMoves
	cp DEXENTRY_FIELD
	jr z, .Field_Moves
	cp DEXENTRY_TMS
	jr z, .TMs
	; bit DEXENTRY_HMS, a
	; jr nz, .HMs
	cp DEXENTRY_MTS
	jr z, .MTs
.LvlUpLearnset_new
	ld a, DEXENTRY_LVLUP
	call DexEntry_NextCategory
.LvlUpLearnset
; place category name
	ld de, String_LVL_text
	call Print_Category_MOVES_text

	ld a, DEXENTRY_LVLUP
	ld [wPokedexEntryType], a
	call Pokedex_Calc_LvlMovesPtr
	call Pokedex_Print_NextLvlMoves
	ret
.EggMoves
; place category name
	ld de, String_EGG_text
	call Print_Category_MOVES_text

	ld a, DEXENTRY_EGG
	ld [wPokedexEntryType], a
	call Pokedex_Calc_EggMovesPtr
	ret z
	call Pokedex_Print_Egg_moves
	ret
.Field_Moves
; place category name
	ld de, String_FIELD_text
	call Print_Category_MOVES_text

	ld a, DEXENTRY_FIELD
	ld [wPokedexEntryType], a
	call Pokedex_PrintFieldMoves
	ret
.TMs
; place category name
	ld de, String_TECH_text
	ld hl, String_MACHINES_text
	call Print_Category_text

	ld a, DEXENTRY_TMS
	ld [wPokedexEntryType], a
	call Pokedex_PrintTMs
	ret
; .HMs
; 	ld a, DEXENTRY_HMS
; 	ld [wPokedexEntryType], a
; 	call Pokedex_PrintHMs
; 	ret
.MTs
; place category name
	ld de, String_MOVE_text
	ld hl, String_TUTOR_text
	call Print_Category_text

	ld a, DEXENTRY_MTS
	ld [wPokedexEntryType], a
	call Pokedex_PrintMTs
	ret

Pokedex_Calc_LvlMovesPtr:
	ld a, [wTempSpecies]
	dec a
	ld b, 0
	ld c, a
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarWord
.SkipEvoBytes	
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	and a ; cp 0
	jr nz, .SkipEvoBytes
.CalcPageoffset
	call Pokedex_PrintPageNum ; page num is also returned in a
	ld c, MAX_NUM_MOVES
	call SimpleMultiply 
	; double this num and add to first byte after Evo's 0
	; for p16, triple the num
	ld b, 0
	ld c, a
	add hl, bc
	add hl, bc
	ret

Pokedex_Print_NextLvlMoves:
; Print No more than MAX_NUM_MOVES moves
	ld b, 0
	ld c, 0 ; our move counter, max of MAX_NUM_MOVES
.learnset_loop
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	and a
	jr z, .FoundEnd
	push hl
	ld [wTextDecimalByte], a
	hlcoord 2, 9
	call DexEntry_adjusthlcoord
	ld [hl], "<DEX_LV>"
	hlcoord 3, 9
	call DexEntry_adjusthlcoord
	ld de, wTextDecimalByte
	push bc
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	call PrintNum
	pop bc 
	pop hl
	inc hl
	push hl
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	ld [wNamedObjectIndex], a
	call GetMoveName
	hlcoord 7, 9
	call DexEntry_adjusthlcoord
	push bc
	call PlaceString
	pop bc
	pop hl
	inc hl
	inc bc
	ld a, MAX_NUM_MOVES
	cp c
	jr nz, .learnset_loop
	jr .MaxedPage
.MaxedPage ; Printed MAX_NUM_MOVES moves. Moves are still left. Inc the Page counter
	; check to see if really any moves left, we dont want a blank page
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	and a
	jr z, .FoundEnd
	call DexEntry_IncPageNum
	ret
.FoundEnd
	ld a, DEXENTRY_FIELD
	call DexEntry_NextCategory
	ret

Pokedex_PrintFieldMoves:
; CheckLvlUpMoves, 1 for fail, 0 for yes, in c
	call Pokedex_PrintPageNum ; page num is also returned in a
	ld a, [wPokedexStatus] ; machine moves index
	ld b, a
	ld c, 0 ; current line
.fm_loop
	push bc
	ld c, b
	ld b, 0
	ld hl, Field_Moves_List
	add hl, bc
	ld a, [hl]
	ld d, a
	call Pokedex_CheckLvlUpMoves
	ld a, c ; c has lvl we learn move
	ld e, c
	pop bc
	and a
	jr nz, .print_move_name
.check_machines
; check TM/HM
	push bc
	ld c, b 
	ld b, 0
	ld hl, Field_Moves_List
	add hl, bc
	ld a, [hl]
	ld d, a
	ld [wPutativeTMHMMove], a
	farcall CanLearnTMHMMove
	ld a, c
	pop bc
	and a
	jr z, .notcompatible
; check TM/HM done
.print_move_name
	push de
	ld a, d
	ld [wNamedObjectIndex], a
	call GetMoveName
	push bc ; our count is in c
	hlcoord 7, 9
	call DexEntry_adjusthlcoord
	call PlaceString
	pop bc
; print TM/HM num
	ld d, 0
	ld e, b
	ld hl, Field_Moves_Method_List
	add hl, de
	ld a, [hl]
	pop de
	and a
	jr nz, .tm_or_hm
.printlvlupmove	
	push bc
	hlcoord 3, 9
	call DexEntry_adjusthlcoord
	ld [hl], "<DEX_LV>"
	inc hl
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	ld a, e
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	call PrintNum
	pop bc
	jr .inc_line_count  
.tm_or_hm
	; a has the item id of the tm/hm/mt
	push af
	ld a, e ; lvl at which they learn move?
	and a
	jr nz, .BothLvlUpandTMHMMT
	pop af
	ld [wNamedObjectIndex], a
	call GetItemName
	push bc
	hlcoord 2, 9
	call DexEntry_adjusthlcoord
	call PlaceString
	pop bc
; print TM/HM num done
.inc_line_count
	inc c ; since we printed a line
	ld a, MAX_NUM_MOVES
	cp c
	jr nz, .notcompatible ; not yet printed all MAX_NUM_MOVES slots
	; We've printed all MAX_NUM_MOVES slots
	; check if we need to move to next category or if there are moves left
	call Pokedex_anymoreFieldMoves
	jr z, .done ; there are no moves left
	; moves left
	call DexEntry_IncPageNum
	ret
.notcompatible
	ld a, NUM_FIELD_MOVES - 1
	cp b
	jr z, .done
	inc b
	ld a, b
	ld [wPokedexStatus], a ; moves machines index
	jp .fm_loop
.done
	ld a, DEXENTRY_EGG
	call DexEntry_NextCategory
	ld a, c
	and a
	ret nz ; we've had at least one HM Move
	hlcoord 4, 9
	ld de, DexEntry_NONE_text
	call PlaceString
	ret
.both_no_more_room
	pop af
	jr .inc_line_count	
.BothLvlUpandTMHMMT
	; we're print number regardless
	push bc
	push de
	hlcoord 3, 9
	call DexEntry_adjusthlcoord
	ld [hl], "<DEX_LV>"
	inc hl
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	ld a, e
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	call PrintNum
	pop de
	pop bc

	ld a, c
	dec b ; so it will do dig again on next page
	cp MAX_NUM_MOVES - 1
	jr z, .both_no_more_room ; we only have 1 space left, so prioritize lvl up
	inc b ; we have room, so fix the field move counter
	; print name again
	inc c ; line counter
	push bc
	push de
	ld a, d
	ld [wNamedObjectIndex], a
	call GetMoveName
	; push bc ; our count is in c
	hlcoord 7, 9
	call DexEntry_adjusthlcoord
	call PlaceString
	pop de
	pop bc

	xor a ; so we dont get flagged as both again
	ld e, a
	pop af ; tm/hm/mt item id
	jp .tm_or_hm
	; a needs to be the TM/HM/MT item id	
	; do not increment index, so it will print both on next page

Field_Moves_List:
	db TELEPORT, SOFTBOILED, MILK_DRINK, \
		HEADBUTT, ROCK_SMASH, SWEET_SCENT, DIG,\
		CUT, FLY, SURF, STRENGTH, FLASH, WATERFALL, WHIRLPOOL
Field_Moves_Method_List:
	db 0, 0, 0, TM01 + 1, TM01 + 7, TM01 + 11, TM01 + 27, HM01, \
	HM01 + 1, HM01 + 2, HM01 + 3, HM01 + 4, HM01 + 5, HM01 + 6

Pokedex_anymoreFieldMoves:
	ld a, NUM_FIELD_MOVES - 1
	cp b
	jr z, .none	
	; b has the current machine index
	inc b
.fmloop
	push bc
	ld d, 0
	ld e, b 
	ld hl, Field_Moves_List
	add hl, de
	ld a, [hl]
	ld d, a

	call Pokedex_CheckLvlUpMoves
	ld a, c ; c has lvl we learn move
	ld d, a ; to preserve it for later
	pop bc
	and a
	jr nz, .yes
	push bc
	ld d, 0
	ld e, b
	ld hl, Field_Moves_Method_List
	add hl, de
	ld a, [hl]
	and a
	jr z, .not_tm_or_hm
	ld [wCurItem], a
	farcall GetTMHMItemMove
	ld a, [wTempTMHM]	
	ld [wPutativeTMHMMove], a
	farcall CanLearnTMHMMove
	ld a, c
	pop bc
	and a
	jr nz, .yes
.not_tm_or_hm
	ld a, NUM_FIELD_MOVES - 1
	cp b
	jr z, .none
	inc b
	jr .fmloop	
.yes
	ld a, b
	ld [wPokedexStatus], a ; so we can start off at the next learnable machine
	ld a, 1
	and a
	ret
.none
	xor a
	ret

Pokedex_CheckLvlUpMoves: ; used by pokedex field moves
; move looking for in 'd'
	ld a, [wCurPartySpecies]
	dec a
	ld b, 0
	ld c, a
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	ld b, a
	call GetFarWord
	ld a, b
	call GetFarByte
	inc hl
	and a
	jr z, .find_move ; does not evolve
	dec hl
; Skip Evo Bytes
; Receives a pointer to the evos and attacks for a mon in b:hl, and skips to the attacks.
.skip_evo_bytes	
	ld a, b
	call GetFarByte
	inc hl
	and a
	jr z, .find_move ; found end
	cp EVOLVE_STAT
	jr nz, .no_extra_skip
	inc hl
.no_extra_skip
	inc hl
	inc hl
	jr .skip_evo_bytes
.find_move
	ld a, BANK(EvosAttacksPointers)
	call GetFarByte
	inc hl
	and a
	jr z, .notfound ; end of mon's lvl up learnset
	ld c, a ; the lvl we learn move
	ld a, BANK(EvosAttacksPointers)
	call GetFarByte
	inc hl
	cp d ; 'd' is not clobbered in any of the used funcs or farcalls
	jr z, .found
	jr .find_move
.found
	; lvl learned move in c
	ret ; move is in lvl up learnset
.notfound
	xor a
	ld c, a
	ret

Pokedex_Calc_EggMovesPtr:
	ld a, DEXENTRY_EGG
	ld [wPokedexEntryType], a
	call Pokedex_PrintPageNum ; page num is also returned in a
	ld a, [wPokedexEntryPageNum]
	ld c, MAX_NUM_MOVES ; we can print MAX_NUM_MOVES Egg moves per page
	call SimpleMultiply ; double this num and add to first byte after Evo's 0
	ld b, 0
	ld c, a
	push bc
; Step 4: Get First byte of learnset
	callfar GetPreEvolution ; changes wCurPartyMon
	callfar GetPreEvolution ; changes wCurPartyMon
	ld a, [wCurPartySpecies]
	dec a ; Bulbasaur is No 1 but entry ZERO
	ld b, 0
	ld c, a
	ld hl, EggMovePointers
	add hl, bc ; trying to add the species number in only 'a' will overflow a
	add hl, bc ; add twice to double the index, words/PTRs are TWO bytes ea
	ld a, [wCurSpecies]
	ld [wCurPartySpecies], a
	ld [wTempSpecies], a
	ld [wTempMonSpecies], a

	ld a, BANK(EggMovePointers)
	call GetFarWord
.check_if_any
	ld a, BANK("Egg Moves")
	call GetFarByte ; a will be -1 if no egg moves
	pop bc
	add hl, bc
	cp -1
	ret nz
	; if we reach here, the mon has no egg moves at all
	; will not call Pokedex_Print_Egg_moves
	; increment to next category
	ld a, DEXENTRY_TMS
	call DexEntry_NextCategory
	;print NONE
	hlcoord 3, 9
	ld de, DexEntry_NONE_text
	call PlaceString
	ret

Pokedex_Print_Egg_moves:
; Print No more than MAX_NUM_MOVES moves
	ld b, 0
	ld c, 0 ; our move counter, max of MAX_NUM_MOVES - 1 for MAX_NUM_MOVES moves
	; our adjusted pointer based on page num is in hl
.Egg_loop
	ld a, BANK("Egg Moves")
	call GetFarByte ; EGG Move, or -1 for end
	cp -1
	jr z, .FoundEnd
	inc hl ; Moves HL to next Byte
	push hl
	ld [wNamedObjectIndex], a ; all the "Name" Funcs use this 
	call GetMoveName ; returns the string pointer in de
	hlcoord 3, 9
	call DexEntry_adjusthlcoord
	push bc
	call PlaceString ; places Move Name
	pop bc
	pop hl
	ld a, MAX_NUM_MOVES - 1 ; means we just printed last move on page
	cp c
	jr z, .MaxedPage
	inc c
	jr .Egg_loop
.MaxedPage ; Printed MAX_NUM_MOVES moves. Moves are still left. Inc the Page counter
; CheckNextByte, we dont want blank screen if we just printed last move in slot 5
	ld a, BANK("Egg Moves")
	call GetFarByte; Move # returned in "a"
	cp -1
	jr z, .FoundEnd
	call DexEntry_IncPageNum
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wTempSpecies], a
	ld [wTempMonSpecies], a
	ret
.FoundEnd
	ld a, DEXENTRY_TMS
	call DexEntry_NextCategory
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wTempSpecies], a
	ld [wTempMonSpecies], a
	ret

Pokedex_PrintTMs:
	call Pokedex_PrintPageNum ; page num is also returned in a
	ld a, [wPokedexStatus] ; machine moves index
	ld b, a
	ld c, 0 ; current line
.tm_loop
	push bc
	ld a, TM01
	add b ; machine moves index
	ld [wCurItem], a ; machine moves index
	farcall GetTMHMItemMove
	ld a, [wTempTMHM]
	ld [wPutativeTMHMMove], a
	farcall CanLearnTMHMMove
	ld a, c
	pop bc
	and a
	jr z, .notcompatible
	call GetMoveName
	push bc ; our count is in c
	hlcoord 7, 9
	call DexEntry_adjusthlcoord
	call PlaceString
	pop bc
	ld a, [wPokedexStatus]
	ld b, a
	ld a, TM01
	add b ; machine moves index
	ld [wNamedObjectIndex], a
	call GetItemName
	push bc
	hlcoord 2, 9
	call DexEntry_adjusthlcoord
	call PlaceString
	pop bc
	inc c ; since we printed a line
	ld a, MAX_NUM_MOVES
	cp c
	jr nz, .notcompatible ; not yet printed all 5 slots
	; We've printed all MAX_NUM_MOVES slots
	; check if we need to move to next category or if there are moves left
	call Pokedex_anymoreTMs
	jr z, .done ; there are no moves left
	; moves left
	call DexEntry_IncPageNum
	ret
.notcompatible
	ld a, NUM_TMS - 1
	cp b
	jr z, .done
	inc b
	ld a, b
	ld [wPokedexStatus], a ; moves machines index
	jr .tm_loop
.done
	ld a, DEXENTRY_MTS
	call DexEntry_NextCategory
	ld a, c
	and a
	ret nz ; we've had at least one HM Move
	hlcoord 4, 9
	ld de, DexEntry_NONE_text
	call PlaceString
	ret

Pokedex_anymoreTMs:
	; b has the current HM index
	ld a, NUM_TMS - 1
	cp b
	jr z, .none
	inc b
.tmloop
	push bc
	ld a, TM01
	add b
	ld [wCurItem], a
	farcall GetTMHMItemMove
	ld a, [wTempTMHM]	
	ld [wPutativeTMHMMove], a
	farcall CanLearnTMHMMove
	ld a, c
	pop bc
	and a
	jr nz, .yes
	ld a, NUM_TMS - 1
	cp b
	jr z, .none
	inc b
	jr .tmloop	
.yes
	ld a, b
	ld [wPokedexStatus], a ; so we can start off at the next learnable machine
	ld a, 1
	and a
	ret
.none
	xor a
	ld [wPokedexStatus], a
	ret

Pokedex_PrintMTs:
	call Pokedex_PrintPageNum ; page num is also returned in a
	ld a, [wPokedexStatus] ; moves machines index
	ld b, a ; result of simple multiply in a
	ld c, 0 ; current line
.mt_loop
	push bc
	ld a, MT01
	add b
	ld [wCurItem], a
	farcall GetTMHMItemMove
	ld a, [wTempTMHM]
	ld [wPutativeTMHMMove], a
	farcall CanLearnTMHMMove
	ld a, c
	pop bc
	and a
	jr z, .notcompatible
	call GetMoveName
	push bc ; our count is in c
	hlcoord 3, 9
	call DexEntry_adjusthlcoord
	call PlaceString
	pop bc
	inc c ; since we printed a line
	ld a, MAX_NUM_MOVES
	cp c
	jr nz, .notcompatible
	; We've printed all MAX_NUM_MOVES slots
	; check if we need to move to next category or if there are moves left
	call Pokedex_anymoreMTs
	jr z, .done ; there are no moves left
	; moves left
	call DexEntry_IncPageNum
	ret
.notcompatible
	ld a, NUM_TUTORS - 1
	cp b
	jr z, .done
	inc b
	ld a, b
	ld [wPokedexStatus], a ; moves machines index
	jr .mt_loop
.done
	ld a, DEXENTRY_LVLUP
	call DexEntry_NextCategory
	ld a, c
	and a
	ret nz ; we've had at least one HM Move
	hlcoord 4, 9
	ld de, DexEntry_NONE_text
	call PlaceString
	ret

Pokedex_anymoreMTs:
	ld a, NUM_TUTORS - 1
	cp b
	jr z, .none
	; b has the current HM index
	inc b
.mtloop
	push bc
	ld a, MT01
	add b
	ld [wCurItem], a
	farcall GetTMHMItemMove
	ld a, [wTempTMHM]	
	ld [wPutativeTMHMMove], a
	farcall CanLearnTMHMMove
	ld a, c
	pop bc
	and a
	jr nz, .yes
	ld a, NUM_TUTORS - 1
	cp b
	jr z, .none
	inc b
	jr .mtloop	
.yes
	ld a, 1
	and a
	ret
.none
	xor a
	ret

; Pokedex_PrintHMs:
; 	hlcoord 2, 9
; 	ld de, .dex_HM_text
; 	call PlaceString
; 	call Pokedex_PrintPageNum ; page num is also returned in a
; 	ld c, MAX_NUM_MOVES
; 	ld a, [wPokedexStatus]
; 	ld b, a
; 	ld c, 0 ; current line
; .hm_loop
; 	push bc
; 	ld a, HM01
; 	add b
; 	ld [wCurItem], a
; 	farcall GetTMHMItemMove
; 	ld a, [wTempTMHM]
; 	ld [wPutativeTMHMMove], a
; 	farcall CanLearnTMHMMove
; 	ld a, c
; 	pop bc
; 	and a
; 	jr z, .notcompatible
; 	call GetMoveName
; 	push bc ; our count is in c
; 	hlcoord 7, 9
; 	call DexEntry_adjusthlcoord
; 	call PlaceString
; 	pop bc
; 	ld a, HM01
; 	add b
; 	ld [wNamedObjectIndex], a
; 	call GetItemName
; 	push bc
; 	hlcoord 2, 9
; 	call DexEntry_adjusthlcoord
; 	call PlaceString
; 	pop bc
; 	inc c ; since we printed a line
; 	ld a, MAX_NUM_MOVES
; 	cp c
; 	jr nz, .notcompatible
; 	call Pokedex_anymoreHMs
; 	jr z, .done
; 	call DexEntry_IncPageNum
; 	ret
; .notcompatible
; 	ld a, NUM_HMS - 1
; 	cp b
; 	jr z, .done
; 	inc b
; 	jr .hm_loop
; .done
; 	ld a, DEXENTRY_MTS
; 	call DexEntry_NextCategory
; 	ld a, c
; 	and a
; 	ret nz ; we've had at least one HM Move
; 	hlcoord 4, 9
; 	ld de, DexEntry_NONE_text
; 	call PlaceString
; 	ret
; .dex_HM_text:
; 	db "HIDDEN MACHINES@"

; Pokedex_anymoreHMs:
; 	ld a, NUM_HMS - 1
; 	cp b
; 	jr z, .none
; 	; b has the current HM index
; 	inc b
; .hmloop
; 	push bc
; 	ld a, HM01
; 	add b
; 	ld [wCurItem], a
; 	farcall GetTMHMItemMove
; 	ld a, [wTempTMHM]	
; 	ld [wPutativeTMHMMove], a
; 	farcall CanLearnTMHMMove
; 	ld a, c
; 	pop bc
; 	and a
; 	jr nz, .yes
; 	ld a, NUM_HMS - 1
; 	cp b
; 	jr z, .none
; 	inc b
; 	jr .hmloop	
; .yes
; 	ld a, 1
; 	and a
; 	ret
; .none
; 	xor a
; 	ld [wPokedexStatus], a
; 	ret

DexEntry_NONE_text:
	db "NONE@"
