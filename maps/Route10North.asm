	object_const_def
	const ROUTE_10_ZAPDOS

Route10North_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .Flypoint

.Flypoint:
	setflag ENGINE_FLYPOINT_ROCK_TUNNEL
	return

PowerPlantSign:
	jumptext PowerPlantSignText

Route10PokecenterSign:
	jumpstd PokecenterSignScript

ZapdosScript:
	faceplayer
	opentext
	writetext ZapdosBattleText
	cry ZAPDOS
	waitbutton
	closetext
	loadwildmon ZAPDOS, 60
	startbattle
	disappear ROUTE_10_ZAPDOS
	setevent EVENT_CAUGHT_ZAPDOS
	reloadmapafterbattle
	end

PowerPlantSignText:
	text "KANTO POWER PLANT"
	done

ZapdosBattleText:
	text "Gyaoo!"
	done

Route10North_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11,  1, ROUTE_10_POKECENTER_1F, 1
	warp_event  3,  9, POWER_PLANT, 1

	def_coord_events

	def_bg_events
	bg_event  5, 11, BGEVENT_READ, PowerPlantSign
	bg_event 12,  1, BGEVENT_READ, Route10PokecenterSign

	def_object_events
	object_event 4,  11, SPRITE_ZAPDOS_OVERWORLD, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ZapdosScript, EVENT_CAUGHT_ZAPDOS