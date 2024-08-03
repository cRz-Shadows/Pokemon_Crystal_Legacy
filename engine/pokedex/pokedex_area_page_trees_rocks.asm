;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; HEADBUTT TREES / ROCKS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Pokedex_DetailedArea_Trees:
	ld a, [wPokedexStatus]; TreeMonMaps entry index, will be zero if we havent started yet
	and a
	jr nz, .start
	call Dex_Check_Trees
	and a
	jp nz, Pokedex_Skip_Empty_Area_Category
.start
	xor a
	ld [wPokedexEvoStage2], a ; lines printed
	ld [wPokedexEvoStage3], a ; encounter % total
	; print the title, HEADBUTT TREES - COMMON
	call Print_TreeTitle
	; using wPokedexStatus/TreeMonMaps entry index, calculate ptr
.map_loop	
; RockMonMaps::
; 	treemon_map CIANWOOD_CITY,             TREEMON_SET_ROCK
	ld hl, TreeMonMaps
	ld bc, 3 ; bytes per entry in TreeMonMaps, two for map group& and ID, and one for tree set
	ld a, [wPokedexStatus]; TreeMonMaps entry index
	call AddNTimes
	; check for -1
	ld a, BANK(TreeMonMaps)
	call GetFarByte
	cp -1
	jr z, .donedone
	ld a, BANK(TreeMonMaps)
	push hl
	call GetFarWord ; map id and group
	ld d, h ; map num
	ld e, l ; map group
	pop hl
	push de ; map
	inc hl
	inc hl
	ld a, BANK(TreeMonMaps)
	call GetFarByte ; tree set index
	; set up hl based on index
	ld hl, TreeMons
	ld bc, 2 ; table of ptrs
	call AddNTimes  	
	; check the set for species match
	; if match, encounter % in wPokedexEvoStage3
	ld a, [wPokedexEntryType]
	cp DEXENTRY_AREA_TREES_RARE
	jr z, .rare
	call Dex_Check_commontree_rocksmash_set
	jr .setcheckdone
.rare
	call Dex_Check_raretree_set
.setcheckdone	
	pop de ; map
	and a
	jr z, .print_tree
	call inc_trees_rocksmash_map_index
	jr .map_loop
.donedone
	ld a, [wPokedexEntryType] ; rocksmash
	inc a
	call DexEntry_NextCategory	
	ret
.print_tree
	call Print_Trees_Rocksmash ; map info in de, encounter % in wPokedexEvoStage3
	call inc_trees_rocksmash_map_index
	ld a, [wPokedexEvoStage2] ; lines printed
	inc a
	inc a ; since each result takes 2 lines
	ld [wPokedexEvoStage2], a ; lines printed
	; check if we are at max printed, 3
	cp 6
	jr z, .thispagedone
	jr .map_loop
.thispagedone
	; check if any remaining entries
	call AnyRemaining_trees
	and a
	jr nz, .donedone
	call DexEntry_IncPageNum
	ret

Dex_Check_Trees_firstcommon:
	ld a, DEXENTRY_AREA_TREES_RARE
	jr Dex_Check_Trees_firstrare.stub
Dex_Check_Trees_firstrare:
	ld a, DEXENTRY_AREA_TREES_RARE
.stub	
	ld [wPokedexEntryType], a
	call Dex_Check_Trees
	ld b, a ; results of check trees
	xor a
	ld [wPokedexEntryType], a
	ld a, b ; results of check trees
	ret

Dex_Check_Trees:
; check for matching mons in RockSmashMons
; return zero in 'a' if found, else 1 in 'a'
	ld hl, TreeMons ; table of pointers, NUM_ROCKSMASH_SETS
	ld b, 0 ; corresponds to NUM_TREEMON_SETS, so we check each entry
.setloop	
	push bc ; tree set index
	push hl ; TreeMons ptr
	ld a, [wPokedexEntryType]
	cp DEXENTRY_AREA_TREES_RARE
	jr z, .rare
