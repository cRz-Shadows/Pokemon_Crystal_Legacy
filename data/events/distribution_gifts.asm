; @towersvault note
; Since the distribution gifts changed from time to time on
; the dates distributions were done, I've opted to rather
; just add all the Pokemon in a list here as opposed to
; mapping each tiny change such as when OT ID's would change.
; The primary reason for this decision is to save space.
; I've however opted for "grouping", i.e. the Distribution Man
; will for example select only "Legendary Beasts".
;
; Data from
; https://bulbapedia.bulbagarden.net/wiki/List_of_PCNY_event_Pok%C3%A9mon_distributions_in_Generation_II

DEF PCNY_OT_NAME EQUS "PCNY@@@@@@@"
DEF PCNY_OT_ID EQU 00006

; \1: Pokemon
; \2: Egg Status
; \3: Level
; \4: Shiny Chance
; \5: Move 1 (Optional)
; \6: Move 2 (Optional)
; \7: Move 3 (Optional)
; \8: Move 4 (Optional)
; \9: OT ID and Name Flag
distributionGift: MACRO
    db \1, \2, \3, \4, \5, \6, \7, \8, \9
ENDM

DistributionGifts:
    table_width 9, DistributionGifts
; Johto Legendary
    distributionGift RAIKOU,        NOT_EGG, 40, 100,       LEER, THUNDERSHOCK, ROAR, QUICK_ATTACK,                     OT_PCNY
    distributionGift ENTEI,         NOT_EGG, 40, 100,       LEER, EMBER, ROAR, FIRE_SPIN,                               OT_PCNY
    distributionGift SUICUNE,       NOT_EGG, 40, 100,       LEER, WATER_GUN, ROAR, GUST,                                OT_PCNY
    distributionGift HO_OH,         NOT_EGG, 40, 100,       SACRED_FIRE, SAFEGUARD, GUST, RECOVER,                      OT_PCNY
    distributionGift LUGIA,         NOT_EGG, 40, 100,       AEROBLAST, SAFEGUARD, GUST, RECOVER,                        OT_PCNY
; Legendary Birds
    distributionGift ARTICUNO,      NOT_EGG, 50, 100,       MIST, AGILITY, MIND_READER, ICE_BEAM,                       OT_PCNY
    distributionGift ZAPDOS,        NOT_EGG, 50, 100,       THUNDER_WAVE, AGILITY, DETECT, DRILL_PECK,                  OT_PCNY
    distributionGift MOLTRES,       NOT_EGG, 50, 100,       FIRE_SPIN, AGILITY, ENDURE, FLAMETHROWER,                   OT_PCNY
; Christmas Week
    distributionGift DELIBIRD,      IS_EGG, EGG_LEVEL, 15,  PRESENT, PAY_DAY, 0, 0,                                     OT_TRAINER
; The Initial Three
    distributionGift BULBASAUR,     IS_EGG, EGG_LEVEL, 15,  TACKLE, GROWL, ANCIENTPOWER, 0,                             OT_TRAINER
    distributionGift CHARMANDER,    IS_EGG, EGG_LEVEL, 15,  SCRATCH, GROWL, CRUNCH, 0,                                  OT_TRAINER
    distributionGift SQUIRTLE,      IS_EGG, EGG_LEVEL, 15,  TACKLE, TAIL_WHIP, ZAP_CANNON, 0,                           OT_TRAINER
    distributionGift CHIKORITA,     IS_EGG, EGG_LEVEL, 15,  TACKLE, GROWL, PETAL_DANCE, 0,                              OT_TRAINER
    distributionGift CYNDAQUIL,     IS_EGG, EGG_LEVEL, 15,  TACKLE, LEER, DOUBLE_EDGE, 0,                               OT_TRAINER
    distributionGift TOTODILE,      IS_EGG, EGG_LEVEL, 15,  SCRATCH, LEER, SUBMISSION, 0,                               OT_TRAINER
