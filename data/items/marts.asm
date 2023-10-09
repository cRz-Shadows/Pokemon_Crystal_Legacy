Marts:
; entries correspond to MART_* constants (see constants/mart_constants.asm)
	table_width 2, Marts
	dw MartCherrygrove
	dw MartCherrygroveDex
	dw MartViolet
	dw MartAzalea
	dw MartCianwood
	dw MartGoldenrod2F1
	dw MartGoldenrod2F2
	dw MartGoldenrod3F
	dw MartGoldenrod4F
	dw MartGoldenrod5F1
	dw MartGoldenrod5F2
	dw MartGoldenrod5F3
	dw MartGoldenrod5F4
	dw MartOlivine
	dw MartEcruteak
	dw MartMahogany1
	dw MartMahogany2
	dw MartBlackthorn
	dw MartViridian
	dw MartPewter
	dw MartCerulean
	dw MartLavender
	dw MartVermilion
	dw MartCeladon2F1
	dw MartCeladon2F2
	dw MartCeladon3F
	dw MartCeladon3F_2
	dw MartCeladon4F
	dw MartCeladon5F1
	dw MartCeladon5F1_2
	dw MartCeladon5F2
	dw MartCeladon5F2_2
	dw MartFuchsia
	dw MartSaffron
	dw MartMtMoon
	dw MartIndigoPlateau
	dw MartUnderground
	dw MartBerrys
	dw MartBerrys2
	assert_table_length NUM_MARTS

MartCherrygrove:
	db 4 ; # items
	db POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db -1 ; end

MartCherrygroveDex:
	db 5 ; # items
	db POKE_BALL
	db POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db -1 ; end

MartViolet:
	db 8 ; # items
	db POKE_BALL
	db POTION
	db REPEL
	db ESCAPE_ROPE
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db FLOWER_MAIL
	db -1 ; end

MartAzalea:
	db 9 ; # items
	db POKE_BALL
	db POTION
	db SUPER_POTION
	db SUPER_REPEL
	db ESCAPE_ROPE
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db CHARCOAL
	db -1 ; end

MartCianwood:
	db 12 ; # items
	db BERRY_JUICE
	db ETHER
	db ENERGYPOWDER
	db ENERGY_ROOT
	db HEAL_POWDER
	db REVIVAL_HERB
	db WATER_STONE
	db FIRE_STONE
	db LEAF_STONE
	db THUNDERSTONE
	db SUN_STONE
	db MOON_STONE
	db -1 ; end
	
MartGoldenrod2F1:
	db 7 ; # items
	db POTION
	db SUPER_POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db ICE_HEAL
	db -1 ; end

MartGoldenrod2F2:
	db 9 ; # items
	db POKE_BALL
	db GREAT_BALL
	db ESCAPE_ROPE
    db REPEL
	db SUPER_REPEL
	db REVIVE
	db FULL_HEAL
	db POKE_DOLL
	db FLOWER_MAIL
	db -1 ; end

MartGoldenrod3F:
	db 7 ; # items
	db X_SPEED
	db X_SPECIAL
	db X_DEFEND
	db X_ATTACK
	db DIRE_HIT
	db GUARD_SPEC
	db X_ACCURACY
	db -1 ; end

MartGoldenrod4F:
	db 5 ; # items
	db PROTEIN
	db IRON
	db CARBOS
	db CALCIUM
	db HP_UP
	db -1 ; end

MartGoldenrod5F1:
	db 3 ; # items
	db TM_THUNDERPUNCH
	db TM_FIRE_PUNCH
	db TM_ICE_PUNCH
	db -1 ; end

MartGoldenrod5F2:
	db 4 ; # items
	db TM_THUNDERPUNCH
	db TM_FIRE_PUNCH
	db TM_ICE_PUNCH
	db TM_HEADBUTT
	db -1 ; end

