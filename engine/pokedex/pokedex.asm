; Pokedex_RunJumptable.Jumptable indexes
	const_def
	const DEXSTATE_MAIN_SCR
	const DEXSTATE_UPDATE_MAIN_SCR
	const DEXSTATE_DEX_ENTRY_SCR
	const DEXSTATE_UPDATE_DEX_ENTRY_SCR
	const DEXSTATE_REINIT_DEX_ENTRY_SCR
	const DEXSTATE_SEARCH_SCR
	const DEXSTATE_UPDATE_SEARCH_SCR
	const DEXSTATE_OPTION_SCR
	const DEXSTATE_UPDATE_OPTION_SCR
	const DEXSTATE_SEARCH_RESULTS_SCR
	const DEXSTATE_UPDATE_SEARCH_RESULTS_SCR
	const DEXSTATE_UNOWN_MODE
	const DEXSTATE_UPDATE_UNOWN_MODE
	const DEXSTATE_COLOR_OPTION
	const DEXSTATE_UPDATE_COLOR_OPTION
	const DEXSTATE_EXIT

POKEDEX_SCX EQU 5
EXPORT POKEDEX_SCX

Pokedex:
	ldh a, [hWX]
	ld l, a
	ldh a, [hWY]
	ld h, a
	push hl
	ldh a, [hSCX]
	push af
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a

	xor a
	ldh [hMapAnims], a
	call InitPokedex
	call DelayFrame

.main
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .exit
	call Pokedex_RunJumptable
	call DelayFrame
	jr .main

.exit
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	call WaitSFX
	call ClearSprites
	ld a, [wCurDexMode]
	ld [wLastDexMode], a

	xor a
	ld [wPokedexShinyToggle], a

	pop af
	ldh [hInMenu], a
	pop af
	ld [wVramState], a
	pop af
	ld [wOptions], a
	pop af
	ldh [hSCX], a
	pop hl
	ld a, l
	ldh [hWX], a
	ld a, h
	ldh [hWY], a
	ret

InitPokedex:
	call ClearBGPalettes
	call ClearSprites
	call ClearTilemap
	call Pokedex_LoadGFX

	ld hl, wPokedexDataStart
	ld bc, wPokedexDataEnd - wPokedexDataStart
	xor a
	call ByteFill

	xor a
	ld [wJumptableIndex], a
	ld [wPrevDexEntryJumptableIndex], a
	ld [wPrevDexEntryBackup], a
	ld [wUnusedPokedexByte], a

	call Pokedex_CheckUnlockedUnownMode

	ld a, [wLastDexMode]
	ld [wCurDexMode], a

	call Pokedex_OrderMonsByMode
	call Pokedex_InitCursorPosition
	call Pokedex_GetLandmark
	farcall DrawDexEntryScreenRightEdge
	call Pokedex_ResetBGMapMode
	ret

Pokedex_CheckUnlockedUnownMode:
	ld a, [wStatusFlags]
	bit STATUSFLAGS_UNOWN_DEX_F, a
	jr nz, .unlocked

	xor a
	ld [wUnlockedUnownMode], a
	ret

.unlocked
	ld a, TRUE
	ld [wUnlockedUnownMode], a
	ret

Pokedex_InitCursorPosition:
	ld hl, wPokedexOrder
	ld a, [wPrevDexEntry]
	and a
	jr z, .done
	cp NUM_POKEMON + 1
	jr nc, .done

	ld b, a
	ld a, [wDexListingEnd]
	cp $8
	jr c, .only_one_page

	sub $7
	ld c, a
.loop1
	ld a, b
	cp [hl]
	jr z, .done
	inc hl
	ld a, [wDexListingScrollOffset]
	inc a
	ld [wDexListingScrollOffset], a
	dec c
	jr nz, .loop1

.only_one_page
	ld c, $7
.loop2
	ld a, b
	cp [hl]
	jr z, .done
	inc hl
	ld a, [wDexListingCursor]
	inc a
	ld [wDexListingCursor], a
	dec c
	jr nz, .loop2

.done
	ret

Pokedex_GetLandmark:
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation

	cp LANDMARK_SPECIAL
	jr nz, .load

	ld a, [wBackupMapGroup]
	ld b, a
	ld a, [wBackupMapNumber]
	ld c, a
	call GetWorldMapLocation

.load
	ld [wDexCurLocation], a
	ret

Pokedex_RunJumptable:
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call Pokedex_LoadPointer
	jp hl

.Jumptable:
; entries correspond to DEXSTATE_* constants
	dw Pokedex_InitMainScreen
	dw Pokedex_UpdateMainScreen
	dw Pokedex_InitDexEntryScreen
	dw Pokedex_UpdateDexEntryScreen
	dw Pokedex_ReinitDexEntryScreen
	dw Pokedex_InitSearchScreen
	dw Pokedex_UpdateSearchScreen
	dw Pokedex_InitOptionScreen
	dw Pokedex_UpdateOptionScreen
	dw Pokedex_InitSearchResultsScreen
	dw Pokedex_UpdateSearchResultsScreen
	dw Pokedex_InitUnownMode
	dw Pokedex_UpdateUnownMode
	dw Pokedex_InitColorOption
	dw Pokedex_UpdateColorOption
	dw Pokedex_Exit

Pokedex_IncrementDexPointer:
	ld hl, wJumptableIndex
	inc [hl]
	ret

Pokedex_Exit:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

Pokedex_InitMainScreen:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	xor a
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	call ByteFill
	farcall DrawPokedexListWindow
	hlcoord 0, 17
	ld de, String_START_SEARCH
	call Pokedex_PlaceString
	ld a, 7
	ld [wDexListingHeight], a
	call Pokedex_PrintListing
	call Pokedex_SetBGMapMode_3ifDMG_4ifCGB
	call Pokedex_ResetBGMapMode
	call Pokedex_DrawMainScreenBG
	ld a, POKEDEX_SCX
	ldh [hSCX], a

	ld a, [wCurDexMode]
	cp DEXMODE_OLD
	ld a, $4a
	jr z, .okay
	ld a, $47
.okay
	ldh [hWX], a
	xor a
	ldh [hWY], a
	call WaitBGMap

	call Pokedex_ResetBGMapMode
	ld a, -1
	ld [wCurPartySpecies], a
	ld a, SCGB_POKEDEX
	call Pokedex_GetSGBLayout
	call Pokedex_UpdateCursorOAM
	farcall DrawPokedexListWindow
	hlcoord 0, 17
	ld de, String_START_SEARCH
	call Pokedex_PlaceString
	ld a, 7
	ld [wDexListingHeight], a
	call Pokedex_PrintListing
	call Pokedex_IncrementDexPointer
	ret

Pokedex_UpdateMainScreen:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b
	ld a, [hl]
	and A_BUTTON
	jr nz, .a
	ld a, [hl]
	and SELECT
	jr nz, .select
	ld a, [hl]
	and START
	jr nz, .start
	call Pokedex_ListingHandleDPadInput
	ret nc
	call Pokedex_UpdateCursorOAM
	xor a
	ldh [hBGMapMode], a
	call Pokedex_PrintListing
	call Pokedex_SetBGMapMode3
	call Pokedex_ResetBGMapMode
	ret

.a
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	ret z
	ld a, DEXSTATE_DEX_ENTRY_SCR
	ld [wJumptableIndex], a
	ld a, DEXSTATE_MAIN_SCR
	ld [wPrevDexEntryJumptableIndex], a
	ret

.select
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_OPTION_SCR
	ld [wJumptableIndex], a
	xor a
	ldh [hSCX], a
	ld a, $a7
	ldh [hWX], a
	call DelayFrame
	ret

.start
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_SEARCH_SCR
	ld [wJumptableIndex], a
	xor a
	ldh [hSCX], a
	ld a, $a7
	ldh [hWX], a
	call DelayFrame
	ret

.b
	ld a, DEXSTATE_EXIT
	ld [wJumptableIndex], a
	ret

Pokedex_InitDexEntryScreen:
	call LowVolume
	xor a ; page 1
	ld [wPokedexStatus], a ; moves machines index
	ld [wPokedexEntryPageNum], a
	ld [wPokedexEntryType], a
	ld [wPokedexEvoStage2], a
	ld [wPokedexEvoStage3], a
	ldh [hBGMapMode], a
	call ClearSprites
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
	ld a, SCGB_POKEDEX
	call Pokedex_GetSGBLayout
	call Pokedex_LoadCurrentFootprint
	call Pokedex_DrawDexEntryScreenBG
	call Pokedex_InitArrowCursor
	call Pokedex_GetSelectedMon
	ld [wPrevDexEntry], a
	call Pokedex_DrawFootprint
	farcall DisplayDexEntry
	call WaitBGMap
	ld a, $a7
	ldh [hWX], a
	ld a, [wCurPartySpecies]
	call PlayMonCry
	call Pokedex_IncrementDexPointer
	ret

Pokedex_UpdateDexEntryScreen:
	ld de, DexEntryScreen_ArrowCursorData
	call Pokedex_MoveArrowCursor
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .return_to_prev_screen
	vc_hook print_forbid_5
	ld a, [hl]
	and A_BUTTON
	jr nz, .do_menu_action
	ld a, [hl] ;
	and START ;
	jp nz, Area_Page_map ; .toCry ;
	ld a, [hl]
	and SELECT ;
	call nz, Pokedex_toggle_shininess_Entry
	call Pokedex_NextOrPreviousDexEntry
	ret nc
	call Pokedex_IncrementDexPointer
	ret

.do_menu_action
	ld a, [wDexArrowCursorPosIndex]
	ld hl, DexEntryScreen_MenuActionJumptable
	call Pokedex_LoadPointer
	jp hl

.return_to_prev_screen
	ld a, [wLastVolume]
	and a
	jr z, .max_volume
	ld a, MAX_VOLUME
	ld [wLastVolume], a

.max_volume
	call MaxVolume
	ld a, [wPrevDexEntryJumptableIndex]
	ld [wJumptableIndex], a
	ret

.toggle_shininess
; toggle the current shininess setting
	ld a, [wPokedexShinyToggle]
	xor 1
	ld [wPokedexShinyToggle], a
	; refresh palettes
	ld a, SCGB_POKEDEX
	call Pokedex_GetSGBLayout
	; play sound based on setting
	ld a, [wPokedexShinyToggle]
	bit 0, a
	ld de, SFX_BUMP
	jr z, .got_sound
	ld de, SFX_SHINE
.got_sound
	call PlaySFX
	jp WaitSFX

Pokedex_Page:
	call Pokedex_GetSelectedMon
	ld [wPrevDexEntry], a
	farcall DisplayDexEntry
	ret

Pokedex_toggle_shininess_Entry:
	call Pokedex_toggle_shininess1
; refresh palettes
	ld a, SCGB_POKEDEX
	call Pokedex_GetSGBLayout	
	call Pokedex_toggle_shininess2
	ret

Pokedex_toggle_shininess_Pics:
	call Pokedex_toggle_shininess1
; refresh palettes
	ld a, SCGB_POKEDEX_PICS
	call Pokedex_GetSGBLayout	
	call Pokedex_toggle_shininess2
	ret

Pokedex_toggle_shininess1:
; toggle the current shininess setting
	ld hl, wPokedexShinyToggle
	bit 0, [hl]
	jr z, .set
	; already set, so clear it
	res 0, [hl]
	ret
	; jr .update_palettes
