; @towersvault note
; Since the distribution gifts changed from time to time on
; the dates distributions were done, I've opted to rather
; just add all the Pokemon in a list here as opposed to
; mapping each tiny change such as when OT ID's would change.
; The primary reason for this decision is to save space.
;
; Data from
; https://bulbapedia.bulbagarden.net/wiki/List_of_PCNY_event_Pok%C3%A9mon_distributions_in_Generation_II
;
; A special thanks is also made out to Gridelin from Project Pokemon,
; Julie and Grace from Pokemon Center New York's Historical Archive,
; and any others that have contributed to cataloging all the Gen II
; Pokemon Distribution Events

DEF PCNY_OT_ID EQU 10020
PCNYOTTrainerName:
    db "PCNYdst@"

DEF DISTRIBUTION_GIFT_VALUES EQU 8

; \1: Pokemon
; \2: Egg Status
; \3: Level
; \4: Shiny Chance
; \5: Move 1 (Optional)
; \6: Move 2 (Optional)
; \7: Move 3 (Optional)
; \8: Move 4 (Optional)
distributionGift: MACRO
    db \1, \2, \3, \4, \5, \6, \7, \8
ENDM

DistributionGifts:
    table_width DISTRIBUTION_GIFT_VALUES, DistributionGifts
; Johto Legendary
    distributionGift RAIKOU,        NOT_EGG, 40, 100,       LEER, THUNDERSHOCK, ROAR, QUICK_ATTACK
    distributionGift ENTEI,         NOT_EGG, 40, 100,       LEER, EMBER, ROAR, FIRE_SPIN
    distributionGift SUICUNE,       NOT_EGG, 40, 100,       LEER, WATER_GUN, ROAR, GUST
    distributionGift HO_OH,         NOT_EGG, 40, 100,       SACRED_FIRE, SAFEGUARD, GUST, RECOVER
    distributionGift LUGIA,         NOT_EGG, 40, 100,       AEROBLAST, SAFEGUARD, GUST, RECOVER
; Legendary Birds
    distributionGift ARTICUNO,      NOT_EGG, 50, 100,       MIST, AGILITY, MIND_READER, ICE_BEAM
    distributionGift ZAPDOS,        NOT_EGG, 50, 100,       THUNDER_WAVE, AGILITY, DETECT, DRILL_PECK
    distributionGift MOLTRES,       NOT_EGG, 50, 100,       FIRE_SPIN, AGILITY, ENDURE, FLAMETHROWER
; Christmas Week
    distributionGift DELIBIRD,      IS_EGG, EGG_LEVEL, 25,  PRESENT, PAY_DAY, 0, 0
; The Initial Three
    distributionGift BULBASAUR,     IS_EGG, EGG_LEVEL, 25,  TACKLE, GROWL, ANCIENTPOWER, 0
    distributionGift CHARMANDER,    IS_EGG, EGG_LEVEL, 25,  SCRATCH, GROWL, CRUNCH, 0
    distributionGift SQUIRTLE,      IS_EGG, EGG_LEVEL, 25,  TACKLE, TAIL_WHIP, ZAP_CANNON, 0
    distributionGift CHIKORITA,     IS_EGG, EGG_LEVEL, 25,  TACKLE, GROWL, PETAL_DANCE, 0
    distributionGift CYNDAQUIL,     IS_EGG, EGG_LEVEL, 25,  TACKLE, LEER, DOUBLE_EDGE, 0
    distributionGift TOTODILE,      IS_EGG, EGG_LEVEL, 25,  SCRATCH, LEER, SUBMISSION, 0
; Valentine Week
    distributionGift NIDORAN_F,     IS_EGG, EGG_LEVEL, 25,  GROWL, TACKLE, LOVELY_KISS, 0
    distributionGift NIDORAN_F,     IS_EGG, EGG_LEVEL, 25,  GROWL, TACKLE, SWEET_KISS, 0
    distributionGift NIDORAN_M,     IS_EGG, EGG_LEVEL, 25,  LEER, TACKLE, LOVELY_KISS, 0
    distributionGift NIDORAN_M,     IS_EGG, EGG_LEVEL, 25,  LEER, TACKLE, SWEET_KISS, 0
    distributionGift BELLSPROUT,    IS_EGG, EGG_LEVEL, 25,  VINE_WHIP, LOVELY_KISS, 0, 0
    distributionGift BELLSPROUT,    IS_EGG, EGG_LEVEL, 25,  VINE_WHIP, SWEET_KISS, 0, 0
    distributionGift POLIWAG,       IS_EGG, EGG_LEVEL, 25,  BUBBLE, LOVELY_KISS, 0, 0
    distributionGift POLIWAG,       IS_EGG, EGG_LEVEL, 25,  BUBBLE, SWEET_KISS, 0, 0
    distributionGift SNORLAX,       IS_EGG, EGG_LEVEL, 25,  TACKLE, LOVELY_KISS, 0, 0
    distributionGift SNORLAX,       IS_EGG, EGG_LEVEL, 25,  TACKLE, SWEET_KISS, 0, 0
