	object_const_def
	const GOLDENRODMAGNETTRAINSTATION_OFFICER
	const GOLDENRODMAGNETTRAINSTATION_GENTLEMAN
	const GOLDENRODMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN

GoldenrodMagnetTrainStation_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EventDistributionManTuesdayCheck

.EventDistributionManTuesdayCheck:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse .ChecksFailed

	checktime DAY
	iffalse .ChecksFailed
	
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, .ChecksFailed

	checkevent EVENT_POKEDISTRIBUTIONMAN_RECEIVEDGIFT
	iftrue .ChecksFailed

	appear GOLDENRODMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN
	endcallback
.ChecksFailed:
	disappear GOLDENRODMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN
	endcallback

GoldenrodMagnetTrainStationOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .MagnetTrainToSaffron
	writetext GoldenrodMagnetTrainStationOfficerTheTrainHasntComeInText
	waitbutton
	closetext
	end

.MagnetTrainToSaffron:
	writetext GoldenrodMagnetTrainStationOfficerAreYouComingAboardText
	yesorno
	iffalse .DecidedNotToRide
	checkitem PASS
	iffalse .PassNotInBag
	writetext GoldenrodMagnetTrainStationOfficerRightThisWayText
	waitbutton
	closetext
	applymovement GOLDENRODMAGNETTRAINSTATION_OFFICER, GoldenrodMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, GoldenrodMagnetTrainStationPlayerApproachAndEnterTrainMovement
	setval FALSE
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
	writetext GoldenrodMagnetTrainStationOfficerYouDontHaveARailPassText
	waitbutton
	closetext
	end

.DecidedNotToRide:
	writetext GoldenrodMagnetTrainStationOfficerHopeToSeeYouAgainText
	waitbutton
	closetext
	end

Script_ArriveFromSaffron:
	applymovement GOLDENRODMAGNETTRAINSTATION_OFFICER, GoldenrodMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, GoldenrodMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement
	applymovement GOLDENRODMAGNETTRAINSTATION_OFFICER, GoldenrodMagnetTrainStationOfficerReturnToBoardingGateMovement
	opentext
	writetext GoldenrodMagnetTrainStationOfficerArrivedInGoldenrodText
	waitbutton
	closetext
	end

GoldenrodMagnetTrainStationGentlemanScript:
	jumptextfaceplayer GoldenrodMagnetTrainStationGentlemanText

GoldenrodMagnetTrainStationOfficerApproachTrainDoorMovement:
	step UP
	step UP
	step RIGHT
	turn_head LEFT
	step_end

GoldenrodMagnetTrainStationOfficerReturnToBoardingGateMovement:
	step LEFT
	step DOWN
	step DOWN
	step_end

GoldenrodMagnetTrainStationPlayerApproachAndEnterTrainMovement:
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

GoldenrodMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement:
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
	turnobject GOLDENRODMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN, RIGHT
	end

.FullParty:
	writetext DistributionManText_PartyFull
	waitbutton
	closetext
	turnobject GOLDENRODMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN, RIGHT
	end

.OutOfGifts:
	writetext DistributionManText_OutOfGifts
	waitbutton
	closetext
	readvar VAR_FACING
	ifequal UP, DistributionManLeavingJumpScriptLeft
	ifequal DOWN, DistributionManLeavingJumpScriptLeft
	ifequal RIGHT, DistributionManLeavingJumpScriptDown
	end

DistributionManLeavingJumpScriptLeft:
	applymovement GOLDENRODMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN, DistributionManLeavingMovementLeft
	applymovement GOLDENRODMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN, DistributionManLeavingMovementFinish
	disappear GOLDENRODMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN
	end

DistributionManLeavingMovementLeft:
; Player is either above or below the Distribution Man
	step LEFT
	step LEFT
	step LEFT
	step DOWN
	step_end

DistributionManLeavingJumpScriptDown:
	applymovement GOLDENRODMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN, DistributionManLeavingMovementDown
	applymovement GOLDENRODMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN, DistributionManLeavingMovementFinish
	disappear GOLDENRODMAGNETTRAINSTATION_EVENTDISTRIBUTIONMAN
	end

DistributionManLeavingMovementDown:
; Player is left of the Distribution Man
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step_end

DistributionManLeavingMovementFinish:
; Finish the movement
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

GoldenrodMagnetTrainStationOfficerTheTrainHasntComeInText:
	text "The train hasn't"
	line "come in…"

	para "I know! I'll carry"
	line "the passengers on"
	cont "my back!"

	para "That won't work."
	done

GoldenrodMagnetTrainStationOfficerAreYouComingAboardText:
	text "We'll soon depart"
	line "for SAFFRON."

	para "Are you coming"
	line "aboard?"
	done

GoldenrodMagnetTrainStationOfficerRightThisWayText:
	text "May I see your"
	line "rail PASS, please?"

	para "OK. Right this"
	line "way, please."
	done

GoldenrodMagnetTrainStationOfficerYouDontHaveARailPassText:
	text "Sorry. You don't"
	line "have a rail PASS."
	done

GoldenrodMagnetTrainStationOfficerHopeToSeeYouAgainText:
	text "We hope to see you"
	line "again!"
	done

GoldenrodMagnetTrainStationOfficerArrivedInGoldenrodText:
	text "We have arrived in"
	line "GOLDENROD."

	para "We hope to see you"
	line "again."
	done

GoldenrodMagnetTrainStationGentlemanText:
	text "I'm the PRESIDENT."

	para "My dream was to"
	line "build a train that"

	para "is faster than any"
	line "#MON."

	para "It really brings"
	line "JOHTO much closer"
	cont "to KANTO."
	done

DistributionManText_Introduction:
	text "STRANGE MAN: Hi!"
	
	para "I'm sorry to be"
	line "a bother. "
	
	para "I just arrived in"
	line "GOLDEN ROD, but I"
	cont "am a bit lost."

	para "Is ECRUTEAK CITY"
	line "north from here?"
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

GoldenrodMagnetTrainStation_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  8, 17, GOLDENROD_CITY, 5
	warp_event  9, 17, GOLDENROD_CITY, 5
	warp_event  6,  5, SAFFRON_MAGNET_TRAIN_STATION, 4
	warp_event 11,  5, SAFFRON_MAGNET_TRAIN_STATION, 3

	def_coord_events
	coord_event 11,  6, SCENE_DEFAULT, Script_ArriveFromSaffron

	def_bg_events

	def_object_events
	object_event  9,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodMagnetTrainStationOfficerScript, -1
	object_event 11, 14, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodMagnetTrainStationGentlemanScript, EVENT_GOLDENROD_TRAIN_STATION_GENTLEMAN
	object_event 12, 12, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DistributionManScript, EVENT_POKEDISTRIBUTIONMAN_TUESDAY
