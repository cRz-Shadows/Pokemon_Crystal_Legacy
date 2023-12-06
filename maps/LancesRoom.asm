	object_const_def
	const LANCESROOM_LANCE
	const LANCESROOM_MARY
	const LANCESROOM_OAK

LancesRoom_MapScripts:
	def_scene_scripts
	scene_script .LockDoor ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_LANCESROOM_APPROACH_LANCE

	def_callbacks
	callback MAPCALLBACK_TILES, .LancesRoomDoors

.LockDoor:
	sdefer .LancesDoorLocksBehindYou
	end

.DummyScene:
	end

.LancesRoomDoors:
	checkevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	iffalse .KeepEntranceOpen
	changeblock 4, 22, $34 ; wall
.KeepEntranceOpen:
	checkevent EVENT_LANCES_ROOM_EXIT_OPEN
	iffalse .KeepExitClosed
	changeblock 4, 0, $0b ; open door
.KeepExitClosed:
	endcallback

.LancesDoorLocksBehindYou:
	applymovement PLAYER, LancesRoom_EnterMovement
	refreshscreen $86
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 4, 22, $34 ; wall
	reloadmappart
	closetext
	setscene SCENE_LANCESROOM_APPROACH_LANCE
	setevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	end

Script_ApproachLanceFromLeft:
	special FadeOutMusic
	applymovement PLAYER, MovementData_ApproachLanceFromLeft
	sjump LancesRoomLanceScript

Script_ApproachLanceFromRight:
	special FadeOutMusic
	applymovement PLAYER, MovementData_ApproachLanceFromRight
LancesRoomLanceScript:
	turnobject LANCESROOM_LANCE, LEFT
	opentext
	
	readvar VAR_BADGES
	if_less_than 16, .OriginalText1
	writetext LanceRematchBattleIntroText
	sjump .EndText1
.OriginalText1
	writetext LanceBattleIntroText
.EndText1

	waitbutton
	closetext
	winlosstext LanceBattleWinText, 0
	setlasttalked LANCESROOM_LANCE
	readvar VAR_BADGES
	if_greater_than 15, .Rematch
	loadtrainer CHAMPION, LANCE
	sjump .LoadtrainerEnd
.Rematch:
	loadtrainer CHAMPION, 2
.LoadtrainerEnd:
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	readvar VAR_BADGES
	if_less_than 16, .NoRed
	setevent EVENT_ELITE_4_REMATCH
.NoRed
	
	checkflag ENGINE_HARD_MODE
	iffalse .DontUpdateBadge
	readvar VAR_BADGES
	if_less_than 9, .BaseCap
	if_not_equal 16, .DontUpdateBadge
	checkevent EVENT_CERULEAN_CAVE_B1F_MEWTWO
	iftrue .DontUpdateBadge
	loadmem wLevelCap, 77 ; update level cap for hard mode
	sjump .DontUpdateBadge
.BaseCap
	loadmem wLevelCap, 60 ; update level cap for hard mode
.DontUpdateBadge

	opentext
	writetext LanceBattleAfterText
	waitbutton
	closetext

; 	checkevent EVENT_BEAT_LANCE_FIRST_TIME
; 	iftrue .ZapdosAlreadyReleased
; 	setval ZAPDOS
;     special ShowPokedexEntry
; .ZapdosAlreadyReleased

	setevent EVENT_BEAT_LANCE_FIRST_TIME
	setevent EVENT_BEAT_CHAMPION_LANCE
	playsound SFX_ENTER_DOOR
	changeblock 4, 0, $0b ; open door
	reloadmappart
	closetext
	setevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	musicfadeout MUSIC_BEAUTY_ENCOUNTER, 16
	pause 30
	showemote EMOTE_SHOCK, LANCESROOM_LANCE, 15
	turnobject LANCESROOM_LANCE, DOWN
	pause 10
	turnobject PLAYER, DOWN
	appear LANCESROOM_MARY
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryRushesIn
	opentext
	writetext LancesRoomMaryOhNoOakText
	waitbutton
	closetext
	appear LANCESROOM_OAK
	applymovement LANCESROOM_OAK, LancesRoomMovementData_OakWalksIn
	follow LANCESROOM_MARY, LANCESROOM_OAK
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryYieldsToOak
	stopfollow
	turnobject LANCESROOM_OAK, UP
	turnobject LANCESROOM_LANCE, LEFT
	opentext

	readvar VAR_BADGES
	if_less_than 16, .OriginalText2
	writetext LancesRoomRematchOakCongratulationsText
	sjump .EndText2
