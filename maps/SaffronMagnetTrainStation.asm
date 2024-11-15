	object_const_def
	const SAFFRONMAGNETTRAINSTATION_OFFICER
	const SAFFRONMAGNETTRAINSTATION_GYM_GUIDE
	const SAFFRONMAGNETTRAINSTATION_TEACHER
	const SAFFRONMAGNETTRAINSTATION_LASS
	const SAFFRONMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN

SaffronMagnetTrainStation_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EventDistributionManTuesdayCheck

.EventDistributionManTuesdayCheck:
	checkevent EVENT_DEFEATED_RED
	iffalse .ChecksFailed

	checktime DAY
	iffalse .ChecksFailed
	
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, .ChecksFailed

	checkevent EVENT_POKEDISTRIBUTIONMAN_RECEIVEDGIFT
	iftrue .ChecksFailed

	appear SAFFRONMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN
	endcallback
.ChecksFailed:
	disappear SAFFRONMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN
	endcallback

SaffronMagnetTrainStationOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .MagnetTrainToGoldenrod
	writetext SaffronMagnetTrainStationOfficerTrainIsntOperatingText
	waitbutton
	closetext
	end

.MagnetTrainToGoldenrod:
	writetext SaffronMagnetTrainStationOfficerAreYouComingOnBoardText
	yesorno
	iffalse .DecidedNotToRide
	checkitem PASS
	iffalse .PassNotInBag
	writetext SaffronMagnetTrainStationOfficerRightThisWayText
	waitbutton
	closetext
	applymovement SAFFRONMAGNETTRAINSTATION_OFFICER, SaffronMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, SaffronMagnetTrainStationPlayerApproachAndEnterTrainMovement
	setval TRUE
	special MagnetTrain
	warpcheck
	newloadmap MAPSETUP_TRAIN
	applymovement PLAYER, .MovementBoardTheTrain
	wait 20
	end

.MovementBoardTheTrain:
	turn_head DOWN
	step_end

.PassNotInBag:
	writetext SaffronMagnetTrainStationOfficerYouDontHaveAPassText
	waitbutton
	closetext
	end

.DecidedNotToRide:
	writetext SaffronMagnetTrainStationOfficerHopeToSeeYouAgainText
	waitbutton
	closetext
	end

Script_ArriveFromGoldenrod:
	applymovement SAFFRONMAGNETTRAINSTATION_OFFICER, SaffronMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, SaffronMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement
	applymovement SAFFRONMAGNETTRAINSTATION_OFFICER, SaffronMagnetTrainStationOfficerReturnToBoardingGateMovement
	opentext
	writetext SaffronMagnetTrainStationOfficerArrivedInSaffronText
	waitbutton
	closetext
	end

SaffronMagnetTrainStationGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext SaffronMagnetTrainStationGymGuideText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext SaffronMagnetTrainStationGymGuideText_ReturnedMachinePart
	waitbutton
	closetext
	end

SaffronMagnetTrainStationTeacherScript:
	jumptextfaceplayer SaffronMagnetTrainStationTeacherText

SaffronMagnetTrainStationLassScript:
	jumptextfaceplayer SaffronMagnetTrainStationLassText

SaffronMagnetTrainStationOfficerApproachTrainDoorMovement:
	step UP
	step UP
	step RIGHT
	turn_head LEFT
	step_end

SaffronMagnetTrainStationOfficerReturnToBoardingGateMovement:
	step LEFT
	step DOWN
	step DOWN
	step_end

SaffronMagnetTrainStationPlayerApproachAndEnterTrainMovement:
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

SaffronMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement:
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	turn_head UP
	step_end

DistributionManScript:
	faceplayer
	opentext
	checkevent EVENT_POKEDISTRIBUTIONMAN_METNPC
	iffalse .DistributionManIntroduction
	
	checkevent EVENT_POKEDISTRIBUTIONMAN_RECEIVEDGIFT
	iftrue .OutOfGifts

	writetext DistributionManText_NewGift
	promptbutton
	sjump .GiftingPlayer

.DistributionManIntroduction:
	writetext DistributionManText_Introduction
	yesorno
	iffalse .IncorrectDirection
	setevent EVENT_POKEDISTRIBUTIONMAN_METNPC
	writetext DistributionManText_CorrectDirections
	promptbutton

.GiftingPlayer:
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .FullParty
	waitsfx
	writetext DistributionManText_GiftGot
	playsound SFX_CAUGHT_MON
	waitsfx
	callasm GiveEventDistribution
	setevent EVENT_POKEDISTRIBUTIONMAN_RECEIVEDGIFT
	sjump .OutOfGifts

.IncorrectDirection:
	writetext DistributionManText_IncorrectDirections
	waitbutton
	closetext
	turnobject SAFFRONMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN, RIGHT
	end

.FullParty:
	writetext DistributionManText_PartyFull
	waitbutton
	closetext
	turnobject SAFFRONMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN, RIGHT
	end

.OutOfGifts:
	writetext DistributionManText_OutOfGifts
	waitbutton
	closetext
	readvar VAR_FACING
	ifequal UP, DistributionManLeavingJumpScriptRight
	sjump DistributionManLeavingJumpScriptDown