; Valentine Week
    distributionGift NIDORAN_F,     IS_EGG, EGG_LEVEL, 15,  GROWL, TACKLE, LOVELY_KISS, 0,                              OT_TRAINER
    distributionGift NIDORAN_F,     IS_EGG, EGG_LEVEL, 15,  GROWL, TACKLE, SWEET_KISS, 0,                               OT_TRAINER
    distributionGift NIDORAN_M,     IS_EGG, EGG_LEVEL, 15,  LEER, TACKLE, LOVELY_KISS, 0,                               OT_TRAINER
    distributionGift NIDORAN_M,     IS_EGG, EGG_LEVEL, 15,  LEER, TACKLE, SWEET_KISS, 0,                                OT_TRAINER
    distributionGift BELLSPROUT,    IS_EGG, EGG_LEVEL, 15,  VINE_WHIP, LOVELY_KISS, 0, 0,                               OT_TRAINER
    distributionGift BELLSPROUT,    IS_EGG, EGG_LEVEL, 15,  VINE_WHIP, SWEET_KISS, 0, 0,                                OT_TRAINER
    distributionGift POLIWAG,       IS_EGG, EGG_LEVEL, 15,  BUBBLE, LOVELY_KISS, 0, 0,                                  OT_TRAINER
    distributionGift POLIWAG,       IS_EGG, EGG_LEVEL, 15,  BUBBLE, SWEET_KISS, 0, 0,                                   OT_TRAINER
    distributionGift SNORLAX,       IS_EGG, EGG_LEVEL, 15,  TACKLE, LOVELY_KISS, 0, 0,                                  OT_TRAINER
    distributionGift SNORLAX,       IS_EGG, EGG_LEVEL, 15,  TACKLE, SWEET_KISS, 0, 0,                                   OT_TRAINER
; Swarm Week
    distributionGift MARILL,        IS_EGG, EGG_LEVEL, 15,  TACKLE, DEFENSE_CURL, HYDRO_PUMP, 0,                        OT_TRAINER
    distributionGift YANMA,         IS_EGG, EGG_LEVEL, 15,  TACKLE, FORESIGHT, STEEL_WING, 0,                           OT_TRAINER
    distributionGift DUNSPARCE,     IS_EGG, EGG_LEVEL, 15,  RAGE, DEFENSE_CURL, HORN_DRILL, 0,                          OT_TRAINER
    distributionGift SNUBBULL,      IS_EGG, EGG_LEVEL, 15,  TACKLE, SCARY_FACE, TAIL_WHIP, LOVELY_KISS,                 OT_TRAINER
    distributionGift QWILFISH,      IS_EGG, EGG_LEVEL, 15,  TACKLE, POISON_STING, DOUBLE_EDGE, 0,                       OT_TRAINER
    distributionGift REMORAID,      IS_EGG, EGG_LEVEL, 15,  WATER_GUN, AMNESIA, 0, 0,                                   OT_TRAINER
; Kanto Initial Three
    distributionGift VENUSAUR,      NOT_EGG, 40, 100,       POISONPOWDER, SLEEP_POWDER, RAZOR_LEAF, SWEET_SCENT,        OT_PCNY
    distributionGift CHARIZARD,     NOT_EGG, 40, 100,       RAGE, SCARY_FACE, FLAMETHROWER, WING_ATTACK,                OT_PCNY
    distributionGift BLASTOISE,     NOT_EGG, 40, 100,       WATER_GUN, BITE, RAPID_SPIN, PROTECT,                       OT_PCNY
    distributionGift MEWTWO,        NOT_EGG, 70, 100,       PSYCH_UP, FUTURE_SIGHT, MIST, PSYCHIC_M,                    OT_PCNY
; Babies Week
    distributionGift PICHU,         IS_EGG, EGG_LEVEL, 15,  THUNDERSHOCK, CHARM, SING, 0,                               OT_TRAINER
    distributionGift CLEFFA,        IS_EGG, EGG_LEVEL, 15,  POUND, CHARM, ENCORE, SWIFT,                                OT_TRAINER
    distributionGift IGGLYBUFF,     IS_EGG, EGG_LEVEL, 15,  SING, CHARM, DEFENSE_CURL, MIMIC,                           OT_TRAINER
    distributionGift SMOOCHUM,      IS_EGG, EGG_LEVEL, 15,  POUND, LICK, METRONOME, 0,                                  OT_TRAINER
    distributionGift ELEKID,        IS_EGG, EGG_LEVEL, 15,  QUICK_ATTACK, LEER, PURSUIT, 0,                             OT_TRAINER
    distributionGift MAGBY,         IS_EGG, EGG_LEVEL, 15,  EMBER, FAINT_ATTACK, 0, 0,                                  OT_TRAINER