; Swarm Week
    distributionGift MARILL,        IS_EGG, EGG_LEVEL, 25,  TACKLE, DEFENSE_CURL, HYDRO_PUMP, 0
    distributionGift YANMA,         IS_EGG, EGG_LEVEL, 25,  TACKLE, FORESIGHT, STEEL_WING, 0
    distributionGift DUNSPARCE,     IS_EGG, EGG_LEVEL, 25,  RAGE, DEFENSE_CURL, HORN_DRILL, 0
    distributionGift SNUBBULL,      IS_EGG, EGG_LEVEL, 25,  TACKLE, SCARY_FACE, TAIL_WHIP, LOVELY_KISS
    distributionGift QWILFISH,      IS_EGG, EGG_LEVEL, 25,  TACKLE, POISON_STING, DOUBLE_EDGE, 0
    distributionGift REMORAID,      IS_EGG, EGG_LEVEL, 25,  WATER_GUN, AMNESIA, 0, 0
; Kanto Initial Three
    distributionGift VENUSAUR,      NOT_EGG, 40, 100,       POISONPOWDER, SLEEP_POWDER, RAZOR_LEAF, SWEET_SCENT
    distributionGift CHARIZARD,     NOT_EGG, 40, 100,       RAGE, SCARY_FACE, FLAMETHROWER, WING_ATTACK
    distributionGift BLASTOISE,     NOT_EGG, 40, 100,       WATER_GUN, BITE, RAPID_SPIN, PROTECT
    distributionGift MEWTWO,        NOT_EGG, 70, 100,       PSYCH_UP, FUTURE_SIGHT, MIST, PSYCHIC_M
; Babies Week
    distributionGift PICHU,         IS_EGG, EGG_LEVEL, 25,  THUNDERSHOCK, CHARM, SING, 0
    distributionGift CLEFFA,        IS_EGG, EGG_LEVEL, 25,  POUND, CHARM, ENCORE, SWIFT
    distributionGift IGGLYBUFF,     IS_EGG, EGG_LEVEL, 25,  SING, CHARM, DEFENSE_CURL, MIMIC
    distributionGift SMOOCHUM,      IS_EGG, EGG_LEVEL, 25,  POUND, LICK, METRONOME, 0
    distributionGift ELEKID,        IS_EGG, EGG_LEVEL, 25,  QUICK_ATTACK, LEER, PURSUIT, 0
    distributionGift MAGBY,         IS_EGG, EGG_LEVEL, 25,  EMBER, FAINT_ATTACK, 0, 0
; Spring Into Spring
    distributionGift PSYDUCK,       IS_EGG, EGG_LEVEL, 25,  SCRATCH, TAIL_WHIP, PETAL_DANCE, 0
    distributionGift PICHU,         IS_EGG, EGG_LEVEL, 25,  THUNDERSHOCK, CHARM, PETAL_DANCE, 0
    distributionGift CLEFFA,        IS_EGG, EGG_LEVEL, 25,  POUND, CHARM, ENCORE, PETAL_DANCE
    distributionGift IGGLYBUFF,     IS_EGG, EGG_LEVEL, 25,  SING, CHARM, DEFENSE_CURL, PETAL_DANCE
    distributionGift SMOOCHUM,      IS_EGG, EGG_LEVEL, 25,  POUND, LICK, PETAL_DANCE, 0
