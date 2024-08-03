casinomon: MACRO
; species, coins needed
	db \1
	dw \2
ENDM

specialencounter: MACRO
; requested mon, offered mon, item, OT ID, OT name, gender requested
	db \1
	dw \2
	map_id \3
	dw \4
ENDM

CasinoMons::
; usually 3 per region, but not a hard coded limit
	; region map ; 2 bytes (group/ID)
	; species, coins (2 bytes)

	; johto, from maps\goldenrodgamecorner.asm
	map_id GOLDENROD_GAME_CORNER
	casinomon ABRA, GOLDENRODGAMECORNER_ABRA_COINS
	casinomon PORYGON, GOLDENRODGAMECORNER_CUBONE_COINS
	casinomon DRATINI, GOLDENRODGAMECORNER_WOBBUFFET_COINS 
	db -1
	; kanto, from maps\celadongamecornerprizeroom.asm
	map_id CELADON_GAME_CORNER_PRIZE_ROOM
	casinomon PIKACHU, CELADONGAMECORNERPRIZEROOM_PIKACHU_COINS 
	casinomon PORYGON, CELADONGAMECORNERPRIZEROOM_PORYGON_COINS 
	casinomon LARVITAR, CELADONGAMECORNERPRIZEROOM_LARVITAR_COINS 
	db -1

NPCTradeMons_Locations::
; corresponds to NPCTrades:: in data\events\npc_trades.asm
	table_width 2 ; map is 2 bytes
	map_id GOLDENROD_DEPT_STORE_5F 	; MAPGROUP_GOLDENROD, 	MAP_GOLDENROD_DEPT_STORE_5F
	map_id VIOLET_KYLES_HOUSE		; MAPGROUP_VIOLET, 		MAP_VIOLET_KYLES_HOUSE
	map_id OLIVINE_TIMS_HOUSE 		; MAPGROUP_OLIVINE, 	MAP_OLIVINE_TIMS_HOUSE 
	map_id BLACKTHORN_EMYS_HOUSE 	; MAPGROUP_BLACKTHORN, 	MAP_BLACKTHORN_EMYS_HOUSE
	map_id PEWTER_POKECENTER_1F 	; MAPGROUP_PEWTER, 		MAP_PEWTER_POKECENTER_1F
	map_id ROUTE_14 				; MAPGROUP_FUCHSIA, 	MAP_ROUTE_14
	map_id POWER_PLANT 				; MAPGROUP_CERULEAN, 	MAP_POWER_PLANT
	assert_table_length NUM_NPC_TRADES

EventWildMons::
; BROKEN: ; replace map_id with -1 to hide location but keep hint
; specialencounter 	 SPECIES,   EVENT_FLAG,                         map_id, blurb string ptr
	specialencounter LAPRAS, 	-1, 								UNION_CAVE_B2F, FridayLapras_Str ; reoccurs every Friday
	specialencounter ELECTRODE, -1, 								TEAM_ROCKET_BASE_B2F, Trap_Electrode_Str
	specialencounter SUDOWOODO, EVENT_FOUGHT_SUDOWOODO, 			ROUTE_36, SudowoodoEvent_Str
	specialencounter GYARADOS, 	EVENT_LAKE_OF_RAGE_RED_GYARADOS, 	LAKE_OF_RAGE, ShinyGyarados_Str
	specialencounter SNORLAX, 	EVENT_FOUGHT_SNORLAX, 				VERMILION_CITY, SnorlaxEvent_Str
	specialencounter SUICUNE,	EVENT_FOUGHT_SUICUNE, 				TIN_TOWER_1F, SuicuneEvent_Str ; will not normally be seen by player w/o Dex Splash Page, may need new EVENT constant
	specialencounter CELEBI, 	EVENT_CELEBI_FATEFUL_ENCOUNTER, 	ILEX_FOREST, CelebiEvent_Str ; will not normally be seen by player w/o Dex Splash Page, may need new EVENT constant
	specialencounter LUGIA, 	EVENT_FOUGHT_LUGIA, 				WHIRL_ISLAND_LUGIA_CHAMBER, LugiaEvent_Str ; will not normally be seen by player w/o Dex Splash Page, may need new EVENT constant
	specialencounter HO_OH, 	EVENT_FOUGHT_HO_OH,  				TIN_TOWER_ROOF, HoOhEvent_Str ; will not normally be seen by player w/o Dex Splash Page, may need new EVENT constant
	specialencounter ARTICUNO, 	EVENT_CAUGHT_ARTICUNO, 				ROUTE_20, ArticunoEvent_Str ; will not normally be seen by player w/o Dex Splash Page, may need new EVENT constant
	specialencounter ZAPDOS, 	EVENT_CAUGHT_ZAPDOS, 				ROUTE_10_NORTH, ZapdosEvent_Str ; will not normally be seen by player w/o Dex Splash Page, may need new EVENT constant
	specialencounter MOLTRES, 	EVENT_CAUGHT_MOLTRES, 				VICTORY_ROAD, MoltresEvent_Str ; will not normally be seen by player w/o Dex Splash Page, may need new EVENT constant
	specialencounter MEWTWO, 	EVENT_CERULEAN_CAVE_B1F_MEWTWO, 	SILVER_CAVE_ROOM_3, MewtwoEvent_Str ; will not normally be seen by player w/o Dex Splash Page, may need new EVENT constant
	specialencounter MEW, 		EVENT_ROUTE_24_MEW_CAUGHT, 			ROUTE_24, MewEvent_Str ; will not normally be seen by player w/o Dex Splash Page, may need new EVENT constant
	db -1

