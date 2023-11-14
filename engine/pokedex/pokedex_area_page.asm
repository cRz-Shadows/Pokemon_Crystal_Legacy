INCLUDE "engine/pokedex/pokedex_area_page_trees_rocks.asm"
INCLUDE "engine/pokedex/pokedex_area_page_fishing.asm"

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

	cp DEXENTRY_AREA_TREES_COMMON
	jr z, .trees
	cp DEXENTRY_AREA_TREES_RARE
	jr z, .trees	
	cp DEXENTRY_AREA_ROCKSMASH
	jr z, .rocksmash

	cp DEXENTRY_AREA_CONTEST
	jr z, .bugcontest

	cp DEXENTRY_AREA_ROAMING
	jr z, .roaming
	
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
	call Pokedex_DetailedArea_Trees
	jr .skip_empty_area_check	
.rocksmash
	call Pokedex_DetailedArea_rocksmash
	jr .skip_empty_area_check
.bugcontest
	call Pokedex_DetailedArea_bugcontest
	jr .skip_empty_area_check
.roaming
	call Pokedex_DetailedArea_roaming	
	; fallthrough
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

	call Dex_Check_Trees_firstcommon
	and a
	jr z, .commontrees

	call Dex_Check_Trees_firstrare
	and a
	jr z, .raretrees

	call Dex_Check_rocksmash
	and a
	jr z, .rocksmash

	call Dex_Check_bugcontest
	and a
	jr z, .contest

	call Dex_Check_roaming
	and a
	jr z, .roaming

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
.commontrees
	ld a, DEXENTRY_AREA_TREES_COMMON
	ret
.raretrees
	ld a, DEXENTRY_AREA_TREES_RARE
	ret
.rocksmash
	ld a, DEXENTRY_AREA_ROCKSMASH
	ret
.contest
	ld a, DEXENTRY_AREA_CONTEST
	ret
.roaming
	ld a, DEXENTRY_AREA_ROAMING
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; BUG CATCHING CONTEST ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Dex_Check_bugcontest:
	ld hl, ContestMons
; ContestMons:
; 	;   %, species,   min, max
; 	db 20, CATERPIE,    7, 18

; given HL, point in ContestMons, check for any further matching mons
; return zero in 'a' if found, else 1 in 'a'
.loop
	ld a, BANK(ContestMons)
	call GetFarByte ;; will be -1 at the end, otherwise it's the % chance to encounter
	cp -1
	jr z, .notfound
	; we arent at the end, so increment ptr by 1 and check species, that's all we care about
	inc hl
	ld a, BANK(ContestMons)
	call GetFarByte ;; will be -1 at the end, otherwise it's the % chance to encounter
	ld c, a ; pokemon species of entry in ContestMons
	ld a, [wCurSpecies] ; current pokedex entry species
	cp c
	jr z, .found
	; species didnt match, inc hl by 3, need to check for -1
	inc hl
	inc hl
	inc hl
	jr .loop
.found
	xor a
	ret
.notfound
	ld a, 1
	ret

Pokedex_DetailedArea_bugcontest:
	call Dex_Check_bugcontest
	and a
	jp nz, Pokedex_Skip_Empty_Area_Category
	
	xor a
	ld [wPokedexEvoStage2], a
	ld [wPokedexEvoStage3], a

	; print the title, BUG CONTEST
	hlcoord 1, 9
	ld de, .bugcontest_text
	call PlaceString
	hlcoord 1, 10
	ld de, .park_text
	call PlaceString

	ld hl, ContestMons
	ld e, 0
.loop
	ld a, BANK(ContestMons)
	call GetFarByte ;; will be -1 at the end, otherwise it's the % chance to encounter
	ld d, a ; encounter %
	cp -1
	jr z, .done
	; we arent at the end, so increment ptr by 1 and check species, that's all we care about
	inc hl
	ld a, BANK(ContestMons)
	call GetFarByte ;; will be -1 at the end, otherwise it's the % chance to encounter
	ld c, a ; pokemon species of entry in ContestMons
	ld a, [wCurSpecies] ; current pokedex entry species
	cp c
	jr z, .found
	; species didnt match, inc hl by 3, need to check for -1
.continue
	inc hl
	inc hl
	inc hl
	jr .loop
.found
	; 'e' is the accumulated %, in case of multiple species entries
	ld a, d
	add e
	ld e, a
	jr .continue
.done
	; if 'e' is above zero, print
	xor a
	cp e
	jr z, .donedone
	call BugContest_Print
.donedone
	ld a, [wPokedexEntryType] ; bug
	inc a
	call DexEntry_NextCategory
	ret
.bugcontest_text:
	db "BUG-CATCH CONTEST@"
.park_text:
	db "-NATIONAL PARK@"

