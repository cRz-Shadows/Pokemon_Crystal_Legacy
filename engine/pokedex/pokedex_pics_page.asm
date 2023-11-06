Pokedex_PlaceAnimatedFrontpic:
	ld a, [wCurSpecies]
	ld [wCurPartySpecies], a
	ld [wTempSpecies], a
	ld [wTempMonSpecies], a
	ld [wCurPartySpecies], a
	farcall Pokedex_GetSelectedMon
	call GetBaseData
	ld hl, wTempMonDVs
	predef GetUnownLetter
	ld bc, wTempSpecies
	call SetPalettes
	call .AnimateMon
	call SetPalettes
	ret

.AnimateMon:
	ld hl, wStatsScreenFlags
	set 5, [hl]
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a
	hlcoord 1, 1
	
;;; Taken from _PrepMonFrontPic
	push hl
	ld de, vTiles2
	predef GetMonFrontpic
	pop hl
	xor a
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	xor a
	ld [wBoxAlignment], a

.get_animation
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a

	farcall Pokedex_LoadTextboxSpaceGFX
	ld de, vTiles2 tile $00
	predef GetAnimatedFrontpic
	hlcoord 1, 1
	ld d, $0
	ld e, ANIM_MON_MENU
	predef LoadMonAnimation
	ld hl, wStatsScreenFlags
	set 6, [hl]
	ret

Pokedex_PlayMonCry_AnimateFrontpic:
	xor a
	ld [wPokedexEntryType], a
.loop
	call .Pokedex_WaitAnim
	call .PokedexWaitCry
	ld a, [wPokedexEntryType]
	;bit 7, a
	cp 150
	jr nz, .loop
	xor a
	ld [wPokedexEntryType], a

	call WaitBGMap
	ret

.PokedexWaitCry:
	ld a, [wPokedexEntryType]
	inc a
	ld [wPokedexEntryType], a
	callfar PlaySpriteAnimations
	ret

.Pokedex_WaitAnim:
	ld hl, wStatsScreenFlags
	bit 6, [hl]
	jr nz, .try_anim
	bit 5, [hl]
	jr nz, .finish
	call DelayFrame
	ret
.try_anim
	farcall SetUpPokeAnim
	jr nc, .finish
	ld hl, wStatsScreenFlags
	res 6, [hl]
	ret
.finish
	ld hl, wStatsScreenFlags
	res 5, [hl]
	farcall HDMATransferTilemapToWRAMBank3
	ret

Pokedex_PlaceBackPic:
	ld a, $1
	ldh [rVBK], a
	ld a, [wCurSpecies]
	ld [wCurPartySpecies], a
	ld [wTempSpecies], a
	ld [wTempMonSpecies], a
	call GetBaseData
	ld hl, wTempMonDVs
	predef GetUnownLetter
	ld de, vTiles0 tile $80
	predef GetMonBackpic
	ld a, $80
	ldh [hGraphicStartTile], a
	lb bc, 6, 6
	hlcoord 11, 2
	predef PlaceGraphic

	ld a, $0
	ldh [rVBK], a
	ret

Pokedex_place_Mon_Icon:
	push af
	push bc
	push de
	push hl
	; farcall InitPartyMenuOBPals
; white box	
	hlcoord 2, 14
	ld a, $7f
	ld [hli], a
	ld [hld], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hli], a
	ld [hld], a
; sprite box border
	hlcoord 1, 13
	ld [hl], $77
	inc hl
	ld a, $7b
	ld [hli], a
	ld [hli], a
	ld [hl], $78
	hlcoord 1, 14
	ld [hl], $7d
	hlcoord 1, 15
	ld [hl], $7d
	hlcoord 1, 16
	ld [hl], $79
	ld a, $7c
	inc hl
	ld [hli], a
	ld [hli], a
	ld [hl], $7a
	hlcoord 4, 14
	ld [hl], $7e
	hlcoord 4, 15
	ld [hl], $7e
	; call Dex_Pics_DrawBorder
; load the icon sprite
	ld a, 11
	ld [wStatsScreenFlags], a
	xor a
	ldh [hObjectStructIndex], a
	ld hl, LoadMenuMonIcon
	ld a, BANK(LoadMenuMonIcon)
	ld e, MONICON_UNUSED
	rst FarCall
	farcall SetDexMonIconColor_SpritePage
	pop hl
	pop de
	pop bc
	pop af
	ret

Dex_Pics_DrawBorder:
	hlcoord 0, 9
	ld a, [wPokedexShinyToggle]
	bit 0, a
	jr z, .not_shiny
	ld [hl], "<DEX_⁂>"
	jr .shiny_done
.not_shiny
	ld [hl], " "
.shiny_done
	hlcoord 0, 0
	ld [hl], $77 
	inc hl

	ld bc, 17
	ld a, $7b
	call ByteFill
	ld [hl], $78

	hlcoord 8, 0
	ld [hl], $78
	inc hl
	inc hl
	ld [hl], $77

	hlcoord 0, 8
	ld [hl], $79
	inc hl

	ld bc, 17
	ld a, $7c
	call ByteFill
	ld [hl], $7a

	hlcoord 8, 8
	ld [hl], $7a
	inc hl
	inc hl
	ld [hl], $79

	hlcoord 0, 1
	lb bc, 7, 1
	ld a, $7d
	call FillBoxWithByte
	hlcoord 10, 1
	lb bc, 7, 1
	ld a, $7d
	call FillBoxWithByte
	hlcoord 8, 1
	lb bc, 7, 1
	ld a, $7e
	call FillBoxWithByte
	hlcoord 18, 1
	lb bc, 7, 1
	ld a, $7e
	call FillBoxWithByte
	hlcoord 9, 0
	lb bc, 9, 1
	ld a, $7f
	call FillBoxWithByte
	ret