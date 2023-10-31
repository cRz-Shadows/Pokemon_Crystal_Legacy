	const_def
	const DEXENTRY_LORE      ; 0 ; bit 0, $1
	const DEXENTRY_BASESTATS ; 1 ; bit 1, $2
	const DEXENTRY_LVLUP     ; 2 ; bit 2, $4
	const DEXENTRY_FIELD     ; 3 ; bit 3, $8
	const DEXENTRY_EGG		 ; 4 ; bit 4, $10, 16
	const DEXENTRY_TMS       ; 5 ; bit 5, $20, 32
	; const DEXENTRY_HMS       ; bit 6, $40, 64
	const DEXENTRY_MTS       ; 6 ;bit 7, $80, 128
	const DEXENTRY_EVO		 ; 7
	const DEXENTRY_PICS      ; 8
	const DEXENTRY_AREA_NONE	;  9
	const DEXENTRY_AREA_GRASS_JOHTO   ; 10
	const DEXENTRY_AREA_GRASS_KANTO   ; 11
	const DEXENTRY_AREA_GRASS_SWARM   ; 12
	const DEXENTRY_AREA_SURF_JOHTO    ; 13
	const DEXENTRY_AREA_SURF_KANTO    ; 14
	const DEXENTRY_AREA_SURF_SWARM   ; 15
	const DEXENTRY_AREA_RODS    ; 16
	const DEXENTRY_AREA_TREES   ; 17
	const DEXENTRY_AREA_CONTEST ; 18
	
EXPORT DEXENTRY_LORE
EXPORT DEXENTRY_BASESTATS
EXPORT DEXENTRY_LVLUP
EXPORT DEXENTRY_FIELD
EXPORT DEXENTRY_EGG
EXPORT DEXENTRY_TMS
; EXPORT DEXENTRY_HMS
EXPORT DEXENTRY_MTS
EXPORT DEXENTRY_EVO		 ; 7
EXPORT DEXENTRY_PICS      ; 8

EXPORT DEXENTRY_AREA_GRASS_JOHTO
EXPORT DEXENTRY_AREA_GRASS_KANTO
EXPORT DEXENTRY_AREA_GRASS_SWARM

EXPORT DEXENTRY_AREA_SURF_JOHTO
EXPORT DEXENTRY_AREA_SURF_KANTO
EXPORT DEXENTRY_AREA_SURF_SWARM

EXPORT DEXENTRY_AREA_RODS
EXPORT DEXENTRY_AREA_TREES
EXPORT DEXENTRY_AREA_CONTEST
EXPORT DEXENTRY_AREA_NONE

DEF NUM_FIELD_MOVES EQU 14 
DEF MOVESPAGES_CONT_MASK EQU %00000011

AnimateDexSearchSlowpoke:
	ld hl, .FrameIDs
	ld b, 25
.loop
	ld a, [hli]

	; Wrap around
	cp $fe
	jr nz, .ok
	ld hl, .FrameIDs
	ld a, [hli]
.ok

	ld [wDexSearchSlowpokeFrame], a
	ld a, [hli]
	ld c, a
	push bc
	push hl
	call DoDexSearchSlowpokeFrame
	pop hl
	pop bc
	call DelayFrames
	dec b
	jr nz, .loop
	xor a
	ld [wDexSearchSlowpokeFrame], a
	call DoDexSearchSlowpokeFrame
	ld c, 32
	call DelayFrames
	ret

.FrameIDs:
	; frame ID, duration
	db 0, 7
	db 1, 7
	db 2, 7
	db 3, 7
	db 4, 7
	db -2

DoDexSearchSlowpokeFrame:
	ld a, [wDexSearchSlowpokeFrame]
	ld hl, .SlowpokeSpriteData
	ld de, wVirtualOAMSprite00
.loop
	ld a, [hli]
	cp -1
	ret z
	ld [de], a ; y
	inc de
	ld a, [hli]
	ld [de], a ; x
	inc de
	ld a, [wDexSearchSlowpokeFrame]
	ld b, a
	add a
	add b
	add [hl]
	inc hl
	ld [de], a ; tile id
	inc de
	ld a, [hli]
	ld [de], a ; attributes
	inc de
	jr .loop

.SlowpokeSpriteData:
	dbsprite  9, 11, 0, 0, $00, 0
	dbsprite 10, 11, 0, 0, $01, 0
	dbsprite 11, 11, 0, 0, $02, 0
	dbsprite  9, 12, 0, 0, $10, 0
	dbsprite 10, 12, 0, 0, $11, 0
	dbsprite 11, 12, 0, 0, $12, 0
	dbsprite  9, 13, 0, 0, $20, 0
	dbsprite 10, 13, 0, 0, $21, 0
	dbsprite 11, 13, 0, 0, $22, 0
	db -1

HandlePageNumReset:
	ld b, a
	ld a, [wPokedexEntryType]
	cp b
	ret z
	ld a, b
	ld [wPokedexEntryType], a
	xor a
	ld [wPokedexEntryPageNum], a
	ret

DisplayDexEntry:
	ld a, [wPokedexEntryType]
	and a
	jr nz, .check_caught
	ld a, DEXENTRY_LORE
	call HandlePageNumReset
.check_caught
; Check to see if we caught it.  Get out of here if we haven't.
	ld a, [wTempSpecies]
	dec a
	call CheckCaughtMon
	ret z

	; xor a
	; ldh [hBGMapMode], a 

	ld a, DEXENTRY_LORE
	call HandlePageNumReset

	lb bc, 8, SCREEN_WIDTH - 1
	hlcoord 1, 8
	call ClearBox

	hlcoord 1, 8
	ld bc, 19
	ld a, $55
	call ByteFill

	ld a, [wTempSpecies]
	ld b, a
	call GetDexEntryPointer
	ld a, b
	push af
	hlcoord 2, 9
	call PlaceFarString ; dex species nickname
	ld h, b
	ld l, c
	push de
	hlcoord 12, 9
.check_tile
	; this prints the "PKMN" symbols after the species nickname
	ld a, [hld]
	cp $e2
	jr z, .cont
	cp $7f ; empty tile
	jr z, .check_tile
	inc hl
	inc hl
	ld [hl], " "
	inc hl
	ld [hl], $e1
	inc hl
	ld [hl], $e2 
.cont
	pop hl
	pop bc
; Get the height of the Pokemon.
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	inc hl
	ld a, b
	push af
	inc hl
	inc hl
	inc hl
	push hl
	ld a, [wPokedexEntryPageNum]
	and a ; check for page 2
	jr nz, .page2
; Page 1
	call Pokedex_PrintPageNum
	pop de
	inc de
	pop af
	hlcoord 2, 11
	push af
	call PlaceFarString
	pop bc
	call DexEntry_IncPageNum
	; call WaitBGMap
	ret

; Page 2
.page2
	pop de
	inc de
	pop af
	hlcoord 2, 11
	push af
	call PlaceFarString
	pop bc
	push bc
	push de
	lb bc, 5, SCREEN_WIDTH - 1
	hlcoord 1, 11
	call ClearBox
	hlcoord 1, 8
	ld bc, 19
	ld a, $55
	call ByteFill
	call Pokedex_PrintPageNum
	pop de
	inc de
	pop af
	hlcoord 2, 11
	call PlaceFarString
	xor a
	ld [wPokedexEntryPageNum], a
	; call WaitBGMap
	ret

GetDexEntryPointer:
; return dex entry pointer b:de
	push hl
	ld hl, PokedexDataPointerTable
	ld a, b
	dec a
	ld d, 0
	ld e, a
	add hl, de
	add hl, de
	add hl, de
	; b = bank
	ld a, [hli]
	ld b, a
	; de = address
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	ret

GetDexEntryPagePointer:
	call GetDexEntryPointer
	push hl
	ld h, d
	ld l, e
; skip species name
.loop1
	ld a, b
	call GetFarByte
	inc hl
	cp "@"
	jr nz, .loop1
; skip height and weight
rept 4
	inc hl
endr
; if c != 1: skip entry
	dec c
	and c
	jr z, .done
; skip entry
.loop2
	ld a, b
	call GetFarByte
	inc hl
	cp "@"
	jr nz, .loop2
.done
	ld d, h
	ld e, l
	pop hl
	ret

DisplayDexMonType_CustomGFX:
	call GetBaseData
	ld a, [wBaseType1]
; Skip Bird
	cp BIRD
	jr c, .type1_adjust_done
	cp UNUSED_TYPES
	dec a
	jr c, .type1_adjust_done
	sub UNUSED_TYPES
.type1_adjust_done
; load the tiles
	ld hl, TypeLightIconGFX
	ld bc, 4 * LEN_2BPP_TILE
	call AddNTimes
	ld d, h
	ld e, l

	ld a, $1
	ldh [rVBK], a
	ld hl, vTiles2 tile $77
	lb bc, BANK(TypeLightIconGFX), 4
	call Request2bpp

	hlcoord 9, 6
	ld [hl], $77
	inc hl
	ld [hl], $78
	inc hl
	ld [hl], $79
	inc hl
	ld [hl], $7a

	ld a, $0
	ldh [rVBK], a