; LoadWildMon Dex Hints, max 18 chars per line
FridayLapras_Str:
	db 	 "Appears every"
	next "FRIDAY, lonely in"
	next "hidden sea cave.@"
Trap_Electrode_Str:
	db 	 "CAUTION:"
	next "Can be disguised"
	next "as an item.@"	
SudowoodoEvent_Str:
	db 	 "Unassuming fake"
	next "tree. Vengeful if"
	next "watered. LVL 20.@"
ShinyGyarados_Str:
	db 	 "Unique rampaging"
	next "Red GYARADOS."
	next "LVL 30.@"
SnorlaxEvent_Str:
	db 	 "Guaranteed to be"
	next "holding LEFTOVERS."
	next "LVL 40.@"
SuicuneEvent_Str:
	db 	 "CLEAR BELL is the"
	next "key to the hunt."
	next "LVL 40.@"
CelebiEvent_Str:
	db 	 "GS BALL, deeply"
	next "buried in RUINS."
	next "Offer to SHRINE.@"
LugiaEvent_Str:
	db 	 "SILVER WING, dull"
	next "PEWTER sheen. Mis-"
	next "placed as memento.@"
HoOhEvent_Str:
	db 	 "RAINBOW WING best-"
	next "owed to Trainers"
	next "after FOUR trials.@"
ArticunoEvent_Str:
	db 	 "Waiting surrounded"
	next "by waves."
	next "LVL 60.@"
ZapdosEvent_Str:
	db 	 "Waiting above"
	next "electric renewal."
	next "LVL 60.@"
MoltresEvent_Str:
	db 	 "Waiting in the"
	next "long dark of"
	next "VICTORY. LVL 60.@"
MewtwoEvent_Str:
	db 	 "Not CERULEAN, but"
	next "RED and SILVER"
	next "ice. LVL 75.@"
MewEvent_Str:
	db 	 "Meet at nugget"
	next "bridge, with 251."
	next "LVL 60.@"

GiftMons::
; replace map_id with -1 to hide location but keep hint
; species, EVENT_FLAG, map_id, blurb string ptr
	specialencounter SHUCKLE, 	EVENT_MANIA_TOOK_SHUCKIE_OR_LET_YOU_KEEP_HIM, MANIAS_HOUSE, ShuckieEvent_Str ; EVENT_GOT_SHUCKIE / EVENT_MANIA_TOOK_SHUCKIE_OR_LET_YOU_KEEP_HIM
	specialencounter SPEAROW, 	EVENT_GOT_KENYA, 					ROUTE_35_GOLDENROD_GATE, KenyaEvent_Str
	specialencounter DRATINI, 	EVENT_GOT_DRATINI, 					DRAGON_SHRINE, ExtremespeedDratini_Str
	specialencounter EEVEE,	 	EVENT_GOT_EEVEE, 					BILLS_FAMILYS_HOUSE, BillsEevee_Str
	specialencounter TYROGUE, 	EVENT_GOT_TYROGUE_FROM_KIYO, 		MOUNT_MORTAR_1F_OUTSIDE, TyrogueEvent_Str
	specialencounter AERODACTYL,EVENT_GAVE_SCIENTIST_OLD_AMBER, 	RUINS_OF_ALPH_RESEARCH_CENTER, OldAmberEvent_Str
	specialencounter KABUTO, 	EVENT_GAVE_SCIENTIST_DOME_FOSSIL, 	RUINS_OF_ALPH_RESEARCH_CENTER, DomeFossil_Str
	specialencounter OMANYTE, 	EVENT_GAVE_SCIENTIST_HELIX_FOSSIL, 	RUINS_OF_ALPH_RESEARCH_CENTER, HelixFossil_Str
	db -1

; GivePoke Dex Hints, max 18 chars per line
ShuckieEvent_Str:
	db 	 "Happiness over 150"
	next "may inspire change"
	next "of heart, forever.@"
KenyaEvent_Str:
	db 	 "Scrappy birb"
	next "carrying mail"
	next "for ROUTE 31.@"
ExtremespeedDratini_Str:
	db 	 "EXTREMESPEED is"
	next "rewarded as a true"
	next "virtue reflection.@"
BillsEevee_Str:
	db 	 "LVL 20 - Cute"
	next "baby with un-"
	next "limited potential.@"
TyrogueEvent_Str:
	db 	 "Gift from KIYO,"
	next "Karate Expert."
	next "@"
OldAmberEvent_Str:
	db 	 "Solve mysterious"
	next "ruins puzzle, then"
	next "revive fossil.@"
DomeFossil_Str:
	db 	 "Solve mysterious"
	next "ruins puzzle, then"
	next "revive fossil.@"
HelixFossil_Str:
	db 	 "Solve mysterious"
	next "ruins puzzle, then"
	next "revive fossil.@"