DistributionManLeavingJumpScriptRight:
	applymovement SAFFRONMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN, DistributionManLeavingMovementRight
	applymovement SAFFRONMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN, DistributionManLeavingMovementFinish
	disappear SAFFRONMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN
	end

DistributionManLeavingMovementRight:
; Player below the Distribution Man
	step RIGHT
	step_end

DistributionManLeavingJumpScriptDown:
	applymovement SAFFRONMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN, DistributionManLeavingMovementFinish
	disappear SAFFRONMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN
	end

DistributionManLeavingMovementFinish:
; Finish the movement
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

SaffronMagnetTrainStationOfficerTrainIsntOperatingText:
	text "I'm sorry, but the"
	line "MAGNET TRAIN isn't"
	cont "operating now."
	done

SaffronMagnetTrainStationOfficerAreYouComingOnBoardText:
	text "We'll soon depart"
	line "for GOLDENROD."

	para "Are you coming on"
	line "board?"
	done

SaffronMagnetTrainStationOfficerRightThisWayText:
	text "May I see your"
	line "rail PASS, please?"

	para "OK. Right this"
	line "way, please."
	done

SaffronMagnetTrainStationOfficerYouDontHaveAPassText:
	text "Sorry, but you"
	line "don't have a PASS."
	done

SaffronMagnetTrainStationOfficerHopeToSeeYouAgainText:
	text "We hope to see you"
	line "again."
	done

SaffronMagnetTrainStationOfficerArrivedInSaffronText:
	text "We have arrived in"
	line "SAFFRON."

	para "We hope to see you"
	line "again."
	done

SaffronMagnetTrainStationGymGuideText:
	text "The MAGNET TRAIN"
	line "is a super-modern"

	para "rail liner that"
	line "uses electricity"

	para "and magnets to"
	line "attain incredible"
	cont "speed."

	para "However, if there"
	line "isn't any elec-"
	cont "tricity…"
	done

SaffronMagnetTrainStationGymGuideText_ReturnedMachinePart:
	text "Whew…"

	para "How many times"
	line "have I gone back"

	para "and forth between"
	line "KANTO and JOHTO?"
	done

SaffronMagnetTrainStationTeacherText:
	text "Before the MAGNET"
	line "TRAIN STATION was"

	para "built, there was a"
	line "house there."

	para "A little girl"
	line "named COPYCAT used"
	cont "to live there."
	done

SaffronMagnetTrainStationLassText:
	text "Hi. Do you have a"
	line "rail PASS? I have"

	para "one. All the peo-"
	line "ple in SAFFRON who"

	para "ride the MAGNET"
	line "TRAIN have PASSES."
	done

DistributionManText_Introduction:
	text "STRANGE MAN: Hi!"
	
	para "I'm sorry to be"
	line "a bother. "
	
	para "I just arrived in"
	line "GOLDEN ROD, but I"
	cont "am a bit lost."

	para "Is VERMILION CITY"
	line "south from here?"
	done
	
DistributionManText_CorrectDirections:
	text "Ah, of course!"
	line "Thank you for your"
	cont "help!"

	para "My name's CLIFF"
	line "by the way."
	
	para "CLIFF: I work for"
	line "a #CENTER far"
	cont "away from here."

	para "I've got just the"
	line "right gift for you"
	cont "as thanks!"
	done

DistributionManText_IncorrectDirections:
	text "Hmm, that doesn't"
	line "sound right."
	done

DistributionManText_NewGift:
	text "CLIFF: I'm back"
	line "from the #-"
	cont "CENTER far away."

	para "I've got something"
	line "new for you!"
	done

DistributionManText_OutOfGifts:
	text "Thank you again!"
	line "I better be off"
	cont "now."

	para "I'll be back next"
	line "TUESDAY, so make"
	cont "sure pass by!"
	done

DistributionManText_GiftGot:
	text "<PLAYER> received"
	line "#CENTER gift!"
	done

DistributionManText_PartyFull:
	text "It looks like your"
	line "party's full."
	
	para "Go make space for"
	line "for one more"
	cont "#MON."
	done

SaffronMagnetTrainStation_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  8, 17, SAFFRON_CITY, 6
	warp_event  9, 17, SAFFRON_CITY, 6
	warp_event  6,  5, GOLDENROD_MAGNET_TRAIN_STATION, 4
	warp_event 11,  5, GOLDENROD_MAGNET_TRAIN_STATION, 3

	def_coord_events
	coord_event 11,  6, SCENE_DEFAULT, Script_ArriveFromGoldenrod

	def_bg_events

	def_object_events
	object_event  9,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationOfficerScript, -1
	object_event 10, 14, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationGymGuideScript, -1
	object_event  6, 11, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationTeacherScript, EVENT_SAFFRON_TRAIN_STATION_POPULATION
	object_event  6, 10, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationLassScript, EVENT_SAFFRON_TRAIN_STATION_POPULATION
	object_event 8, 12, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DistributionManScript, EVENT_POKEDISTRIBUTIONMAN_TUESDAY