; 2nd Type
	ld a, [wBaseType1]
	ld b, a
	ld a, [wBaseType2]
	cp b
	ret z
; Skip Bird
	cp BIRD
	jr c, .type2_adjust_done
	cp UNUSED_TYPES
	dec a
	jr c, .type2_adjust_done
	sub UNUSED_TYPES
.type2_adjust_done
; load type 2 tiles
	ld hl, TypeDarkIconGFX
	ld bc, 4 * LEN_2BPP_TILE
	call AddNTimes
	ld d, h
	ld e, l

	ld a, $1
	ldh [rVBK], a

	ld hl, vTiles2 tile $7b
	lb bc, BANK(TypeDarkIconGFX), 4
	call Request2bpp
	hlcoord 13, 6
	ld [hl], $7b
	inc hl
	ld [hl], $7c
	inc hl
	ld [hl], $7d
	inc hl
	ld [hl], $7e
	ld a, $0
	ldh [rVBK], a
	ret

DEX_PrintType_Short:
; Print type a at hl.
	ld b,b
	; shouldnt need to double index
	push hl
	ld hl, .Types
	ld bc, 4 ; since each entry is 4 bytes
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	jp PlaceString

.Types
	db "NRM@"
	db "FGT@"
	db "FLY@"
	db "PSN@"
	db "GRD@"
	db "RCK@"
	db "BUG@"
	db "GST@"
	db "STL@"
	db "FIR@"
	db "WTR@"
	db "GRS@"
	db "ELC@"
	db "PSY@"
	db "ICE@"
	db "DRG@"
	db "DRK@"

INCLUDE "data/pokemon/dex_entry_pointers.asm"
INCLUDE "engine/pokedex/pokedex_evolution_page.asm"
INCLUDE "engine/pokedex/pokedex_stats_page.asm"
INCLUDE "engine/pokedex/pokedex_pics_page.asm"
TypeLightIconGFX::
INCBIN "gfx/pokedex/types_light.2bpp"

TypeDarkIconGFX::
INCBIN "gfx/pokedex/types_dark.2bpp"


Pokedex_Clearbox:
	;clear Area BC @ HL
	; xor a
	; ldh [hBGMapMode], a
	lb bc, 7, SCREEN_WIDTH - 1
	hlcoord 1, 9
	call ClearBox
	; call WaitBGMap
	ret

DexEntry_adjusthlcoord:
	; given: current printed lines in c
	push af
	push de
	ld a, 20
	; the num of moves already printed should still be in bc
	call SimpleMultiply ; uses c as the other number
	; result in a
	ld d, 0
	ld e, a
	add hl, de ; allows us to print on the proper row lol
	pop de
	pop af
	ret

DexEntry_IncPageNum:
	ld a, [wPokedexEntryPageNum]
	inc a
	ld [wPokedexEntryPageNum], a
	ret

Pokedex_PrintPageNum:
	push hl
	ld a, [wPokedexEntryPageNum]
	; a = page num, starting with 0 as page 1
	hlcoord 18, 7
	ld [hl], $61 ; p. vram1
	inc hl

	cp 10 ; if we are past nine pages
	jr c, .checkdone
	ld a, 9
.checkdone
	add $62 ; this is how we get the page num tile
	ld [hl], a ; #
	pop hl
	ld a, [wPokedexEntryPageNum]
	ret

DexEntry_NextCategory:
	ld [wPokedexEntryType], a
	xor a
	ld [wPokedexEntryPageNum], a
	ld [wPokedexStatus], a
	ret

DexEntry_NONE_text:
	db "NONE@"

DisplayDexMonStats::
	ld a, [wTempSpecies]
	ld [wCurSpecies], a

	ld a, DEXENTRY_BASESTATS
	call HandlePageNumReset

	call Pokedex_Clearbox
	ld de, .Base_stats_text
	hlcoord 2, 9
	call PlaceString
	call Pokedex_PrintPageNum ; page num is also returned in a
	and a
	jr z, .print_page1
	cp 1
	jr z, .print_page2
	cp 2
	jr z, .print_page3
	jr .print_page4
.print_page1
	call Pokedex_GBS_Stats ; 4 lines
	call Pokedex_CatchRate ; 1 line
	jp DexEntry_IncPageNum
.print_page2
	call Pokedex_Get_Items ; 3 lines
	call Pokedex_PrintBaseExp ; 1 line
	call Pokedex_Get_Growth ; 1 lines
	jp DexEntry_IncPageNum
.print_page3
	; these ones NEED to be in this order
	call Pokedex_EggG_SetUp ; 3 lines
	call Pokedex_PrintHatchSteps ; 1 line
	call Pokedex_Get_GenderRatio ; 1 line	
	; call Pokedex_HeightWeight ; 2 lines
	; call Pokedex_Get_Items ; 3 lines
	jp DexEntry_IncPageNum
.print_page4
	; call Pokedex_EggG_SetUp ; 3 lines
	; call Pokedex_PrintHatchSteps ; 1 line
	; call Pokedex_Get_GenderRatio ; 1 line
	call Pokedex_HeightWeight ; 2 lines
	xor a
	ld [wPokedexEntryPageNum], a
	ret
.Base_stats_text:
	db "BASE STATS@"

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
	ld a, DEXENTRY_LVLUP
	ld [wPokedexEntryType], a
	call Pokedex_Calc_LvlMovesPtr
	call Pokedex_Print_NextLvlMoves
	ret
.EggMoves
	ld a, DEXENTRY_EGG
	ld [wPokedexEntryType], a
	call Pokedex_Calc_EggMovesPtr
	ret z
	call Pokedex_Print_Egg_moves
	ret
.Field_Moves
	ld a, DEXENTRY_FIELD
	ld [wPokedexEntryType], a

	call Pokedex_PrintFieldMoves
	ret
.TMs
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
	ld c, 5
	call SimpleMultiply 
	; double this num and add to first byte after Evo's 0
	; for p16, triple the num
	ld b, 0
	ld c, a
	add hl, bc
	add hl, bc
	; add hl, bc
	ret

Pokedex_Print_NextLvlMoves:
; Print No more than 5 moves
	ld b, 0
	ld c, 0 ; our move counter, max of 5
	push bc ; our move counter
	push hl ; our offset for the start of Moves
	ld de, .lvl_moves_text
	hlcoord 2, 9
	call PlaceString ; TEXT for 'LVL - Move'
	pop hl
	pop bc
.learnset_loop
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	and a
	jr z, .FoundEnd
	push hl
	ld [wTextDecimalByte], a
	hlcoord 2, 11
	call DexEntry_adjusthlcoord
	ld [hl], $5d
	hlcoord 3, 11
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
	hlcoord 7, 11
	call DexEntry_adjusthlcoord
	push bc
	call PlaceString
	pop bc
	pop hl
	inc hl
	inc bc
	ld a, 5
	cp c
	jr nz, .learnset_loop
	jr .MaxedPage
.MaxedPage ; Printed 5 moves. Moves are still left. Inc the Page counter
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
.lvl_moves_text:
	db "LVL-UP MOVES@"

Pokedex_PrintFieldMoves:
; CheckLvlUpMoves, 1 for fail, 0 for yes, in c
	hlcoord 2, 9
	ld de, .Field_Moves_text
	call PlaceString
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
	hlcoord 7, 11
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
	hlcoord 3, 11
	call DexEntry_adjusthlcoord
	ld [hl], $5d ; <LVL>
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
	hlcoord 2, 11
	call DexEntry_adjusthlcoord
	call PlaceString
	pop bc
; print TM/HM num done
.inc_line_count
	inc c ; since we printed a line
	ld a, $5
	cp c
	jr nz, .notcompatible ; not yet printed all 5 slots
	; We've printed all 5 slots
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
	hlcoord 4, 11
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
	hlcoord 3, 11
	call DexEntry_adjusthlcoord
	ld [hl], $5d ; <LVL>
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
	cp 4
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
	hlcoord 7, 11
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
.Field_Moves_text:
	db "FIELD MOVES@"

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
	ld c, 5 ; we can print 5 Egg moves per page
	call SimpleMultiply ; double this num and add to first byte after Evo's 0
	ld b, 0
	ld c, a
	push bc
; Step 4: Get First byte of learnset
	; push af ; preserve current species or else move sets will be messed up for stage2+ mons
	callfar GetPreEvolution ; changes wCurPartyMon
	callfar GetPreEvolution ; changes wCurPartyMon
	ld a, [wCurPartySpecies]
	dec a ; Bulbasaur is No 1 but entry ZERO
	ld b, 0
	ld c, a
	ld hl, EggMovePointers
	add hl, bc ; trying to add the species number in only 'a' will overflow a
	add hl, bc ; add twice to double the index, words/PTRs are TWO bytes ea
	; pop af ; preserve current species or else move sets will be messed up for stage2+ mons
	ld a, [wCurSpecies]
	ld [wCurPartySpecies], a
	ld [wTempSpecies], a
	ld [wTempMonSpecies], a

	ld a, BANK(EggMovePointers)
	call GetFarWord