.set ; bit is not set, so set it
	set 0, [hl]
	ret
Pokedex_toggle_shininess2:
; play sound based on setting
	ld de, SFX_BUMP
	ld a, [wPokedexShinyToggle]
	bit 0, a
	jr z, .got_sound
	ld de, SFX_SHINE
.got_sound
	call PlaySFX
	call WaitSFX
	ret

Pokedex_ReinitDexEntryScreen:
; Reinitialize the Pokédex entry screen after changing the selected mon.
	call Pokedex_BlackOutBG
	; xor a
	; ldh [hBGMapMode], a
	call Pokedex_DrawDexEntryScreenBG
	call Pokedex_LoadCurrentFootprint
	call Pokedex_GetSelectedMon
	ld [wPrevDexEntry], a
.skip
	ld a, [wPokedexEntryType]
	cp DEXENTRY_PICS
	jr c, .pics
	; find first area entry or none?
	xor a
	ld [wPokedexEntryPageNum], a
	ld a, DEXENTRY_PICS
	ld [wPokedexEntryType], a
	call Area_Page
	jr .cont
.pics
	ld a, [wPokedexEntryType]
	cp DEXENTRY_PICS
	jr nz, .evo
	xor a
	ld [wPokedexEntryPageNum], a
	call Pics_Page
	jr .cont	
.evo
	ld a, [wPokedexEntryType]
	cp DEXENTRY_EVO
	jr nz, .lore
.evo2
	xor a
	ld [wPokedexEntryPageNum], a
	call Evos_Page
	jr .cont

.lore
	cp DEXENTRY_LORE
	jr nz, .basestats_check
	xor a
	ld [wPokedexEntryPageNum], a
	farcall DisplayDexEntry
	jr .cont
.basestats_check
	; so we can preserve the place for easy swithing when comparing base stats
	; since each mon will have the same number and layout of base stats
	ld a, [wPokedexEntryType]
	cp DEXENTRY_BASESTATS
	jr nz, .moves
	
	; dec page, since it's auto inc'd after printing
	ld a, [wPokedexEntryPageNum]
	dec a
	ld b, a
	ld a, $3 ; currently max supported possible pages (we have tiles for up to 9 tho)
	; by dec'ing the current page num, we could now have -1 (255)
	cp b
	jr nc, .basestats
	; so if carry flag set, we know we had been on page 4, and after printing it became 4
	ld b, $3 ; page index for page 4, our max page
.basestats
	ld a, b
	ld [wPokedexEntryPageNum], a
	farcall DisplayDexMonStats
	jr .cont

; if not lore or base stats, it's moves
.moves
	; for moves, we can have different numbers of pages.
	; but we can at least keep them on the first move page of the category they were in
	; roll back category if page is 0
	; since it auto inc's category and xors page num after printing last page of move category
	ld a, [wPokedexEntryPageNum]
	and a
	jr nz, .moves_done
; .rollbackcategory
	ld a, [wPokedexEntryType]
	dec a ; make sure the order of the consts is right!!!
	ld [wPokedexEntryType], a
	cp DEXENTRY_BASESTATS
	jr nz, .moves_done
	; if a is now DEXENTRY_BASESTATS, we know we were in LVLUP moves category
	; meaning, the last actuall printed category was for the last const, DEXENTRY_MTS 
	ld a, DEXENTRY_MTS
	ld [wPokedexEntryType], a
.moves_done
	xor a
	ld [wPokedexEntryPageNum], a
	ld [wPokedexStatus], a ; moves machines index
	farcall DisplayDexMonMoves
.cont	
	call Pokedex_DrawFootprint
	call Pokedex_LoadSelectedMonTiles
	call WaitBGMap
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
	ld a, SCGB_POKEDEX
	call Pokedex_GetSGBLayout
	ld a, [wCurPartySpecies]
	call PlayMonCry
	ld hl, wJumptableIndex
	dec [hl]
	ld a, [wLastDexMode]
	cp -2
	jp z, Pokedex_Handle_Reinit_Evo
	ret

Pokedex_Handle_Reinit_Evo:
	ld a, [wCurDexMode]
	ld [wLastDexMode], a
	jp Pokedex_IncrementDexPointer
	ret

DexEntryScreen_ArrowCursorData:
	db D_RIGHT | D_LEFT, 6
	dwcoord 1, 17  ; INFO
	dwcoord 4, 17  ; STAT
	dwcoord 7, 17  ; MOVES
	dwcoord 11, 17 ; AREA
	dwcoord 14, 17 ; EVO
	dwcoord 17, 17 ; PICS

DexEntryScreen_MenuActionJumptable:
	dw Pokedex_Page
	dw BaseStat_Page
	dw Moves_Page
	dw Area_Page
	dw Evos_Page
	dw Pics_Page ; .SpriteAnim

BaseStat_Page:
	call Pokedex_GetSelectedMon
	farcall DisplayDexMonStats
	ret

Moves_Page:
	call Pokedex_GetSelectedMon
	farcall DisplayDexMonMoves
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wTempSpecies], a
	ld [wTempMonSpecies], a
	ret

Area_Page:
	ld a, [wPrevDexEntryJumptableIndex] ; same ram as wStatsScreenFlags
	push af
	call Pokedex_GetSelectedMon
	xor a
	ldh [hBGMapMode], a
	farcall Pokedex_DetailedArea
	call WaitBGMap
	pop af
	ld [wPrevDexEntryJumptableIndex], a ; same ram as wStatsScreenFlags
	ret

Area_Page_map:
	ld a, [wPrevDexEntryJumptableIndex] ; same ram as wStatsScreenFlags
	push af
	call LoadTilemapToTempTilemap
	call Pokedex_BlackOutBG
	xor a
	ldh [hSCX], a
	call DelayFrame
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	call Pokedex_GetSelectedMon
	ld a, [wDexCurLocation]
	ld e, a
	predef Pokedex_GetArea
	call Pokedex_BlackOutBG
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ld a, $90
	ldh [hWY], a
	ld a, POKEDEX_SCX
	ldh [hSCX], a
	call DelayFrame
	call Pokedex_RedisplayDexEntry
	call Pokedex_LoadSelectedMonTiles
	call WaitBGMap
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
	ld a, SCGB_POKEDEX
	call Pokedex_GetSGBLayout
	pop af
	ld [wPrevDexEntryJumptableIndex], a ; same ram as wStatsScreenFlags
	ret

Evos_Page:
	ld a, [wPrevDexEntryJumptableIndex] ; same ram as wStatsScreenFlags
	ld b, a
	ld a, [wPokedexEntryType]
	ld c, a
	ld a, [wPokedexEntryPageNum]
	ld d, a
	push bc
	push de

	xor a
	ld [wStatsScreenFlags], a
	ld a, [wLastDexMode]
	cp -1
	jr z, .handle_recursed
	cp -2
	jr z, .skip
	ld a, [wCurDexMode]
	ld [wLastDexMode], a
	jr .skip
.handle_recursed
	ld a, -2
	ld [wLastDexMode], a
.skip
	call LoadTilemapToTempTilemap
	call Pokedex_BlackOutBG
	; hlcoord 0, 0
	; lb bc, SCREEN_HEIGHT, SCREEN_WIDTH
	; call ClearBox
	xor a
	ldh [hBGMapMode], a
	ld [wCurDamage], a
	ld [wCurDamage + 1], a
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT, SCREEN_WIDTH
	call ClearBox
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	farcall HDMATransferTilemapToWRAMBank3
	; xor a
	; ldh [hSCX], a
	; call DelayFrame
	; ld a, $7
	; ldh [hWX], a
	; ld a, $90
	; ldh [hWY], a
	
	ld a, $1
	ldh [rVBK], a
	ld de, Pokedex_ExtraTiles ; tile 19
	ld hl, vTiles2 tile $62 ; $76
	lb bc, BANK(Pokedex_ExtraTiles), 30 ; 10
	call Request2bpp
; replace icon borders for evo page
	ld de, Pokedex_ExtraTiles tile 32
	ld hl, vTiles2 tile $77
	lb bc, BANK(Pokedex_ExtraTiles), 4
	call Request2bpp
	ld de, Pokedex_ExtraTiles tile 36
	ld hl, vTiles2 tile $7d
	lb bc, BANK(Pokedex_ExtraTiles), 2
	call Request2bpp

	call Pokedex_LoadInversedFont
	ld a, $0
	ldh [rVBK], a
	call DelayFrame
	
	ld a, SCGB_POKEDEX_EVO
	call Pokedex_GetSGBLayout
.nextpage_jump
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
	push af
	farcall DisplayDexMonEvos
	call WaitBGMap
	pop af
	ld [wCurPartySpecies], a 
	ld [wTempSpecies], a
	ld [wCurSpecies], a
	ld [wTempMonSpecies], a
	ld a, DEXENTRY_EVO
	ld [wPokedexEntryType], a
.evopage_loop
	callfar PlaySpriteAnimations
	call JoyTextDelay
	ld hl, hJoyPressed
	ld a, [hl]
	bit B_BUTTON_F, a
	jr nz, .evo_exit
	ld a, [wStatsScreenFlags] ; page/continue evo line flag
	and a
	jr z, .no_second_page
	ld hl, hJoyPressed
	ld a, [hl]
	bit A_BUTTON_F, a
	jp nz, .right_dpad
	ld hl, hJoyLast
	ld a, [hl]
	and D_RIGHT
	jp nz, .right_dpad
	ld a, [hl]
.no_second_page
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .up_or_down_pressed
	ld a, [hl]
	and D_DOWN
	jr nz, .up_or_down_pressed
	call DelayFrame
	jr .evopage_loop
.up_or_down_pressed
	ld a, -1
	ld [wLastDexMode], a
	call Pokedex_NextOrPreviousDexEntry
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
.evo_exit
	call Pokedex_BlackOutBG
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call Pokedex_LoadCurrentFootprint
	call Pokedex_DrawFootprint
	call Pokedex_LoadPageNums
	ld a, $90
	ldh [hWY], a
	ld a, POKEDEX_SCX
	ldh [hSCX], a
	farcall DrawDexEntryScreenRightEdge
	call DelayFrame
	call Pokedex_RedisplayDexEntry
	call Pokedex_LoadSelectedMonTiles
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
	ld a, SCGB_POKEDEX
	call Pokedex_GetSGBLayout
	pop de
	pop bc
	ld a, b
	ld [wPrevDexEntryJumptableIndex], a ; same ram as wStatsScreenFlags
	ld a, c
	ld [wPokedexEntryType], a
	ld a, d
	ld [wPokedexEntryPageNum], a
	ld a, [wLastDexMode]
	cp -1
	call z, Evos_Page
	cp -2
	jp z, Pokedex_ReinitDexEntryScreen
	call WaitBGMap
	ret
.right_dpad
	ld a, [wCurDamage + 1]
	cp -1
	jp nz, .inc_evopage; .nextpage_jump
	xor a
	ld [wCurDamage], a
	jp .nextpage_jump
.inc_evopage
	ld a, [wCurDamage]
	inc a
	ld [wCurDamage], a
	jp .nextpage_jump

; SpriteAnim:
Pics_Page:
	ld a, [wPrevDexEntryJumptableIndex] ; same ram as wStatsScreenFlags
	ld b, a
	ld a, [wPokedexEntryType]
	ld c, a
	ld a, [wPokedexEntryPageNum]
	ld d, a
	push bc
	push de
	ld a, [wLastDexMode]
	cp -1
	jr z, .handle_recursed
	cp -2
	jr z, .skip
	ld a, [wCurDexMode]
	ld [wLastDexMode], a
	jr .skip
