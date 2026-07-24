MACRO bt_trainer
	dname \1 ; name
	db \2 ; class
ENDM

BattleTowerTrainers:
; The trainer class is not used in Crystal 1.0 due to a bug.
; Instead, the sixth character in the trainer's name is used.
; See BattleTowerText in engine/events/battle_tower/trainer_text.asm.
	; THIS IS FIXED!
	table_width (NAME_LENGTH - 1) + 1
	; name, class
	bt_trainer "Isona",      TEACHER
	bt_trainer "Tiberius",   GENTLEMAN
	bt_trainer "Masuda",     GUITARIST
	bt_trainer "Karlos",     SCIENTIST
	bt_trainer "SoulXCross", TEACHER
	bt_trainer "Talos",      EXECUTIVEM
	bt_trainer "Sacred",     BOARDER
	bt_trainer "Sable",      HIKER
	bt_trainer "Obelisk",    TEACHER
	bt_trainer "Aero",       COOLTRAINERM
	bt_trainer "Disq",       KIMONO_GIRL
	bt_trainer "Joshua",     OFFICER
	bt_trainer "Nayru",      MEDIUM
	bt_trainer "Idain",      POKEMANIAC
	bt_trainer "Regi",       JUGGLER
	bt_trainer "Reader",     POKEFANF
	bt_trainer "Brice",      MYSTICALMAN
	bt_trainer "Luna",       BEAUTY
	bt_trainer "ZAAACH",     SCHOOLBOY
	bt_trainer "Cadmium",    BOARDER
	bt_trainer "Tajiri",     BUG_CATCHER
	assert_table_length BATTLETOWER_NUM_UNIQUE_MON
; The following can only be sampled in Crystal 1.1.
	bt_trainer "Plague",     TEACHER
	bt_trainer "Coral",      SUPER_NERD
	bt_trainer "Francis",    BOARDER
	bt_trainer "Zumi",       SUPER_NERD
	bt_trainer "TSK",        COOLTRAINERM
	bt_trainer "Jojobear",   SAGE
	bt_trainer "Ryomnar",    EXECUTIVEM
	bt_trainer "Ferro",      SUPER_NERD
	bt_trainer "Frank",      SCIENTIST
	bt_trainer "Sea",        KIMONO_GIRL
	bt_trainer "Oats",       SUPER_NERD
	bt_trainer "Rubicate",   SCIENTIST
	bt_trainer "PokeGlitch", SAGE
	bt_trainer "theSLAYER",  BIKER
	bt_trainer "Dabomstew",  SAGE
	bt_trainer "LuckyT",     SCIENTIST
	bt_trainer "Opwith",     POKEMANIAC
	bt_trainer "KBM",        BLACKBELT_T
	bt_trainer "LVL 3",      CAMPER
	bt_trainer "Cam",        FIREBREATHER
	bt_trainer "KoH",        POKEFANM
	bt_trainer "Miksy91",    SKIER
	bt_trainer "Celadonk",   JUGGLER
	bt_trainer "Jobexi",     YOUNGSTER
	bt_trainer "Fotomac",    GRUNTM
	bt_trainer "Oak",        POKEMON_PROF
	bt_trainer "Vortiene",   GENTLEMAN
	bt_trainer "ZZAZZ",      SCIENTIST
	bt_trainer "Nair",       PICNICKER
	bt_trainer "Steppo",     EXECUTIVEM
	bt_trainer "Yahweasel",  TEACHER
	bt_trainer "Nuuk",       COOLTRAINERM
	bt_trainer "DamienD",    FISHER
	bt_trainer "Masaru2",    YOUNGSTER
	bt_trainer "Hikikomori", MEDIUM
	bt_trainer "Snyd",       GENTLEMAN
	bt_trainer "THexagon",   GUITARIST
	bt_trainer "TimoVM",     SCIENTIST
	bt_trainer "Peanutella", LASS
	bt_trainer "Dracrius",   BOARDER
	bt_trainer "EricGall23", SKIER
	bt_trainer "z3bra",      POKEMANIAC
	bt_trainer "Rangi",      BEAUTY
	bt_trainer "SarnDev",    BOARDER
	bt_trainer "Atma",       COOLTRAINERF
	bt_trainer "SatoMew",    BEAUTY
	bt_trainer "SHF",        GRUNTM
	bt_trainer "80c",        BURGLAR
	bt_trainer "SS",         BURGLAR
	assert_table_length BATTLETOWER_NUM_UNIQUE_TRAINERS