.check_if_any
	ld a, BANK("Egg Moves")
	call GetFarByte
	pop bc
	add hl, bc
	push af ; -1 if no egg moves
	push hl
	hlcoord 2, 9
	ld de, .EggMoves_text
	call PlaceString
	pop hl
	pop af
	cp -1
	ret nz
	; if we reach here, the mon has no egg moves at all
	; will not call Pokedex_Print_Egg_moves
	; increment to next category
	ld a, DEXENTRY_TMS
	call DexEntry_NextCategory
	;print NONE
	hlcoord 3, 11
	ld de, DexEntry_NONE_text
	call PlaceString
	ret
.EggMoves_text:
	db "EGG MOVES@"

Pokedex_Print_Egg_moves:
; Print No more than 5 moves
	ld b, 0
	ld c, 0 ; our move counter, max of 4 for 5 moves
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
	hlcoord 3, 11
	call DexEntry_adjusthlcoord
	push bc
	call PlaceString ; places Move Name
	pop bc
	pop hl
	ld a, $4 ; means we just printed 5th move
	cp c
	jr z, .MaxedPage
	inc c
	jr .Egg_loop
.MaxedPage ; Printed 5 moves. Moves are still left. Inc the Page counter
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
	hlcoord 2, 9
	ld de, .dex_TM_text
	call PlaceString
	call Pokedex_PrintPageNum ; page num is also returned in a
	ld a, [wPokedexStatus] ; machine moves index
	ld b, a
	ld c, 0 ; current line
.tm_loop
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
	jr z, .notcompatible
	call GetMoveName
	push bc ; our count is in c
	hlcoord 7, 11
	call DexEntry_adjusthlcoord
	call PlaceString
	pop bc
	ld a, TM01
	ld a, [wPokedexStatus]
	ld b, a
	ld a, TM01
	add b
	ld [wNamedObjectIndex], a
	call GetItemName
	push bc
	hlcoord 2, 11
	call DexEntry_adjusthlcoord
	call PlaceString
	pop bc
	inc c ; since we printed a line
	ld a, $5
	cp c
	jr nz, .notcompatible ; not yet printed all 5 slots
	; We've printed all 5 slots
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
	; ld a, DEXENTRY_HMS
	ld a, DEXENTRY_MTS
	call DexEntry_NextCategory
	ld a, c
	and a
	ret nz ; we've had at least one HM Move
	hlcoord 4, 11
	ld de, DexEntry_NONE_text
	call PlaceString
	ret
.dex_TM_text:
	db "TECHNICAL MACHINES@"

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
	hlcoord 2, 9
	ld de, .dex_MT_text
	call PlaceString
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
	hlcoord 3, 11
	call DexEntry_adjusthlcoord
	call PlaceString
	pop bc
	inc c ; since we printed a line
	ld a, $5
	cp c
	jr nz, .notcompatible
	; We've printed all 5 slots
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
	hlcoord 4, 11
	ld de, DexEntry_NONE_text
	call PlaceString
	ret
.dex_MT_text:
	db "MOVE TUTORS@"

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
; 	ld c, $5
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
; 	hlcoord 7, 11
; 	call DexEntry_adjusthlcoord
; 	call PlaceString
; 	pop bc
; 	ld a, HM01
; 	add b
; 	ld [wNamedObjectIndex], a
; 	call GetItemName
; 	push bc
; 	hlcoord 2, 11
; 	call DexEntry_adjusthlcoord
; 	call PlaceString
; 	pop bc
; 	inc c ; since we printed a line
; 	ld a, $5
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
; 	hlcoord 4, 11
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

Pokedex_DetailedArea:
	xor a
	ld [wCurDamage], a
	ld [wCurDamage + 1], a
	ld [wPokedexEvoStage2], a ; highest lvl
	ld [wPokedexEvoStage3], a ; lowest lvl
	ld [wStatsScreenFlags], a ; misc counters
	ld a, [wPokedexEntryType]
	cp DEXENTRY_AREA_NONE
	ret z
.checkpoint
	call Pokedex_Clearbox
	ld a, [wPokedexEntryType]
	cp DEXENTRY_AREA_NONE
	jr c, .first
	call Pokedex_PrintPageNum
	ld a, [wPokedexEntryType]

	ld hl, JohtoGrassWildMons
	cp DEXENTRY_AREA_GRASS_JOHTO
	jr z, .grass ; _johto
	ld hl, KantoGrassWildMons
	cp DEXENTRY_AREA_GRASS_KANTO
	jr z, .grass ; _kanto
	ld hl, SwarmGrassWildMons
	cp DEXENTRY_AREA_GRASS_SWARM
	jr z, .grass ; _swarm
	
	ld hl,JohtoWaterWildMons
	cp DEXENTRY_AREA_SURF_JOHTO
	jr z, .surf
	ld hl, KantoWaterWildMons
	cp DEXENTRY_AREA_SURF_KANTO
	jr z, .surf
	ld hl, SwarmWaterWildMons
	cp DEXENTRY_AREA_SURF_SWARM
	jr z, .surf
	
	cp DEXENTRY_AREA_RODS
	jr z, .rods
	cp DEXENTRY_AREA_TREES
	cp DEXENTRY_AREA_CONTEST
	
	; loop back around as if we are arriving for the first time, creating a closed-loop rotation
.first
	xor a
	ld [wPokedexEntryPageNum], a
	call Dex_FindFirstList
	cp DEXENTRY_AREA_NONE
	jr nz, .found
.none
	ld [wPokedexEntryType], a
	ld de, .none_wild_text
	hlcoord 2, 9
	call PlaceString
	xor a
	ld [wPokedexStatus], a ; wildmon entry index
	ld [wPokedexEntryPageNum], a ; page num
	call Pokedex_PrintPageNum
	ret
.found
	ld [wPokedexEntryType], a
	xor a
	ld [wPokedexStatus], a ; wildmon entry index
	ld [wPokedexEntryPageNum], a ; page num
	call Pokedex_DetailedArea
	ret

.grass
	; hl contains the table we are looking at, JohtoGrassWildMons, KantoGrassWildMons, or SwarmGrassWildMons  	
	call Pokedex_DetailedArea_grass
	jr .skip_empty_area_check
.surf
	call Pokedex_DetailedArea_surf
	jr .skip_empty_area_check
.rods
	call Pokedex_DetailedArea_rods
	jr .skip_empty_area_check
.trees
.contest
.skip_empty_area_check
	cp -1 ; -1 means we skipped, ;;;; 0 is normal
	jp z, .checkpoint
; .done
	xor a
	ret

.none_wild_text:
	db "NONE IN WILD@"

Dex_FindFirstList:
; contest, trees(+rocks), grass swarm, grass, rods, water surf, surf
; grass, grass swarm, contest, trees(+rocks), surf, surf swarm, rods
	ld hl, JohtoGrassWildMons
	ld a, BANK(JohtoGrassWildMons)
	call Dex_Check_Grass
	and a
	jr z, .grass_johto
	ld hl, KantoGrassWildMons
	ld a, BANK(KantoGrassWildMons)
	call Dex_Check_Grass
	and a
	jr z, .grass_kanto
	ld hl, SwarmGrassWildMons
	ld a, BANK(SwarmGrassWildMons)
	call Dex_Check_Grass
	and a
	jr z, .grass_swarm

	ld hl, JohtoWaterWildMons
	ld a, BANK(JohtoWaterWildMons)
	call Dex_Check_Surf
	and a
	jr z, .surf_johto

	ld hl, KantoWaterWildMons
	ld a, BANK(KantoWaterWildMons)
	call Dex_Check_Surf
	and a
	jr z, .surf_kanto
	
	ld hl, SwarmWaterWildMons
	ld a, BANK(SwarmWaterWildMons)
	call Dex_Check_Surf
	and a
	jr z, .surf_swarm

	xor a
	ld [wPokedexStatus], a
	ld hl, FishGroups ; we want to start at the beginning
	call Dex_Check_Fishing
	and a
	jr z, .rods

	; call Dex_Check_TreesRocks
	; and a
	; jr z, .treesrocks

	; call Dex_Check_BugContest
	; and a
	; jr z, .contest

; none found
	ld a, DEXENTRY_AREA_NONE
	ret
.grass_johto
	ld a, DEXENTRY_AREA_GRASS_JOHTO
	ret
.grass_kanto
	ld a, DEXENTRY_AREA_GRASS_KANTO
	ret
.grass_swarm
	ld a, DEXENTRY_AREA_GRASS_SWARM
	ret
.surf_johto
	ld a, DEXENTRY_AREA_SURF_JOHTO
	ret
.surf_kanto
	ld a, DEXENTRY_AREA_SURF_KANTO
	ret
.surf_swarm
	ld a, DEXENTRY_AREA_SURF_SWARM
	ret
.rods
	ld a, DEXENTRY_AREA_RODS
	ret
.treesrocks
	ld a, DEXENTRY_AREA_TREES
	ret
.contest
	ld a, DEXENTRY_AREA_CONTEST
	ret