.handle_recursed
	ld a, -2
	ld [wLastDexMode], a
.skip
	call LoadTilemapToTempTilemap
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT, SCREEN_WIDTH
	call ClearBox	
	call Pokedex_BlackOutBG
	farcall HDMATransferTilemapToWRAMBank3	
	call ClearSprites
	call DisableSpriteUpdates
	callfar ClearSpriteAnims2
	xor a
	ldh [hBGMapMode], a
	ldh [hSCX], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a

	ld a, $1
	ldh [rVBK], a
	ld de, Pokedex_ExtraTiles tile 21
	ld hl, vTiles2 tile $77
	lb bc, BANK(Pokedex_ExtraTiles), 9
	call Request2bpp
	ld a, $0
	ldh [rVBK], a

	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wTempSpecies], a
	ld [wTempMonSpecies], a
	call GetBaseData
	ld a, SCGB_POKEDEX_PICS
	call Pokedex_GetSGBLayout
	call Pokedex_GetSelectedMon

	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT, SCREEN_WIDTH
	call ClearBox	

	hlcoord 1, 9
	call GetPokemonName
	call PlaceString	
	farcall Pokedex_PlaceBackPic
	xor a
	ld [wStatsScreenFlags], a
	farcall Pokedex_PlaceAnimatedFrontpic
	farcall Dex_Pics_DrawBorder	
	call WaitBGMap
	farcall Pokedex_place_Mon_Icon
	callfar PlaySpriteAnimations
	farcall Pokedex_PlayMonCry_AnimateFrontpic
.spritepage_loop
	callfar PlaySpriteAnimations
	call JoyTextDelay
	ld hl, hJoyPressed
	ld a, [hl]
	and SELECT ;
	jp nz, .toggle_shininess
	ld a, [hl]
	bit B_BUTTON_F, a
	jr nz, .sprite_b
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .up_or_down_pressed
	ld a, [hl]
	and D_DOWN
	jr nz, .up_or_down_pressed
	call DelayFrame
	jr .spritepage_loop
.up_or_down_pressed
	ld a, -1
	ld [wLastDexMode], a
	call Pokedex_NextOrPreviousDexEntry
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
	pop de
	pop bc
	ld a, b
	ld [wPrevDexEntryJumptableIndex], a ; same ram as wStatsScreenFlags
	ld a, c
	ld [wPokedexEntryType], a
	ld a, d
	ld [wPokedexEntryPageNum], a
	jp Pics_Page
.sprite_b
	call Pokedex_BlackOutBG
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call Pokedex_LoadCurrentFootprint
	call Pokedex_DrawFootprint
	call Pokedex_LoadPageNums
	ld a, $90
	ldh [hWY], a
	ld a, POKEDEX_SCX
	ldh [hSCX], a
	farcall DrawDexEntryScreenRightEdge
	call DelayFrame
	call Pokedex_RedisplayDexEntry
	call Pokedex_LoadSelectedMonTiles
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
	ld a, SCGB_POKEDEX
	call Pokedex_GetSGBLayout
	pop de
	pop bc
	ld a, b
	ld [wPrevDexEntryJumptableIndex], a ; same ram as wStatsScreenFlags
	ld a, c
	ld [wPokedexEntryType], a
	ld a, d
	ld [wPokedexEntryPageNum], a
	ld a, [wLastDexMode]
	cp -2
	jp z, Pokedex_ReinitDexEntryScreen
	call WaitBGMap
	ret
.toggle_shininess:
	xor a
	ldh [hBGMapMode], a
	call Pokedex_toggle_shininess_Pics
	xor a
	ldh [hObjectStructIndex], a
	farcall SetDexMonIconColor_SpritePage
	call WaitBGMap
	jp .spritepage_loop

Pokedex_RedisplayDexEntry:
	call Pokedex_DrawDexEntryScreenBG
	call Pokedex_GetSelectedMon
	call SafeLoadTempTilemapToTilemap
	call Pokedex_DrawFootprint
	ret

Pokedex_InitOptionScreen:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call Pokedex_DrawOptionScreenBG
	call Pokedex_InitArrowCursor
	ld [wDexArrowCursorPosIndex], a
	call Pokedex_DisplayModeDescription
	call WaitBGMap
	ld a, SCGB_POKEDEX_SEARCH_OPTION
	call Pokedex_GetSGBLayout
	call Pokedex_IncrementDexPointer
	ret

Pokedex_UpdateOptionScreen:
	ld a, [wUnlockedUnownMode]
	and a
	jr nz, .okay
	ld de, .NoUnownModeArrowCursorData
	jr .okay2
.okay
	ld de, .ArrowCursorData
.okay2
	call Pokedex_MoveArrowCursor
	call c, Pokedex_DisplayModeDescription
	ld hl, hJoyPressed
	ld a, [hl]
	and SELECT | B_BUTTON
	jr nz, .return_to_main_screen
	ld a, [hl]
	and A_BUTTON
	jr nz, .do_menu_action
	ret

.do_menu_action
	ld a, [wDexArrowCursorPosIndex]
	ld hl, .MenuActionJumptable
	call Pokedex_LoadPointer
	jp hl

.return_to_main_screen
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

.NoUnownModeArrowCursorData:
	db D_UP | D_DOWN, 5
	dwcoord 2,  3 ; NAYRU'S DEX INFO PAGE
	dwcoord 2,  4 ; NEW
	dwcoord 2,  5 ; OLD
	dwcoord 2,  6 ; ABC
	dwcoord 2,  7 ; COLOR
	

.ArrowCursorData:
	db D_UP | D_DOWN, 6
	dwcoord 2,  3 ; NAYRU'S DEX INFO PAGE
	dwcoord 2,  4 ; NEW
	dwcoord 2,  5 ; OLD
	dwcoord 2,  6 ; ABC
	dwcoord 2,  7 ; COLOR
	dwcoord 2,  8 ; UNOWN

.MenuActionJumptable:
	dw .MenuAction_NayDexInfoPage
	dw .MenuAction_NewMode
	dw .MenuAction_OldMode
	dw .MenuAction_ABCMode
	dw .MenuAction_ColorOption
	dw .MenuAction_UnownMode

.MenuAction_NayDexInfoPage
	ret

.MenuAction_NewMode:
	ld b, DEXMODE_NEW
	jr .ChangeMode

.MenuAction_OldMode:
	ld b, DEXMODE_OLD
	jr .ChangeMode

.MenuAction_ABCMode:
	ld b, DEXMODE_ABC

.ChangeMode:
	ld a, [wCurDexMode]
	cp b
	jr z, .skip_changing_mode ; Skip if new mode is same as current.

	ld a, b
	ld [wCurDexMode], a
	call Pokedex_OrderMonsByMode
	call Pokedex_DisplayChangingModesMessage
	xor a
	ld [wDexListingScrollOffset], a
	ld [wDexListingCursor], a
	call Pokedex_InitCursorPosition

.skip_changing_mode
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

.MenuAction_ColorOption
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_COLOR_OPTION
	ld [wJumptableIndex], a
	ret

.MenuAction_UnownMode:
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_UNOWN_MODE
	ld [wJumptableIndex], a
	ret

Pokedex_InitSearchScreen:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call Pokedex_LoadGFX ; restoring our precious Slowpoke Sprite
	call Pokedex_DrawSearchScreenBG
	call Pokedex_InitArrowCursor
	ld a, NORMAL + 1
	ld [wDexSearchMonType1], a
	xor a
	ld [wDexSearchMonType2], a
	call Pokedex_PlaceSearchScreenTypeStrings
	xor a
	ld [wDexSearchSlowpokeFrame], a
	farcall DoDexSearchSlowpokeFrame
	call WaitBGMap
	ld a, SCGB_POKEDEX_SEARCH_OPTION
	call Pokedex_GetSGBLayout
	call Pokedex_IncrementDexPointer
	ret

Pokedex_UpdateSearchScreen:
	ld de, .ArrowCursorData
	call Pokedex_MoveArrowCursor
	call Pokedex_UpdateSearchMonType
	call c, Pokedex_PlaceSearchScreenTypeStrings
	ld hl, hJoyPressed
	ld a, [hl]
	and START | B_BUTTON
	jr nz, .cancel
	ld a, [hl]
	and A_BUTTON
	jr nz, .do_menu_action
	ret

.do_menu_action
	ld a, [wDexArrowCursorPosIndex]
	ld hl, .MenuActionJumptable
	call Pokedex_LoadPointer
	jp hl

.cancel
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

.ArrowCursorData:
	db D_UP | D_DOWN, 4
	dwcoord 2, 4  ; TYPE 1
	dwcoord 2, 6  ; TYPE 2
	dwcoord 2, 13 ; BEGIN SEARCH
	dwcoord 2, 15 ; CANCEL

.MenuActionJumptable:
	dw .MenuAction_MonSearchType
	dw .MenuAction_MonSearchType
	dw .MenuAction_BeginSearch
	dw .MenuAction_Cancel

.MenuAction_MonSearchType:
	call Pokedex_NextSearchMonType
	call Pokedex_PlaceSearchScreenTypeStrings
	ret

.MenuAction_BeginSearch:
	call Pokedex_SearchForMons
	farcall AnimateDexSearchSlowpoke
	ld a, [wDexSearchResultCount]
	and a
	jr nz, .show_search_results

; No mon with matching types was found.
	call Pokedex_OrderMonsByMode
	call Pokedex_DisplayTypeNotFoundMessage
	xor a
	ldh [hBGMapMode], a
	call Pokedex_DrawSearchScreenBG
	call Pokedex_InitArrowCursor
	call Pokedex_PlaceSearchScreenTypeStrings
	call WaitBGMap
	ret

.show_search_results
	ld [wDexListingEnd], a
	ld a, [wDexListingScrollOffset]
	ld [wDexListingScrollOffsetBackup], a
	ld a, [wDexListingCursor]
	ld [wDexListingCursorBackup], a
	ld a, [wPrevDexEntry]
	ld [wPrevDexEntryBackup], a
	xor a
	ld [wDexListingScrollOffset], a
	ld [wDexListingCursor], a
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_SEARCH_RESULTS_SCR
	ld [wJumptableIndex], a
	ret

.MenuAction_Cancel:
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

Pokedex_InitSearchResultsScreen:
	xor a
	ldh [hBGMapMode], a
	xor a
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call ByteFill
	call Pokedex_SetBGMapMode4
	call Pokedex_ResetBGMapMode
	farcall DrawPokedexSearchResultsWindow
	call Pokedex_PlaceSearchResultsTypeStrings
	ld a, 4
	ld [wDexListingHeight], a
	call Pokedex_PrintListing
	call Pokedex_SetBGMapMode3
	call Pokedex_ResetBGMapMode
	call Pokedex_DrawSearchResultsScreenBG
	ld a, POKEDEX_SCX
	ldh [hSCX], a
	ld a, $4a
	ldh [hWX], a
	xor a
	ldh [hWY], a
	call WaitBGMap
	call Pokedex_ResetBGMapMode
	farcall DrawPokedexSearchResultsWindow
	call Pokedex_PlaceSearchResultsTypeStrings
	call Pokedex_UpdateSearchResultsCursorOAM
	ld a, -1
	ld [wCurPartySpecies], a
	ld a, SCGB_POKEDEX
	call Pokedex_GetSGBLayout
	call Pokedex_IncrementDexPointer
	ret