.common
	call Dex_Check_commontree_rocksmash_set
	jr .setcheckdone
.rare
	call Dex_Check_raretree_set
.setcheckdone	
	pop hl ; TreeMons ptr
	pop bc ; tree set index
	and a ; if zero, found, exit with zero in 'a'
	ret z

	ld a, NUM_TREEMON_SETS - 1
	cp b ; tree set index
	jr z, .notfound
	inc hl ; TreeMons ptr
	inc hl ; TreeMons ptr, 2 bytes per entry
	inc b ; tree set index
	jr .setloop
.notfound
	ld a, 1
	ret

AnyRemaining_trees:
	; given map index in wPokedexStatus, return 0 if species match, else 1
.map_loop	
; RockMonMaps::
; 	treemon_map CIANWOOD_CITY,             TREEMON_SET_ROCK
	ld hl, TreeMonMaps
	ld bc, 3 ; bytes per entry in TreeMonMaps, two for map group& and ID, and one for rocksmash set
	ld a, [wPokedexStatus]; TreeMonMaps entry index
	call AddNTimes
	; check for -1
	ld a, BANK(TreeMonMaps)
	call GetFarByte
	cp -1
	jr z, .notfound
	inc hl
	inc hl
	ld a, BANK(TreeMonMaps)
	call GetFarByte ; tree set index
	; set up hl based on index
	ld hl, TreeMons
	ld bc, 2 ; table of ptrs
	call AddNTimes  	
	; check the set for species match
	ld a, [wPokedexEntryType]
	cp DEXENTRY_AREA_TREES_RARE
	jr z, .rare
	call Dex_Check_commontree_rocksmash_set
	jr .setcheckdone
.rare
	call Dex_Check_raretree_set
.setcheckdone
	and a
	ret z
	call inc_trees_rocksmash_map_index
	jr .map_loop
.notfound
	ld a, 1
	ret

Print_Trees_Rocksmash:
; map info in de, encounter % in wPokedexEvoStage3
	farcall GetMapGroupNum_Name ; map info needs to be in de
	; map name ptr is in de
	hlcoord 2 , 9
	ld a, [wPokedexEvoStage2] ; lines printed
	ld c, a
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	ld a, BANK(MapGroupNum_Names)
	call PlaceFarString

	hlcoord 2, 10 ; same position regardless
	ld a, [wPokedexEvoStage2] ; lines printed
	ld c, a	
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	ld [hl], $65 ; day icon tile
	ld de, 6
	add hl, de
	ld [hl], $6b ; day icon tile
	add hl, de
	ld [hl], $6c ; nite icon tile 
	hlcoord 6, 10
	ld a, [wPokedexEvoStage2] ; lines printed
	ld c, a		
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	ld [hl], "<%>"
	ld de, 6
	add hl, de
	ld [hl], "<%>"
	add hl, de
	ld [hl], "<%>"

	ld de, wPokedexEvoStage3 ; encounter %
	hlcoord 3, 10
	ld a, [wPokedexEvoStage2] ; lines printed
	ld c, a	
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	lb bc, 1, 3
	call PrintNum

	hlcoord 9, 10
	ld a, [wPokedexEvoStage2] ; lines printed
	ld c, a		
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	lb bc, 1, 3
	call PrintNum

	hlcoord 15, 10
	ld a, [wPokedexEvoStage2] ; lines printed
	ld c, a		
	call DexEntry_adjusthlcoord ; current print line needs to be in c
	lb bc, 1, 3
	call PrintNum
	ret

Print_TreeTitle:
	ld a, [wPokedexEntryType]
	cp DEXENTRY_AREA_TREES_COMMON
	jr z, .common
	ld de, .headbutt_tree_rare_text
	jr .print
.common
	ld de, .headbutt_tree_common_text
.print	
	ld hl, .trees_text
	call Print_Category_text
	ret
.headbutt_tree_common_text:
	db "COMMON     @"
.headbutt_tree_rare_text:
	db "RARE       @"
.trees_text:	
	db " TREES   @"	

