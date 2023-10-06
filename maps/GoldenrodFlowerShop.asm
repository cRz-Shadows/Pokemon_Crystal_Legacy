	object_const_def
	const GOLDENRODFLOWERSHOP_TEACHER
	const GOLDENRODFLOWERSHOP_FLORIA
	const GOLDENRODFLOWERSHOP_CLERK

GoldenrodFlowerShop_MapScripts:
	def_scene_scripts

	def_callbacks

FlowerShopTeacherScript:
	opentext
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue .SkipSquirtBottle
	checkflag ENGINE_PLAINBADGE
	iffalse .SkipSquirtBottle
	faceplayer
	writetext GoldenrodFlowerShopTeacherHeresTheSquirtbottleText
	promptbutton
	verbosegiveitem SQUIRTBOTTLE
	setevent EVENT_GOT_SQUIRTBOTTLE
.SkipSquirtBottle
	checkevent EVENT_MET_FLORIA
	iffalse .HaventMetFloria
	checkevent EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP
	iffalse .Lalala
	checkflag ENGINE_PLAINBADGE
	iffalse .NoPlainBadge
	checkevent EVENT_GOT_GOLD_BERRY_FROM_FLOWER_SHOP
	iftrue .GotReward
	faceplayer
	writetext GoldenrodFlowerShopTeacherHeresTheGoldBerryText
	promptbutton
	verbosegiveitem GOLD_BERRY
	setevent EVENT_GOT_GOLD_BERRY_FROM_FLOWER_SHOP
	setevent EVENT_FLORIA_AT_FLOWER_SHOP
	closetext
	end
	
.GotReward
	sjump .Lalala

.Lalala:
	turnobject GOLDENRODFLOWERSHOP_TEACHER, LEFT
	writetext GoldenrodFlowerShopTeacherLalalaHavePlentyOfWaterText
	waitbutton
	closetext
	end

.GotSquirtbottle:
	jumptextfaceplayer GoldenrodFlowerShopTeacherDontDoAnythingDangerousText

.NoPlainBadge:
	faceplayer
	writetext GoldenrodFlowerShopTeacherAskWantToBorrowWaterBottleText
	promptbutton
	checkevent EVENT_MET_FLORIA
	iffalse .HaventMetFloria
	closetext
	end

.HaventMetFloria:
	faceplayer
	writetext GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36Text
	waitbutton
	closetext
	end

FlowerShopFloriaScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP
	iffalse .TalkToFlorida
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .FoughtSudowoodo
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue .GotSquirtbottle
.TalkToFlorida
	writetext GoldenrodFlowerShopFloriaWonderIfSisWillLendWaterBottleText
	waitbutton
	setevent EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP
	closetext
	end

.GotSquirtbottle:
	writetext GoldenrodFlowerShopFloriaYouBeatWhitneyText
	waitbutton
	closetext
	end

.FoughtSudowoodo:
	writetext GoldenrodFlowerShopFloriaItReallyWasAMonText
	waitbutton
	closetext
	end

FlowerShopShelf1: ; unreferenced
	jumpstd PictureBookshelfScript

FlowerShopShelf2: ; unreferenced
	jumpstd MagazineBookshelfScript

FlowerShopRadio: ; unreferenced
	jumpstd Radio2Script

BerryMartScript:
	faceplayer
	opentext
	readvar VAR_BADGES
	if_less_than 7, .NotSevenBadges
	sjump .SevenBadges
.NotSevenBadges
	pokemart MARTTYPE_STANDARD, MART_BERRYS
	sjump .end
.SevenBadges
	pokemart MARTTYPE_STANDARD, MART_BERRYS_2
.end
	closetext
	end

GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36Text:
	text "Have you seen that"
	line "wiggly tree that's"

	para "growing on ROUTE"
	line "36?"

	para "My little sister"
	line "got all excited"

	para "and went to see"
	line "it…"

	para "I'm worried… Isn't"
	line "it dangerous?"
	done

GoldenrodFlowerShopTeacherAskWantToBorrowWaterBottleText:
	text "Do you want to"
	line "borrow the water"

	para "bottle too?"
	line "I don't want you"

	para "doing anything"
	line "dangerous with it."
	done

GoldenrodFlowerShopTeacherHeresTheSquirtbottleText:
	text "Oh, you're better"
	line "than WHITNEY…"

	para "You'll be OK,"
	line "then. Here's the"
	cont "SQUIRTBOTTLE!"
	done

GoldenrodFlowerShopTeacherHeresTheGoldBerryText:
	text "Oh, you"
	line "found FLORIA…"

	para "Here's a GOLD"
	line "BERRY as thanks!"
	done

GoldenrodFlowerShopTeacherDontDoAnythingDangerousText:
	text "Don't do anything"
	line "too dangerous!"
	done

GoldenrodFlowerShopTeacherLalalaHavePlentyOfWaterText:
	text "Lalala lalalala."
	line "Have plenty of"
	cont "water, my lovely!"
	done

GoldenrodFlowerShopFloriaWonderIfSisWillLendWaterBottleText:
	text "When I told my sis"
	line "about the jiggly"

	para "tree, she told me"
	line "it's dangerous."

	para "If I beat WHITNEY,"
	line "I wonder if she'll"

	para "lend me her water"
	line "bottle…"
	done

GoldenrodFlowerShopFloriaYouBeatWhitneyText:
	text "Wow, you beat"
	line "WHITNEY? Cool!"
	done

GoldenrodFlowerShopFloriaItReallyWasAMonText:
	text "So it really was a"
	line "#MON!"
	done

GoldenrodFlowerShop_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 6
	warp_event  3,  7, GOLDENROD_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FlowerShopTeacherScript, -1
	object_event  5,  6, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FlowerShopFloriaScript, EVENT_FLORIA_AT_FLOWER_SHOP
	object_event  5,  3, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BerryMartScript, -1