Pokedex_UpdateSearchResultsScreen:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .return_to_search_screen
	ld a, [hl]
	and A_BUTTON
	jr nz, .go_to_dex_entry
	call Pokedex_ListingHandleDPadInput
	ret nc
	call Pokedex_UpdateSearchResultsCursorOAM
	xor a
	ldh [hBGMapMode], a
	call Pokedex_PrintListing
	call Pokedex_SetBGMapMode3
	call Pokedex_ResetBGMapMode
	ret

.go_to_dex_entry
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	ret z
	ld a, DEXSTATE_DEX_ENTRY_SCR
	ld [wJumptableIndex], a
	ld a, DEXSTATE_SEARCH_RESULTS_SCR
	ld [wPrevDexEntryJumptableIndex], a
	ret

.return_to_search_screen
	ld a, [wDexListingScrollOffsetBackup]
	ld [wDexListingScrollOffset], a
	ld a, [wDexListingCursorBackup]
	ld [wDexListingCursor], a
	ld a, [wPrevDexEntryBackup]
	ld [wPrevDexEntry], a
	call Pokedex_BlackOutBG
	call ClearSprites
	call Pokedex_OrderMonsByMode
	ld a, DEXSTATE_SEARCH_SCR
	ld [wJumptableIndex], a
	xor a
	ldh [hSCX], a
	ld a, $a7
	ldh [hWX], a
	ret

Pokedex_InitUnownMode:
	call Pokedex_LoadUnownFont
	call Pokedex_DrawUnownModeBG
	xor a
	ld [wDexCurUnownIndex], a
	call Pokedex_LoadUnownFrontpicTiles
	call Pokedex_UnownModePlaceCursor
	farcall PrintUnownWord
	call WaitBGMap
	ld a, SCGB_POKEDEX_UNOWN_MODE
	call Pokedex_GetSGBLayout
	call Pokedex_IncrementDexPointer
	ret

Pokedex_UpdateUnownMode:
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON | B_BUTTON
	jr nz, .a_b
	call Pokedex_UnownModeHandleDPadInput
	ret

.a_b
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_OPTION_SCR
	ld [wJumptableIndex], a
	call DelayFrame
	call Pokedex_CheckSGB
	jr nz, .decompress
	farcall LoadSGBPokedexGFX2
	jr .done

.decompress
	ld hl, PokedexLZ
	ld de, vTiles2 tile $31
	lb bc, BANK(PokedexLZ), 58
	call DecompressRequest2bpp

.done
	ret

Pokedex_UnownModeHandleDPadInput:
	ld hl, hJoyLast
	ld a, [hl]
	and D_RIGHT
	jr nz, .right
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	ret

.right
	ld a, [wDexUnownCount]
	ld e, a
	ld hl, wDexCurUnownIndex
	ld a, [hl]
	inc a
	cp e
	ret nc
	ld a, [hl]
	inc [hl]
	jr .update

.left
	ld hl, wDexCurUnownIndex
	ld a, [hl]
	and a
	ret z
	ld a, [hl]
	dec [hl]

.update
	push af
	xor a
	ldh [hBGMapMode], a
	pop af
	call Pokedex_UnownModeEraseCursor
	call Pokedex_LoadUnownFrontpicTiles
	call Pokedex_UnownModePlaceCursor
	farcall PrintUnownWord
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	ret

Pokedex_UnownModeEraseCursor:
	ld c, " "
	jr Pokedex_UnownModeUpdateCursorGfx

Pokedex_UnownModePlaceCursor:
	ld a, [wDexCurUnownIndex]
	ld c, FIRST_UNOWN_CHAR + NUM_UNOWN ; diamond cursor

Pokedex_UnownModeUpdateCursorGfx:
	ld e, a
	ld d, 0
	ld hl, UnownModeLetterAndCursorCoords + 2
rept 4
	add hl, de
endr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], c
	ret

Pokedex_NextOrPreviousDexEntry:
	ld a, [wDexListingCursor]
	ld [wBackupDexListingCursor], a
	ld a, [wDexListingScrollOffset]
	ld [wBackupDexListingPage], a
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .up
	ld a, [hl]
	and D_DOWN
	jr nz, .down
	and a
	ret

.up
	ld a, [wDexListingHeight]
	ld d, a
	ld a, [wDexListingEnd]
	ld e, a
	call Pokedex_ListingMoveCursorUp
	jr nc, .nope
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	jr nz, .yep
	jr .up

.down
	ld a, [wDexListingHeight]
	ld d, a
	ld a, [wDexListingEnd]
	ld e, a
	call Pokedex_ListingMoveCursorDown
	jr nc, .nope
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	jr nz, .yep
	jr .down

.yep
	scf
	ret

.nope
	ld a, [wBackupDexListingCursor]
	ld [wDexListingCursor], a
	ld a, [wBackupDexListingPage]
	ld [wDexListingScrollOffset], a
	and a
	ret

Pokedex_ListingHandleDPadInput:
; Handles D-pad input for a list of Pokémon.
	ld a, [wDexListingHeight]
	ld d, a
	ld a, [wDexListingEnd]
	ld e, a
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, Pokedex_ListingMoveCursorUp
	ld a, [hl]
	and D_DOWN
	jr nz, Pokedex_ListingMoveCursorDown
	ld a, d
	cp e
	jr nc, Pokedex_ListingPosStayedSame
	ld a, [hl]
	and D_LEFT
	jr nz, Pokedex_ListingMoveUpOnePage
	ld a, [hl]
	and D_RIGHT
	jr nz, Pokedex_ListingMoveDownOnePage
	jr Pokedex_ListingPosStayedSame

Pokedex_ListingMoveCursorUp:
	ld hl, wDexListingCursor
	ld a, [hl]
	and a
	jr z, .try_scrolling
	dec [hl]
	jr Pokedex_ListingPosChanged
.try_scrolling
	ld hl, wDexListingScrollOffset
	ld a, [hl]
	and a
	jr z, Pokedex_ListingPosStayedSame
	dec [hl]
	jr Pokedex_ListingPosChanged

Pokedex_ListingMoveCursorDown:
	ld hl, wDexListingCursor
	ld a, [hl]
	inc a
	cp e
	jr nc, Pokedex_ListingPosStayedSame
	cp d
	jr nc, .try_scrolling
	inc [hl]
	jr Pokedex_ListingPosChanged
.try_scrolling
	ld hl, wDexListingScrollOffset
	add [hl]
	cp e
	jr nc, Pokedex_ListingPosStayedSame
	inc [hl]
	jr Pokedex_ListingPosChanged

Pokedex_ListingMoveUpOnePage:
	ld hl, wDexListingScrollOffset
	ld a, [hl]
	and a
	jr z, Pokedex_ListingPosStayedSame
	cp d
	jr nc, .not_near_top
; If we're already less than page away from the top, go to the top.
	xor a
	ld [hl], a
	jr Pokedex_ListingPosChanged
.not_near_top
	sub d
	ld [hl], a
	jr Pokedex_ListingPosChanged

Pokedex_ListingMoveDownOnePage:
; When moving down a page, the return value always report a change in position.
	ld hl, wDexListingScrollOffset
	ld a, d
	add a
	add [hl]
	jr c, .near_bottom
	cp e
	jr c, .not_near_bottom
.near_bottom
	ld a, e
	sub d
	ld [hl], a
	jr Pokedex_ListingPosChanged
.not_near_bottom
	ld a, [hl]
	add d
	ld [hl], a
	jr Pokedex_ListingPosChanged

Pokedex_ListingPosStayedSame:
	and a
	ret

Pokedex_ListingPosChanged:
	scf
	ret

Pokedex_FillColumn:
; Fills a column starting at hl, going downwards.
; b is the height of the column, and a is the tile it's filled with.
	push de
	ld de, SCREEN_WIDTH
.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	pop de
	ret

Pokedex_DrawMainScreenBG:
; Draws the left sidebar and the bottom bar on the main screen.
	hlcoord 0, 17
	ld de, String_START_SEARCH
	call Pokedex_PlaceString
	ld a, $32
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call ByteFill
	hlcoord 0, 0
	lb bc, 7, 7
	call Pokedex_PlaceBorder
	hlcoord 0, 9
	lb bc, 6, 7
	call Pokedex_PlaceBorder
	hlcoord 1, 11
	ld de, String_SEEN
	call Pokedex_PlaceString
	ld hl, wPokedexSeen
	ld b, wEndPokedexSeen - wPokedexSeen
	call CountSetBits
	ld de, wNumSetBits
	hlcoord 5, 12
	lb bc, 1, 3
	call PrintNum
	hlcoord 1, 14
	ld de, String_OWN
	call Pokedex_PlaceString
	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	ld de, wNumSetBits
	hlcoord 5, 15
	lb bc, 1, 3
	call PrintNum
	hlcoord 1, 17
	ld de, String_SELECT_OPTION
	call Pokedex_PlaceString
	hlcoord 8, 1
	ld b, 7
	ld a, $5a
	call Pokedex_FillColumn
	hlcoord 8, 10
	ld b, 6
	ld a, $5a
	call Pokedex_FillColumn
	hlcoord 8, 0
	ld [hl], $59
	hlcoord 8, 8
	ld [hl], $53
	hlcoord 8, 9
	ld [hl], $54
	hlcoord 8, 16
	ld [hl], $5b
	call Pokedex_PlaceFrontpicTopLeftCorner
	ret

String_SEEN:
	db "SEEN", -1
String_OWN:
	db "OWN", -1
String_SELECT_OPTION:
	db $3b, $48, $49, $4a, $44, $45, $46, $47 ; SELECT > OPTION
	; fallthrough
String_START_SEARCH:
	db $3c, $3b, $41, $42, $43, $4b, $4c, $4d, $4e, $3c, -1 ; START > SEARCH

Pokedex_DrawDexEntryScreenBG:
	hlcoord 0, 0
	lb bc, 15, 18
	call Pokedex_PlaceBorder
	hlcoord 19, 0
	ld [hl], $34
	hlcoord 19, 1
	ld a, " "
	ld b, 15
	call Pokedex_FillColumn
	ld [hl], $39

	hlcoord 1, 17
	ld bc, 18
	ld a, " "
	call ByteFill

	hlcoord 2, 17
	ld bc, $7 tiles
	ld a, $7f ; black square
	call ByteFill
	ld c, 4
	call DelayFrames

	lb bc, 8, SCREEN_WIDTH - 1
	hlcoord 1, 8
	call ClearBox
	
	hlcoord 1, 8
	ld bc, 19
	ld a, $55
	call ByteFill
	ld a, [wTempSpecies]
	ld [wCurSpecies], a
	farcall DisplayDexMonType_CustomGFX
	call GetPokemonName
	hlcoord 9, 4
	call PlaceString ; mon species	

.print_dex_num
; Print dex number
	hlcoord 9, 2
	ld a, $5c ; No
	ld [hli], a
	ld a, $e8 ; .
	ld [hli], a
	ld de, wTempSpecies
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum

	hlcoord 0, 17
	ld de, .MenuItems
	call Pokedex_PlaceString
	call Pokedex_PlaceFrontpicTopLeftCorner
; Check to see if we caught it.  Get out of here if we haven't.
	ld a, [wTempSpecies]
	dec a
	call CheckCaughtMon
	ret z
	hlcoord 14, 2
	ld [hl], $4f ; pokeball icon
	ret