; Spring Into Spring
    distributionGift PSYDUCK,       IS_EGG, EGG_LEVEL, 15,  SCRATCH, TAIL_WHIP, PETAL_DANCE, 0,                         OT_TRAINER
    distributionGift PICHU,         IS_EGG, EGG_LEVEL, 15,  THUNDERSHOCK, CHARM, PETAL_DANCE, 0,                        OT_TRAINER
    distributionGift CLEFFA,        IS_EGG, EGG_LEVEL, 15,  POUND, CHARM, ENCORE, PETAL_DANCE,                          OT_TRAINER
    distributionGift IGGLYBUFF,     IS_EGG, EGG_LEVEL, 15,  SING, CHARM, DEFENSE_CURL, PETAL_DANCE,                     OT_TRAINER
    distributionGift SMOOCHUM,      IS_EGG, EGG_LEVEL, 15,  POUND, LICK, PETAL_DANCE, 0,                                OT_TRAINER
; Tropical Promo to Summer Festival 1
    distributionGift POLIWAG,       IS_EGG, EGG_LEVEL, 15,  BUBBLE, GROWTH, 0, 0,                                       OT_TRAINER
    distributionGift HORSEA,        IS_EGG, EGG_LEVEL, 15,  BUBBLE, HAZE, 0, 0,                                         OT_TRAINER
    distributionGift GOLDEEN,       IS_EGG, EGG_LEVEL, 15,  PECK, TAIL_WHIP, SWORDS_DANCE, 0,                           OT_TRAINER
    distributionGift MAGIKARP,      IS_EGG, EGG_LEVEL, 15,  SPLASH, REVERSAL, 0, 0,                                     OT_TRAINER
    distributionGift MARILL,        IS_EGG, EGG_LEVEL, 15,  TACKLE, DEFENSE_CURL, DIZZY_PUNCH, 0,                       OT_TRAINER
    distributionGift WOOPER,        IS_EGG, EGG_LEVEL, 15,  WATER_GUN, TAIL_WHIP, BELLY_DRUM, 0,                        OT_TRAINER
; Tropical Promo to Summer Festival 2
    distributionGift PSYDUCK,       IS_EGG, EGG_LEVEL, 15,  SCRATCH, TAIL_WHIP, TRI_ATTACK, 0,                          OT_TRAINER
    distributionGift TENTACOOL,     IS_EGG, EGG_LEVEL, 15,  POISON_STING, CONFUSE_RAY, 0, 0,                            OT_TRAINER
    distributionGift LAPRAS,        IS_EGG, EGG_LEVEL, 15,  WATER_GUN, GROWL, SING, BITE,                               OT_TRAINER
    distributionGift CHINCHOU,      IS_EGG, EGG_LEVEL, 15,  BUBBLE, THUNDER_WAVE, SUPERSONIC, LIGHT_SCREEN,             OT_TRAINER
    distributionGift REMORAID,      IS_EGG, EGG_LEVEL, 15,  WATER_GUN, MIST, 0, 0,                                      OT_TRAINER
    distributionGift MANTINE,       IS_EGG, EGG_LEVEL, 15,  TACKLE, BUBBLE, GUST, 0,                                    OT_TRAINER
; Safari Week
    distributionGift NIDORAN_F,     IS_EGG, EGG_LEVEL, 15,  GROWL, TACKLE, MOONLIGHT, 0,                                OT_TRAINER
    distributionGift NIDORAN_M,     IS_EGG, EGG_LEVEL, 15,  LEER, TACKLE, MORNING_SUN, 0,                               OT_TRAINER
    distributionGift CHANSEY,       IS_EGG, EGG_LEVEL, 15,  POUND, SWEET_SCENT, 0, 0,                                   OT_TRAINER
    distributionGift KANGASKHAN,    IS_EGG, EGG_LEVEL, 15,  COMET_PUNCH, FAINT_ATTACK, 0, 0,                            OT_TRAINER
    distributionGift TAUROS,        IS_EGG, EGG_LEVEL, 15,  TACKLE, TAIL_WHIP, QUICK_ATTACK, 0,                         OT_TRAINER
    distributionGift DRATINI,       IS_EGG, EGG_LEVEL, 15,  WRAP, LEER, HYDRO_PUMP, 0,                                  OT_TRAINER