inc_trees_rocksmash_map_index:
	ld a, [wPokedexStatus]
	inc a
	ld [wPokedexStatus], a
	ret	

;;;;;;;;;;; COMMON TREES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Dex_Check_commontree_rocksmash_set:
	xor a
	ld [wPokedexEvoStage3], a ; encounter % total
	; get the ptr from the double ptr in hl
	ld a, BANK(TreeMons)
	call GetFarWord
; TreeMonSet_Rock::
; 	db 90, KRABBY,     15
.loop
	ld a, BANK(TreeMons)
	call GetFarByte ;; will be -1 at the end, otherwise it's the % chance to encounter
	cp -1
	jr z, .done
	ld b, a ; encounter %
	; we arent at the end, so increment ptr by 1 and check species, that's all we care about
	inc hl
	ld a, BANK(TreeMons)
	call GetFarByte ;; will be -1 at the end, otherwise it's the % chance to encounter
	ld c, a ; pokemon species of entry in ContestMons
	ld a, [wCurSpecies] ; current pokedex entry species
	cp c
	call z, .found
	; species didnt match, inc hl by 3, need to check for -1
	inc hl
	inc hl
	jr .loop
.found
	ld a, [wPokedexEvoStage3]
	add b ; this encounter %
	ld [wPokedexEvoStage3], a ; encounter % total
	ret
.done
	ld a, [wPokedexEvoStage3]
	ld b, a
	xor a
	cp b
	ret nz
	; fallthrough
; .notfound
	ld a, 1
	ret	

;;;;;;;;;;; RARE TREES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Dex_Check_raretree_set:
	xor a
	ld [wPokedexEvoStage3], a ; encounter % total
	; get the ptr from the double ptr in hl
	ld a, BANK(TreeMons)
	call GetFarWord
; 	db 10, AIPOM,      10
.loop1 ; get past the common table
	ld a, BANK(TreeMons)
	call GetFarByte ;; will be -1 at the end, otherwise it's the % chance to encounter
	cp -1
	jr z, .loop2setup
	inc hl
	inc hl
	inc hl
	jr .loop1
.loop2setup
	inc hl
.loop2
	ld a, BANK(TreeMons)
	call GetFarByte ;; will be -1 at the end, otherwise it's the % chance to encounter
	cp -1
	jr z, .done
	ld b, a ; encounter %
	; we arent at the end, so increment ptr by 1 and check species, that's all we care about
	inc hl
	ld a, BANK(TreeMons)
	call GetFarByte ;; will be -1 at the end, otherwise it's the % chance to encounter
	ld c, a ; pokemon species of entry in ContestMons
	ld a, [wCurSpecies] ; current pokedex entry species
	cp c
	call z, .found
	; species didnt match, inc hl by 3, need to check for -1
	inc hl
	inc hl
	jr .loop2
.found
	ld a, [wPokedexEvoStage3]
	add b ; this encounter %
	ld [wPokedexEvoStage3], a ; encounter % total
	ret
.done
	ld a, [wPokedexEvoStage3]
	ld b, a
	xor a
	cp b
	ret nz
	; fallthrough
; .notfound
	ld a, 1
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ROCKSMASH  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Pokedex_DetailedArea_rocksmash:
	ld a, [wPokedexStatus]; RockMonMaps entry index, will be zero if we havent started yet
	and a
	jr nz, .start
	call Dex_Check_rocksmash
	and a
	jp nz, Pokedex_Skip_Empty_Area_Category
.start
	xor a
	ld [wPokedexEvoStage2], a ; lines printed
	ld [wPokedexEvoStage3], a ; encounter % total
	; print the title, ROCK SMASH
	ld hl, .rocksmash_text2
	ld de, .rocksmash_text1
	call Print_Category_text
	; using wPokedexStatus/RockMonMaps entry index, calculate ptr