Print_area_entry:
; morn,day,nite,space,map name
; time of day
	push hl ; pointer to map groupnum/name
	push bc ; b has morn encounter rate, c is current print line?
	push de ; day (e) /nite (d) encounter rates
	hlcoord 3, 11 ; same position regardless
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	ld [hl], $65 ; day icon tile
	ld de, 6
	add hl, de
	ld [hl], $6b ; day icon tile
	add hl, de
	ld [hl], $6c ; nite icon tile 
	hlcoord 7, 11
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	ld [hl], "<%>"
	ld de, 6
	add hl, de
	ld [hl], "<%>"
	add hl, de
	ld [hl], "<%>"
.time_done
	pop de ; nite encounter %
	push de
; encounter % for nite
	ld a, d
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	hlcoord 16, 11
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	lb bc, 1, 3
	call PrintNum
; encounter rate for day
	pop de
	pop bc
	push bc
	ld a, e
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	hlcoord 10, 11
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	lb bc, 1, 3
	call PrintNum
; encounter rate for morn
	pop bc
	push bc
	ld a, b
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	hlcoord 4, 11
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	lb bc, 1, 3
	call PrintNum
	pop bc

; map name
	ld a, BANK(JohtoGrassWildMons)
	pop hl
	push bc
	call GetFarWord
	pop bc
	ld d, h 
	ld e, l
	farcall GetMapGroupNum_Name
	; map name ptr is in de
	hlcoord 2 , 10
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	ld a, BANK(MapGroupNum_Names)
	push bc
	call PlaceFarString
	ld c, 4
	call DelayFrames
	pop bc ; line counter
	ret

Pokedex_Skip_Empty_Area_Category:
	xor a
	ld [wPokedexStatus], a ; wildmon entry index
	ld [wPokedexEntryPageNum], a ; page num
	ld a, [wPokedexEntryType] ; johto, kanto, swarm
	inc a
	call DexEntry_NextCategory
	ld a, -1 ; will signify 
	ret

Pokedex_DetailedArea_grass:
	push hl ; JohtoGrassWildMons, KantoGrassWildMons, or SwarmGrassWildMons. still need this push because the function probably clobbers hl
	; need to preserve Wildmon Index
	ld a, [wPokedexStatus]; wildmon entry index
	push af ; wildmon index
	ld a, BANK(JohtoGrassWildMons) ; same bank for all 3 thankfully
	call Dex_Check_Grass ; since we automatically roll into the next category, we need to check if there's even anything there for us again
	ld b, a ; placeholder for a
	pop af ; wildmon index
	ld [wPokedexStatus], a ; wildmon entry index
	pop hl ; in case we are about to exit
	ld a, b
	and a
	jp nz, Pokedex_Skip_Empty_Area_Category

	push hl ; JohtoGrassWildMons, KantoGrassWildMons, or SwarmGrassWildMons
	hlcoord 7, 9
	ld de, .grass_walk_text
	call PlaceString
	ld a, [wPokedexEntryType]
	cp DEXENTRY_AREA_GRASS_JOHTO
	jr nz, .chk_kanto
	hlcoord 1, 9
	ld de, .johto_text
	call PlaceString
	jr .title_done
.chk_kanto
	cp DEXENTRY_AREA_GRASS_KANTO
	jr nz, .swarm
	hlcoord 1, 9
	ld de, .kanto_text
	call PlaceString
	jr .title_done
.swarm
	hlcoord 1, 9
	ld de, .swarm_text
	call PlaceString
.title_done

	ld a, [wPokedexStatus] ; wildmon index
	ldh [hMultiplicand + 2], a
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
; Multiply hMultiplicand (3 bytes) by hMultiplier. Result in hProduct.
	ld a, GRASS_WILDDATA_LENGTH
	ldh [hMultiplier], a
	call Multiply ; wildmon entry index
	ldh a, [hProduct + 2]
	ld b, a
	ldh a, [hProduct + 3]
	ld c, a ; result of simple multiply in a
	; ld hl, JohtoGrassWildMons
	pop hl ; JohtoGrassWildMons, KantoGrassWildMons, or SwarmGrassWildMons
	add hl, bc; pointing to map group and num?
	ld bc, 0 ; printed line count
	push bc ; printed line count
	push hl ; points to map group/num
.landmark_loop
	ld a, BANK(JohtoGrassWildMons)
	call GetFarWord
	pop hl  ; points to map group/num
	pop bc ; line counter
	push bc ; line counter
	push hl ; points to map group/num
	; skip map encounter rates
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl ; should now point to lvl of encounter slot
	inc hl ; now pointing to species
; morn
	ld a, 0 ; morn
	call Pokedex_Parse_grass ; encounter % in a
	ld b, a
	ld a, 1 ; day
	call Pokedex_Parse_grass ; encounter % in a
	ld e, a
	ld a, 2 ; nite
	call Pokedex_Parse_grass ; encounter % in a
	ld d, a
	ld a, b
	and a
	jr nz, .print
	ld a, e
	and a
	jr nz, .print
	ld a, d
	and a
	jr z, .done
.print
	pop hl
	push hl
	call Print_area_entry
	pop hl ; points to map group/num
	pop bc ; line counter in c
	inc c
	inc c
	push bc ; print line counter
	push hl
.done
	pop hl ; points to map group/num
	pop bc ; line counter in c
	ld a, [wPokedexStatus] ; wildmon index
	inc a
	ld [wPokedexStatus], a ; wildmon index
	push bc ; line counter in c
	ld b, 0
	ld c, GRASS_WILDDATA_LENGTH
	add hl, bc
	pop bc ; print counter
	; check to see if there is a next entry
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte ; hl is preserved, also wont clobber print line counter in c
	cp -1
	jr z, .reached_end

	; no need to handle hving printed all 3 slots if we had already reached the end of the table
	ld a, c
	cp $6 ; 3 entries, 6 rows
	jr z, .max_print

	push bc ; print line counter in c
	push hl
	jr .landmark_loop
.reached_end
	xor a
	ld [wPokedexStatus], a ; wildmon entry index
	ld [wPokedexEntryPageNum], a ; page num
	ld a, [wPokedexEntryType] ; johto, janto, swarm
	inc a
	call DexEntry_NextCategory
	xor a ; to ensure a isnt actually returned at -1. 0 is for normal
	ret
.max_print
	call Grass_check_any_remaining
	and a
	jr z, .reached_end
	ld a, [wPokedexStatus] ; wildmon index
	inc a 
	ld [wPokedexStatus], a ; wildmon index
	call DexEntry_IncPageNum
	; page number is currently in a
	xor a ; to ensure a isnt actually returned at -1. 0 is for normal
	ret
.grass_walk_text:
	db "GRASS/WALKING@"
.johto_text:
	db "JOHTO@"
.kanto_text:
	db "KANTO@"
.swarm_text:
	db "SWARM@"

Pokedex_Parse_grass:
	push hl ; first species byte in morn
	push bc ; current print line
	ld c, 14 ; 7 entries * 2 bytes
	call SimpleMultiply
	ld b, 0
	ld c, a ; time of day adjustment
	add hl, bc
	ld c, 0; up to NUM_GRASSMON ; * 3 ; total mon entries, morn/day/nite, 7 per
	ld b, 0 ; for calcing encounter %
	; 30%, 30%, 20%, 10%, 5%, 4%, 1%
	push bc ; % and NUM_GRASSMON
.map_loop
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte ; bkup hl and change to getfarword for pk16?
	; a is species
	inc hl ; pointing to next mon lvl
	inc hl ; pointing to next mon species
	; a is mon species 
	ld d, a
	ld a, [wCurSpecies]
	pop bc ; % and NUM_GRASSMON
	cp d ; mon species 
	jr nz, .not_match
	call Add_encounter_percent_grass
	add b
	ld b, a
.not_match
	inc c
	push bc ; % and NUM_GRASSMON
	ld a, c
	cp NUM_GRASSMON
	jr z, .map_loop_end ; end of day group
	jr .map_loop

.map_loop_end ; reach end of day group
	pop bc ; % and NUM_GRASSMON
	ld a, b ; %
	pop bc ; print line, do not modify
	pop hl ; first species byte in morn
	ret

Grass_check_any_remaining:
	push hl
	push de
	push bc

	ld b, 0
	ld c, GRASS_WILDDATA_LENGTH
	add hl, bc
	ld bc, 0 ; fake print line counter
	push bc
	push hl
.landmark_loop
	ld a, BANK(JohtoGrassWildMons)
	call GetFarWord
	pop hl  ; points to map group/num
	pop bc ; line counter
	push bc ; line counter
	push hl ; points to map group/num
	; skip map encounter rates
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl ; should now point to lvl of encounter slot
	inc hl ; now pointing to species
; morn
	ld a, 0 ; morn
	call Pokedex_Parse_grass ; encounter % in a
	ld b, a
	ld a, 1 ; day
	call Pokedex_Parse_grass ; encounter % in a
	ld e, a
	ld a, 2 ; nite
	call Pokedex_Parse_grass ; encounter % in a
	ld d, a
	ld a, b
	and a
	jr nz, .entries_remaining
	ld a, e
	and a
	jr nz, .entries_remaining
	ld a, d
	and a
	jr nz, .entries_remaining