.MenuItems:
	db $3b, " ", $79, $7a, " ", \ ; INFO
		$71, $72, " ", \ ; STATS
		$74, $75, $76, " ", \ ; MOVES
		$77, $78, " ", \ ; AREA
		$7d, $7e, \ ; EVO
		$31, $7b, $7c, -1 ; PICS

Pokedex_LoadTextboxSpaceGFX:
	nop
	push hl
	push de
	push bc
	push af
	call DelayFrame
	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a
	ld de, TextboxSpaceGFX
	lb bc, BANK(TextboxSpaceGFX), 1
	ld hl, vTiles2 tile " "
	call Get2bpp
	pop af
	ldh [rVBK], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Pokedex_DrawOptionScreenBG:
	call Pokedex_FillBackgroundColor2
	hlcoord 0, 2
	lb bc, 8, 18
	call Pokedex_PlaceBorder
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	hlcoord 0, 1
	ld de, .Title
	call Pokedex_PlaceString
	hlcoord 3, 3
	ld de, .NayrusPokedex
	call PlaceString	
	hlcoord 3, 4
	ld de, .NewMode
	call PlaceString
	hlcoord 3, 5
	ld de, .OldMode
	call PlaceString
	hlcoord 3, 6
	ld de, .AtoZMode
	call PlaceString
	hlcoord 3, 7
	ld de, .Color
	call PlaceString
	ld a, [wUnlockedUnownMode]
	and a
	ret z
	hlcoord 3, 8
	ld de, .UnownMode
	call PlaceString
	ret

.Title:
	db $3b, " OPTION ", $3c, -1

.NayrusPokedex:
	db "#DEX INFO@"

.NewMode:
	db "NEW #DEX MODE@"

.OldMode:
	db "OLD #DEX MODE@"

.AtoZMode:
	db "A to Z MODE@"
	
.Color:
	db "#DEX COLOR@"

.UnownMode:
	db "UNOWN MODE@"

Pokedex_DrawColorScreenBG:
	call Pokedex_FillBackgroundColor2
	hlcoord 0, 2
	lb bc, 14, 18
	call Pokedex_PlaceBorder
	hlcoord 0, 1
	ld de, .Title
	call Pokedex_PlaceString
	hlcoord 3, 3
	ld de, .Red
	call Pokedex_PlaceString	
	hlcoord 3, 4
	ld de, .Blue
	call Pokedex_PlaceString
	hlcoord 3, 5
	ld de, .Purple
	call Pokedex_PlaceString
	hlcoord 3, 6
	ld de, .Brown
	call Pokedex_PlaceString
	hlcoord 3, 7
	ld de, .Green
	call Pokedex_PlaceString
	hlcoord 3, 8
	ld de, .Pink
	call Pokedex_PlaceString
	hlcoord 3, 9
	ld de, .Yellow
	call Pokedex_PlaceString
	hlcoord 3, 10
	ld de, .Cyan
	call Pokedex_PlaceString
	hlcoord 3, 11
	ld de, .Gray
	jp Pokedex_PlaceString
	; hlcoord 3, 12
	; ld de, .Mewtwo
	; jp Pokedex_PlaceString

 .Title:
	db $3b, " COLORS ", $3c, -1

 .Red
	db "RED    ", $4f, -1
	
 .Blue
	db "BLUE   ", $4f, -1

 .Purple
	db "PURPLE ", $4f, -1

 .Brown
	db "BROWN  ", $4f, -1

 .Green
	db "GREEN  ", $4f, -1	
	
 .Pink
	db "PINK   ", $4f, -1	
	
 .Yellow
	db "YELLOW ", $4f, -1	
	
 .Cyan
	db "CYAN   ", $4f, -1
	
 .Gray
	db "GRAY   ", $4f, -1	
	
;  .Mewtwo
; 	db "MEWTWO ", $4f, -1	

 Pokedex_UpdateColorOption:
	ld de, .ArrowCursorData
	call Pokedex_MoveArrowCursor
	ld hl, hJoyPressed
	ld a, [hl]
	and SELECT | B_BUTTON
	jr nz, .return_to_main_screen
	ld a, [hl]
	and A_BUTTON
	jr nz, .do_menu_action
	ret
	
 .ArrowCursorData:
	db D_UP | D_DOWN, 10
	dwcoord 2,  3  ; Red
	dwcoord 2,  4  ; Blue
	dwcoord 2,  5  ; Purple
	dwcoord 2,  6  ; Brown
	dwcoord 2,  7  ; Green
	dwcoord 2,  8  ; Pink
	dwcoord 2,  9  ; Yellow	
	dwcoord 2,  10 ; Cyan
	dwcoord 2,  11 ; Gray
	; dwcoord 2,  12 ; Mewtwo
	
 .do_menu_action
	ld a, [wDexArrowCursorPosIndex]
	ld hl, .MenuActionJumptable
	call Pokedex_LoadPointer
	jp hl
	
 .return_to_main_screen
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

 .MenuActionJumptable:
	dw .MenuAction_Red
	dw .MenuAction_Blue
	dw .MenuAction_Purple
	dw .MenuAction_Brown
	dw .MenuAction_Green
	dw .MenuAction_Pink
	dw .MenuAction_Yellow
	dw .MenuAction_Cyan
	dw .MenuAction_Gray
	; dw .MenuAction_Mewtwo
	
 .MenuAction_Red
	ld b, DEXCOLOR_RED
	jr .ChangeColor
	
 .MenuAction_Blue
	ld b, DEXCOLOR_BLUE
	jr .ChangeColor

 .MenuAction_Purple
	ld b, DEXCOLOR_PURPLE
	jr .ChangeColor
	
 .MenuAction_Brown
	ld b, DEXCOLOR_BROWN
	jr .ChangeColor

 .MenuAction_Green
	ld b, DEXCOLOR_GREEN
	jr .ChangeColor

 .MenuAction_Pink
	ld b, DEXCOLOR_PINK
	jr .ChangeColor
	
 .MenuAction_Yellow
	ld b, DEXCOLOR_YELLOW
	jr .ChangeColor
	
 .MenuAction_Cyan
	ld b, DEXCOLOR_CYAN
	jr .ChangeColor	
	
 .MenuAction_Gray
	ld b, DEXCOLOR_GRAY
	jr .ChangeColor
	
 .ChangeColor:
	ld a, [wCurPokedexColor]
	cp b
	jr z, .skip_changing_color

	ld a, b
	ld [wCurPokedexColor], a
	
 .skip_changing_color
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_COLOR_OPTION
	ld [wJumptableIndex], a
	ret

Pokedex_DrawSearchScreenBG:
	call Pokedex_FillBackgroundColor2
	hlcoord 0, 2
	lb bc, 14, 18
	call Pokedex_PlaceBorder
	hlcoord 0, 1
	ld de, .Title
	call Pokedex_PlaceString
	hlcoord 8, 4
	ld de, .TypeLeftRightArrows
	call Pokedex_PlaceString
	hlcoord 8, 6
	ld de, .TypeLeftRightArrows
	call Pokedex_PlaceString
	hlcoord 3, 4
	ld de, .Types
	call PlaceString
	hlcoord 3, 13
	ld de, .Menu
	call PlaceString
	ret

.Title:
	db $3b, " SEARCH ", $3c, -1

.TypeLeftRightArrows:
	db $3d, "        ", $3e, -1

.Types:
	db   "TYPE1"
	next "TYPE2"
	db   "@"

.Menu:
	db   "BEGIN SEARCH!!"
	next "CANCEL"
	db   "@"

Pokedex_DrawSearchResultsScreenBG:
	call Pokedex_FillBackgroundColor2
	hlcoord 0, 0
	lb bc, 7, 7
	call Pokedex_PlaceBorder
	hlcoord 0, 11
	lb bc, 5, 18
	call Pokedex_PlaceBorder
	hlcoord 1, 12
	ld de, .BottomWindowText
	call PlaceString
	ld de, wDexSearchResultCount
	hlcoord 1, 16
	lb bc, 1, 3
	call PrintNum
	hlcoord 8, 0
	ld [hl], $59
	hlcoord 8, 1
	ld b, 7
	ld a, $5a
	call Pokedex_FillColumn
	hlcoord 8, 8
	ld [hl], $53
	hlcoord 8, 9
	ld [hl], $69
	hlcoord 8, 10
	ld [hl], $6a
	call Pokedex_PlaceFrontpicTopLeftCorner
	ret

.BottomWindowText:
	db   "SEARCH RESULTS"
	next "  TYPE"
	next "    FOUND!"
	db   "@"

Pokedex_PlaceSearchResultsTypeStrings:
	ld a, [wDexSearchMonType1]
	hlcoord 0, 14
	call Pokedex_PlaceTypeString
	ld a, [wDexSearchMonType1]
	ld b, a
	ld a, [wDexSearchMonType2]
	and a
	jr z, .done
	cp b
	jr z, .done
	hlcoord 2, 15
	call Pokedex_PlaceTypeString
	hlcoord 1, 15
	ld [hl], "/"
.done
	ret

Pokedex_DrawUnownModeBG:
	call Pokedex_FillBackgroundColor2
	hlcoord 2, 1
	lb bc, 10, 13
	call Pokedex_PlaceBorder
	hlcoord 2, 14
	lb bc, 1, 13
	call Pokedex_PlaceBorder
	hlcoord 2, 15
	ld [hl], $3d
	hlcoord 16, 15
	ld [hl], $3e
	hlcoord 6, 5
	call Pokedex_PlaceFrontpicAtHL
	ld de, 0
	ld b, 0
	ld c, NUM_UNOWN
.loop
	ld hl, wUnownDex
	add hl, de
	ld a, [hl]
	and a
	jr z, .done
	push af
	ld hl, UnownModeLetterAndCursorCoords
rept 4
	add hl, de
endr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	add FIRST_UNOWN_CHAR - 1 ; Unown A
	ld [hl], a
	inc de
	inc b
	dec c
	jr nz, .loop
.done
	ld a, b
	ld [wDexUnownCount], a
	ret

UnownModeLetterAndCursorCoords:
; entries correspond to Unown forms
;           letter, cursor
	dwcoord   4,11,   3,11 ; A
	dwcoord   4,10,   3,10 ; B
	dwcoord   4, 9,   3, 9 ; C
	dwcoord   4, 8,   3, 8 ; D
	dwcoord   4, 7,   3, 7 ; E
	dwcoord   4, 6,   3, 6 ; F
	dwcoord   4, 5,   3, 5 ; G
	dwcoord   4, 4,   3, 4 ; H
	dwcoord   4, 3,   3, 2 ; I
	dwcoord   5, 3,   5, 2 ; J
	dwcoord   6, 3,   6, 2 ; K
	dwcoord   7, 3,   7, 2 ; L
	dwcoord   8, 3,   8, 2 ; M
	dwcoord   9, 3,   9, 2 ; N
	dwcoord  10, 3,  10, 2 ; O
	dwcoord  11, 3,  11, 2 ; P
	dwcoord  12, 3,  12, 2 ; Q
	dwcoord  13, 3,  13, 2 ; R
	dwcoord  14, 3,  15, 2 ; S
	dwcoord  14, 4,  15, 4 ; T
	dwcoord  14, 5,  15, 5 ; U
	dwcoord  14, 6,  15, 6 ; V
	dwcoord  14, 7,  15, 7 ; W
	dwcoord  14, 8,  15, 8 ; X
	dwcoord  14, 9,  15, 9 ; Y
	dwcoord  14,10,  15,10 ; Z