; Sky Week
    distributionGift SPEAROW,       IS_EGG, EGG_LEVEL, 15,  PECK, GROWL, SONICBOOM, 0,                                  OT_TRAINER
    distributionGift FARFETCH_D,    IS_EGG, EGG_LEVEL, 15,  PECK, FURY_CUTTER, 0, 0,                                    OT_TRAINER
    distributionGift DODUO,         IS_EGG, EGG_LEVEL, 15,  PECK, GROWL, LOW_KICK, 0,                                   OT_TRAINER
    distributionGift NATU,          IS_EGG, EGG_LEVEL, 15,  PECK, LEER, SAFEGUARD, 0,                                   OT_TRAINER
    distributionGift MURKROW,       IS_EGG, EGG_LEVEL, 15,  PECK, BEAT_UP, 0, 0,                                        OT_TRAINER
    distributionGift SKARMORY,      IS_EGG, EGG_LEVEL, 15,  LEER, PECK, FURY_CUTTER, 0,                                 OT_TRAINER
; Power Plant
    distributionGift PICHU,         IS_EGG, EGG_LEVEL, 15,  THUNDERSHOCK, CHARM, DIZZY_PUNCH, 0,                        OT_TRAINER
    distributionGift MAGNEMITE,     IS_EGG, EGG_LEVEL, 15,  TACKLE, AGILITY, 0, 0,                                      OT_TRAINER
    distributionGift ELEKID,        IS_EGG, EGG_LEVEL, 15,  QUICK_ATTACK, LEER, DIZZY_PUNCH, 0,                         OT_TRAINER
    distributionGift VOLTORB,       IS_EGG, EGG_LEVEL, 15,  TACKLE, AGILITY, 0, 0,                                      OT_TRAINER
; Scary Face
    distributionGift CLEFFA,        IS_EGG, EGG_LEVEL, 15,  POUND, CHARM, ENCORE, SCARY_FACE,                           OT_TRAINER
    distributionGift IGGLYBUFF,     IS_EGG, EGG_LEVEL, 15,  SING, CHARM, DEFENSE_CURL, SCARY_FACE,                      OT_TRAINER
    distributionGift MARILL,        IS_EGG, EGG_LEVEL, 15,  TACKLE, DEFENSE_CURL, SCARY_FACE, 0,                        OT_TRAINER
    distributionGift PICHU,         IS_EGG, EGG_LEVEL, 15,  THUNDERSHOCK, CHARM, SCARY_FACE, 0,                         OT_TRAINER
    distributionGift WOOPER,        IS_EGG, EGG_LEVEL, 15,  WATER_GUN, TAIL_WHIP, SCARY_FACE, 0,                        OT_TRAINER
; Silver Cave
    distributionGift TANGELA,       IS_EGG, EGG_LEVEL, 15,  CONSTRICT, SLEEP_POWDER, SYNTHESIS, 0,                      OT_TRAINER
    distributionGift PONYTA,        IS_EGG, EGG_LEVEL, 15,  TACKLE, GROWL, LOW_KICK, 0,                                 OT_TRAINER
    distributionGift MISDREAVUS,    IS_EGG, EGG_LEVEL, 15,  GROWL, PSYWAVE, HYPNOSIS, 0,                                OT_TRAINER
    distributionGift LARVITAR,      IS_EGG, EGG_LEVEL, 15,  BITE, LEER, RAGE, 0,                                        OT_TRAINER
; Union Cave
    distributionGift STARYU,        IS_EGG, EGG_LEVEL, 15,  TACKLE, HARDEN, TWISTER, 0,                                 OT_TRAINER
    distributionGift KRABBY,        IS_EGG, EGG_LEVEL, 15,  BUBBLE, LEER, METAL_CLAW, 0,                                OT_TRAINER
    distributionGift ONIX,          IS_EGG, EGG_LEVEL, 15,  TACKLE, SCREECH, SHARPEN, 0,                                OT_TRAINER
    distributionGift LAPRAS,        IS_EGG, EGG_LEVEL, 15,  WATER_GUN, GROWL, SING, FUTURE_SIGHT,                       OT_TRAINER
