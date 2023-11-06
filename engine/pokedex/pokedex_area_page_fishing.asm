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