; Tropical Promo to Summer Festival 1
    distributionGift POLIWAG,       IS_EGG, EGG_LEVEL, 25,  BUBBLE, GROWTH, 0, 0
    distributionGift HORSEA,        IS_EGG, EGG_LEVEL, 25,  BUBBLE, HAZE, 0, 0
    distributionGift GOLDEEN,       IS_EGG, EGG_LEVEL, 25,  PECK, TAIL_WHIP, SWORDS_DANCE, 0
    distributionGift MAGIKARP,      IS_EGG, EGG_LEVEL, 25,  SPLASH, REVERSAL, 0, 0
    distributionGift MARILL,        IS_EGG, EGG_LEVEL, 25,  TACKLE, DEFENSE_CURL, DIZZY_PUNCH, 0
    distributionGift WOOPER,        IS_EGG, EGG_LEVEL, 25,  WATER_GUN, TAIL_WHIP, BELLY_DRUM, 0
; Tropical Promo to Summer Festival 2
    distributionGift PSYDUCK,       IS_EGG, EGG_LEVEL, 25,  SCRATCH, TAIL_WHIP, TRI_ATTACK, 0
    distributionGift TENTACOOL,     IS_EGG, EGG_LEVEL, 25,  POISON_STING, CONFUSE_RAY, 0, 0
    distributionGift LAPRAS,        IS_EGG, EGG_LEVEL, 25,  WATER_GUN, GROWL, SING, BITE
    distributionGift CHINCHOU,      IS_EGG, EGG_LEVEL, 25,  BUBBLE, THUNDER_WAVE, SUPERSONIC, LIGHT_SCREEN
    distributionGift REMORAID,      IS_EGG, EGG_LEVEL, 25,  WATER_GUN, MIST, 0, 0
    distributionGift MANTINE,       IS_EGG, EGG_LEVEL, 25,  TACKLE, BUBBLE, GUST, 0
; Safari Week
    distributionGift NIDORAN_F,     IS_EGG, EGG_LEVEL, 25,  GROWL, TACKLE, MOONLIGHT, 0
    distributionGift NIDORAN_M,     IS_EGG, EGG_LEVEL, 25,  LEER, TACKLE, MORNING_SUN, 0
    distributionGift CHANSEY,       IS_EGG, EGG_LEVEL, 25,  POUND, SWEET_SCENT, 0, 0
    distributionGift KANGASKHAN,    IS_EGG, EGG_LEVEL, 25,  COMET_PUNCH, FAINT_ATTACK, 0, 0
    distributionGift TAUROS,        IS_EGG, EGG_LEVEL, 25,  TACKLE, TAIL_WHIP, QUICK_ATTACK, 0
    distributionGift DRATINI,       IS_EGG, EGG_LEVEL, 25,  WRAP, LEER, HYDRO_PUMP, 0
; Sky Week
    distributionGift SPEAROW,       IS_EGG, EGG_LEVEL, 25,  PECK, GROWL, SONICBOOM, 0
    distributionGift FARFETCH_D,    IS_EGG, EGG_LEVEL, 25,  PECK, FURY_CUTTER, 0, 0
    distributionGift DODUO,         IS_EGG, EGG_LEVEL, 25,  PECK, GROWL, LOW_KICK, 0
    distributionGift NATU,          IS_EGG, EGG_LEVEL, 25,  PECK, LEER, SAFEGUARD, 0
    distributionGift MURKROW,       IS_EGG, EGG_LEVEL, 25,  PECK, BEAT_UP, 0, 0
    distributionGift SKARMORY,      IS_EGG, EGG_LEVEL, 25,  LEER, PECK, FURY_CUTTER, 0
; Power Plant
    distributionGift PICHU,         IS_EGG, EGG_LEVEL, 25,  THUNDERSHOCK, CHARM, DIZZY_PUNCH, 0
    distributionGift MAGNEMITE,     IS_EGG, EGG_LEVEL, 25,  TACKLE, AGILITY, 0, 0
    distributionGift ELEKID,        IS_EGG, EGG_LEVEL, 25,  QUICK_ATTACK, LEER, DIZZY_PUNCH, 0
    distributionGift VOLTORB,       IS_EGG, EGG_LEVEL, 25,  TACKLE, AGILITY, 0, 0
; Scary Face
    distributionGift CLEFFA,        IS_EGG, EGG_LEVEL, 25,  POUND, CHARM, ENCORE, SCARY_FACE
    distributionGift IGGLYBUFF,     IS_EGG, EGG_LEVEL, 25,  SING, CHARM, DEFENSE_CURL, SCARY_FACE
    distributionGift MARILL,        IS_EGG, EGG_LEVEL, 25,  TACKLE, DEFENSE_CURL, SCARY_FACE, 0
    distributionGift PICHU,         IS_EGG, EGG_LEVEL, 25,  THUNDERSHOCK, CHARM, SCARY_FACE, 0
    distributionGift WOOPER,        IS_EGG, EGG_LEVEL, 25,  WATER_GUN, TAIL_WHIP, SCARY_FACE, 0