MartGoldenrod5F3:
	db 4 ; # items
	db TM_THUNDERPUNCH
	db TM_FIRE_PUNCH
	db TM_ICE_PUNCH
	db TM_ROCK_SMASH
	db -1 ; end

MartGoldenrod5F4:
	db 5 ; # items
	db TM_THUNDERPUNCH
	db TM_FIRE_PUNCH
	db TM_ICE_PUNCH
	db TM_HEADBUTT
	db TM_ROCK_SMASH
	db -1 ; end

MartOlivine:
	db 10 ; # items
	db GREAT_BALL
	db SUPER_POTION
	db HYPER_POTION
	db FULL_HEAL
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db ICE_HEAL
	db SUPER_REPEL
	db SURF_MAIL
	db -1 ; end

MartEcruteak:
	db 11 ; # items
	db POKE_BALL
	db GREAT_BALL
	db POTION
	db SUPER_POTION
	db FULL_HEAL
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db ICE_HEAL
	db REVIVE
	db -1 ; end

MartMahogany1:
	db 6 ; # items
	db TM_FRUSTRATION
	db TM_ROAR
	db TINYMUSHROOM
	db SLOWPOKETAIL
	db POKE_BALL
	db POTION
	db -1 ; end

MartMahogany2:
	db 10 ; # items
	db RAGECANDYBAR
	db METAL_COAT
	db UP_GRADE
	db BRICK_PIECE
	db TM_DIG
	db TM_ROLLOUT
	db TM_SWIFT
	db TM_NIGHTMARE
	db TM_DEFENSE_CURL
	db TM_DETECT
	db -1 ; end

MartBlackthorn:
	db 10 ; # items
	db ULTRA_BALL
	db HYPER_POTION
	db MAX_REPEL
	db FULL_HEAL
	db TM_SLUDGE_BOMB
	db TM_STEEL_WING
	db TM_THIEF
	db TM_PSYCH_UP
	db TM_RAIN_DANCE
	db TM_SUNNY_DAY
	db -1 ; end

MartViridian:
	db 9 ; # items
	db ULTRA_BALL
	db HYPER_POTION
	db FULL_HEAL
	db REVIVE
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db FLOWER_MAIL
	db -1 ; end

MartPewter:
	db 7 ; # items
	db GREAT_BALL
	db SUPER_POTION
	db SUPER_REPEL
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db -1 ; end

MartCerulean:
	db 9 ; # items
	db GREAT_BALL
	db ULTRA_BALL
	db SUPER_POTION
	db SUPER_REPEL
	db FULL_HEAL
	db X_DEFEND
	db X_ATTACK
	db DIRE_HIT
	db SURF_MAIL
	db -1 ; end

MartLavender:
	db 8 ; # items
	db GREAT_BALL
	db POTION
	db SUPER_POTION
	db MAX_REPEL
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db -1 ; end

MartVermilion:
	db 8 ; # items
	db ULTRA_BALL
	db SUPER_POTION
	db HYPER_POTION
	db REVIVE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db LITEBLUEMAIL
	db -1 ; end

MartCeladon2F1:
	db 7 ; # items
	db POTION
	db SUPER_POTION
	db HYPER_POTION
	db MAX_POTION
	db REVIVE
	db SUPER_REPEL
	db MAX_REPEL
	db -1 ; end

MartCeladon2F2:
	db 10 ; # items
	db POKE_BALL
	db GREAT_BALL
	db ULTRA_BALL
	db ESCAPE_ROPE
	db FULL_HEAL
	db ANTIDOTE
	db BURN_HEAL
	db ICE_HEAL
	db AWAKENING
	db PARLYZ_HEAL
	db -1 ; end

MartCeladon3F:
	db 5 ; # items
	db TM_SUNNY_DAY
	db TM_RAIN_DANCE
	db TM_SANDSTORM
	db TM_PROTECT
	db TM_ENDURE
	db -1 ; end