.map_loop	
; RockMonMaps::
; 	treemon_map CIANWOOD_CITY,             TREEMON_SET_ROCK
	ld hl, RockMonMaps
	ld bc, 3 ; bytes per entry in RockMonMaps, two for map group& and ID, and one for rocksmash set
	ld a, [wPokedexStatus]; RockMonMaps entry index
	call AddNTimes
	; check for -1
	ld a, BANK(RockMonMaps)
	call GetFarByte
	cp -1
	jr z, .donedone
	ld a, BANK(RockMonMaps)
	push hl
	call GetFarWord ; map id and group
	ld d, h ; map num
	ld e, l ; map group
	pop hl
	push de ; map
	inc hl
	inc hl
	ld a, BANK(RockMonMaps)
	call GetFarByte ; ROCKSMASH_SETS index
	; set up hl based on index
	ld hl, RockSmashMons
	ld bc, 2 ; table of ptrs
	call AddNTimes  	
	; check the set for species match
	; if match, encounter % in wPokedexEvoStage3
	call Dex_Check_commontree_rocksmash_set
	pop de ; map
	and a
	jr z, .print_rocksmash
	call inc_trees_rocksmash_map_index
	jr .map_loop
.donedone
	ld a, [wPokedexEntryType] ; rocksmash
	inc a
	call DexEntry_NextCategory	
	ret
.print_rocksmash
	call Print_Trees_Rocksmash ; map info in de, encounter % in wPokedexEvoStage3
	call inc_trees_rocksmash_map_index
	ld a, [wPokedexEvoStage2] ; lines printed
	inc a
	inc a ; since each result takes 2 lines
	ld [wPokedexEvoStage2], a ; lines printed
	; check if we are at max printed, 3
	cp 6
	jr z, .thispagedone
	jr .map_loop
.thispagedone

	; check if any remaining entries
	call AnyRemaining_RockSmash
	and a
	jr nz, .donedone
	call DexEntry_IncPageNum
	ret
.rocksmash_text1:
	db "ROCK      @"
.rocksmash_text2:	
	db " SMASH   @"

Dex_Check_rocksmash:
; check for matching mons in RockSmashMons
; return zero in 'a' if found, else 1 in 'a'
	ld hl, RockSmashMons ; table of pointers, NUM_ROCKSMASH_SETS
	ld b, 0 ; corresponds to NUM_ROCKSMASH_SETS, so we check each entry, to support more than one rock smash set
.setloop	
	push bc ; rock smash set index
	push hl ; RockSmashMons ptr
	call Dex_Check_commontree_rocksmash_set
	pop hl ; RockSmashMons ptr
	pop bc ; rock smash set index
	and a ; if zero, found, exit with zero in 'a'
	ret z

	ld a, NUM_ROCKSMASH_SETS - 1
	cp b ; rock smash set index
	jr z, .notfound
	inc hl ; RockSmashMons ptr
	inc hl ; RockSmashMons ptr
	inc b ; rock smash set index
	jr .setloop
.notfound
	ld a, 1
	ret

AnyRemaining_RockSmash:
	; given map index in wPokedexStatus, return 0 if species match, else 1
.map_loop	
; RockMonMaps::
; 	treemon_map CIANWOOD_CITY,             TREEMON_SET_ROCK
	ld hl, RockMonMaps
	ld bc, 3 ; bytes per entry in RockMonMaps, two for map group& and ID, and one for rocksmash set
	ld a, [wPokedexStatus]; RockMonMaps entry index
	call AddNTimes
	; check for -1
	ld a, BANK(RockMonMaps)
	call GetFarByte
	cp -1
	jr z, .notfound
	inc hl
	inc hl
	ld a, BANK(RockMonMaps)
	call GetFarByte ; ROCKSMASH_SETS index
	; set up hl based on index
	ld hl, RockSmashMons
	ld bc, 2 ; table of ptrs
	call AddNTimes  	
	; check the set for species match	
	call Dex_Check_commontree_rocksmash_set
	and a
	ret z
	call inc_trees_rocksmash_map_index
	jr .map_loop
.notfound
	ld a, 1
	ret
