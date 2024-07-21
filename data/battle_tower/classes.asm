BattleTowerTrainers:
; The trainer class is not used in Crystal 1.0 due to a bug.
; Instead, the sixth character in the trainer's name is used.
; See BattleTowerText in engine/events/battle_tower/trainer_text.asm.
	; THIS IS FIXED!
	table_width (NAME_LENGTH - 1) + 1, BattleTowerTrainers
	; name, class
	db "Isona@@@@@", TEACHER
	db "Tiberius@@", GENTLEMAN
	db "Masuda@@@@", GUITARIST
	db "Karlos@@@@", SCIENTIST
	db "SoulXCross", TEACHER
	db "Talos@@@@@", EXECUTIVEM
	db "Sacred@@@@", BOARDER
	db "Sable@@@@@", HIKER
	db "Obelisk@@@", TEACHER
	db "Aero@@@@@@", COOLTRAINERM
	db "Disq@@@@@@", KIMONO_GIRL
	db "Joshua@@@@", OFFICER
	db "Nayru@@@@@", MEDIUM
	db "Idain@@@@@", POKEMANIAC
	db "Regi@@@@@@", JUGGLER
	db "Reader@@@@", POKEFANF
	db "Brice@@@@@", MYSTICALMAN
	db "Luna@@@@@@", BEAUTY
	db "ZAAACH@@@@", SCHOOLBOY
	db "Cadmium@@@", BOARDER
	db "Tajiri@@@@", BUG_CATCHER
	assert_table_length BATTLETOWER_NUM_UNIQUE_MON
; The following can only be sampled in Crystal 1.1.
	db "Plague@@@@", TEACHER
	db "Coral@@@@@", SUPER_NERD
	db "Francis@@@", BOARDER
	db "Zumi@@@@@@", SUPER_NERD
	db "TSK@@@@@@@", COOLTRAINERM
	db "Jojobear@@", SAGE
	db "Ryomnar@@@", EXECUTIVEM
	db "Ferro@@@@@", SUPER_NERD
	db "Frank@@@@@", SCIENTIST
	db "Sea@@@@@@@", KIMONO_GIRL
	db "Oats@@@@@@", SUPER_NERD
	db "Rubicate@@", SCIENTIST
	db "PokeGlitch", SAGE
	db "theSLAYER@", BIKER
	db "Dabomstew@", SAGE
	db "LuckyT@@@@", SCIENTIST
	db "Opwith@@@@", POKEMANIAC
	db "KBM@@@@@@@", BLACKBELT_T
	db "LVL 3@@@@@", CAMPER
	db "Cam@@@@@@@", FIREBREATHER
	db "KoH@@@@@@@", POKEFANM
	db "Miksy91@@@", SKIER
	db "Celadonk@@", JUGGLER
	db "Jobexi@@@@", YOUNGSTER
	db "Fotomac@@@", GRUNTM
	db "Oak@@@@@@@", POKEMON_PROF
	db "Vortiene@@", GENTLEMAN
	db "ZZAZZ@@@@@", SCIENTIST
	db "Nair@@@@@@", PICNICKER
	db "Steppo@@@@", EXECUTIVEM
	db "Yahweasel@", TEACHER
	db "Nuuk@@@@@@", COOLTRAINERM
	db "DamienD@@@", FISHER
	db "Masaru2@@@", YOUNGSTER
	db "Hikikomori", MEDIUM
	db "Snyd@@@@@@", GENTLEMAN
	db "THexagon@@", GUITARIST
	db "TimoVM@@@@", SCIENTIST
	db "Peanutella", LASS
	db "Dracrius@@", BOARDER
	db "EricGall23", SKIER
	db "z3bra@@@@@", POKEMANIAC
	db "Rangi@@@@@", BEAUTY
	db "SarnDev@@@", BOARDER
	db "Atma@@@@@@", COOLTRAINERF
	db "SatoMew@@@", BEAUTY
	db "SHF@@@@@@@", GRUNTM
	db "80c@@@@@@@", BURGLAR
	db "SS@@@@@@@@", BURGLAR
	assert_table_length BATTLETOWER_NUM_UNIQUE_TRAINERS