.OriginalText2
	writetext LancesRoomOakCongratulationsText
.EndText2

	waitbutton
	closetext
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryInterviewChampion
	turnobject PLAYER, LEFT
	opentext

	readvar VAR_BADGES
	if_less_than 16, .OriginalText3
	writetext LancesRoomRematchMaryInterviewText
	sjump .EndText3
.OriginalText3
	writetext LancesRoomMaryInterviewText
.EndText3

	waitbutton
	closetext
	applymovement LANCESROOM_LANCE, LancesRoomMovementData_LancePositionsSelfToGuidePlayerAway
	turnobject PLAYER, UP
	opentext
	writetext LancesRoomNoisyText
	waitbutton
	closetext
	follow LANCESROOM_LANCE, PLAYER
	turnobject LANCESROOM_MARY, UP
	turnobject LANCESROOM_OAK, UP
	applymovement LANCESROOM_LANCE, LancesRoomMovementData_LanceLeadsPlayerToHallOfFame
	stopfollow
	playsound SFX_EXIT_BUILDING
	disappear LANCESROOM_LANCE
	applymovement PLAYER, LancesRoomMovementData_PlayerExits
	playsound SFX_EXIT_BUILDING
	disappear PLAYER
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryTriesToFollow
	showemote EMOTE_SHOCK, LANCESROOM_MARY, 15
	opentext

	readvar VAR_BADGES
	if_less_than 16, .OriginalText4
	writetext LancesRoomRematchMaryNoInterviewText
	sjump .EndText4
.OriginalText4
	writetext LancesRoomMaryNoInterviewText
.EndText4
	
	pause 30
	closetext
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryRunsBackAndForth
	special FadeOutPalettes
	pause 15
	warpfacing UP, HALL_OF_FAME, 4, 13
	end

LancesRoom_EnterMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

MovementData_ApproachLanceFromLeft:
	step UP
	step UP
	turn_head RIGHT
	step_end

MovementData_ApproachLanceFromRight:
	step UP
	step LEFT
	step UP
	turn_head RIGHT
	step_end

LancesRoomMovementData_MaryRushesIn:
	big_step UP
	big_step UP
	big_step UP
	turn_head DOWN
	step_end

LancesRoomMovementData_OakWalksIn:
	step UP
	step UP
	step_end

LancesRoomMovementData_MaryYieldsToOak:
	step LEFT
	turn_head RIGHT
	step_end

LancesRoomMovementData_MaryInterviewChampion:
	big_step UP
	turn_head RIGHT
	step_end

LancesRoomMovementData_LancePositionsSelfToGuidePlayerAway:
	step UP
	step LEFT
	turn_head DOWN
	step_end

LancesRoomMovementData_LanceLeadsPlayerToHallOfFame:
	step UP
	step_end

LancesRoomMovementData_PlayerExits:
	step UP
	step_end

LancesRoomMovementData_MaryTriesToFollow:
	step UP
	step RIGHT
	turn_head UP
	step_end

LancesRoomMovementData_MaryRunsBackAndForth:
	big_step RIGHT
	big_step RIGHT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step LEFT
	big_step LEFT
	turn_head UP
	step_end

LanceRematchBattleIntroText:
	text "LANCE: "
	line "Welcome back!"

    para "You've proven"
    line "yourself in JOHTO,"
	
	para "acquiring all 8"
    line "badges and even"
    cont "besting me once."

    para "But now, you're"
    line "in the big"
	cont "leagues."

	para "The KANTO LEAGUE!"
	
	para "A region with its"
    line "own trials and"
    cont "champions."
	
	para "Here, I am the"
    line "final challenge,"

    para "with a team "
    line "stronger than ever"
	cont "before."

    para "This is the true"
    line "test,"
	
	para "a battle to"
    line "determine the"
    cont "CHAMPION of KANTO."

    para "Are you ready to"
    line "rise to this new"
    cont "challenge?" 
	
	para "To prove yourself"
    line "once more?"

    para "Show me the"
    line "strength that"
	cont "conquered JOHTO,"
    cont "CHAMPION."
    done

LanceBattleIntroText:
	text "LANCE: I've been"
	line "waiting for you."

	para "<PLAY_G>!"

	para "I knew that you,"
	line "with your skills,"

	para "would eventually"
	line "reach me here."
	
	para "Three years ago"
	line "a trainer"
	
	para "just like you"
	line "stood before me."
	
	para "That trainer would"
	line "go on to become"
	
	para "the strongest in"
	line "both our regions."
	
	para "He has entrusted"
	line "me to uphold the"
	cont "LEAGUE, and to"
	
	para "take care of"
	line "the legendary"
	
	para "lightning bird,"
	line "ZAPDOS."

	para "There's no need"
	line "for any more"
	cont "words now."

	para "We will battle to"
	line "determine who is"

	para "the stronger of"
	line "the two of us."

	para "As the #MON"
	line "LEAGUE CHAMPION…"

	para "I, LANCE the drag-"
	line "on master, accept"
	cont "your challenge!"
	done