.done
	pop hl ; points to map group/num
	pop bc ; line counter in c
	push bc ; line counter in c
	ld b, 0
	ld c, GRASS_WILDDATA_LENGTH
	add hl, bc
	pop bc ; print counter
	; check to see if there is a next entry
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte ; hl is preserved
	cp -1
	jr z, .reached_end
	push bc
	push hl
	jr .landmark_loop

.reached_end
	pop bc
	pop de
	pop hl
	; 0 means none left
	xor a
	ret
.entries_remaining
	pop hl ; realign stack, dont care about values
	pop bc ; realign stack, dont care about values
	
	pop bc
	pop de
	pop hl
	ld a, 1
	ret

Add_encounter_percent_grass:
	; total in b
	; current count in c
	push bc
	call .body
	ld a, b
	pop bc
	ret
.body:
	ld a, c
	ld b, 30
	and a
	ret z
	ld b, 30
	cp 1
	ret z
	ld b, 20
	cp 2
	ret z
	ld b, 10
	cp 3
	ret z
	ld b, 5
	cp 4
	ret z
	ld b, 4
	cp 5
	ret z
	ld b, 1
	ret

;;;;;;;;;;;;;;;;;;;;;;; SURF ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Pokedex_DetailedArea_surf:
	push hl ; JohtoWaterWildMons, KantoWaterWildMons, or SwarmWaterWildMons. still need this push because the function probably clobbers hl
	; need to preserve Wildmon Index
	ld a, [wPokedexStatus]; wildmon entry index
	push af ; wildmon index
	ld a, BANK(JohtoWaterWildMons) ; same bank for all 3 thankfully
	call Dex_Check_Surf ; since we automatically roll into the next category, we need to check if there's even anything there for us again
	ld b, a ; placeholder for a
	pop af ; wildmon index
	ld [wPokedexStatus], a ; wildmon entry index
	pop hl ; in case we are about to exit
	ld a, b
	and a
	jp nz, Pokedex_Skip_Empty_Area_Category

	push hl ; JohtoWaterWildMons, KantoWaterWildMons, or SwarmWaterWildMons
	hlcoord 7, 9
	ld de, .surfing_text
	call PlaceString
	ld a, [wPokedexEntryType]
	cp DEXENTRY_AREA_SURF_JOHTO
	jr nz, .chk_kanto
	hlcoord 1, 9
	ld de, .johto_text
	call PlaceString
	jr .title_done
.chk_kanto
	cp DEXENTRY_AREA_SURF_KANTO
	jr nz, .swarm
	hlcoord 1, 9
	ld de, .kanto_text
	call PlaceString
	jr .title_done
.swarm
	hlcoord 1, 9
	ld de, .swarm_text
	call PlaceString
.title_done
	ld a, [wPokedexStatus] ; wildmon index
	ldh [hMultiplicand + 2], a
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
; Multiply hMultiplicand (3 bytes) by hMultiplier. Result in hProduct.
	ld a, WATER_WILDDATA_LENGTH
	ldh [hMultiplier], a
	call Multiply ; wildmon entry index
	ldh a, [hProduct + 2]
	ld b, a
	ldh a, [hProduct + 3]
	ld c, a ; result of simple multiply in a
	; ld hl, JohtoWaterWildMons
	pop hl ; JohtoWaterWildMons, KantoWaterWildMons, or SwarmWaterWildMons
	add hl, bc; pointing to map group and num?
	ld bc, 0 ; printed line count
	push bc ; printed line count
	push hl ; points to map group/num
.landmark_loop
	ld a, BANK(JohtoWaterWildMons)
	call GetFarWord
	pop hl  ; points to map group/num
	pop bc ; line counter
	push bc ; line counter
	push hl ; points to map group/num
	; skip map encounter rates, surf only has one, grass has 3
	inc hl
	inc hl
	inc hl ; should now point to lvl of encounter slot
	inc hl ; now pointing to species
; morn
	ld a, 0 ; morn
	call Pokedex_Parse_surf ; encounter % in a
	ld b, a ; pretend morning
	ld d, a ; pretend day
	ld e, a ; pretend night
	and a
	jr z, .done
.print
	pop hl
	push hl
	call Print_area_entry
	pop hl ; points to map group/num
	pop bc ; line counter in c
	inc c
	inc c
	push bc ; print line counter
	push hl
.done
	pop hl ; points to map group/num
	pop bc ; line counter in c
	ld a, [wPokedexStatus] ; wildmon index
	inc a
	ld [wPokedexStatus], a ; wildmon index
	push bc ; line counter in c
	ld b, 0
	ld c, WATER_WILDDATA_LENGTH
	add hl, bc
	pop bc ; print counter
	; check to see if there is a next entry
	ld a, BANK(JohtoWaterWildMons)
	call GetFarByte ; hl is preserved
	cp -1 ; if we've printed a 3rd entry, this doesn't get checked
	jr z, .reached_end

	; we dont need to handle having printed all 3 slots if we were at the end of the table
	ld a, c
	cp $6 ; 3 entries, 6 rows
	jr z, .max_print
	push bc ; print counter
	push hl
	jr .landmark_loop
.reached_end
	xor a
	ld [wPokedexStatus], a ; wildmon entry index
	ld [wPokedexEntryPageNum], a ; page num
	ld a, [wPokedexEntryType] ; johto, janto, swarm
	inc a
	call DexEntry_NextCategory
	xor a ; to ensure a isnt actually returned at -1. 0 is for normal
	ret
.max_print
	call Surf_check_any_remaining
	and a
	jr z, .reached_end
	ld a, [wPokedexStatus] ; wildmon index
	inc a 
	ld [wPokedexStatus], a ; wildmon index
	call DexEntry_IncPageNum
	; page number is currently in a
	xor a ; to ensure a isnt actually returned at -1. 0 is for normal
	ret
.surfing_text:
	db "SURFING@"
.johto_text:
	db "JOHTO@"
.kanto_text:
	db "KANTO@"
.swarm_text:
	db "SWARM@"

Pokedex_Parse_surf:
	push hl ; first species byte, surfing has no time of day
	push bc ; current print line
	ld c, 0; up to NUM_WATERMON ; unlike grass, which is 21, this is only 3. and no time of day shenanigans
	ld b, 0 ; for calcing encounter %
	; 60%, 30%, 10%
	push bc ; % and NUM_WATERMON
.map_loop
	ld a, BANK(JohtoWaterWildMons)
	call GetFarByte ; bkup hl and change to getfarword for pk16?
	; a is species
	inc hl ; pointing to next mon lvl
	inc hl ; pointing to next mon species
	; a is mon species 
	ld d, a
	ld a, [wCurSpecies]
	pop bc ; % and NUM_GRASSMON
	cp d ; mon species 
	jr nz, .not_match
	call Add_encounter_percent_water
	add b ; accumulated encounter total for this species is in b, this slot % is in a
	ld b, a ; new accumulated encounter % total in b
.not_match
	inc c 
	push bc ; % and NUM_WATERMON
	ld a, c
	cp NUM_WATERMON
	jr z, .map_loop_end ; end of day group
	jr .map_loop

.map_loop_end ; reach end of day group
	pop bc ; % and NUM_WATERMON
	ld a, b ; %
	pop bc ; print line, do not modify
	pop hl ; first species byte in morn
	ret

Surf_check_any_remaining:
	; once we have printed max number of entries per page
	; need to determine if there's anymore in this category (johto/kanto/swarm) before switching to next category
	push hl
	push de
	push bc

	ld b, 0
	ld c, WATER_WILDDATA_LENGTH
	add hl, bc
	ld bc, 0 ; fake print line counter
	push bc
	push hl
.landmark_loop
	ld a, BANK(JohtoWaterWildMons)
	call GetFarWord
	pop hl  ; points to map group/num
	pop bc ; line counter
	push bc ; line counter
	push hl ; points to map group/num
	; skip map encounter rates, minus two for surf
	inc hl
	inc hl
	inc hl ; should now point to lvl of encounter slot
	inc hl ; now pointing to species
; morn
	ld a, 0 ; morn
	call Pokedex_Parse_surf ; encounter % in a
	and a
	jr nz, .entries_remaining
.done
	pop hl ; points to map group/num
	pop bc ; line counter in c
	push bc ; line counter in c
	ld b, 0
	ld c, WATER_WILDDATA_LENGTH
	add hl, bc
	pop bc ; print counter
	; check to see if there is a next entry
	ld a, BANK(JohtoWaterWildMons)
	call GetFarByte ; hl is preserved
	cp -1
	jr z, .reached_end
	push bc
	push hl
	jr .landmark_loop

.reached_end
	pop bc
	pop de
	pop hl
	; 0 means none left
	xor a
	ret
.entries_remaining
	pop hl ; realign stack, dont care about values
	pop bc ; realign stack, dont care about values
	
	pop bc
	pop de
	pop hl
	ld a, 1
	ret

Add_encounter_percent_water:
	; total in b
	; current count in c
	ld a, c
	and a
	jr nz, .slot2
	ld a, 60
	jr .done
.slot2
	cp 1
	jr nz, .slot3
	ld a, 30
	jr .done
.slot3
	ld a, 10