; Celebi Present SP
    distributionGift MEW,           NOT_EGG, 5, 100,        POUND, 0, 0, 0,                                             OT_PCNY
; Psychic Type
    distributionGift ABRA,          IS_EGG, EGG_LEVEL, 15,  TELEPORT, FORESIGHT, 0, 0,                                  OT_TRAINER
    distributionGift DROWZEE,       IS_EGG, EGG_LEVEL, 15,  POUND, HYPNOSIS, AMNESIA, 0,                                OT_TRAINER
    distributionGift EXEGGCUTE,     IS_EGG, EGG_LEVEL, 15,  BARRAGE, HYPNOSIS, SWEET_SCENT, 0,                          OT_TRAINER
    distributionGift MR__MIME,      IS_EGG, EGG_LEVEL, 15,  BARRIER, MIND_READER, 0, 0,                                 OT_TRAINER
; The Johto Initial Three
    distributionGift MEGANIUM,      NOT_EGG, 40, 100,       REFLECT, POISONPOWDER, SYNTHESIS, BODY_SLAM,                OT_PCNY
    distributionGift TYPHLOSION,    NOT_EGG, 40, 100,       SMOKESCREEN, EMBER, QUICK_ATTACK, FLAME_WHEEL,              OT_PCNY
    distributionGift FERALIGATR,    NOT_EGG, 40, 100,       WATER_GUN, BITE, SCARY_FACE, SLASH,                         OT_PCNY
; Rock Tunnel
    distributionGift GEODUDE,       IS_EGG, EGG_LEVEL, 15,  TACKLE, RAPID_SPIN, 0, 0,                                   OT_TRAINER
    distributionGift ZUBAT,         IS_EGG, EGG_LEVEL, 15,  LEECH_LIFE, FLAIL, 0, 0,                                    OT_TRAINER
    distributionGift MACHOP,        IS_EGG, EGG_LEVEL, 15,  LOW_KICK, LEER, THRASH, 0,                                  OT_TRAINER
    distributionGift CUBONE,        IS_EGG, EGG_LEVEL, 15,  GROWL, TAIL_WHIP, FURY_ATTACK, 0,                           OT_TRAINER
; Ice Type
    distributionGift DELIBIRD,      IS_EGG, EGG_LEVEL, 15,  PRESENT, SPIKES, 0, 0,                                      OT_TRAINER
    distributionGift SEEL,          IS_EGG, EGG_LEVEL, 15,  HEADBUTT, GROWL, FLAIL, 0,                                  OT_TRAINER
    distributionGift SWINUB,        IS_EGG, EGG_LEVEL, 15,  TACKLE, WHIRLWIND, 0, 0,                                    OT_TRAINER
; Pokemon that Appear at Night only
    distributionGift HOOTHOOT,      IS_EGG, EGG_LEVEL, 15,  TACKLE, GROWL, NIGHT_SHADE, 0,                              OT_TRAINER
    distributionGift SNEASEL,       IS_EGG, EGG_LEVEL, 15,  SCRATCH, LEER, MOONLIGHT, 0,                                OT_TRAINER
; Grass Type
    distributionGift SUNKERN,       IS_EGG, EGG_LEVEL, 15,  ABSORB, GROWTH, SPLASH, 0,                                  OT_TRAINER
    distributionGift PARAS,         IS_EGG, EGG_LEVEL, 15,  SCRATCH, SYNTHESIS, 0, 0,                                   OT_TRAINER
    distributionGift HOPPIP,        IS_EGG, EGG_LEVEL, 15,  SPLASH, SYNTHESIS, TAIL_WHIP, AGILITY,                      OT_TRAINER
    distributionGift ODDISH,        IS_EGG, EGG_LEVEL, 15,  ABSORB, LEECH_SEED, 0, 0,                                   OT_TRAINER
; Normal Pokemon
    distributionGift SENTRET,       IS_EGG, EGG_LEVEL, 15,  TACKLE, DEFENSE_CURL, DIZZY_PUNCH, 0,                       OT_TRAINER
    distributionGift STANTLER,      IS_EGG, EGG_LEVEL, 15,  TACKLE, SAFEGUARD, 0, 0,                                    OT_TRAINER
    distributionGift MILTANK,       IS_EGG, EGG_LEVEL, 15,  TACKLE, GROWL, MEGA_KICK, 0,                                OT_TRAINER
    distributionGift AIPOM,         IS_EGG, EGG_LEVEL, 15,  SCRATCH, TAIL_WHIP, MIMIC, 0,                               OT_TRAINER
    distributionGift LICKITUNG,     IS_EGG, EGG_LEVEL, 15,  LICK, DOUBLESLAP, 0, 0,                                     OT_TRAINER
    distributionGift SNORLAX,       IS_EGG, EGG_LEVEL, 15,  TACKLE, SPLASH, 0, 0,                                       OT_TRAINER