; Silver Cave
    distributionGift TANGELA,       IS_EGG, EGG_LEVEL, 25,  CONSTRICT, SLEEP_POWDER, SYNTHESIS, 0
    distributionGift PONYTA,        IS_EGG, EGG_LEVEL, 25,  TACKLE, GROWL, LOW_KICK, 0
    distributionGift MISDREAVUS,    IS_EGG, EGG_LEVEL, 25,  GROWL, PSYWAVE, HYPNOSIS, 0
    distributionGift LARVITAR,      IS_EGG, EGG_LEVEL, 25,  BITE, LEER, RAGE, 0
; Union Cave
    distributionGift STARYU,        IS_EGG, EGG_LEVEL, 25,  TACKLE, HARDEN, TWISTER, 0
    distributionGift KRABBY,        IS_EGG, EGG_LEVEL, 25,  BUBBLE, LEER, METAL_CLAW, 0
    distributionGift ONIX,          IS_EGG, EGG_LEVEL, 25,  TACKLE, SCREECH, SHARPEN, 0
    distributionGift LAPRAS,        IS_EGG, EGG_LEVEL, 25,  WATER_GUN, GROWL, SING, FUTURE_SIGHT
; Celebi Present SP
    distributionGift MEW,           NOT_EGG, 5, 100,        POUND, 0, 0, 0
; Psychic Type
    distributionGift ABRA,          IS_EGG, EGG_LEVEL, 25,  TELEPORT, FORESIGHT, 0, 0
    distributionGift DROWZEE,       IS_EGG, EGG_LEVEL, 25,  POUND, HYPNOSIS, AMNESIA, 0
    distributionGift EXEGGCUTE,     IS_EGG, EGG_LEVEL, 25,  BARRAGE, HYPNOSIS, SWEET_SCENT, 0
    distributionGift MR__MIME,      IS_EGG, EGG_LEVEL, 25,  BARRIER, MIND_READER, 0, 0
; The Johto Initial Three
    distributionGift MEGANIUM,      NOT_EGG, 40, 100,       REFLECT, POISONPOWDER, SYNTHESIS, BODY_SLAM
    distributionGift TYPHLOSION,    NOT_EGG, 40, 100,       SMOKESCREEN, EMBER, QUICK_ATTACK, FLAME_WHEEL
    distributionGift FERALIGATR,    NOT_EGG, 40, 100,       WATER_GUN, BITE, SCARY_FACE, SLASH
; Rock Tunnel
    distributionGift GEODUDE,       IS_EGG, EGG_LEVEL, 25,  TACKLE, RAPID_SPIN, 0, 0
    distributionGift ZUBAT,         IS_EGG, EGG_LEVEL, 25,  LEECH_LIFE, FLAIL, 0, 0
    distributionGift MACHOP,        IS_EGG, EGG_LEVEL, 25,  LOW_KICK, LEER, THRASH, 0
    distributionGift CUBONE,        IS_EGG, EGG_LEVEL, 25,  GROWL, TAIL_WHIP, FURY_ATTACK, 0
; Ice Type
    distributionGift DELIBIRD,      IS_EGG, EGG_LEVEL, 25,  PRESENT, SPIKES, 0, 0
    distributionGift SEEL,          IS_EGG, EGG_LEVEL, 25,  HEADBUTT, GROWL, FLAIL, 0
    distributionGift SWINUB,        IS_EGG, EGG_LEVEL, 25,  TACKLE, WHIRLWIND, 0, 0
; Pokemon that Appear at Night only
    distributionGift HOOTHOOT,      IS_EGG, EGG_LEVEL, 25,  TACKLE, GROWL, NIGHT_SHADE, 0
    distributionGift SNEASEL,       IS_EGG, EGG_LEVEL, 25,  SCRATCH, LEER, MOONLIGHT, 0