.done
	; whatever value is currently in a will added to b
	ret

;;;;;;;; First Pass Checking ;;;;;;;;;;;;;;

Dex_Check_Grass:
	; hl is JohtoGrassWildMons, KantoGrassWildMons, or SwarmGrassWildMons
	call GetFarByte
	cp -1 ; swarm water table will be empty, just -1
	ret z
.landmark_loop
	push hl ; points to map group/num
	inc hl
	inc hl
	inc hl
	inc hl ; should now point to lvl of encounter slot
	inc hl ; now pointing to species
	inc hl
	ld a, BANK(JohtoGrassWildMons)
	call Pokedex_LookCheck_grass
	and a
	jr z, .found
	pop hl ; points to map group/num
	ld a, [wPokedexStatus]
	inc a
	ld [wPokedexStatus], a
	ld b, 0
	ld c, GRASS_WILDDATA_LENGTH
	add hl, bc
	; check to see if there is a next entry
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte ; hl is preserved
	cp -1
	ret z
	; push hl ; hl is JohtoGrassWildMons, KantoGrassWildMons, or SwarmGrassWildMons
	jr .landmark_loop
.found
	pop hl
	xor a
	ret

Pokedex_LookCheck_grass:
	ld bc, 0; up to NUM_GRASSMON ; * 3 ; total mon entries, morn/day/nite, 7 per
	; push bc ; up to NUM_GRASSMON * 3
	push af ; bank
.map_loop
	pop af
	push af
	push bc
	call GetFarByte ; bkup hl and change to getfarword for pk16?
	; a is species
	inc hl ; pointing to next mon lvl
	inc hl ; pointing to next mon species
	; a is mon species 
	ld d, a
	ld a, [wCurSpecies]
	pop bc
	cp d
	jr z, .found
	; pop bc ; % and NUM_GRASSMON
	inc c
	push bc ; % and NUM_GRASSMON
	ld a, c
	cp NUM_GRASSMON * 3
	jr z, .map_loop_end ; end of wildmon entry, species not found in any time
	pop bc
	jr .map_loop
.map_loop_end
	pop bc
	pop af
	ld a, 1
	ret
.found
	pop af
	xor a
	ret

Dex_Check_Surf:
	; hl is JohtoGrassWildMons, KantoGrassWildMons, or SwarmGrassWildMons
	call GetFarByte
	cp -1 ; swarm water table will be empty, just -1
	ret z
.landmark_loop
	push hl ; points to map group/num
	; db 2 percent ; encounter rate
	; db 15, WOOPER
	; db 20, QUAGSIRE
	; db 15, QUAGSIRE
	inc hl
	inc hl ; should now point to lvl of encounter slot
	inc hl ; now pointing to species
	inc hl
	ld a, BANK(JohtoWaterWildMons)
	; ld a, BANK(KantoWaterWildMons)
	call Pokedex_LookCheck_surf
	and a
	jr z, .found
	pop hl ; points to map group/num
	ld a, [wPokedexStatus]
	inc a
	ld [wPokedexStatus], a
	ld b, 0
	ld c, WATER_WILDDATA_LENGTH
	add hl, bc
	; check to see if there is a next entry
	ld a, BANK(JohtoWaterWildMons)
	call GetFarByte ; hl is preserved
	cp -1
	;jr z, .reached_end
	ret z
	; push hl ; hl is JohtoGrassWildMons, KantoGrassWildMons, or SwarmGrassWildMons
	jr .landmark_loop
.found
	pop hl
	xor a
	ret

Pokedex_LookCheck_surf:
	ld bc, 0; up to NUM_WATERMON ; * 3 ; total mon entries, 1 per day, 3 per
	; push bc ; up to NUM_WATERMON * 3
	push af ; bank
.map_loop
	pop af
	push af
	push bc
	call GetFarByte ; bkup hl and change to getfarword for pk16?
	; a is species
	inc hl ; pointing to next mon lvl
	inc hl ; pointing to next mon species
	; a is mon species 
	ld d, a
	ld a, [wCurSpecies]
	pop bc
	cp d
	jr z, .found
	; pop bc ; % and NUM_WATERMON
	inc c
	push bc ; % and NUM_WATERMON
	ld a, c
	cp NUM_WATERMON ; no time of day considerations
	jr z, .map_loop_end ; end of wildmon entry, species not found in any time
	pop bc
	jr .map_loop
.map_loop_end
	pop bc
	pop af
	ld a, 1
	ret
.found
	pop af
	xor a
	ret

;;;;;;;;;;;;;;;;;;;;;;; FISHING RODS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Pokedex_DetailedArea_rods:
	ld a, [wPokedexStatus]; wildmon entry index, 0 we havent started yet, 1 is old-shore, 2 is good-shore, 3 is super-shore, 4 is old-ocean, etc
	and a
	; if not zero, we know that there are Fishing entries
	jr nz, .auto_cont

	ld hl, FishGroups ; we want to start at the beginning
	call Dex_Check_Fishing ; from prev category, we automatically roll into this category, we need to check if there's even anything there for us, so we use same func as first pass/check
	and a ; if a is 0, means species was found somewhere
	jp nz, Pokedex_Skip_Empty_Area_Category

.auto_cont
	xor a
	ld [wPokedexEvoStage2], a
	ld [wPokedexEvoStage3], a

	; print the title, FISHING RODS
	hlcoord 1, 9
	ld de, .fishing_text
	call PlaceString
	; calculate where we left off

	call Fishing_MonIndex_Addr ; clobbers bc, return addr in hl
	ld bc, 0 ; printed line count
	push bc ; printed line count
	; push hl ; points to fishgroup, specific rod ptr
.landmark_loop
	call Check_this_rod ; maybe make new version to accumulate encounter % properly
	pop bc ; line counter
	ld a, [wPokedexEvoStage2] ; day and morn
	and a
	jr nz, .print
	ld a, [wPokedexEvoStage3] ; nite
	and a
	jp z, .prep_loop
.print
	; when we arrive here, we are printing our first rod for this Fishing Group, could be any
	; print the first rod, then check if we're super, if not, inc Index and check
	; again, check if we're super, if we ARE, check and inc
	push bc ; line counter, rod in b, maps in c
	pop bc ; ; line counter, rod in b, maps in c
	; push hl ; points to fishgroup, specific rod ptr
	ld a, [wPokedexStatus] ; fish group starting at bit 3
	; ld b,b
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call Fishing_Print_Rod
	push bc ; line counter, rod in b, maps in c, b has been inc'd
	; zero the cumulative bytes
	xor a
	ld [wPokedexEvoStage2], a
	ld [wPokedexEvoStage3], a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; ld b,b
	ld a, [wPokedexStatus] ; fish group starting at bit 3
	and 3 ; rod type mask, first 2 bits
	cp 2 ; did we just print a super rod?
	jr z, .print_rods_done ; we do not inc the index, prep loop will, and calcs new hl
	cp 1 ; did we just print a good rod?
	jr z, .good2super ; we just printed an good rod, inc index and check, print if not 0
	; now we can assume we are an old rod
	call Fishing_Inc_Index ; we are now indexed on the good rod
	call Fishing_MonIndex_Addr
	call Check_this_rod
	and a
	jr z, .good2super ; since we're on the good rod, we still need to check the super rod entry	
	;
	ld a, [wPokedexStatus] ; fish group starting at bit 3
	; ld b,b
	;
	pop bc ; line counter, rod in b, maps in c
	call Fishing_Print_Rod
	push bc ; line counter, rod in b, maps in c, now has been inc'd
	; zero the cumulative bytes
	xor a
	ld [wPokedexEvoStage2], a
	ld [wPokedexEvoStage3], a
.good2super
	call Fishing_Inc_Index ; we are now indexed on the super rod
	call Fishing_MonIndex_Addr
	call Check_this_rod
	and a
	jr z, .print_rods_done
	;
	ld a, [wPokedexStatus] ; fish group starting at bit 3
	; ld b,b
	;
	pop bc ; line counter, rod in b, maps in c
	call Fishing_Print_Rod
	push bc ; line counter, rod in b, maps in c, now has been inc'd
	; zero the cumulative bytes
	xor a
	ld [wPokedexEvoStage2], a
	ld [wPokedexEvoStage3], a
	; do we fall through to prep loop or skip directly to max print?
	; should probably fall through, so double check we dont double inc
