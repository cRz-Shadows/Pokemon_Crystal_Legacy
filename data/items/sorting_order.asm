ItemNameOrder:
	table_width 1, ItemNameOrder

	db NO_ITEM			; 00

	db POKE_BALL 		; 01
	db GREAT_BALL		; 02
	db ULTRA_BALL		; 03
	db MASTER_BALL		; 04
    db PARK_BALL		; 05
	db LEVEL_BALL		; 06
	db LURE_BALL		; 07
	db MOON_BALL		; 08
	db FRIEND_BALL		; 09
	db FAST_BALL		; 0a
	db HEAVY_BALL 		; 0b
	db LOVE_BALL		; 0c
	db GS_BALL			; 0d

	db POTION 			; 0e
	db SUPER_POTION 	; 0f
	db HYPER_POTION 	; 10
	db MAX_POTION 		; 11
    db SECRETPOTION 	; 12

	db ANTIDOTE 		; 13
	db BURN_HEAL 		; 14
	db PARLYZ_HEAL 		; 15
	db AWAKENING 		; 16
	db ICE_HEAL 		; 17
	db FULL_HEAL 		; 18
	db FULL_RESTORE 	; 19

	db REVIVE 			; 1a
	db MAX_REVIVE 		; 1b

	db ETHER 			; 1c
	db MAX_ETHER 		; 1d
	db ELIXER 			; 1e
	db MAX_ELIXER 		; 1f

	db HP_UP 			; 20
	db PROTEIN 			; 21
	db IRON 			; 22
	db CARBOS 			; 23
	db CALCIUM 			; 24
	db RARE_CANDY 		; 25
	db PP_UP 			; 26

	db FRESH_WATER		; 27
	db SODA_POP 		; 28
	db LEMONADE 		; 29
	db MOOMOO_MILK 		; 2a
	db RAGECANDYBAR 	; 2b

	db SACRED_ASH 		; 2c
	db ENERGYPOWDER 	; 2d
	db ENERGY_ROOT 		; 2e
	db HEAL_POWDER 		; 2f
	db REVIVAL_HERB 	; 30

	db X_ATTACK 		; 31
	db X_DEFEND 		; 32
	db X_SPEED 			; 33
	db X_SPECIAL 		; 34
	db X_ACCURACY 		; 35
	db DIRE_HIT 		; 36
	db GUARD_SPEC 		; 37

	db REPEL 			; 38
	db SUPER_REPEL 		; 39
	db MAX_REPEL 		; 3a
	db ESCAPE_ROPE 		; 3b
	db POKE_DOLL 		; 3c

	db LEAF_STONE 		; 3d
	db FIRE_STONE 		; 3e
	db WATER_STONE 		; 3f
	db THUNDERSTONE 	; 40
	db MOON_STONE 		; 41
	db SUN_STONE 		; 42
	db EVERSTONE 		; 43

	db EXP_SHARE 		; 44

	db BERRY 			; 45
	db PSNCUREBERRY 	; 46
	db PRZCUREBERRY 	; 47
	db BURNT_BERRY 		; 48
	db ICE_BERRY 		; 49
	db BITTER_BERRY 	; 4a
	db MINT_BERRY 		; 4b
	db MIRACLEBERRY 	; 4c
	db MYSTERYBERRY 	; 4d
	db GOLD_BERRY 		; 4e

	db BERRY_JUICE 		; 4f

	db BLACKBELT_I 		; 50
	db SHARP_BEAK 		; 51
	db POISON_BARB 		; 52
	db SOFT_SAND 		; 53
	db HARD_STONE 		; 54
	db SILVERPOWDER 	; 55
	db SPELL_TAG 		; 56
	db METAL_COAT 		; 57
	db CHARCOAL 		; 58
	db MYSTIC_WATER 	; 59
	db MIRACLE_SEED 	; 5a
	db MAGNET 			; 5b
	db TWISTEDSPOON 	; 5c
	db NEVERMELTICE 	; 5d
	db DRAGON_FANG 		; 5e
	db BLACKGLASSES 	; 5f
	db PINK_BOW 		; 60

	db BRIGHTPOWDER 	; 61
	db SCOPE_LENS 		; 62
	db QUICK_CLAW 		; 63
	db KINGS_ROCK 		; 64
	db FOCUS_BAND 		; 65
	db LEFTOVERS 		; 66
	db LUCKY_EGG 		; 67
	db AMULET_COIN 		; 68
	db CLEANSE_TAG 		; 69
	db SMOKE_BALL 		; 6a
	db BERSERK_GENE 	; 6b

	db LIGHT_BALL 		; 6c
	db STICK 			; 6d
	db THICK_CLUB		; 6e
	db LUCKY_PUNCH 		; 6f
	db METAL_POWDER 	; 70

	db DRAGON_SCALE 	; 71
	db UP_GRADE 		; 72

	db NUGGET 			; 73
	db TINYMUSHROOM 	; 74
	db BIG_MUSHROOM 	; 75
	db PEARL 			; 76
	db BIG_PEARL		; 77
	db STARDUST 		; 78
	db STAR_PIECE 		; 79
	db BRICK_PIECE		; 7a
	db SILVER_LEAF		; 7b
	db GOLD_LEAF		; 7c
	db SLOWPOKETAIL 	; 7d

	db HELIX_FOSSIL 	; 7e
	db DOME_FOSSIL 		; 7f
	db OLD_AMBER 		; 80

	db FLOWER_MAIL 		; 81
	db SURF_MAIL		; 82
	db LITEBLUEMAIL 	; 83
	db PORTRAITMAIL 	; 84
	db LOVELY_MAIL 		; 85
	db EON_MAIL 		; 86
	db MORPH_MAIL 		; 87
	db BLUESKY_MAIL 	; 88
	db MUSIC_MAIL 		; 89
	db MIRAGE_MAIL 		; 8a

; Key Items
    db TOWN_MAP 		; 8b
    db BICYCLE			; 8c
    db OLD_ROD 			; 8d
    db GOOD_ROD			; 8e
    db SUPER_ROD		; 8f
    db ITEMFINDER		; 90
    db POKE_FLUTE		; 91
    db COIN_CASE		; 92
    db RED_SCALE		; 93
    db S_S_TICKET		; 94
    db MYSTERY_EGG		; 95
    db CLEAR_BELL		; 96
    db SILVER_WING		; 97
    db RAINBOW_WING		; 98
    db CARD_KEY			; 99
    db MACHINE_PART		; 9a
    db EGG_TICKET		; 9b
    db LOST_ITEM		; 9c
    db BASEMENT_KEY		; 9d
    db PASS 			; 9e
    db NORMAL_BOX 		; 9f
    db GORGEOUS_BOX 	; a0
    db POLKADOT_BOW 	; a1
    db SQUIRTBOTTLE 	; a2
    db BLUE_CARD 		; a3

; Apricorns
    db RED_APRICORN 	; a4
    db BLU_APRICORN 	; a5
    db YLW_APRICORN		; a6
    db GRN_APRICORN		; a7
    db WHT_APRICORN		; a8
    db BLK_APRICORN		; a9
    db PNK_APRICORN		; aa

REPT 22
	db $FF ; fill with empty bytes to reach NUM_ITEMS + 1
ENDR

	assert_table_length NUM_ITEMS + 1
	db -1 ; end
