	object_const_def
	const VICTORYROAD_SILVER
	const VICTORYROAD_POKE_BALL1
	const VICTORYROAD_POKE_BALL2
	const VICTORYROAD_POKE_BALL3
	const VICTORYROAD_POKE_BALL4
	const VICTORYROAD_POKE_BALL5
	const VICTORYROAD_MOLTRES

VictoryRoad_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_FINISHED

	def_callbacks

.DummyScene0:
	end

.DummyScene1:
	end

VictoryRoadRivalLeft:
	moveobject VICTORYROAD_SILVER, 18, 11
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	appear VICTORYROAD_SILVER
	applymovement VICTORYROAD_SILVER, VictoryRoadRivalBattleApproachMovement1
	scall VictoryRoadRivalNext
	applymovement VICTORYROAD_SILVER, VictoryRoadRivalBattleExitMovement1
	disappear VICTORYROAD_SILVER
	setscene SCENE_FINISHED
	playmapmusic
	end

VictoryRoadRivalRight:
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	appear VICTORYROAD_SILVER
	applymovement VICTORYROAD_SILVER, VictoryRoadRivalBattleApproachMovement2
	scall VictoryRoadRivalNext
	applymovement VICTORYROAD_SILVER, VictoryRoadRivalBattleExitMovement2
	disappear VICTORYROAD_SILVER
	setscene SCENE_FINISHED
	playmapmusic
	end

VictoryRoadRivalNext:
	turnobject PLAYER, DOWN
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext VictoryRoadRivalBeforeText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, VICTORYROAD_SILVER, 15
	special FadeOutMusic
	pause 15
	writetext VictoryRoadRivalEvolveText
	waitbutton
	closetext
	setevent EVENT_RIVAL_VICTORY_ROAD
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .GotTotodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .GotChikorita
	winlosstext VictoryRoadRivalDefeatText, VictoryRoadRivalVictoryText
	setlasttalked VICTORYROAD_SILVER
	loadtrainer RIVAL1, RIVAL1_5_TOTODILE
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_RIVAL1_5_TOTODILE
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_RIVAL1_5_TOTODILE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .AfterBattle

.GotTotodile:
	winlosstext VictoryRoadRivalDefeatText, VictoryRoadRivalVictoryText
	setlasttalked VICTORYROAD_SILVER
	loadtrainer RIVAL1, RIVAL1_5_CHIKORITA
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_RIVAL1_5_CHIKORITA
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_RIVAL1_5_CHIKORITA
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .AfterBattle

.GotChikorita:
	winlosstext VictoryRoadRivalDefeatText, VictoryRoadRivalVictoryText
	setlasttalked VICTORYROAD_SILVER
	loadtrainer RIVAL1, RIVAL1_5_CYNDAQUIL
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_RIVAL1_5_CYNDAQUIL
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_RIVAL1_5_CYNDAQUIL
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .AfterBattle

.AfterBattle:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext VictoryRoadRivalAfterText
	waitbutton
	closetext
	end

VictoryRoadTMEarthquake:
	itemball TM_EARTHQUAKE

VictoryRoadMaxRevive:
	itemball MAX_REVIVE

VictoryRoadFullRestore:
	itemball FULL_RESTORE

VictoryRoadFullHeal:
	itemball FULL_HEAL

VictoryRoadHPUp:
	itemball HP_UP

VictoryRoadHiddenMaxPotion:
	hiddenitem MAX_POTION, EVENT_VICTORY_ROAD_HIDDEN_MAX_POTION

VictoryRoadHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_VICTORY_ROAD_HIDDEN_FULL_HEAL

VictoryRoadRivalBattleApproachMovement1:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

VictoryRoadRivalBattleApproachMovement2:
	step UP
	step UP
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

VictoryRoadRivalBattleExitMovement1:
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

VictoryRoadRivalBattleExitMovement2:
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step_end

MoltresScript:
	opentext
	writetext MoltresBattleText
	cry MOLTRES
	waitbutton
	closetext
	loadwildmon MOLTRES, 60
	startbattle
	disappear VICTORYROAD_MOLTRES
	setevent EVENT_CAUGHT_MOLTRES
	reloadmapafterbattle
	end