; Grass Type
    distributionGift SUNKERN,       IS_EGG, EGG_LEVEL, 25,  ABSORB, GROWTH, SPLASH, 0
    distributionGift PARAS,         IS_EGG, EGG_LEVEL, 25,  SCRATCH, SYNTHESIS, 0, 0
    distributionGift HOPPIP,        IS_EGG, EGG_LEVEL, 25,  SPLASH, SYNTHESIS, TAIL_WHIP, AGILITY
    distributionGift ODDISH,        IS_EGG, EGG_LEVEL, 25,  ABSORB, LEECH_SEED, 0, 0
; Normal Pokemon
    distributionGift SENTRET,       IS_EGG, EGG_LEVEL, 25,  TACKLE, DEFENSE_CURL, DIZZY_PUNCH, 0
    distributionGift STANTLER,      IS_EGG, EGG_LEVEL, 25,  TACKLE, SAFEGUARD, 0, 0
    distributionGift MILTANK,       IS_EGG, EGG_LEVEL, 25,  TACKLE, GROWL, MEGA_KICK, 0
    distributionGift AIPOM,         IS_EGG, EGG_LEVEL, 25,  SCRATCH, TAIL_WHIP, MIMIC, 0
    distributionGift LICKITUNG,     IS_EGG, EGG_LEVEL, 25,  LICK, DOUBLESLAP, 0, 0
    distributionGift SNORLAX,       IS_EGG, EGG_LEVEL, 25,  TACKLE, SPLASH, 0, 0
; Mt. Mortar
    distributionGift MACHOP,        IS_EGG, EGG_LEVEL, 25,  LOW_KICK, LEER, FALSE_SWIPE, 0
    distributionGift MAGIKARP,      IS_EGG, EGG_LEVEL, 25,  SPLASH, BUBBLE, 0, 0
    distributionGift TYROGUE,       IS_EGG, EGG_LEVEL, 25,  TACKLE, RAGE, 0, 0
; Dark Cave Pokemon
    distributionGift DUNSPARCE,     IS_EGG, EGG_LEVEL, 25,  RAGE, DEFENSE_CURL, FURY_ATTACK, 0
    distributionGift WOBBUFFET,     IS_EGG, EGG_LEVEL, 25,  MIRROR_COAT, SAFEGUARD, DESTINY_BOND, MIMIC
    distributionGift PHANPY,        IS_EGG, EGG_LEVEL, 25,  TACKLE, GROWL, ABSORB, 0
    distributionGift TEDDIURSA,     IS_EGG, EGG_LEVEL, 25,  SCRATCH, LEER, SWEET_SCENT, 0
; Rare Pokemon
    distributionGift KABUTO,        IS_EGG, EGG_LEVEL, 25,  SCRATCH, HARDEN, ROCK_THROW, 0
    distributionGift OMANYTE,       IS_EGG, EGG_LEVEL, 25,  CONSTRICT, WITHDRAW, ROCK_THROW, 0
    distributionGift AERODACTYL,    IS_EGG, EGG_LEVEL, 25,  WING_ATTACK, ROCK_THROW, 0, 0
    distributionGift PORYGON,       IS_EGG, EGG_LEVEL, 25,  TACKLE, CONVERSION, CONVERSION2, BARRIER
    distributionGift EEVEE,         IS_EGG, EGG_LEVEL, 25,  TACKLE, TAIL_WHIP, GROWTH, 0
    distributionGift SUDOWOODO,     IS_EGG, EGG_LEVEL, 25,  ROCK_THROW, MIMIC, SUBSTITUTE, 0
; Bug Type Pokemon
    distributionGift SCYTHER,       IS_EGG, EGG_LEVEL, 25,  QUICK_ATTACK, LEER, SONICBOOM, 0
    distributionGift HERACROSS,     IS_EGG, EGG_LEVEL, 25,  TACKLE, LEER, SEISMIC_TOSS, 0
    distributionGift PINSIR,        IS_EGG, EGG_LEVEL, 25,  VICEGRIP, ROCK_THROW, 0, 0
    distributionGift LEDYBA,        IS_EGG, EGG_LEVEL, 25,  TACKLE, BARRIER, 0, 0
    distributionGift SPINARAK,      IS_EGG, EGG_LEVEL, 25,  POISON_STING, STRING_SHOT, GROWTH, 0
    distributionGift YANMA,         IS_EGG, EGG_LEVEL, 25,  TACKLE, FORESIGHT, SWEET_KISS, 0
    distributionGift PINECO,        IS_EGG, EGG_LEVEL, 25,  TACKLE, PROTECT, SUBSTITUTE, 0
    assert_table_length NUM_DISTRIBUTION_GIFTS