Pokedex_FillBackgroundColor2:
	hlcoord 0, 0
	ld a, $32
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call ByteFill
	ret

Pokedex_PlaceFrontpicTopLeftCorner:
	hlcoord 1, 1
Pokedex_PlaceFrontpicAtHL:
	xor a
	ld b, $7
.row
	ld c, $7
	push af
	push hl
.col
	ld [hli], a
	add $7
	dec c
	jr nz, .col
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop af
	inc a
	dec b
	jr nz, .row
	ret

Pokedex_PlaceString:
.loop
	ld a, [de]
	cp -1
	ret z
	inc de
	ld [hli], a
	jr .loop

Pokedex_PlaceBorder:
	push hl
	ld a, $33
	ld [hli], a
	ld d, $34
	call .FillRow
	ld a, $35
	ld [hl], a
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
.loop
	push hl
	ld a, $36
	ld [hli], a
	ld d, $7f
	call .FillRow
	ld a, $37
	ld [hl], a
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .loop
	ld a, $38
	ld [hli], a
	ld d, $39
	call .FillRow
	ld a, $3a
	ld [hl], a
	ret

.FillRow:
	ld e, c
.row_loop
	ld a, e
	and a
	ret z
	ld a, d
	ld [hli], a
	dec e
	jr .row_loop

Pokedex_PrintListing:
; Prints the list of Pokémon on the main Pokédex screen.

; ; This check is completely useless.
; 	ld a, [wCurDexMode]
; 	cp DEXMODE_OLD
; 	jr z, .okay
; 	ld c, 11
; 	jr .resume
; .okay
; 	ld c, 11
; ; End useless check

; .resume
	ld c, 11
; Clear (2 * [wDexListingHeight] + 1) by 11 box starting at 0,1
	hlcoord 0, 1
	ld a, [wDexListingHeight]
	add a
	inc a
	ld b, a
	ld a, " "
	call Pokedex_FillBox

; Load de with wPokedexOrder + [wDexListingScrollOffset]
	ld a, [wDexListingScrollOffset]
	ld e, a
	ld d, 0
	ld hl, wPokedexOrder
	add hl, de
	ld e, l
	ld d, h
	hlcoord 0, 2
	ld a, [wDexListingHeight]
.loop
	push af
	ld a, [de]
	ld [wTempSpecies], a ; also sets wNamedObjectIndex
	assert wTempSpecies == wNamedObjectIndex
	push de
	push hl
	call .PrintEntry
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop de
	inc de
	pop af
	dec a
	jr nz, .loop
	call Pokedex_LoadSelectedMonTiles
	ret

.PrintEntry:
; Prints one entry in the list of Pokémon on the main Pokédex screen.
	and a
	ret z
	call Pokedex_PrintNumberIfOldMode
	call Pokedex_PlaceDefaultStringIfNotSeen
	ret c
	call Pokedex_PlaceCaughtSymbolIfCaught
	push hl
	call GetPokemonName
	pop hl
	call PlaceString
	ret

Pokedex_PrintNumberIfOldMode:
	ld a, [wCurDexMode]
	cp DEXMODE_OLD
	jr z, .printnum
	ret

.printnum
	push hl
	ld de, -SCREEN_WIDTH
	add hl, de
	ld de, wTempSpecies
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	pop hl
	ret

Pokedex_PlaceCaughtSymbolIfCaught:
	call Pokedex_CheckCaught
	jr nz, .place_caught_symbol
	inc hl
	ret

.place_caught_symbol
	ld a, $4f
	ld [hli], a
	ret

Pokedex_PlaceDefaultStringIfNotSeen:
	call Pokedex_CheckSeen
	ret nz
	inc hl
	ld de, .NameNotSeen
	call PlaceString
	scf
	ret

.NameNotSeen:
	db "-----@"

Pokedex_DrawFootprint:
	hlcoord 18, 1
	ld a, $6d ; $62
	ld [hli], a
	inc a
	ld [hl], a
	hlcoord 18, 2
	ld a, $6f ; $64
	ld [hli], a
	inc a
	ld [hl], a
	ret

Pokedex_GetSelectedMon:
; Gets the species of the currently selected Pokémon. This corresponds to the
; position of the cursor in the main listing, but this function can be used
; on all Pokédex screens.
	ld a, [wDexListingCursor]
	ld hl, wDexListingScrollOffset
	add [hl]
	ld e, a
	ld d, 0
	ld hl, wPokedexOrder
	add hl, de
	ld a, [hl]
	ld [wTempSpecies], a
	ret

Pokedex_CheckCaught:
	push de
	push hl
	ld a, [wTempSpecies]
	dec a
	call CheckCaughtMon
	pop hl
	pop de
	ret

Pokedex_CheckSeen:
	push de
	push hl
	ld a, [wTempSpecies]
	dec a
	call CheckSeenMon
	pop hl
	pop de
	ret

Pokedex_OrderMonsByMode:
	ld hl, wPokedexOrder
	ld bc, wPokedexOrderEnd - wPokedexOrder
	xor a
	call ByteFill
	ld a, [wCurDexMode]
	ld hl, .Jumptable
	call Pokedex_LoadPointer
	jp hl

.Jumptable:
	dw .NewMode
	dw .OldMode
	dw Pokedex_ABCMode

.NewMode:
	ld de, NewPokedexOrder
	ld hl, wPokedexOrder
	ld c, NUM_POKEMON
.loopnew
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loopnew
	call .FindLastSeen
	ret

.OldMode:
	ld hl, wPokedexOrder
	ld a, $1
	ld c, NUM_POKEMON
.loopold
	ld [hli], a
	inc a
	dec c
	jr nz, .loopold
	call .FindLastSeen
	ret

.FindLastSeen:
	ld hl, wPokedexOrder + NUM_POKEMON - 1
	ld d, NUM_POKEMON
	ld e, d
.loopfindend
	ld a, [hld]
	ld [wTempSpecies], a
	call Pokedex_CheckSeen
	jr nz, .foundend
	dec d
	dec e
	jr nz, .loopfindend
.foundend
	ld a, d
	ld [wDexListingEnd], a
	ret

Pokedex_ABCMode:
	xor a
	ld [wDexListingEnd], a
	ld hl, wPokedexOrder
	ld de, AlphabeticalPokedexOrder
	ld c, NUM_POKEMON
.loop1abc
	push bc
	ld a, [de]
	ld [wTempSpecies], a
	call Pokedex_CheckSeen
	jr z, .skipabc
	ld a, [wTempSpecies]
	ld [hli], a
	ld a, [wDexListingEnd]
	inc a
	ld [wDexListingEnd], a

.skipabc
	inc de
	pop bc
	dec c
	jr nz, .loop1abc
	ld a, [wDexListingEnd]
	ld c, 0
.loop2abc
	cp NUM_POKEMON
	jr z, .doneabc
	ld [hl], c
	inc hl
	inc a
	jr .loop2abc

.doneabc
	ret

INCLUDE "data/pokemon/dex_order_alpha.asm"

INCLUDE "data/pokemon/dex_order_new.asm"

Pokedex_DisplayModeDescription:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	ld a, [wDexArrowCursorPosIndex]
	ld hl, .Modes
	call Pokedex_LoadPointer
	ld e, l
	ld d, h
	hlcoord 1, 14
	call Pokedex_PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ret

.Modes:
	dw .NayDexInfo
	dw .NewMode
	dw .OldMode
	dw .ABCMode
	dw .Color
	dw .UnownMode

.NayDexInfo:	
	db   $41, $42, $43, $56, " FULL AREA MAP", $37, $36, \
		 "                  ", $37, $36, \
		 $48, $49, $4a, $56, " TOGGLE SHINY", -1	

.NewMode:
	db   "<PK><MN> are listed by  ", $37, $36, \
		 "                  ", $37, $36, \
		 "evolution type.", -1

.OldMode:
	db   "<PK><MN> are listed by  ", $37, $36, \
		 "                  ", $37, $36, \
		 "official type.", -1

.ABCMode:
	db   "<PK><MN> are listed     ", $37, $36, \
		 "                  ", $37, $36, \
		 "alphabetically.", -1

.Color
	db   "Change the color  ", $37, $36, \
		 "                  ", $37, $36, \
		 "of the border.", -1

.UnownMode:
	db   "UNOWN are listed  ", $37, $36, \
		 "                  ", $37, $36, \
		 "in catching order.", -1

Pokedex_DisplayChangingModesMessage:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	ld de, String_ChangingModesPleaseWait
	hlcoord 1, 14
	call PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ld c, 64
	call DelayFrames
	ld de, SFX_CHANGE_DEX_MODE
	call PlaySFX
	ld c, 64
	call DelayFrames
	ret

String_ChangingModesPleaseWait:
	db   "Changing modes."
	next "Please wait.@"

Pokedex_UpdateSearchMonType:
	ld a, [wDexArrowCursorPosIndex]
	cp 2
	jr nc, .no_change
	ld hl, hJoyLast
	ld a, [hl]
	and D_LEFT
	jr nz, Pokedex_PrevSearchMonType
	ld a, [hl]
	and D_RIGHT
	jr nz, Pokedex_NextSearchMonType
.no_change
	and a
	ret

Pokedex_PrevSearchMonType:
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr nz, .type2

	ld hl, wDexSearchMonType1
	ld a, [hl]
	cp 1
	jr z, .wrap_around
	dec [hl]
	jr .done

.type2
	ld hl, wDexSearchMonType2
	ld a, [hl]
	and a
	jr z, .wrap_around
	dec [hl]
	jr .done

.wrap_around
	ld [hl], NUM_TYPES

.done
	scf
	ret

Pokedex_NextSearchMonType:
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr nz, .type2

	ld hl, wDexSearchMonType1
	ld a, [hl]
	cp NUM_TYPES
	jr nc, .type1_wrap_around
	inc [hl]
	jr .done
.type1_wrap_around
	ld [hl], 1
	jr .done

.type2
	ld hl, wDexSearchMonType2
	ld a, [hl]
	cp NUM_TYPES
	jr nc, .type2_wrap_around
	inc [hl]
	jr .done
.type2_wrap_around
	ld [hl], 0

.done
	scf
	ret

Pokedex_PlaceSearchScreenTypeStrings:
	xor a
	ldh [hBGMapMode], a
	hlcoord 9, 3
	lb bc, 4, 8
	ld a, " "
	call Pokedex_FillBox
	ld a, [wDexSearchMonType1]
	hlcoord 9, 4
	call Pokedex_PlaceTypeString
	ld a, [wDexSearchMonType2]
	hlcoord 9, 6
	call Pokedex_PlaceTypeString
	ld a, $1
	ldh [hBGMapMode], a
	ret

Pokedex_PlaceTypeString:
	push hl
	ld e, a
	ld d, 0
	ld hl, PokedexTypeSearchStrings
rept POKEDEX_TYPE_STRING_LENGTH
	add hl, de
endr
	ld e, l
	ld d, h
	pop hl
	call PlaceString
	ret

INCLUDE "data/types/search_strings.asm"

Pokedex_SearchForMons:
	ld a, [wDexSearchMonType2]
	and a
	call nz, .Search
	ld a, [wDexSearchMonType1]
	and a
	call nz, .Search
	ret