MartCeladon3F_2:
	db 9 ; # items
	db TM_SUNNY_DAY
	db TM_RAIN_DANCE
	db TM_SANDSTORM
	db TM_PROTECT
	db TM_ENDURE
	db TM_EARTHQUAKE ; OP
	db TM_SOLARBEAM ; OP
	db TM_PSYCHIC_M ; OP
	db TM_ZAP_CANNON ; OP
	db -1 ; end

MartCeladon4F:
	db 5 ; # items
	db HP_UP
	db PROTEIN
	db IRON
	db CARBOS
	db CALCIUM
	db -1 ; end

MartCeladon5F1:
	db 8 ; # items
	db TM_MUD_SLAP
	db TM_FURY_CUTTER
	db TM_ATTRACT
	db TM_SHADOW_BALL
	db TM_DYNAMICPUNCH
	db TM_ICY_WIND
	db TM_IRON_TAIL
	db TM_DRAGONBREATH
	db -1 ; end

MartCeladon5F1_2:
	db 10 ; # items
	db TM_MUD_SLAP
	db TM_FURY_CUTTER
	db TM_ATTRACT
	db TM_SHADOW_BALL
	db TM_DYNAMICPUNCH
	db TM_ICY_WIND
	db TM_IRON_TAIL
	db TM_DRAGONBREATH
	db TM_TOXIC ; OP
	db TM_GIGA_DRAIN ; OP
	db -1 ; end

MartCeladon5F2:
	db 5 ; # items
	db TM_HIDDEN_POWER
	db TM_SWAGGER
	db TM_SNORE
	db TM_SLEEP_TALK
	db TM_SWEET_SCENT
	db -1 ; end

MartCeladon5F2_2:
	db 9 ; # items
	db TM_HIDDEN_POWER
	db TM_SWAGGER
	db TM_SNORE
	db TM_SLEEP_TALK
	db TM_SWEET_SCENT
	db TM_RETURN ; OP
	db TM_DREAM_EATER ; OP
	db TM_CURSE ; OP
	db TM_REST ; OP
	db -1 ; end

MartFuchsia:
	db 7 ; # items
	db GREAT_BALL
	db ULTRA_BALL
	db SUPER_POTION
	db HYPER_POTION
	db FULL_HEAL
	db MAX_REPEL
	db FLOWER_MAIL
	db -1 ; end

MartSaffron:
	db 8 ; # items
	db GREAT_BALL
	db ULTRA_BALL
	db HYPER_POTION
	db MAX_POTION
	db FULL_HEAL
	db X_ATTACK
	db X_DEFEND
	db FLOWER_MAIL
	db -1 ; end

MartMtMoon:
	db 6 ; # items
	db POKE_DOLL
	db FRESH_WATER
	db SODA_POP
	db LEMONADE
	db REPEL
	db PORTRAITMAIL
	db -1 ; end

MartIndigoPlateau:
	db 7 ; # items
	db ULTRA_BALL
	db MAX_REPEL
	db HYPER_POTION
	db MAX_POTION
	db FULL_RESTORE
	db REVIVE
	db FULL_HEAL
	db -1 ; end

MartUnderground:
	db 4 ; # items
	db ENERGYPOWDER
	db ENERGY_ROOT
	db HEAL_POWDER
	db REVIVAL_HERB
	db -1 ; end

MartBerrys:
	db 8 ; # items
	db BERRY
	db BITTER_BERRY
	db BURNT_BERRY
	db ICE_BERRY
	db MINT_BERRY
	db MYSTERYBERRY
	db PRZCUREBERRY
	db PSNCUREBERRY
	db -1 ; end

MartBerrys2:
	db 10 ; # items
	db BERRY
	db BITTER_BERRY
	db BURNT_BERRY
	db ICE_BERRY
	db MINT_BERRY
	db MYSTERYBERRY
	db PRZCUREBERRY
	db PSNCUREBERRY
	db GOLD_BERRY
	db MIRACLEBERRY
	db -1 ; end

DefaultMart:
	db 2 ; # items
	db POKE_BALL
	db POTION
	db -1 ; end
