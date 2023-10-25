	object_const_def
	const SILVERCAVEROOM3_RED
	const CERULEANCAVEB1F_MEWTWO

SilverCaveRoom3_MapScripts:
	def_scene_scripts

	def_callbacks

Red:
	special FadeOutMusic
	faceplayer

	checkevent EVENT_CERULEAN_CAVE_B1F_MEWTWO
	iftrue .rematch

	checkevent EVENT_DEFEATED_RED
	iftrue .defeated

.rematch
	opentext
	writetext RedSeenText
	waitbutton
	closetext
	winlosstext RedWinLossText, RedWinLossText
	checkevent EVENT_CERULEAN_CAVE_B1F_MEWTWO ; if rematch
	iftrue .rematchteam ; skip loading base team
	loadtrainer RED, RED1
	sjump .EndLoadTrainerRed
.rematchteam
	loadtrainer RED, 2
.EndLoadTrainerRed
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special FadeOutMusic
	opentext
	writetext RedLeavesText
	waitbutton
	closetext
	setevent EVENT_DEFEATED_RED
	checkevent EVENT_CERULEAN_CAVE_B1F_MEWTWO
	iftrue .RematchCredits
.defeated
	pause 30
	appear CERULEANCAVEB1F_MEWTWO
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	applymovement CERULEANCAVEB1F_MEWTWO, MewtwoMovemenetScript
	applymovement SILVERCAVEROOM3_RED, RedMovemenetScript
	disappear SILVERCAVEROOM3_RED
	special HealParty
	special FadeInQuickly
	clearevent EVENT_RED_IN_MT_SILVER
	end
.RematchCredits
	pause 30
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	disappear SILVERCAVEROOM3_RED
	pause 15
	special FadeInQuickly
	pause 30
	special HealParty
	refreshscreen
	credits
	end

MewtwoScript:
	checkevent EVENT_DEFEATED_RED
	iffalse .notfoughtred
	opentext
	writetext MewtwoBattleText
	cry MEWTWO
	waitbutton
	closetext
	loadwildmon MEWTWO, 75
	startbattle
	disappear SILVERCAVEROOM3_RED
	disappear CERULEANCAVEB1F_MEWTWO
	setevent EVENT_RED_IN_MT_SILVER
	setevent EVENT_CERULEAN_CAVE_B1F_MEWTWO
	reloadmapafterbattle
	credits
	end
.notfoughtred
	opentext
	writetext MewtwoBattleText
	waitbutton
	closetext
	end

MewtwoMovemenetScript:
	fast_jump_step DOWN
	fast_jump_step DOWN
	fast_jump_step DOWN
	step DOWN
	step_end

RedMovemenetScript:
	fast_jump_step UP
	fast_jump_step UP
	fast_jump_step UP
	step UP
	step_end

MewtwoBattleText:
	text "Mew!"
	done

RedSeenText:
	text "<……>"
	line "<……>"
	done

RedWinLossText:
	text "…"
	done

RedLeavesText:
	text "<……>"
	line "<……>"
	done

SilverCaveRoom3_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 33, SILVER_CAVE_ROOM_2, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9, 10, SPRITE_RED, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Red, EVENT_RED_IN_MT_SILVER
	object_event  9, 3, SPRITE_MEWTWO, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, MewtwoScript, EVENT_CERULEAN_CAVE_B1F_MEWTWO