; Mt. Mortar
    distributionGift MACHOP,        IS_EGG, EGG_LEVEL, 15,  LOW_KICK, LEER, FALSE_SWIPE, 0,                             OT_TRAINER
    distributionGift MAGIKARP,      IS_EGG, EGG_LEVEL, 15,  SPLASH, BUBBLE, 0, 0,                                       OT_TRAINER
    distributionGift TYROGUE,       IS_EGG, EGG_LEVEL, 15,  TACKLE, RAGE, 0, 0,                                         OT_TRAINER
; Dark Cave Pokemon
    distributionGift DUNSPARCE,     IS_EGG, EGG_LEVEL, 15,  RAGE, DEFENSE_CURL, FURY_ATTACK, 0,                         OT_TRAINER
    distributionGift WOBBUFFET,     IS_EGG, EGG_LEVEL, 15,  MIRROR_COAT, SAFEGUARD, DESTINY_BOND, MIMIC,                OT_TRAINER
    distributionGift PHANPY,        IS_EGG, EGG_LEVEL, 15,  TACKLE, GROWL, ABSORB, 0,                                   OT_TRAINER
    distributionGift TEDDIURSA,     IS_EGG, EGG_LEVEL, 15,  SCRATCH, LEER, SWEET_SCENT, 0,                              OT_TRAINER
; Rare Pokemon
    distributionGift KABUTO,        IS_EGG, EGG_LEVEL, 15,  SCRATCH, HARDEN, ROCK_THROW, 0,                             OT_TRAINER
    distributionGift OMANYTE,       IS_EGG, EGG_LEVEL, 15,  CONSTRICT, WITHDRAW, ROCK_THROW, 0,                         OT_TRAINER
    distributionGift AERODACTYL,    IS_EGG, EGG_LEVEL, 15,  WING_ATTACK, ROCK_THROW, 0, 0,                              OT_TRAINER
    distributionGift PORYGON,       IS_EGG, EGG_LEVEL, 15,  TACKLE, CONVERSION, CONVERSION2, BARRIER,                   OT_TRAINER
    distributionGift EEVEE,         IS_EGG, EGG_LEVEL, 15,  TACKLE, TAIL_WHIP, GROWTH, 0,                               OT_TRAINER
    distributionGift SUDOWOODO,     IS_EGG, EGG_LEVEL, 15,  ROCK_THROW, MIMIC, SUBSTITUTE, 0,                           OT_TRAINER
; Bug Type Pokemon
    distributionGift SCYTHER,       IS_EGG, EGG_LEVEL, 15,  QUICK_ATTACK, LEER, SONICBOOM, 0,                           OT_TRAINER
    distributionGift HERACROSS,     IS_EGG, EGG_LEVEL, 15,  TACKLE, LEER, SEISMIC_TOSS, 0,                              OT_TRAINER
    distributionGift PINSIR,        IS_EGG, EGG_LEVEL, 15,  VICEGRIP, ROCK_THROW, 0, 0,                                 OT_TRAINER
    distributionGift LEDYBA,        IS_EGG, EGG_LEVEL, 15,  TACKLE, BARRIER, 0, 0,                                      OT_TRAINER
    distributionGift SPINARAK,      IS_EGG, EGG_LEVEL, 15,  POISON_STING, STRING_SHOT, GROWTH, 0,                       OT_TRAINER
    distributionGift YANMA,         IS_EGG, EGG_LEVEL, 15,  TACKLE, FORESIGHT, SWEET_KISS, 0,                           OT_TRAINER
    distributionGift PINECO,        IS_EGG, EGG_LEVEL, 15,  TACKLE, PROTECT, SUBSTITUTE, 0,                             OT_TRAINER
    assert_table_length NUM_DISTRIBUTION_GIFTS