LanceBattleWinText:
	text "…It's over."

	para "But it's an odd"
	line "feeling."

	para "I'm not angry that"
	line "I lost. In fact, I"
	cont "feel happy."

	para "Happy that I"
	line "witnessed the rise"

	para "of a great new"
	line "CHAMPION!"
	done

LanceBattleAfterText:
	text "…Whew."

	para "You have become"
	line "truly powerful,"
	cont "<PLAY_G>."

	para "Your #MON have"
	line "responded to your"

	para "strong and up-"
	line "standing nature."

	para "As a trainer, you"
	line "will continue to"

	para "grow strong with"
	line "your #MON."
	done

LancesRoomMaryOhNoOakText:
	text "MARY: Oh, no!"
	line "It's all over!"

	para "PROF.OAK, if you"
	line "weren't so slow…"
	done

LancesRoomOakCongratulationsText:
	text "PROF.OAK: Ah,"
	line "<PLAY_G>!"

	para "It's been a long"
	line "while."

	para "You certainly look"
	line "more impressive."

	para "Your conquest of"
	line "the JOHTO LEAGUE"
	cont "is just fantastic!"

	para "Your dedication,"
	line "trust and love for"

	para "your #MON made"
	line "this happen."

	para "Your #MON were"
	line "outstanding too."

	para "Because they be-"
	line "lieved in you as a"

	para "trainer, they per-"
	line "severed."

	para "Congratulations,"
	line "<PLAY_G>!"
	done

LancesRoomRematchOakCongratulationsText:
	text "PROF.OAK: Ah,"
    line "<PLAY_G>!"

	para "I've been following"
    line "your progress"
    cont "since PROF."
    cont "ELM sent you on"
	cont "your way."

    para "You've certainly"
    line "become more"
	cont "impressive."

    para "Conquering both"
    line "the JOHTO and now"
    cont "the KANTO LEAGUE"
    cont "is no small feat."
	
	para "You've truly"
    line "outdone yourself!"

    para "It's clear that"
    line "your #MON trust"
    cont "you immensely,"
	
	para "and that trust has"
    line "been the"
    cont "foundation of your"
	cont "success."

    para "But remember, a"
    line "trainer's journey"
    cont "is never truly"
	cont "over."

    para "When you have a"
    line "moment, do visit"
    cont "me in my lab."
	
	para "There's something"
    line "I'd like to"
    cont "discuss with you."

    para "Congratulations on"
    line "your victory,"
	cont "<PLAY_G>!"
	done

LancesRoomMaryInterviewText:
	text "MARY: Let's inter-"
	line "view the brand new"
	cont "JOHTO CHAMPION!"
	done

LancesRoomRematchMaryInterviewText:
	text "MARY: Let's inter-"
	line "view the brand new"
	cont "KANTO CHAMPION!"
	done

LancesRoomNoisyText:
	text "LANCE: This is"
	line "getting to be a"
	cont "bit too noisy…"

	para "<PLAY_G>, could you"
	line "come with me?"
	done

LancesRoomMaryNoInterviewText:
	text "MARY: Oh, wait!"
	line "We haven't done"
	cont "the interview!"
	done

LancesRoomRematchMaryNoInterviewText:
	text "MARY: Come on!"
	line "You can't blow off"
	cont "the interview"
	cont "AGAIN!"
	done

LancesRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 23, KARENS_ROOM, 3
	warp_event  5, 23, KARENS_ROOM, 4
	warp_event  4,  1, HALL_OF_FAME, 1
	warp_event  5,  1, HALL_OF_FAME, 2

	def_coord_events
	coord_event  4,  5, SCENE_LANCESROOM_APPROACH_LANCE, Script_ApproachLanceFromLeft
	coord_event  5,  5, SCENE_LANCESROOM_APPROACH_LANCE, Script_ApproachLanceFromRight

	def_bg_events

	def_object_events
	object_event  5,  3, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LancesRoomLanceScript, -1
	object_event  4,  7, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LANCES_ROOM_OAK_AND_MARY
	object_event  4,  7, SPRITE_OAK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LANCES_ROOM_OAK_AND_MARY