.Search:
	dec a
	ld e, a
	ld d, 0
	ld hl, PokedexTypeSearchConversionTable
	add hl, de
	ld a, [hl]
	ld [wDexConvertedMonType], a
	ld hl, wPokedexOrder
	ld de, wPokedexOrder
	ld c, NUM_POKEMON
	xor a
	ld [wDexSearchResultCount], a
.loop
	push bc
	ld a, [hl]
	and a
	jr z, .next_mon
	ld [wTempSpecies], a
	ld [wCurSpecies], a
	call Pokedex_CheckCaught
	jr z, .next_mon
	push hl
	push de
	call GetBaseData
	pop de
	pop hl
	ld a, [wDexConvertedMonType]
	ld b, a
	ld a, [wBaseType1]
	cp b
	jr z, .match_found
	ld a, [wBaseType2]
	cp b
	jr nz, .next_mon

.match_found
	ld a, [wTempSpecies]
	ld [de], a
	inc de
	ld a, [wDexSearchResultCount]
	inc a
	ld [wDexSearchResultCount], a

.next_mon
	inc hl
	pop bc
	dec c
	jr nz, .loop

	ld l, e
	ld h, d
	ld a, [wDexSearchResultCount]
	ld c, 0

.zero_remaining_mons
	cp NUM_POKEMON
	jr z, .done
	ld [hl], c
	inc hl
	inc a
	jr .zero_remaining_mons

.done
	ret

INCLUDE "data/types/search_types.asm"

Pokedex_DisplayTypeNotFoundMessage:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	ld de, .TypeNotFound
	hlcoord 1, 14
	call PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ld c, $80
	call DelayFrames
	ret

.TypeNotFound:
	db   "The specified type"
	next "was not found.@"

Pokedex_UpdateCursorOAM:
	ld a, [wCurDexMode]
	cp DEXMODE_OLD
	jp z, Pokedex_PutOldModeCursorOAM
	call Pokedex_PutNewModeABCModeCursorOAM
	call Pokedex_PutScrollbarOAM
	ret

Pokedex_PutOldModeCursorOAM:
	ld hl, .CursorOAM
	ld a, [wDexListingCursor]
	or a
	jr nz, .okay
	ld hl, .CursorAtTopOAM
.okay
	call Pokedex_LoadCursorOAM
	ret

.CursorOAM:
	dbsprite  9,  3, -1,  0, $30, 7
	dbsprite  9,  2, -1,  0, $31, 7
	dbsprite 10,  2, -1,  0, $32, 7
	dbsprite 11,  2, -1,  0, $32, 7
	dbsprite 12,  2, -1,  0, $32, 7
	dbsprite 13,  2, -1,  0, $33, 7
	dbsprite 16,  2, -2,  0, $33, 7 | X_FLIP
	dbsprite 17,  2, -2,  0, $32, 7 | X_FLIP
	dbsprite 18,  2, -2,  0, $32, 7 | X_FLIP
	dbsprite 19,  2, -2,  0, $32, 7 | X_FLIP
	dbsprite 20,  2, -2,  0, $31, 7 | X_FLIP
	dbsprite 20,  3, -2,  0, $30, 7 | X_FLIP
	dbsprite  9,  4, -1,  0, $30, 7 | Y_FLIP
	dbsprite  9,  5, -1,  0, $31, 7 | Y_FLIP
	dbsprite 10,  5, -1,  0, $32, 7 | Y_FLIP
	dbsprite 11,  5, -1,  0, $32, 7 | Y_FLIP
	dbsprite 12,  5, -1,  0, $32, 7 | Y_FLIP
	dbsprite 13,  5, -1,  0, $33, 7 | Y_FLIP
	dbsprite 16,  5, -2,  0, $33, 7 | X_FLIP | Y_FLIP
	dbsprite 17,  5, -2,  0, $32, 7 | X_FLIP | Y_FLIP
	dbsprite 18,  5, -2,  0, $32, 7 | X_FLIP | Y_FLIP
	dbsprite 19,  5, -2,  0, $32, 7 | X_FLIP | Y_FLIP
	dbsprite 20,  5, -2,  0, $31, 7 | X_FLIP | Y_FLIP
	dbsprite 20,  4, -2,  0, $30, 7 | X_FLIP | Y_FLIP
	db -1

.CursorAtTopOAM:
; OAM data for when the cursor is at the top of the list. The tiles at the top
; are cut off so they don't show up outside the list area.
	dbsprite  9,  3, -1,  0, $30, 7
	dbsprite  9,  2, -1,  0, $34, 7
	dbsprite 10,  2, -1,  0, $35, 7
	dbsprite 11,  2, -1,  0, $35, 7
	dbsprite 12,  2, -1,  0, $35, 7
	dbsprite 13,  2, -1,  0, $36, 7
	dbsprite 16,  2, -2,  0, $36, 7 | X_FLIP
	dbsprite 17,  2, -2,  0, $35, 7 | X_FLIP
	dbsprite 18,  2, -2,  0, $35, 7 | X_FLIP
	dbsprite 19,  2, -2,  0, $35, 7 | X_FLIP
	dbsprite 20,  2, -2,  0, $34, 7 | X_FLIP
	dbsprite 20,  3, -2,  0, $30, 7 | X_FLIP
	dbsprite  9,  4, -1,  0, $30, 7 | Y_FLIP
	dbsprite  9,  5, -1,  0, $31, 7 | Y_FLIP
	dbsprite 10,  5, -1,  0, $32, 7 | Y_FLIP
	dbsprite 11,  5, -1,  0, $32, 7 | Y_FLIP
	dbsprite 12,  5, -1,  0, $32, 7 | Y_FLIP
	dbsprite 13,  5, -1,  0, $33, 7 | Y_FLIP
	dbsprite 16,  5, -2,  0, $33, 7 | X_FLIP | Y_FLIP
	dbsprite 17,  5, -2,  0, $32, 7 | X_FLIP | Y_FLIP
	dbsprite 18,  5, -2,  0, $32, 7 | X_FLIP | Y_FLIP
	dbsprite 19,  5, -2,  0, $32, 7 | X_FLIP | Y_FLIP
	dbsprite 20,  5, -2,  0, $31, 7 | X_FLIP | Y_FLIP
	dbsprite 20,  4, -2,  0, $30, 7 | X_FLIP | Y_FLIP
	db -1

Pokedex_PutNewModeABCModeCursorOAM:
	ld hl, .CursorOAM
	call Pokedex_LoadCursorOAM
	ret

.CursorOAM:
	dbsprite  9,  3, -1,  3, $30, 7
	dbsprite  9,  2, -1,  3, $31, 7
	dbsprite 10,  2, -1,  3, $32, 7
	dbsprite 11,  2, -1,  3, $32, 7
	dbsprite 12,  2, -1,  3, $33, 7
	dbsprite 16,  2,  0,  3, $33, 7 | X_FLIP
	dbsprite 17,  2,  0,  3, $32, 7 | X_FLIP
	dbsprite 18,  2,  0,  3, $32, 7 | X_FLIP
	dbsprite 19,  2,  0,  3, $31, 7 | X_FLIP
	dbsprite 19,  3,  0,  3, $30, 7 | X_FLIP
	dbsprite  9,  4, -1,  3, $30, 7 | Y_FLIP
	dbsprite  9,  5, -1,  3, $31, 7 | Y_FLIP
	dbsprite 10,  5, -1,  3, $32, 7 | Y_FLIP
	dbsprite 11,  5, -1,  3, $32, 7 | Y_FLIP
	dbsprite 12,  5, -1,  3, $33, 7 | Y_FLIP
	dbsprite 16,  5,  0,  3, $33, 7 | X_FLIP | Y_FLIP
	dbsprite 17,  5,  0,  3, $32, 7 | X_FLIP | Y_FLIP
	dbsprite 18,  5,  0,  3, $32, 7 | X_FLIP | Y_FLIP
	dbsprite 19,  5,  0,  3, $31, 7 | X_FLIP | Y_FLIP
	dbsprite 19,  4,  0,  3, $30, 7 | X_FLIP | Y_FLIP
	db -1

Pokedex_UpdateSearchResultsCursorOAM:
	ld a, [wCurDexMode]
	cp DEXMODE_OLD
	jp z, Pokedex_PutOldModeCursorOAM
	ld hl, .CursorOAM
	call Pokedex_LoadCursorOAM
	ret

.CursorOAM:
	dbsprite  9,  3, -1,  3, $30, 7
	dbsprite  9,  2, -1,  3, $31, 7
	dbsprite 10,  2, -1,  3, $32, 7
	dbsprite 11,  2, -1,  3, $32, 7
	dbsprite 12,  2, -1,  3, $32, 7
	dbsprite 13,  2, -1,  3, $33, 7
	dbsprite 16,  2, -2,  3, $33, 7 | X_FLIP
	dbsprite 17,  2, -2,  3, $32, 7 | X_FLIP
	dbsprite 18,  2, -2,  3, $32, 7 | X_FLIP
	dbsprite 19,  2, -2,  3, $32, 7 | X_FLIP
	dbsprite 20,  2, -2,  3, $31, 7 | X_FLIP
	dbsprite 20,  3, -2,  3, $30, 7 | X_FLIP
	dbsprite  9,  4, -1,  3, $30, 7 | Y_FLIP
	dbsprite  9,  5, -1,  3, $31, 7 | Y_FLIP
	dbsprite 10,  5, -1,  3, $32, 7 | Y_FLIP
	dbsprite 11,  5, -1,  3, $32, 7 | Y_FLIP
	dbsprite 12,  5, -1,  3, $32, 7 | Y_FLIP
	dbsprite 13,  5, -1,  3, $33, 7 | Y_FLIP
	dbsprite 16,  5, -2,  3, $33, 7 | X_FLIP | Y_FLIP
	dbsprite 17,  5, -2,  3, $32, 7 | X_FLIP | Y_FLIP
	dbsprite 18,  5, -2,  3, $32, 7 | X_FLIP | Y_FLIP
	dbsprite 19,  5, -2,  3, $32, 7 | X_FLIP | Y_FLIP
	dbsprite 20,  5, -2,  3, $31, 7 | X_FLIP | Y_FLIP
	dbsprite 20,  4, -2,  3, $30, 7 | X_FLIP | Y_FLIP
	db -1

Pokedex_LoadCursorOAM:
	ld de, wVirtualOAMSprite00
.loop
	ld a, [hl]
	cp -1
	ret z
	ld a, [wDexListingCursor]
	and $7
	swap a
	add [hl] ; y
	inc hl
	ld [de], a
	inc de
	ld a, [hli] ; x
	ld [de], a
	inc de
	ld a, [hli] ; tile id
	ld [de], a
	inc de
	ld a, [hli] ; attributes
	ld [de], a
	inc de
	jr .loop

Pokedex_PutScrollbarOAM:
; Writes the OAM data for the scrollbar in the new mode and ABC mode.
	push de
	ld a, [wDexListingEnd]
	dec a
	ld e, a
	ld a, [wDexListingCursor]
	ld hl, wDexListingScrollOffset
	add [hl]
	cp e
	jr z, .max
	ld hl, 0
	ld bc, 121 ; max y - min y
	call AddNTimes
	ld e, l
	ld d, h
	ld b, 0
	ld a, d
	or e
	jr z, .done
	ld a, [wDexListingEnd]
	ld c, a
.loop
	ld a, e
	sub c
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	jr c, .done
	inc b
	jr .loop
