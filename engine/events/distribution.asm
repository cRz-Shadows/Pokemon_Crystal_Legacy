
GiveEventDistribution::
; Skip if the party's full
; This should technically be checked in the Event Distribution Man's script
    ld a, [wPartyCount]
    cp PARTY_LENGTH
    ret z

    xor a ; PARTYMOM
    ld [wMonType], a

; Get a random Pokemon from the Distribution Gifts list
; Save the address to WRAM for use later
    ld a, NUM_DISTRIBUTION_GIFTS
    call RandomRange

    ld bc, DISTRIBUTION_GIFT_VALUES
    ld hl, DistributionGifts
    call AddNTimes
    ld a, h
    ld [wDistributionEventAddress], a
    ld a, l
    ld [wDistributionEventAddress+1], a

; Set Pokemon Species and Level
    ld a, [hli]
    ld [wCurPartySpecies], a

; Egg check
    ld a, [hli]
    cp IS_EGG
    ld a, [hl]
    ld [wCurPartyLevel], a
    jr z, .egg 

    call EventDistribution_GivePoke
    jp nc, .notGiven
    jr .finish
.egg
    call EventDistribution_GiveEgg
    jp nc, .notGiven
.finish
    ld a, 1
    ld [wScriptVar], a
    ret 

.notGiven
    xor a
    ld [wScriptVar], a
    ret 

EventDistribution_GiveEgg:
; Store info for if we've seen or caught
; the Pokemon in the egg before
    ld a, [wCurPartySpecies]
    call CheckCaughtMon
    push bc

    ld a, [wCurPartySpecies]
    call CheckSeenMon
    push bc

    call EventDistribution_GivePoke
    ret nc

; Set Egg type species
    ld hl, wPartyCount
    ld a, [hl]
    ld c, a
    ld b, 0
    add hl, bc
    ld a, EGG
    ld [hli], a
    ld a, -1
    ld [hl], a

; Set Egg Nickname
    ld a, [wPartyCount]
    dec a
    ld hl, wPartyMonNicknames
    ld bc, MON_NAME_LENGTH
    call AddNTimes
    ld de, String_EGG
    call CopyName2
    
; Egg OT ID
    ld hl, wPartyMon1ID
    call SeekPartyMon
    ld a, [wPlayerID]
    ld [hli], a
    ld a, [wPlayerID+1]
    ld [hl], a

; Egg OT name
    ld a, [wPartyCount]
    dec a
    ld hl, wPartyMonOTs
    call SkipNames
    ld de, wPlayerName
    call CopyName2

; Set steps
    ld hl, wPartyMon1Happiness
    call SeekPartyMon
    ld a, [wBaseEggSteps]
    ld [hli], a

; Clear fields after Happiness
    xor a
    ld [hli], a ; PokerusStatus
    ld [hli], a ; CaughtData, CaughtTime, CaughtLevel
    ld [hl], a  ; CaughtGender, CaughtLocation

; Reset Pokedex Seen Status if needed
    pop bc
    ld a, c
    and a
    jr nz, .skipSeenFlag
    ld a, [wCurPartySpecies]
    dec a
    ld c, a
    ld d, $0
    ld hl, wPokedexSeen
    ld b, RESET_FLAG
    predef SmallFarFlagAction
.skipSeenFlag
    pop bc
    ld a, c
    and a
    jr nz, .skipCaughtFlag
    ld a, [wCurPartySpecies]
    dec a
    ld c, a
    ld d, $0
    ld hl, wPokedexCaught
    ld b, RESET_FLAG
    predef SmallFarFlagAction
.skipCaughtFlag

    scf
    ret 


EventDistribution_GivePoke:
; This routine isn't meant for giving eggs
    predef TryAddMonToParty
    ret nc

; OT ID.
    ld hl, wPartyMon1ID
    call SeekPartyMon
    ld a, HIGH(PCNY_OT_ID)
    ld [hli], a
    ld [hl], LOW(PCNY_OT_ID)

; OT Name
    ld a, [wPartyCount]
    dec a
    ld hl, wPartyMonOTs
    call SkipNames
    ld de, PCNYOTTrainerName
    call CopyName2
    
; Set caught data
    ld hl, wPartyMon1CaughtLevel
    call SeekPartyMon

    ld a, [wTimeOfDay]
    inc a
    rrca
    rrca
    ld b, a
    ld a, [wCurPartyLevel]
    or b
    ld [hli], a ; Set caught level and time of day
    ld a, LANDMARK_EVENT
    ld [hl], a

; Set moveset
    ld hl, wPartyMon1Moves
    call SeekPartyMon

    ld a, [wDistributionEventAddress]
    ld d, a
    ld a, [wDistributionEventAddress+1]
    ld e, a

REPT 4
    inc de
ENDR

    push de
REPT 4
    ld a, [de]
    inc de
    ld [hli], a
ENDR
    pop de

    ld hl, wPartyMon1PP
    call SeekPartyMon
    
    push de
    ld b, NUM_MOVES
; Fix Moves PP
.setMovePPLoop
    push bc

    ld a, [de]
    dec a
    push de
    push hl
    ld hl, Moves + 5
    ld bc, MOVE_LENGTH
    call AddNTimes
    ld de, wDistributionEventAddress
    ld bc, 1
    ld a, BANK(Moves)
    call FarCopyBytes
    pop hl
    pop de
    ld a, [wDistributionEventAddress]
    ld [hli], a
    inc de

    pop bc
    dec b
    jr nz, .setMovePPLoop
    pop de

; Set Shiny
; Move to Shiny ratio
    dec de ; Since we were at the beginning of the moveset
    ld a, 100
    call RandomRange
    ld b, a
    ld a, [de]
    cp b
    jr nc, .setShiny
    ret ; finished!
.setShiny
    ld hl, wPartyMon1DVs
    call SeekPartyMon

; Set Speed and Special DVs
    inc hl
    ld a, $AA
    ld [hld], a
    ld d, h
    ld e, l

    ld hl, ShinyAttackDefenseDVTable
    ld a, 8
    call RandomRange
    ld b, a
.loop
    ld a, [hli]
    dec b
    jr nz, .loop

    ld [de], a

    scf
    ret 

EventDistribution_GetCurrentPartyMember:
    ld a, [wPartyCount]
    dec a
    call AddNTimes
    ld d, h
    ld e, l
    ret 

EventDistribution_ClearEvent::
    ld de, EVENT_POKEDISTRIBUTIONMAN_RECEIVEDGIFT
    ld b, RESET_FLAG
    jp EventFlagAction

String_EGG:
    db "EGG@"

; @param hl: wPartyMon1 Struct Variable
SeekPartyMon:
    ld a, [wPartyCount]
    dec a
    ld bc, PARTYMON_STRUCT_LENGTH
    call AddNTimes
    ret 

ShinyAttackDefenseDVTable:
    db %0010_1010 ; 2, 10
    db %0011_1010 ; 3, 10
    db %0110_1010 ; 6, 10
    db %0111_1010 ; 7, 10
    db %1010_1010 ; 10, 10
    db %1011_1010 ; 11, 10
    db %1110_1010 ; 14, 10
    db %1111_1010 ; 15, 10

INCLUDE "data/events/distribution_gifts.asm"
