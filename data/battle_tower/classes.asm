BattleTowerTrainers:
; The trainer class is not used in Crystal 1.0 due to a bug.
; Instead, the sixth character in the trainer's name is used.
; See BattleTowerText in engine/events/battle_tower/trainer_text.asm.
	; THIS IS FIXED!
	table_width (NAME_LENGTH - 1) + 1, BattleTowerTrainers
	; name, class
	db "HANSON@@@@", FISHER
	db "Tiberius@@", POKEMANIAC
	db "MASUDA@@@@", GUITARIST
	db "Karlos@@@@", SCIENTIST
	db "SoulXCross", TEACHER
	db "ZABOROWSKI", LASS
	db "Nift@@@@@@", BOARDER
	db "Sable@@@@@", HIKER
	db "Obelisk@@@", TEACHER
	db "Aero@@@@@@", COOLTRAINERM
	db "Disq@@@@@@", KIMONO_GIRL
	db "Joshua@@@@", OFFICER
	db "DIAZ@@@@@@", PICNICKER
	db "ERICKSON@@", BIKER
	db "Regi@@@@@@", JUGGLER
	db "Reader@@@@", POKEFANF
	db "HILL@@@@@@", FIREBREATHER
	db "Ha1fisch@@", SWIMMERM
	db "ZAAACH@@@@", SCHOOLBOY
	db "LANCASTER@", SKIER
	db "McMAHILL@@", CAMPER
	assert_table_length BATTLETOWER_NUM_UNIQUE_MON
; The following can only be sampled in Crystal 1.1.
	db "OBRIEN@@@@", GENTLEMAN
	db "FROST@@@@@", BEAUTY
	db "MORSE@@@@@", SUPER_NERD
	db "YUFUNE@@@@", BLACKBELT_T
	db "BICKETT@@@", POKEFANM
	db "RODRIGUEZ@", OFFICER
	db "SANTIAGO@@", PSYCHIC_T
	db "STOCK@@@@@", POKEFANM
	db "THURMAN@@@", SCIENTIST
	db "VALENTINO@", BEAUTY
	db "WAGNER@@@@", CAMPER
	db "YATES@@@@@", BIRD_KEEPER
	db "ANDREWS@@@", PICNICKER
	db "BAHN@@@@@@", POKEMANIAC
	db "MORI@@@@@@", SCIENTIST
	db "BUCKMAN@@@", SAGE
	db "KAUFMAN@@@", SWIMMERM
	db "HUGHES@@@@", FISHER
	db "ARITA@@@@@", KIMONO_GIRL
	db "EASTON@@@@", PSYCHIC_T
	db "FREEMAN@@@", CAMPER
	db "GIESE@@@@@", LASS
	db "HATCHER@@@", GENTLEMAN
	db "JACKSON@@@", POKEFANF
	db "KAHN@@@@@@", POKEMANIAC
	db "LEONG@@@@@", YOUNGSTER
	db "MARINO@@@@", TEACHER
	db "NEWMAN@@@@", SAILOR
	db "NGUYEN@@@@", BLACKBELT_T
	db "OGDEN@@@@@", SUPER_NERD
	db "PARK@@@@@@", COOLTRAINERF
	db "RAINE@@@@@", SWIMMERM
	db "SELLS@@@@@", BIRD_KEEPER
	db "WRIGHT@@@@", YOUNGSTER
	db "THORNTON@@", LASS
	db "CRAWFORD@@", BOARDER
	db "VAN DYKE@@", SKIER
	db "WALKER@@@@", SCHOOLBOY
	db "MEYER@@@@@", SWIMMERF
	db "JOHNSON@@@", YOUNGSTER
	db "ADAMS@@@@@", GUITARIST
	db "SMITH@@@@@", BUG_CATCHER
	db "TAJIRI@@@@", BUG_CATCHER
	db "BAKER@@@@@", POKEMANIAC
	db "COLLINS@@@", SCIENTIST
	db "SMART@@@@@", SUPER_NERD
	db "DYKSTRA@@@", SWIMMERF
	db "EATON@@@@@", BIKER
	db "WONG@@@@@@", FIREBREATHER
	assert_table_length BATTLETOWER_NUM_UNIQUE_TRAINERS