.print_rods_done
	; pop hl ; points to fishgroup+rod table ; eventually get rid of the hl stack here?
	; call Fishing_MonIndex_Addr ; eventually get rid of the hl stack here? 
	; since we will be exiting since we printed a rod and finished checking the group
	pop bc ; line counter, rod in b, maps in c
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; map name ;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld hl, FishGroups_Names
	; ld b,b
	push bc ; line counter, rod in b, maps in c
	; call GetFarWord
	ld a, [wPokedexStatus]
	sra a
	sra a
	ld d, 0
	ld e, a
	add hl, de
	add hl, de
	ld a, BANK(FishGroups_Names)
	call GetFarWord ;; 
	ld d, h 
	ld e, l
	ld a, BANK(FishGroups_Names)
	hlcoord 1 , 11 ; we want allllll the chars we can have
	pop bc ; line counter, rod in b, maps in c
	call FishEntry_adjusthlcoord_map ; line counter, rod in b, maps in c
	push bc
	call PlaceFarString
	pop bc
	inc c ; since we printed a map name
	push bc

	ld c, 4
	call DelayFrames
	; call WaitBGMap

	pop bc ; line counter
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.prep_loop
	; ; increment wildmon index, if end is 2, zero, inc fish group
	push bc
	call Fishing_Inc_Index
	pop bc
	;;;;;;;;;; check if we've finished all FishingGroups
	ld a, [wPokedexStatus] ; fishgroup in bit 3
	sra a
	sra a
	cp NUM_FISHGROUPS ; + 1
	jr z, .reached_end
	;;;;;;;;;;;;;;;;;;;;;
	
	ld a, b ; number of rods printed, anything over 0 means we want a new page
	and a
	; cp $1 ; experimental, since we're only printing FishGroup Name rn
	jr nz, .max_print

	push bc ; print counter
	; push hl ; adjusted points to fishgroup+rod table
	jp .landmark_loop
.reached_end
	xor a
	ld [wPokedexStatus], a ; wildmon entry index
	ld [wPokedexEntryPageNum], a ; page num
	ld a, [wPokedexEntryType] ; johto, janto, swarm
	inc a
	call DexEntry_NextCategory
	xor a ; to ensure a isnt actually returned at -1. 0 is for normal
	ret
.max_print
	; ld b,b
	call Fishing_MonIndex_Addr
	call Rods_check_any_remaining ; if entries remaining for this species, will return 0
	and a
	jr nz, .reached_end ; no more remaining entries for this species, do not increment page

	call DexEntry_IncPageNum
	; page number is currently in a
	xor a ; to ensure a isnt actually returned at -1. 0 is for normal
	ret
.fishing_text:
	db "FISHING RODS@"

Fishing_Print_Rod:
	; day (e) /nite (d) encounter rates
	ld a, [wPokedexEvoStage3]
	ld d, a
	ld a, [wPokedexEvoStage2]
	call Adjust_percent_fish
	ld e, a
	ld a, d
	call Adjust_percent_fish
	ld d, a

	push bc ; b has rods printed, c is current maps printed
	push de ; day (e) /nite (d) encounter rates

; time of day icons	
	; ld b,b
	hlcoord 9, 13 ; same position regardless
	call FishEntry_adjusthlcoord_rod ; current print line needs to be in c
	ld [hl], $6b ; day icon tile
	ld de, 6
	add hl, de
	ld [hl], $6c ; nite icon tile 
; % char	
	hlcoord 13, 13
	call FishEntry_adjusthlcoord_rod ; current print line needs to be in c
	ld [hl], "<%>"
	ld de, 6 ; de should still be 6 since we push/pop de in adjust, check this
	add hl, de
	ld [hl], "<%>"

	pop de ; nite encounter % in d, day in e
	pop bc
	push bc ; probably uneccessary but will check later
	push de
; encounter % for nite
	ld a, d
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	hlcoord 16, 13
	call FishEntry_adjusthlcoord_rod ; current print line needs to be in b
	lb bc, 1, 3
	call PrintNum
; encounter rate for day
	pop de
	pop bc
	push bc
	ld a, e
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	hlcoord 10, 13
	call FishEntry_adjusthlcoord_rod ; current print line needs to be in b
	lb bc, 1, 3
	call PrintNum
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Rod Name;;;;;;;;;;;;
	pop bc
	push bc
;;;;;;;;;; Print Rod based on Index ;;;;;;;;;;;;;;;;;
	ld a, [wPokedexStatus]
	and 3 ; bit mask for rod type, first 2 bits
	ld de, oldrod_text
	and a
	jr z, .printrod
	ld de, goodrod_text
	cp 1
	jr z, .printrod
	ld de, superrod_text
.printrod
	hlcoord 1 , 13
	call FishEntry_adjusthlcoord_rod ; current print line needs to be in b
	call PlaceString

	ld c, 4
	call DelayFrames
	; call WaitBGMap
	; ld b,b

	pop bc ; line counter
	inc b ; we've printed one rod
	ret
oldrod_text:
	db "-OLD@"
goodrod_text:
	db "-GOOD@"
superrod_text:
	db "-SUPER@"

FishEntry_adjusthlcoord_rod:
	; NOTE, preserve bc before calling this
	push bc
	ld c, b
	; given: current printed map lines in c, rod lines in b
	push af
	push de
	ld a, 20
	; the num of moves already printed should still be in bc
	call SimpleMultiply ; uses c as the other number
	; result in a
	ld d, 0
	ld e, a
	add hl, de ; allows us to print on the proper row lol
	pop de
	pop af
	pop bc
	ret

FishEntry_adjusthlcoord_map:
; NOTE, preserve bc before calling this
; given: current printed map lines in c, rod lines in b
; given: set hl coords to baseline location SAME AS ROD, [[[10]]]
	; push af
	; push de	
	; push bc
	; ld c, b ; can be 1, 2, or 3, we wouldn't be here if we havent printed a rod
	; ld a, 20
	; call SimpleMultiply ; uses c as the other number
	; ; result in a
	; ld d, 0
	; ld e, a
	; add hl, de ; allows us to print on the proper row by adjusting the pre-calcd hlcoord
	; pop bc ; now we need to add more lines depending on how many maps we've already printed
	; push bc
	; ; should always be 0 since we havent implemented that yet
	; ld a, 10
	; call SimpleMultiply ; uses c as the other number
	; ; result in a
	; ld d, 0
	; ld e, a
	; add hl, de ; allows us to print on the proper row by adjusting the pre-calcd hlcoord	
	
	; pop bc
	; pop de
	; pop af
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; FISHING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Dex_Check_Fishing:
; For first pass checks
;	NUM_FISHGROUPS
;   FISHGROUP_DATA_LENGTH
	; ld hl, FishGroups
	ld bc, 0 ; NUM_FISHGROUPS set up for mainloop
	ld a, [wPokedexStatus]
	and a
	jr z, .mainloop
	sra a
	sra a ; get fishing group, so we can properly calc to the last fishing group
	ld c, a
.mainloop
	push bc ; NUM_FISHGROUPS
	push hl ; FishGroups + FISHGROUP_DATA_LENGTH * n
	inc hl ; skip fishing group's bite rate
	call Check_Rods
	and a
	jr z, .found
	pop hl ; FishGroups + FISHGROUP_DATA_LENGTH * n
	ld bc, FISHGROUP_DATA_LENGTH
	add hl, bc ; FishGroups + FISHGROUP_DATA_LENGTH * n
	pop bc ; FISH GROUP #
	inc c ; FISH GROUP #

	ld a, NUM_FISHGROUPS
	cp c
	ret z ; not found
	jr .mainloop
.found
	pop hl
	pop bc
	xor a
	ret

;;;; Check all Rods in this Group
Check_Rods: 
	; looks for first instance of Species, starting with Old Rod
; 	; Get encounter data by rod:
	ld bc, 0 ; rod
.rod_loop
	push bc
	push hl
; 	; 0: Old
; 	; 1: Good
; 	; 2: Super
	; inc hl
	add hl, bc
	add hl, bc
	; set b to 0?
	ld b, 0
	call Check_this_rod
	; if a = 0, no match, done
	; if a not 0, accumulate %
	; b will now be this entry's coded %
	push af
	; call Fishing_Inc_Index
	pop af
	and a
	jr z, .notfound ; check next rod type
.found
	pop hl
	pop bc
	xor a
	ret
.notfound
	; zero the cumulative bytes
	xor a
	ld [wPokedexEvoStage2], a
	ld [wPokedexEvoStage3], a
	call Fishing_Inc_Index
	pop hl
	pop bc
	inc c ; 0 -> 1, good rod, 1 ->2 super rod
	ld a, 3 
	; will most likely move this check to parent function and be able to query based on rod
	cp c
	ret z ; means we've checked 3rd rod, super rod, done, no match
	jr .rod_loop

;;;; Look for Species in this Group's Rod, report encounter % for day and nite in 2-byte (WRAM?) that's its not being used during calcs
Check_this_rod:
; day cumulative encounter %: ldh [hMultiplier], a
; nite cumulative encounter %: ldh [hMultiplicand],
	; ld b,b
	push hl
	ld a, BANK(FishGroups)
	call GetFarWord	
.loop
	; check for 100% aka 255. In table, probability is not percentage (out of 100)
	; the probabilities add up to 255. So need to cross multiply to get % T.T
	ld a, BANK(FishGroups)
	call GetFarByte ; index? this is the probability

	ld c, a ; current entry %, b has prev entry %, or 0 if first entry
	sub b ; actual cumulative encounter % is difference between entry's % and prev entry's %, now in a
	; push af ; if this table entry is a match, we will need this value, accumulate based on species match
	ld b, c ; for the next entry's calculation, need raw % not the calculated difference
	ld c, a ; adjusted %
	
	inc hl
	ld a, BANK(FishGroups)
	call GetFarByte ; successfuly gets the Species in the Rod table
	ld d, a
	ld e, a
	and a
	call z, Dex_FishTimeGroupsGet ; if zero, not the species, 
	; looks at Daytime table to determine the species
	ld a, [wCurSpecies]
	; we cannot assume we didnt call the ToD table, which can hold two species,
	;  so check both d and e
	cp d
	jr z, .found
	cp e
	jr z, .found
	; pop af ; dont need this value (diff of entry %), clean stack