.max
	ld b, 121 ; max y - min y
.done
	ld a, 20 ; min y
	add b
	pop hl
	ld [hli], a
	ld a, 161 ; x
	ld [hli], a
	ld a, $3f ; $0f ; tile id
	ld [hli], a
	ld [hl], 0 ; attributes
	ret

Pokedex_InitArrowCursor:
	xor a
	ld [wDexArrowCursorPosIndex], a
	ld [wDexArrowCursorDelayCounter], a
	ld [wDexArrowCursorBlinkCounter], a
	ret

Pokedex_MoveArrowCursor:
; bc = [de] - 1
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	dec a
	ld c, a
	inc de
	call Pokedex_BlinkArrowCursor

	ld hl, hJoyPressed
	ld a, [hl]
	and D_LEFT | D_UP
	and b
	jr nz, .move_left_or_up
	ld a, [hl]
	and D_RIGHT | D_DOWN
	and b
	jr nz, .move_right_or_down
	ld a, [hl]
	and SELECT
	and b
	jr nz, .select
	call Pokedex_ArrowCursorDelay
	jr c, .no_action
	ld hl, hJoyLast
	ld a, [hl]
	and D_LEFT | D_UP
	and b
	jr nz, .move_left_or_up
	ld a, [hl]
	and D_RIGHT | D_DOWN
	and b
	jr nz, .move_right_or_down
	jr .no_action

.move_left_or_up
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr z, .no_action
	call Pokedex_GetArrowCursorPos
	ld [hl], " "
	ld hl, wDexArrowCursorPosIndex
	dec [hl]
	jr .update_cursor_pos

.move_right_or_down
	ld a, [wDexArrowCursorPosIndex]
	cp c
	jr nc, .no_action
	call Pokedex_GetArrowCursorPos
	ld [hl], " "
	ld hl, wDexArrowCursorPosIndex
	inc [hl]

.update_cursor_pos
	call Pokedex_GetArrowCursorPos
	ld [hl], "▶"
	ld a, 12
	ld [wDexArrowCursorDelayCounter], a
	xor a
	ld [wDexArrowCursorBlinkCounter], a
	scf
	ret

.no_action
	and a
	ret

.select
	call Pokedex_GetArrowCursorPos
	ld [hl], " "
	ld a, [wDexArrowCursorPosIndex]
	cp c
	jr c, .update
	ld a, -1
.update
	inc a
	ld [wDexArrowCursorPosIndex], a
	jr .update_cursor_pos

Pokedex_GetArrowCursorPos:
	ld a, [wDexArrowCursorPosIndex]
	add a
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

Pokedex_BlinkArrowCursor:
	ld hl, wDexArrowCursorBlinkCounter
	ld a, [hl]
	inc [hl]
	and $8
	jr z, .blink_on
	call Pokedex_GetArrowCursorPos
	ld [hl], " "
	ret

.blink_on
	call Pokedex_GetArrowCursorPos
	ld [hl], "▶"
	ret

Pokedex_ArrowCursorDelay:
; Updates the delay counter set when moving the arrow cursor.
; Returns whether the delay is active in carry.
	ld hl, wDexArrowCursorDelayCounter
	ld a, [hl]
	and a
	ret z

	dec [hl]
	scf
	ret

Pokedex_FillBox:
	jp FillBoxWithByte

Pokedex_BlackOutBG:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wBGPals1
	ld bc, 8 palettes
	xor a
	call ByteFill
	pop af
	ldh [rSVBK], a

Pokedex_ApplyPrintPals:
	ld a, $ff
	call DmgToCgbBGPals
	; ld a, $ff
	; call DmgToCgbObjPal0
	call DelayFrame
	ret

Pokedex_GetSGBLayout:
	ld b, a
	call GetSGBLayout

Pokedex_ApplyUsualPals:
; This applies the palettes used for most Pokédex screens.
	ld a, $e4
	call DmgToCgbBGPals
	; ld a, $e0
	; call DmgToCgbObjPal0
	ret

Pokedex_LoadPointer:
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

Pokedex_LoadSelectedMonTiles:
; Loads the tiles of the currently selected Pokémon.
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	jr z, .QuestionMark
	ld a, [wFirstUnownSeen]
	ld [wUnownLetter], a
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a
	call GetBaseData
	ld de, vTiles2
	predef GetMonFrontpic
	ret

.QuestionMark:
	ld a, BANK(sScratch)
	call OpenSRAM
	farcall LoadQuestionMarkPic
	ld hl, vTiles2
	ld de, sScratch
	ld c, 7 * 7
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp
	call CloseSRAM
	ret

Pokedex_LoadCurrentFootprint:
	call Pokedex_GetSelectedMon

Pokedex_LoadAnyFootprint:
	ld a, [wTempSpecies]
	dec a
	and %11111000
	srl a
	srl a
	srl a
	ld e, 0
	ld d, a
	ld a, [wTempSpecies]
	dec a
	and %111
	swap a ; * $10
	add a, a
	ld l, a
	ld h, 0
	add hl, de
	ld de, Footprints
	add hl, de

	ld e, l
	ld d, h
	ld hl, vTiles2 tile $6d ; $62
	lb bc, BANK(Footprints), 4
	call Request1bpp

	ret

Pokedex_LoadGFX:
	call Pokedex_LoadPageNums
	call DisableLCD
	ld hl, vTiles2
	ld bc, $31 tiles
	xor a
	call ByteFill
	call Pokedex_LoadInvertedFont
	call LoadFontsExtra
	ld hl, vTiles2 tile $60
	ld bc, $20 tiles
	call Pokedex_InvertTiles
	call Pokedex_CheckSGB
	jr nz, .LoadPokedexLZ
	farcall LoadSGBPokedexGFX
	jr .LoadPokedexSlowpokeLZ

.LoadPokedexLZ:
	ld a, BANK(PokedexLZ)
	ld hl, PokedexLZ
	ld de, vTiles2 tile $31
	call FarDecompress

.LoadPokedexSlowpokeLZ:
    ld a, BANK(PokedexSlowpokeLZ)
    ld hl, PokedexSlowpokeLZ
    ld de, vTiles0
    call FarDecompress

	ld hl, vTiles0 tile $3f
	ld de, vTiles0 tile 15
	lb bc, BANK(vTiles0), 1 ; tile
	call Get2bpp

	ld a, 6
	call SkipMusic
	call EnableLCD
	ret

Pokedex_LoadPageNums:
	; load pagenum tiles to vram1
	; lcd needs to be enabled or it will crash !!!
		ldh a, [rLCDC]
		push af ; preserve the state of lcd for after we're done
		bit rLCDC_ENABLE, a
		jr nz, .lcdalreadyon
		call EnableLCD
	
	.lcdalreadyon
		ld a, $1
		ldh [rVBK], a
		ld de, Pokedex_PageNumTiles tile 0
		ld hl, vTiles2 tile $60
		lb bc, BANK(Pokedex_ExtraTiles), 12
		call Request2bpp
	; single black tile at vram1 $7f
		ld de, Pokedex_PageNumTiles tile 12
		ld hl, vTiles2 tile $7f
		lb bc, BANK(Pokedex_ExtraTiles), 1
		call Request2bpp
	
		ld a, $0
		ldh [rVBK], a
		pop af
		ldh [rLCDC], a
		ret
	
	Pokedex_LoadInversedFont:
		ld a, 1
		ldh [rVBK], a
		ld hl, vTiles1
		lb bc, BANK(FontInversed), 128 ; $80 tiles
		ld de, FontInversed
		ld a, BANK(FontInversed)
		; call Request1bpp
		call Get1bpp;ViaHDMA
	
		ld a, $0
		ldh [rVBK], a
		ret

Pokedex_LoadInvertedFont:
	call LoadStandardFont
	ld hl, vTiles1
	ld bc, $80 tiles

Pokedex_InvertTiles:
.loop
	ld a, [hl]
	xor $ff
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

; PokedexLZ:
; INCBIN "gfx/pokedex/pokedex.2bpp.lz"

; PokedexSlowpokeLZ:
; INCBIN "gfx/pokedex/slowpoke.2bpp.lz"

Pokedex_CheckSGB:
	ldh a, [hCGB]
	or a
	ret nz
	ldh a, [hSGB]
	dec a
	ret

Pokedex_LoadUnownFont:
	ld a, BANK(sScratch)
	call OpenSRAM
	ld hl, UnownFont
	; sScratch + $188 was the address of sDecompressBuffer in pokegold
	ld de, sScratch + $188
	ld bc, 39 tiles
	ld a, BANK(UnownFont)
	call FarCopyBytes
	ld hl, sScratch + $188
	ld bc, (NUM_UNOWN + 1) tiles
	call Pokedex_InvertTiles
	ld de, sScratch + $188
	ld hl, vTiles2 tile FIRST_UNOWN_CHAR
	lb bc, BANK(Pokedex_LoadUnownFont), NUM_UNOWN + 1
	call Request2bpp
	call CloseSRAM
	ret

Pokedex_LoadUnownFrontpicTiles:
	ld a, [wUnownLetter]
	push af
	ld a, [wDexCurUnownIndex]
	ld e, a
	ld d, 0
	ld hl, wUnownDex
	add hl, de
	ld a, [hl]
	ld [wUnownLetter], a
	ld a, UNOWN
	ld [wCurPartySpecies], a
	call GetBaseData
	ld de, vTiles2 tile $00
	predef GetMonFrontpic
	pop af
	ld [wUnownLetter], a
	ret

_NewPokedexEntry:
	xor a
	ldh [hBGMapMode], a
	farcall DrawDexEntryScreenRightEdge
	call Pokedex_ResetBGMapMode
	call DisableLCD
	call LoadStandardFont
	call LoadFontsExtra
	call Pokedex_LoadGFX
	call Pokedex_LoadAnyFootprint
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a
	call Pokedex_DrawDexEntryScreenBG
	call Pokedex_DrawFootprint
	hlcoord 0, 17
	ld [hl], $3b
	inc hl
	ld bc, 19
	ld a, " "
	call ByteFill
	farcall DisplayDexEntry
	call EnableLCD
	call WaitBGMap
	call GetBaseData
	ld de, vTiles2
	predef GetMonFrontpic
	ld a, SCGB_POKEDEX
	call Pokedex_GetSGBLayout
	ld a, [wCurPartySpecies]
	call PlayMonCry
	ret

Pokedex_SetBGMapMode3:
	ld a, $3
	ldh [hBGMapMode], a
	ld c, 4
	call DelayFrames
	ret

Pokedex_SetBGMapMode4:
	ld a, $4
	ldh [hBGMapMode], a
	ld c, 4
	call DelayFrames
	ret

Pokedex_SetBGMapMode_3ifDMG_4ifCGB:
	ldh a, [hCGB]
	and a
	jr z, .DMG
	call Pokedex_SetBGMapMode4
.DMG:
	call Pokedex_SetBGMapMode3
	ret

Pokedex_ResetBGMapMode:
	xor a
	ldh [hBGMapMode], a
	ret

Pokedex_InitColorOption:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call Pokedex_DrawColorScreenBG
	call Pokedex_InitArrowCursor
	ld a, [wCurPokedexColor]
	ld [wDexArrowCursorPosIndex], a
	call WaitBGMap
	ld a, SCGB_POKEDEX_SEARCH_OPTION
	call Pokedex_GetSGBLayout
	jp Pokedex_IncrementDexPointer