MoltresBattleText:
	text "Gyaoo!"
	done

VictoryRoadRivalBeforeText:
	text "Hold it."

	para "…Are you going to"
	line "take the #MON"
	cont "LEAGUE challenge?"

	para "…Don't make me"
	line "laugh."

	para "You're so much"
	line "weaker than I am."

	para "Do you know"
	line "why that is?"
	
	para "Because I've"
	line "realized there is"

	para "more to #MON"
	line "than raw power."

	para "That dragon master"
	line "was right…"

	para "True strength can"
	line "only come through"
	cont "friendship."

	para "It's what the"
	line "elders in the"
	
	para "DRAGON'S DEN"
	line "said too."

	para "I need to care"
	line "for my team."
	
	para "They've been with"
	line "me through it all"
	
	para "and I have treated"
	line "them like pawns."
	
	para "But I promise!"
	line "I will care for"
	cont "all of you."
	
	para "Together, we"
	line "will become"
	cont "unstoppable."

	para "<PLAYER>!"
	line "I challenge you…"
	done
	
VictoryRoadRivalEvolveText:
	para ".....What?"
	line "PUPITAR?"
	
	para "............"
	line "............"
	
	para "My PUPITAR…"
	line "It's evolving?!"

VictoryRoadRivalDefeatText:
	para "We gave it every-"
	line "thing we had…"
	done

VictoryRoadRivalAfterText:
	para "My #MON"
	line "evolved early…"

	para "Perhaps it was"
	line "the ROCKETs"
	cont "radio signal?"

	para "Or some say that"
	line "through love,"
	
	para "the dragon"
	line "master was able"
	
	para "to do such a"
	line "thing too…"

	para "It matters not."

	para "I can't give up"
	line "on becoming the"
	cont "greatest trainer…"

	para "Not now."
	line "Not with this team."

	para "<PLAYER>!"
	line "We will return"
	cont "even stronger."

	para "When we do, we'll"
	line "challenge you."

	para "And we'll beat you"
	line "down with all our"
	cont "power."

	para "Come on, guys."
	line "Let's go."
	done

VictoryRoadRivalVictoryText:
	para "When it comes down"
	line "to it, nothing can"
	cont "beat friendhship."

	para "I don't need any-"
	line "thing else."
	done

VictoryRoad_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 67, VICTORY_ROAD_GATE, 5
	warp_event  1, 49, VICTORY_ROAD, 3
	warp_event  1, 35, VICTORY_ROAD, 2
	warp_event 13, 31, VICTORY_ROAD, 5
	warp_event 13, 17, VICTORY_ROAD, 4
	warp_event 17, 33, VICTORY_ROAD, 7
	warp_event 17, 19, VICTORY_ROAD, 6
	warp_event  0, 11, VICTORY_ROAD, 9
	warp_event  0, 27, VICTORY_ROAD, 8
	warp_event 13,  5, ROUTE_23, 3

	def_coord_events
	coord_event 12,  8, SCENE_DEFAULT, VictoryRoadRivalLeft
	coord_event 13,  8, SCENE_DEFAULT, VictoryRoadRivalRight

	def_bg_events
	bg_event  3, 29, BGEVENT_ITEM, VictoryRoadHiddenMaxPotion
	bg_event  3, 65, BGEVENT_ITEM, VictoryRoadHiddenFullHeal

	def_object_events
	object_event 18, 13, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_VICTORY_ROAD
	object_event  3, 28, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadTMEarthquake, EVENT_VICTORY_ROAD_TM_EARTHQUAKE
	object_event 12, 48, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadMaxRevive, EVENT_VICTORY_ROAD_MAX_REVIVE
	object_event 18, 29, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadFullRestore, EVENT_VICTORY_ROAD_FULL_RESTORE
	object_event 15, 48, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadFullHeal, EVENT_VICTORY_ROAD_FULL_HEAL
	object_event  7, 38, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadHPUp, EVENT_VICTORY_ROAD_HP_UP
	object_event 18, 32, SPRITE_MOLTRES_OVERWORLD, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MoltresScript, EVENT_CAUGHT_MOLTRES