.resume
	ld a, b
	cp 255 ; this is how we tell if we are looking at the last entry of the table (FF)
	jr z, .end
	; we have not reached the end, increment to next entry % loop
	inc hl ; species
	inc hl ; encounter level
	jr .loop
.found
	; return true flag for match, plus %
	; b has adjusted %
	; a is species rn, use to determine day/nite
	cp d
	jr nz, .trynite
	push af ; species
	ld a, [wPokedexEvoStage2]
	add c
	ld [wPokedexEvoStage2], a
	pop af ; species
.trynite
	cp e
	jr nz, .resume
	ld a, [wPokedexEvoStage3]
	add c
	ld [wPokedexEvoStage3], a
	jr .resume
.end
	pop hl
	; call Fishing_Inc_Index
	ld a, [wPokedexEvoStage2]
	and a
	ret nz
	ld a, [wPokedexEvoStage3] ; will ret correct value if 0 or not
	; and a
	; ret nz
	; xor a
	; ; b should be this entry's percentage still, regardless of match or not
	ret
;;;;;;;;;;;;;;;;;;;;;;;;; Main 3 Fishing Funcs End;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; Fishing Utility Funcs ;;;;;;;;;;;;;;;;;;;;;;;
Dex_FishTimeGroupsGet:
	push hl
	push bc
	push af
	inc hl
	ld a, BANK(FishGroups)
	call GetFarByte ; index
	; a is the index
	ld hl, TimeFishGroups
	ld b, 0
	ld c, a
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, BANK(TimeFishGroups)
	call GetFarByte
	ld d, a ; species 1
	inc hl
	inc hl
	ld a, BANK(TimeFishGroups)
	call GetFarByte
	ld e, a ; species 2
.done	
	pop af
	pop bc
	pop hl
	ret

Adjust_percent_fish:
	; hMultiplicand 
	; hMultiplier. Result in hProduct.
	push hl
	push bc
	push de
	ldh [hMultiplicand], a
	ld a, 100
	ldh [hMultiplier], a
	call Multiply
	; Divide hDividend length b (max 4 bytes) by hDivisor. Result in hQuotient.
	; All values are big endian.
	ld b, 2
	; ldh a, [hProduct]
	; ldh [hDividend], a
	ld a, 255
	ldh [hDivisor], a
	call Divide
	pop de
	pop bc
	pop hl
	ldh a, [hQuotient + 3]
	cp 100
	ret z
	cp 0
	ret z
	inc a
	ret

Fishing_MonIndex_Addr:
	; clobbers bc and de
	; return addr in hl
	; given: Wildmon Index (Fishing Group in bits 3+, rod type in bits 1&2)
	ld a, [wPokedexStatus] ; wildmon index, will be zero if we are here for the first time
	and 3 ; masks the rod value
	push af ; rod value
	ld a, [wPokedexStatus]
	sra a; , 2 ; fish group #
	sra a
	ldh [hMultiplicand + 2], a
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
; Multiply hMultiplicand (3 bytes) by hMultiplier. Result in hProduct.
	ld a, FISHGROUP_DATA_LENGTH
	ldh [hMultiplier], a
	call Multiply ; wildmon entry index
	ldh a, [hProduct + 2]
	ld b, a
	ldh a, [hProduct + 3]
	ld c, a ; result of simple multiply in a
	ld hl, FishGroups
	add hl, bc; pointing to fishgroup bite rate
	pop af ; 0 = old rod, 1 = good rod, 2 = super rod
	inc hl ; skip the bite rate byte
	add a ; double the value since the rod's are pointers/words
	ld de, 0
	ld e, a
	add hl, de
	ret

Rods_check_any_remaining:
	; given: hl is addr of next rod, already adjusted for prev rod type and/or new fishing group
	; step 1, depending on this new rod type, if not old rod, check_this_rod individually until next fish group
	ld a, [wPokedexStatus]
	and 3 ; rod type mask for first 2 bits
	jr z, .check_rods
	cp 2 ; super rod
	jr z, .super
	; we are at good rod rn
	call Check_this_rod ; 0 means not found
	and a
	jr nz, .found
	call Fishing_Inc_Index
	; check_this_rod calls inc_index which auto incs hl depending on rod type
.super
	call Check_this_rod ; 0 means not found
	and a
	jr nz, .found
	call Fishing_Inc_Index
.check_rods
	; hl was already set properly to beginning of Fish group when this func is called
	dec hl ; Dex_Check_Fishing assumed you havent already accounted for Fishing Group's bite rate bit
	call Dex_Check_Fishing ; 0 means found
	; and a
	; jr z, .found
	ret
.found
	xor a
	ret
	; call Dex_Check_Fishing with hl aligned to new fish group old rod
	; we are about to exit so we dont need to align the hl addr with new incremented Wildmon index
	; when we come back, will auto calculate new Wildmon Index addr

Fishing_Inc_Index:
	; given hl if using it
	ld a, [wPokedexStatus] ; wildmon index
	and 3 ; mask for first 2 bits
	inc a
	cp 3
	jr z, .incfishgrp
	; no new fish grp needed yet
	ld a, [wPokedexStatus] ; wildmon index
	inc a
	ld [wPokedexStatus], a ; wildmon index
	inc hl
	inc hl ; two bytes to next ptr in fishgrp
	ret
.incfishgrp
	ld a, [wPokedexStatus] ; wildmon index
	sra a
	sra a
	inc a
	sla a
	sla a
	ld [wPokedexStatus], a ; wildmon index, also zeros the rod type
	inc hl
	inc hl
	inc hl ; need to skip extra byte for fishgrp bite rate
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Dex_Check_BugContest:
; ; all entries are unique, i.e. Caterpie wont be on the list twice
; ; but theoretically could, if wanted different ranges to have different encounter rates
; ; so we should check the rest of the table anyways in the main Contest function
; ; ContestMons:
; 	; encounter %, species,   min lvl, max lvl
; 	;db 20, CATERPIE,    7, 18
; 	ld hl, ContestMons
; .loop
; 	push hl ; no map group/num in this table
; 	inc hl ; skip enounter rate, now pointing to species
; 	ld a, [wCurSpecies]
; 	ld b, a
; 	ld a, BANK(ContestMons)
; 	call GetFarByte
; 	cp b
; 	jr z, .found
; 	pop hl ; points to map group/num
; 	ld a, [wPokedexStatus] ; increment how many entries we've checked so far
; 	inc a
; 	ld [wPokedexStatus], a
; 	ld b, 0
; 	ld c, 4 ; contest data length is not defined , unlike GRASS_WILDDATA_LENGTH etc, but it's 4 bytes
; 	add hl, bc
; 	; check to see if there is a next entry
; 	ld a, BANK(ContestMons)
; 	call GetFarByte ; hl is preserved
; 	cp -1 ; we reched the end of the table without finding a species match
; 	ret z
; 	jr .loop
; .found
; 	pop hl
; 	xor a
; 	ret

; Dex_Check_TreesRocks:
; 	xor a
; 	ld [wStatsScreenFlags], a
; 	ld hl, TreeMons
; 	ld bc, 0 ; NUM_TREEMON_SETS
; .loop
; 	push bc
; 	push hl ; points to TreeMons + 2n
; 	; skip map encounter rates
; 	ld a, BANK(TreeMons)
; 	call GetFarWord ; TreeMonSet_City, etc encounter %
; 	inc hl ; now pointing to species
; .mini_loop
; 	ld a, [wCurSpecies]
; 	ld b, a
; 	ld a, BANK(TreeMons)
; 	call GetFarByte
; 	cp b
; 	jr z, .found_end_miniloop
; 	inc hl
; 	inc hl
; 	ld a, BANK(TreeMons)
; 	call GetFarByte
; 	cp -1
; 	jr z, .found_end_miniloop
; 	inc hl
; 	jr .mini_loop
; .found_end_miniloop
; 	cp -1
; 	jr nz, .found
; 	ld a, [wStatsScreenFlags]
; 	and a
; 	jr nz, .rare_done
; 	inc a
; 	ld [wStatsScreenFlags], a
; 	inc hl
; 	inc hl
; 	jr .mini_loop
; .rare_done
; 	pop hl ; points to TreeMons + 2n
; 	ld b, 0
; 	ld c, 2 ; contest not defined , aka GRASS_WILDDATA_LENGTH
; 	add hl, bc ; points to TreeMons + 2n
; 	pop bc
; 	inc c
; 	ld a, NUM_TREEMON_SETS
; 	cp c
; 	ret z
; 	ld a, [wPokedexStatus]
; 	inc a
; 	ld [wPokedexStatus], a
; 	jr .loop
; .found
; 	pop hl
; 	pop bc
; 	xor a
; 	ret