BugContest_Print:
	ld b, e ; encounter %
	hlcoord 3, 11 ; same position regardless
	ld [hl], $65 ; day icon tile
	ld de, 6
	add hl, de
	ld [hl], $6b ; day icon tile
	add hl, de
	ld [hl], $6c ; nite icon tile 
	hlcoord 7, 11
	ld [hl], "<%>"
	ld de, 6
	add hl, de
	ld [hl], "<%>"
	add hl, de
	ld [hl], "<%>"
	ld a, b ; encounter %
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	hlcoord 16, 11
	lb bc, 1, 3
	call PrintNum
	hlcoord 10, 11
	call PrintNum
	hlcoord 4, 11
	call PrintNum
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ROAMING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; wRoamMon1:: roam_struct wRoamMon1
; wRoamMon2:: roam_struct wRoamMon2
; wRoamMon3:: roam_struct wRoamMon3
; roam_struct: MACRO
; \1Species::   db
; \1Level::     db
; \1MapGroup::  db
; \1MapNumber:: db
; \1HP::        db
; \1DVs::       dw
; ENDM

Dex_Check_roaming:
	ld a, [wCurSpecies]
	ld hl, wRoamMon1Species
	cp [hl]
	jr z, .found
	ld hl, wRoamMon2Species
	cp [hl]
	jr z, .found
	ld a, NUM_ROAMMONS
	cp 3
	jr nz, .no_third_roamer
	ld a, [wCurSpecies]
	ld hl, wRoamMon3Species
	cp [hl]
	jr z, .found
.no_third_roamer	
	; none found
	ld a, 1
	ret
.found
	xor a
	ret

Pokedex_DetailedArea_roaming:
	call Dex_Check_roaming
	and a
	jp nz, Pokedex_Skip_Empty_Area_Category
	
	xor a
	ld [wPokedexEvoStage2], a
	ld [wPokedexEvoStage3], a

	; print the title, ROAMING
	hlcoord 1, 9
	ld de, .roaming_text
	call PlaceString
	ld bc, 0 ; print line counter for 'DexEntry_adjusthlcoord' in 'c'

	ld a, [wCurSpecies]
	ld hl, wRoamMon1Species
	cp [hl]
	call z, Dex_Print_Roamer_Info
	
	ld a, [wCurSpecies]
	ld hl, wRoamMon2Species
	cp [hl]
	call z, Dex_Print_Roamer_Info
	; call Dex_Print_Roamer_Info
	
	ld a, NUM_ROAMMONS
	cp 3
	jr nz, .donedone

	ld a, [wCurSpecies]
	ld hl, wRoamMon3Species
	cp [hl]
	call z, Dex_Print_Roamer_Info
.donedone
	ld a, [wPokedexEntryType] ; roaming
	inc a
	call DexEntry_NextCategory
	ret
.roaming_text:
	db "ROAMING@"

Dex_Print_Roamer_Info:
	; push bc ; line counter in c
	; roamer ptr in hl
	; line counter in c
	inc hl ; now pointing to LVL
	ld a, [hl] ; roamer LVL
	ld [wPokedexEvoStage2], a ; roamer LVL

	inc hl ; now pointing to map group
	ld a, [hli] ; now pointing to map num
	ld e, a
	ld a, [hli] ; now pointing to HP
	ld d, a

	ld a, [hli] ; now pointing to DVs
	ld [wPokedexEvoStage3], a ; Roamer HP

	push hl ; now pointing to DVs

	farcall GetMapGroupNum_Name ; map info in 'de'
	; map name ptr is in de
	hlcoord 2 , 10
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	ld a, BANK(MapGroupNum_Names)
	push bc ; current print line in c
	call PlaceFarString
	pop bc ; current print line in c

	;print roamer's lvl	
	ld a, [wPokedexEvoStage2]
	cp 100
	jr nz, .two_digits
	hlcoord 4, 11
	jr .lvl_spot_decided
.two_digits
	hlcoord 3, 11
.lvl_spot_decided
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	push bc ; current print line in c
	lb bc, 1, 3 ; num of bytes of the number, max digits
	ld de, wPokedexEvoStage2 ; roamer's LVL
	call PrintNum
	pop bc ; current print line in c
	; print lvl symbol
	hlcoord 3, 11
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	ld [hl], "<DEX_LV>" ; lvl symbol

; if HP is 0, means the DVs havent been init'd yet upon seeing it in battle for the first time
; if HP is 0, don't print
	push bc ; current print line in c
	ld a, [wPokedexEvoStage3] ; Roamer's HP
	and a
	jr z, .not_initd
; HP string and /
	hlcoord 8, 11
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	ld de, .hp_text
	call PlaceString
	pop bc ; current print line in c
	; current HP
	
	hlcoord 12, 11
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	ld de, wPokedexEvoStage3 ; Roamer's HP
	push bc ; current print line in c
	lb bc, 1, 3 ; num of bytes of the number, max digits
	call PrintNum
	ld a, 1 ; for next check

.not_initd
	pop bc ; current print line in c
	pop hl ; ; now pointing to DVs
; check if shiny
	push bc  ; current print line in c
	; check if DVs are init'd
	and a ; will still be zero if we jumped here after DV check, else will be 1
	jr z, .not_shiny
	
	ld b, h
	ld c, l
	farcall CheckShininess ; ptr needs to be in bc
	; scf if shiny
	; jr nc, .not_shiny
	; shiny tile is $64
	pop bc ; current print line in c
	push bc ; current print line in c
	hlcoord 1, 11
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	ld [hl], "<DEX_⁂>"
; shiny check done
.not_shiny
	pop bc ; line counter in c
	inc c ; for next print, in case there are mult roamers of same species
	inc c
	ret
.hp_text:
	db "HP:@"
