INCLUDE "constants.asm"


SECTION "Evolutions and Attacks", ROMX

; Evos+attacks data structure:
; - Evolution methods:
;    * db EVOLVE_LEVEL, level, species
;    * db EVOLVE_ITEM, used item, species
;    * db EVOLVE_TRADE, held item (or -1 for none), species
;    * db EVOLVE_HAPPINESS, TR_* constant (ANYTIME, MORNDAY, NITE), species
;    * db EVOLVE_STAT, level, ATK_*_DEF constant (LT, GT, EQ), species
; - db 0 ; no more evolutions
; - Learnset (in increasing level order):
;    * db level, move
; - db 0 ; no more level-up moves

INCLUDE "data/pokemon/evos_attacks_pointers.asm"

BulbasaurEvosAttacks:
	db EVOLVE_LEVEL, 16, IVYSAUR
	db 0 ; no more evolutions
	db 1, TACKLE
	db 4, GROWL
	db 7, LEECH_SEED
	db 10, VINE_WHIP
	db 15, POISONPOWDER
	db 15, SLEEP_POWDER
	db 20, RAZOR_LEAF
	db 25, SWEET_SCENT
	db 32, GROWTH
	db 39, SYNTHESIS
	db 46, SOLARBEAM
	db 0 ; no more level-up moves

IvysaurEvosAttacks:
	db EVOLVE_LEVEL, 32, VENUSAUR
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 7, LEECH_SEED
	db 10, VINE_WHIP
	db 15, POISONPOWDER
	db 15, SLEEP_POWDER
	db 20, RAZOR_LEAF
	db 25, SWEET_SCENT
	db 32, GROWTH
	db 39, SYNTHESIS
	db 46, SOLARBEAM
	db 0 ; no more level-up moves

VenusaurEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 1, LEECH_SEED
	db 1, VINE_WHIP
	db 15, POISONPOWDER
	db 15, SLEEP_POWDER
	db 20, RAZOR_LEAF
	db 25, SWEET_SCENT
	db 32, GROWTH
	db 39, SYNTHESIS
	db 45, BODY_SLAM
	db 46, SOLARBEAM
	db 50, ANCIENTPOWER
	db 0 ; no more level-up moves

CharmanderEvosAttacks:
	db EVOLVE_LEVEL, 16, CHARMELEON
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, GROWL
	db 7, EMBER
	db 13, SMOKESCREEN
	db 15, RAGE
	db 19, FLAME_WHEEL
	db 24, FIRE_SPIN
	db 27, SCARY_FACE
	db 34, FLAMETHROWER
	db 40, SLASH
	db 44, BODY_SLAM
	db 48, DRAGON_RAGE
	db 52, FIRE_BLAST
	db 0 ; no more level-up moves

CharmeleonEvosAttacks:
	db EVOLVE_LEVEL, 36, CHARIZARD
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, GROWL
	db 1, EMBER
	db 13, SMOKESCREEN
	db 15, RAGE
	db 19, FLAME_WHEEL
	db 24, FIRE_SPIN
	db 27, SCARY_FACE
	db 34, FLAMETHROWER
	db 40, SLASH
	db 44, BODY_SLAM
	db 48, DRAGON_RAGE
	db 52, FIRE_BLAST
	db 0 ; no more level-up moves

CharizardEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, GROWL
	db 1, EMBER
	db 1, SMOKESCREEN
	db 15, RAGE
	db 19, FLAME_WHEEL
	db 24, FIRE_SPIN
	db 27, SCARY_FACE
	db 34, FLAMETHROWER
	db 36, WING_ATTACK
	db 40, SLASH
	db 45, BODY_SLAM
	db 48, OUTRAGE
	db 52, FIRE_BLAST
	db 0 ; no more level-up moves

SquirtleEvosAttacks:
	db EVOLVE_LEVEL, 16, WARTORTLE
	db 0 ; no more evolutions
	db 1, TACKLE
	db 4, TAIL_WHIP
	db 7, BUBBLE
	db 10, WITHDRAW
	db 13, WATER_GUN
	db 18, BITE
	db 23, RAPID_SPIN
	db 29, PROTECT
	db 35, RAIN_DANCE
	db 41, BODY_SLAM
	db 47, ICE_BEAM
	db 51, SKULL_BASH
	db 56, HYDRO_PUMP
	db 0 ; no more level-up moves

WartortleEvosAttacks:
	db EVOLVE_LEVEL, 36, BLASTOISE
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, TAIL_WHIP
	db 1, BUBBLE
	db 10, WITHDRAW
	db 13, WATER_GUN
	db 18, BITE
	db 23, RAPID_SPIN
	db 29, PROTECT
	db 35, RAIN_DANCE
	db 41, BODY_SLAM
	db 47, ICE_BEAM
	db 51, SKULL_BASH
	db 56, HYDRO_PUMP
	db 0 ; no more level-up moves

BlastoiseEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, TAIL_WHIP
	db 1, BUBBLE
	db 1, WITHDRAW
	db 13, WATER_GUN
	db 18, BITE
	db 23, RAPID_SPIN
	db 29, PROTECT
	db 35, RAIN_DANCE
	db 41, BODY_SLAM
	db 47, ICE_BEAM
	db 51, SKULL_BASH
	db 56, HYDRO_PUMP
	db 0 ; no more level-up moves

CaterpieEvosAttacks:
	db EVOLVE_LEVEL, 7, METAPOD
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, STRING_SHOT
	db 0 ; no more level-up moves

MetapodEvosAttacks:
	db EVOLVE_LEVEL, 10, BUTTERFREE
	db 0 ; no more evolutions
	db 1, HARDEN
	db 1, TACKLE
	db 1, STRING_SHOT
	db 7, HARDEN
	db 0 ; no more level-up moves

ButterfreeEvosAttacks:
	db 0 ; no more evolutions
	db 1, CONFUSION
	db 10, CONFUSION
	db 12, LEECH_LIFE
	db 13, POISONPOWDER
	db 14, STUN_SPORE
	db 15, SLEEP_POWDER
	db 18, SUPERSONIC
	db 23, WHIRLWIND
	db 28, GUST
	db 34, PSYBEAM
	db 40, SAFEGUARD
	db 0 ; no more level-up moves

WeedleEvosAttacks:
	db EVOLVE_LEVEL, 7, KAKUNA
	db 0 ; no more evolutions
	db 1, POISON_STING
	db 1, STRING_SHOT
	db 0 ; no more level-up moves

KakunaEvosAttacks:
	db EVOLVE_LEVEL, 10, BEEDRILL
	db 0 ; no more evolutions
	db 1, HARDEN
	db 1, POISON_STING
	db 1, STRING_SHOT
	db 7, HARDEN
	db 0 ; no more level-up moves

BeedrillEvosAttacks:
	db 0 ; no more evolutions
	db 1, FURY_ATTACK
	db 10, PIN_MISSILE
	db 10, RAGE
	db 12, FOCUS_ENERGY
	db 15, TWINEEDLE
	db 18, PURSUIT
	db 30, SWORDS_DANCE
	db 40, AGILITY
	db 0 ; no more level-up moves

PidgeyEvosAttacks:
	db EVOLVE_LEVEL, 18, PIDGEOTTO
	db 0 ; no more evolutions
	db 1, TACKLE
	db 5, SAND_ATTACK
	db 7, GUST
	db 13, QUICK_ATTACK
	db 19, WHIRLWIND
	db 25, WING_ATTACK
	db 30, MUD_SLAP
	db 42, AGILITY
	db 47, SKY_ATTACK
	db 55, MIRROR_MOVE
	db 0 ; no more level-up moves

PidgeottoEvosAttacks:
	db EVOLVE_LEVEL, 36, PIDGEOT
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, SAND_ATTACK
	db 1, GUST
	db 13, QUICK_ATTACK
	db 19, WHIRLWIND
	db 25, WING_ATTACK
	db 30, MUD_SLAP
	db 42, AGILITY
	db 47, SKY_ATTACK
	db 55, MIRROR_MOVE
	db 0 ; no more level-up moves

PidgeotEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, SAND_ATTACK
	db 1, GUST
	db 1, QUICK_ATTACK
	db 19, WHIRLWIND
	db 25, WING_ATTACK
	db 30, MUD_SLAP
	db 36, EXTREMESPEED
	db 42, AGILITY
	db 47, SKY_ATTACK
	db 55, MIRROR_MOVE
	db 0 ; no more level-up moves

RattataEvosAttacks:
	db EVOLVE_LEVEL, 20, RATICATE
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, TAIL_WHIP
	db 7, QUICK_ATTACK
	db 13, HYPER_FANG
	db 20, PURSUIT
	db 25, FOCUS_ENERGY
	db 40, SUPER_FANG
	db 45, CRUNCH
	db 0 ; no more level-up moves

RaticateEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, TAIL_WHIP
	db 1, QUICK_ATTACK
	db 13, HYPER_FANG
	db 20, SCARY_FACE
	db 25, FOCUS_ENERGY
	db 30, PURSUIT
	db 40, SUPER_FANG
	db 45, CRUNCH
	db 0 ; no more level-up moves

SpearowEvosAttacks:
	db EVOLVE_LEVEL, 20, FEAROW
	db 0 ; no more evolutions
	db 1, PECK
	db 1, GROWL
	db 7, LEER
	db 10, FURY_ATTACK
	db 15, PURSUIT
	db 31, MIRROR_MOVE
	db 37, DRILL_PECK
	db 43, AGILITY
	db 0 ; no more level-up moves

FearowEvosAttacks:
	db 0 ; no more evolutions
	db 1, PECK
	db 1, GROWL
	db 1, LEER
	db 1, FURY_ATTACK
	db 15, PURSUIT
	db 31, MIRROR_MOVE
	db 37, DRILL_PECK
	db 43, AGILITY
	db 0 ; no more level-up moves

EkansEvosAttacks:
	db EVOLVE_LEVEL, 22, ARBOK
	db 0 ; no more evolutions
	db 1, WRAP
	db 1, LEER
	db 9, POISON_STING
	db 15, BITE
	db 18, ACID
	db 25, GLARE
	db 27, SLUDGE
	db 30, SCREECH
	db 36, SLUDGE_BOMB
	db 43, HAZE
	db 0 ; no more level-up moves

ArbokEvosAttacks:
	db 0 ; no more evolutions
	db 1, WRAP
	db 1, LEER
	db 1, POISON_STING
	db 1, BITE
	db 18, ACID
	db 22, SUBSTITUTE
	db 25, GLARE
	db 27, SLUDGE
	db 30, SCREECH
	db 36, SLUDGE_BOMB
	db 43, HAZE
	db 0 ; no more level-up moves

PikachuEvosAttacks:
	db EVOLVE_ITEM, THUNDERSTONE, RAICHU
	db 0 ; no more evolutions
	db 1, THUNDERSHOCK
	db 1, GROWL
	db 6, TAIL_WHIP
	db 8, THUNDER_WAVE
	db 11, QUICK_ATTACK
	db 15, DOUBLE_TEAM
	db 20, SLAM
	db 26, THUNDERBOLT
	db 33, AGILITY
	db 41, THUNDER
	db 50, LIGHT_SCREEN
	db 0 ; no more level-up moves

RaichuEvosAttacks:
	db 0 ; no more evolutions
	db 1, THUNDERSHOCK
	db 1, GROWL
	db 1, TAIL_WHIP
	db 1, THUNDER_WAVE
	db 11, QUICK_ATTACK
	db 15, DOUBLE_TEAM
	db 20, SLAM
	db 26, THUNDERBOLT
	db 33, AGILITY
	db 41, THUNDER
	db 50, LIGHT_SCREEN
	db 0 ; no more level-up moves

SandshrewEvosAttacks:
	db EVOLVE_LEVEL, 22, SANDSLASH
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, FURY_SWIPES
	db 6, DEFENSE_CURL
	db 9, MUD_SLAP
	db 11, SAND_ATTACK
	db 15, ROLLOUT
	db 19, METAL_CLAW
	db 25, SLASH
	db 30, CUT
	db 35, SANDSTORM
	db 40, EARTHQUAKE
	db 0 ; no more level-up moves

SandslashEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, FURY_SWIPES
	db 6, DEFENSE_CURL
	db 9, MUD_SLAP
	db 11, SAND_ATTACK
	db 15, ROLLOUT
	db 19, METAL_CLAW
	db 22, DIG
	db 25, SLASH
	db 30, CUT
	db 35, SANDSTORM
	db 40, EARTHQUAKE
	db 48, SPIKE_CANNON
	db 0 ; no more level-up moves

NidoranFEvosAttacks:
	db EVOLVE_LEVEL, 16, NIDORINA
	db 0 ; no more evolutions
	db 1, GROWL
	db 1, TACKLE
	db 8, SCRATCH
	db 12, DOUBLE_KICK
	db 17, POISON_STING
	db 23, TAIL_WHIP
	db 30, BITE
	db 38, FURY_SWIPES
	db 0 ; no more level-up moves

NidorinaEvosAttacks:
	db EVOLVE_ITEM, MOON_STONE, NIDOQUEEN
	db 0 ; no more evolutions
	db 1, GROWL
	db 1, TACKLE
	db 1, SCRATCH
	db 12, DOUBLE_KICK
	db 17, POISON_STING
	db 23, TAIL_WHIP
	db 30, BITE
	db 38, FURY_SWIPES
	db 0 ; no more level-up moves

NidoqueenEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, SCRATCH
	db 1, DOUBLE_KICK
	db 1, TAIL_WHIP
	db 23, BODY_SLAM
	db 27, MAGNITUDE
	db 36, SLUDGE_BOMB
	db 0 ; no more level-up moves

NidoranMEvosAttacks:
	db EVOLVE_LEVEL, 16, NIDORINO
	db 0 ; no more evolutions
	db 1, LEER
	db 1, TACKLE
	db 8, HORN_ATTACK
	db 12, DOUBLE_KICK
	db 17, POISON_STING
	db 23, FOCUS_ENERGY
	db 30, FURY_ATTACK
	db 38, HORN_DRILL
	db 0 ; no more level-up moves

NidorinoEvosAttacks:
	db EVOLVE_ITEM, MOON_STONE, NIDOKING
	db 0 ; no more evolutions
	db 1, LEER
	db 1, TACKLE
	db 8, HORN_ATTACK
	db 12, DOUBLE_KICK
	db 17, POISON_STING
	db 23, FOCUS_ENERGY
	db 30, FURY_ATTACK
	db 38, HORN_DRILL
	db 0 ; no more level-up moves

NidokingEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, HORN_ATTACK
	db 1, DOUBLE_KICK
	db 1, POISON_STING
	db 23, THRASH
	db 27, MAGNITUDE
	db 36, SLUDGE_BOMB
	db 0 ; no more level-up moves

ClefairyEvosAttacks:
	db EVOLVE_ITEM, MOON_STONE, CLEFABLE
	db 0 ; no more evolutions
	db 1, POUND
	db 1, GROWL
	db 6, ENCORE
	db 8, SING
	db 13, DOUBLESLAP
	db 19, MINIMIZE
	db 26, DEFENSE_CURL
	db 30, METRONOME
	db 35, BODY_SLAM
	db 43, MOONLIGHT
	db 53, LIGHT_SCREEN
	db 0 ; no more level-up moves

ClefableEvosAttacks:
	db 0 ; no more evolutions
	db 1, POUND
	db 1, GROWL
	db 6, ENCORE
	db 8, SING
	db 13, DOUBLESLAP
	db 19, MINIMIZE
	db 26, DEFENSE_CURL
	db 30, METRONOME
	db 35, BODY_SLAM
	db 43, MOONLIGHT
	db 53, LIGHT_SCREEN
	db 0 ; no more level-up moves

VulpixEvosAttacks:
	db EVOLVE_ITEM, FIRE_STONE, NINETALES
	db 0 ; no more evolutions
	db 1, EMBER
	db 1, TAIL_WHIP
	db 7, QUICK_ATTACK
	db 13, ROAR
	db 16, CONFUSE_RAY
	db 20, FLAME_WHEEL
	db 25, SAFEGUARD
	db 32, FLAMETHROWER
	db 37, SHADOW_BALL
	db 40, SUNNY_DAY
	db 45, FIRE_SPIN
	db 55, FIRE_BLAST
	db 0 ; no more level-up moves

NinetalesEvosAttacks:
	db 0 ; no more evolutions
	db 1, EMBER
	db 1, TAIL_WHIP
	db 1, QUICK_ATTACK
	db 1, ROAR
	db 16, CONFUSE_RAY
	db 20, FLAME_WHEEL
	db 25, SAFEGUARD
	db 32, FLAMETHROWER
	db 37, SHADOW_BALL
	db 40, SUNNY_DAY
	db 45, FIRE_SPIN
	db 55, FIRE_BLAST
	db 0 ; no more level-up moves

JigglypuffEvosAttacks:
	db EVOLVE_ITEM, MOON_STONE, WIGGLYTUFF
	db 0 ; no more evolutions
	db 1, SING
	db 1, POUND
	db 6, DEFENSE_CURL
	db 9, CHARM
	db 14, DISABLE
	db 16, DOUBLESLAP
	db 19, ROLLOUT
	db 24, LOVELY_KISS
	db 29, REST
	db 34, BODY_SLAM
	db 39, DOUBLE_EDGE
	db 0 ; no more level-up moves

WigglytuffEvosAttacks:
	db 0 ; no more evolutions
	db 1, SING
	db 1, POUND
	db 6, DEFENSE_CURL
	db 9, CHARM
	db 14, DISABLE
	db 16, DOUBLESLAP
	db 19, ROLLOUT
	db 24, LOVELY_KISS
	db 29, REST
	db 34, BODY_SLAM
	db 39, DOUBLE_EDGE
	db 0 ; no more level-up moves

ZubatEvosAttacks:
	db EVOLVE_LEVEL, 22, GOLBAT
	db 0 ; no more evolutions
	db 1, LEECH_LIFE
	db 5, SUPERSONIC
	db 7, GUST
	db 12, BITE
	db 19, CONFUSE_RAY
	db 23, WING_ATTACK
	db 27, SLUDGE
	db 36, SLUDGE_BOMB
	db 42, MEAN_LOOK
	db 48, HAZE
	db 0 ; no more level-up moves

GolbatEvosAttacks:
	db EVOLVE_HAPPINESS, TR_ANYTIME, CROBAT
	db 0 ; no more evolutions
	db 1, SCREECH
	db 1, LEECH_LIFE
	db 1, SUPERSONIC
	db 1, GUST
	db 12, BITE
	db 19, CONFUSE_RAY
	db 22, WING_ATTACK
	db 27, SLUDGE
	db 36, SLUDGE_BOMB
	db 42, MEAN_LOOK
	db 48, HAZE
	db 0 ; no more level-up moves

OddishEvosAttacks:
	db EVOLVE_LEVEL, 21, GLOOM
	db 0 ; no more evolutions
	db 1, ABSORB
	db 7, SWEET_SCENT
	db 14, POISONPOWDER
	db 16, STUN_SPORE
	db 18, SLEEP_POWDER
	db 22, MEGA_DRAIN
	db 24, ACID
	db 32, GIGA_DRAIN
	db 35, MOONLIGHT
	db 44, PETAL_DANCE
	db 0 ; no more level-up moves

GloomEvosAttacks:
	db EVOLVE_ITEM, LEAF_STONE, VILEPLUME
	db EVOLVE_ITEM, SUN_STONE, BELLOSSOM
	db 0 ; no more evolutions
	db 1, ABSORB
	db 1, SWEET_SCENT
	db 1, POISONPOWDER
	db 16, STUN_SPORE
	db 18, SLEEP_POWDER
	db 21, MEGA_DRAIN
	db 24, ACID
	db 32, GIGA_DRAIN
	db 35, MOONLIGHT
	db 44, PETAL_DANCE
	db 0 ; no more level-up moves

VileplumeEvosAttacks:
	db 0 ; no more evolutions
	db 1, ABSORB
	db 1, SWEET_SCENT
	db 1, POISONPOWDER
	db 1, STUN_SPORE
	db 18, SLEEP_POWDER
	db 21, MEGA_DRAIN
	db 24, ACID
	db 32, GIGA_DRAIN
	db 35, MOONLIGHT
	db 44, PETAL_DANCE
	db 0 ; no more level-up moves

ParasEvosAttacks:
	db EVOLVE_LEVEL, 24, PARASECT
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 5, ABSORB
	db 7, STUN_SPORE
	db 13, POISONPOWDER
	db 16, MEGA_DRAIN
	db 19, LEECH_LIFE
	db 24, SPORE
	db 31, SLASH
	db 36, GROWTH
	db 40, GIGA_DRAIN
	db 0 ; no more level-up moves

ParasectEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, ABSORB
	db 1, STUN_SPORE
	db 13, POISONPOWDER
	db 16, MEGA_DRAIN
	db 19, LEECH_LIFE
	db 24, SPORE
	db 31, SLASH
	db 36, GROWTH
	db 40, GIGA_DRAIN
	db 0 ; no more level-up moves

VenonatEvosAttacks:
	db EVOLVE_LEVEL, 31, VENOMOTH
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, DISABLE
	db 1, FORESIGHT
	db 9, SUPERSONIC
	db 13, LEECH_LIFE
	db 17, CONFUSION
	db 20, POISONPOWDER
	db 28, STUN_SPORE
	db 34, PSYBEAM
	db 38, SLEEP_POWDER
	db 43, SLUDGE_BOMB
	db 50, PSYCHIC_M
	db 0 ; no more level-up moves

VenomothEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, DISABLE
	db 1, FORESIGHT
	db 1, SUPERSONIC
	db 13, LEECH_LIFE
	db 17, CONFUSION
	db 20, POISONPOWDER
	db 28, STUN_SPORE
	db 31, GUST
	db 34, PSYBEAM
	db 38, SLEEP_POWDER
	db 43, SLUDGE_BOMB
	db 50, PSYCHIC_M
	db 0 ; no more level-up moves

DiglettEvosAttacks:
	db EVOLVE_LEVEL, 26, DUGTRIO
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 5, GROWL
	db 9, MAGNITUDE
	db 17, DIG
	db 25, SAND_ATTACK
	db 33, SLASH
	db 41, EARTHQUAKE
	db 49, FISSURE
	db 0 ; no more level-up moves

DugtrioEvosAttacks:
	db 0 ; no more evolutions
	db 1, TRI_ATTACK
	db 1, SCRATCH
	db 1, GROWL
	db 1, MAGNITUDE
	db 17, DIG
	db 25, SAND_ATTACK
	db 33, SLASH
	db 41, EARTHQUAKE
	db 49, FISSURE
	db 0 ; no more level-up moves

MeowthEvosAttacks:
	db EVOLVE_LEVEL, 28, PERSIAN
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, GROWL
	db 1, BITE
	db 20, PAY_DAY
	db 28, FAINT_ATTACK
	db 33, SLASH
	db 38, SCREECH
	db 41, FURY_SWIPES
	db 46, DOUBLE_EDGE
	db 0 ; no more level-up moves

PersianEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, GROWL
	db 1, BITE
	db 11, BITE
	db 20, PAY_DAY
	db 28, FAINT_ATTACK
	db 33, SLASH
	db 38, SCREECH
	db 41, FURY_SWIPES
	db 46, DOUBLE_EDGE
	db 50, HYPER_BEAM
	db 0 ; no more level-up moves

PsyduckEvosAttacks:
	db EVOLVE_LEVEL, 33, GOLDUCK
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 5, TAIL_WHIP
	db 8, WATER_GUN
	db 10, DISABLE
	db 15, CONFUSION
	db 17, BUBBLEBEAM
	db 23, SCREECH
	db 31, PSYCH_UP
	db 37, FURY_SWIPES
	db 42, PSYCHIC_M
	db 50, HYDRO_PUMP
	db 0 ; no more level-up moves

GolduckEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, TAIL_WHIP
	db 1, WATER_GUN
	db 1, DISABLE
	db 15, CONFUSION
	db 17, BUBBLEBEAM
	db 23, SCREECH
	db 31, PSYCH_UP
	db 37, FURY_SWIPES
	db 42, PSYCHIC_M
	db 50, HYDRO_PUMP
	db 0 ; no more level-up moves

MankeyEvosAttacks:
	db EVOLVE_LEVEL, 28, PRIMEAPE
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, LEER
	db 9, LOW_KICK
	db 15, KARATE_CHOP
	db 21, FURY_SWIPES
	db 27, FOCUS_ENERGY
	db 33, SEISMIC_TOSS
	db 39, CROSS_CHOP
	db 45, SCREECH
	db 51, THRASH
	db 0 ; no more level-up moves

PrimeapeEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, LEER
	db 1, LOW_KICK
	db 1, RAGE
	db 15, KARATE_CHOP
	db 21, FURY_SWIPES
	db 27, FOCUS_ENERGY
	db 28, RAGE
	db 33, SEISMIC_TOSS
	db 39, CROSS_CHOP
	db 45, SCREECH
	db 51, THRASH
	db 0 ; no more level-up moves

GrowlitheEvosAttacks:
	db EVOLVE_ITEM, FIRE_STONE, ARCANINE
	db 0 ; no more evolutions
	db 1, ROAR
	db 1, EMBER
	db 5, GROWL
	db 9, BITE
	db 18, LEER
	db 26, FLAME_WHEEL
	db 30, TAKE_DOWN
	db 35, FLAMETHROWER
	db 36, AGILITY
	db 0 ; no more level-up moves

ArcanineEvosAttacks:
	db 0 ; no more evolutions
	db 1, AGILITY
	db 1, FLAME_WHEEL
	db 1, TAKE_DOWN
	db 1, BITE
	db 20, ROAR
	db 45, FLAMETHROWER
	db 50, EXTREMESPEED
	db 0 ; no more level-up moves

PoliwagEvosAttacks:
	db EVOLVE_LEVEL, 25, POLIWHIRL
	db 0 ; no more evolutions
	db 1, BUBBLE
	db 5, MIST
	db 7, HYPNOSIS
	db 10, WATER_GUN
	db 14, DOUBLESLAP
	db 20, BUBBLEBEAM
	db 25, RAIN_DANCE
	db 31, BODY_SLAM
	db 43, BELLY_DRUM
	db 48, HYDRO_PUMP
	db 0 ; no more level-up moves

PoliwhirlEvosAttacks:
	db EVOLVE_ITEM, WATER_STONE, POLIWRATH
	db EVOLVE_ITEM, KINGS_ROCK, POLITOED
	db 0 ; no more evolutions
	db 1, BUBBLE
	db 1, MIST
	db 1, HYPNOSIS
	db 10, WATER_GUN
	db 14, DOUBLESLAP
	db 20, BUBBLEBEAM
	db 25, RAIN_DANCE
	db 31, BODY_SLAM
	db 43, BELLY_DRUM
	db 48, HYDRO_PUMP
	db 0 ; no more level-up moves

PoliwrathEvosAttacks:
	db 0 ; no more evolutions
	db 1, BUBBLE
	db 1, MIST
	db 1, HYPNOSIS
	db 1, SUBMISSION
	db 10, WATER_GUN
	db 14, DOUBLESLAP
	db 20, BUBBLEBEAM
	db 25, RAIN_DANCE
	db 31, BODY_SLAM
	db 35, SUBMISSION
	db 43, BELLY_DRUM
	db 48, HYDRO_PUMP
	db 51, MIND_READER
	db 0 ; no more level-up moves

AbraEvosAttacks:
	db EVOLVE_LEVEL, 16, KADABRA
	db 0 ; no more evolutions
	db 1, TELEPORT
	db 0 ; no more level-up moves

KadabraEvosAttacks:
	db EVOLVE_LEVEL, 42, ALAKAZAM
	db 0 ; no more evolutions
	db 1, TELEPORT
	db 1, KINESIS
	db 1, CONFUSION
	db 16, CONFUSION
	db 18, DISABLE
	db 21, PSYBEAM
	db 26, RECOVER
	db 31, FUTURE_SIGHT
	db 38, PSYCHIC_M
	db 45, REFLECT
	db 0 ; no more level-up moves

AlakazamEvosAttacks:
	db 0 ; no more evolutions
	db 1, TELEPORT
	db 1, KINESIS
	db 1, CONFUSION
	db 16, CONFUSION
	db 18, DISABLE
	db 21, PSYBEAM
	db 26, RECOVER
	db 31, FUTURE_SIGHT
	db 38, PSYCHIC_M
	db 45, REFLECT
	db 0 ; no more level-up moves

MachopEvosAttacks:
	db EVOLVE_LEVEL, 28, MACHOKE
	db 0 ; no more evolutions
	db 1, LOW_KICK
	db 1, LEER
	db 7, FOCUS_ENERGY
	db 13, KARATE_CHOP
	db 19, SEISMIC_TOSS
	db 25, FORESIGHT
	db 31, VITAL_THROW
	db 43, CROSS_CHOP
	db 50, SCARY_FACE
	db 55, SUBMISSION
	db 0 ; no more level-up moves

MachokeEvosAttacks:
	db EVOLVE_LEVEL, 38, MACHAMP
	db 0 ; no more evolutions
	db 1, LOW_KICK
	db 1, LEER
	db 1, FOCUS_ENERGY
	db 13, KARATE_CHOP
	db 19, SEISMIC_TOSS
	db 25, FORESIGHT
	db 31, VITAL_THROW
	db 43, CROSS_CHOP
	db 50, SCARY_FACE
	db 55, SUBMISSION
	db 0 ; no more level-up moves

MachampEvosAttacks:
	db 0 ; no more evolutions
	db 1, LOW_KICK
	db 1, LEER
	db 1, FOCUS_ENERGY
	db 1, KARATE_CHOP
	db 19, SEISMIC_TOSS
	db 25, FORESIGHT
	db 31, VITAL_THROW
	db 43, CROSS_CHOP
	db 50, SCARY_FACE
	db 55, SUBMISSION
	db 0 ; no more level-up moves

BellsproutEvosAttacks:
	db EVOLVE_LEVEL, 21, WEEPINBELL
	db 0 ; no more evolutions
	db 1, VINE_WHIP
	db 6, GROWTH
	db 11, WRAP
	db 15, SLEEP_POWDER
	db 17, POISONPOWDER
	db 19, STUN_SPORE
	db 21, RAZOR_LEAF
	db 23, ACID
	db 30, SLUDGE
	db 33, SWEET_SCENT
	db 41, SLUDGE_BOMB
	db 45, SLAM
	db 0 ; no more level-up moves

WeepinbellEvosAttacks:
	db EVOLVE_ITEM, LEAF_STONE, VICTREEBEL
	db 0 ; no more evolutions
	db 1, VINE_WHIP
	db 1, GROWTH
	db 1, WRAP
	db 6, GROWTH
	db 11, WRAP
	db 15, SLEEP_POWDER
	db 17, POISONPOWDER
	db 19, STUN_SPORE
	db 21, ACID
	db 23, RAZOR_LEAF
	db 30, SLUDGE
	db 33, SWEET_SCENT
	db 41, SLUDGE_BOMB
	db 45, SLAM
	db 0 ; no more level-up moves

VictreebelEvosAttacks:
	db 0 ; no more evolutions
	db 1, VINE_WHIP
	db 1, GROWTH
	db 1, WRAP
	db 1, GROWTH
	db 11, WRAP
	db 15, SLEEP_POWDER
	db 17, POISONPOWDER
	db 19, STUN_SPORE
	db 21, ACID
	db 23, RAZOR_LEAF
	db 30, SLUDGE
	db 33, SWEET_SCENT
	db 41, SLUDGE_BOMB
	db 45, SLAM
	db 0 ; no more level-up moves

TentacoolEvosAttacks:
	db EVOLVE_LEVEL, 30, TENTACRUEL
	db 0 ; no more evolutions
	db 1, POISON_STING
	db 6, SUPERSONIC
	db 10, BUBBLE
	db 12, CONSTRICT
	db 16, ACID
	db 20, BUBBLEBEAM
	db 25, SLUDGE
	db 30, WRAP
	db 37, BARRIER
	db 43, SCREECH
	db 49, HYDRO_PUMP
	db 0 ; no more level-up moves

TentacruelEvosAttacks:
	db 0 ; no more evolutions
	db 1, POISON_STING
	db 1, SUPERSONIC
	db 1, BUBBLE
	db 1, CONSTRICT
	db 16, ACID
	db 20, SLUDGE
	db 25, BUBBLEBEAM
	db 30, WRAP
	db 37, BARRIER
	db 42, SLUDGE_BOMB
	db 47, SCREECH
	db 55, HYDRO_PUMP
	db 0 ; no more level-up moves

GeodudeEvosAttacks:
	db EVOLVE_LEVEL, 25, GRAVELER
	db 0 ; no more evolutions
	db 1, TACKLE
	db 6, DEFENSE_CURL
	db 11, ROCK_THROW
	db 16, MAGNITUDE
	db 21, SELFDESTRUCT
	db 27, HARDEN
	db 34, ROLLOUT
	db 40, ROCK_SLIDE
	db 45, EARTHQUAKE
	db 48, EXPLOSION
	db 0 ; no more level-up moves

GravelerEvosAttacks:
	db EVOLVE_LEVEL, 38, GOLEM
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, DEFENSE_CURL
	db 1, ROCK_THROW
	db 16, MAGNITUDE
	db 21, SELFDESTRUCT
	db 27, HARDEN
	db 34, ROLLOUT
	db 40, ROCK_SLIDE
	db 45, EARTHQUAKE
	db 48, EXPLOSION
	db 0 ; no more level-up moves

GolemEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, DEFENSE_CURL
	db 1, ROCK_THROW
	db 1, MAGNITUDE
	db 21, SELFDESTRUCT
	db 27, HARDEN
	db 34, ROLLOUT
	db 40, ROCK_SLIDE
	db 45, EARTHQUAKE
	db 48, EXPLOSION
	db 0 ; no more level-up moves

PonytaEvosAttacks:
	db EVOLVE_LEVEL, 40, RAPIDASH
	db 0 ; no more evolutions
	db 1, TACKLE
	db 4, GROWL
	db 8, TAIL_WHIP
	db 11, EMBER
	db 17, STOMP
	db 20, FLAME_WHEEL
	db 25, DOUBLE_KICK
	db 33, FLAMETHROWER
	db 36, TAKE_DOWN
	db 39, FIRE_SPIN
	db 45, AGILITY
	db 51, FIRE_BLAST
	db 0 ; no more level-up moves

RapidashEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 1, TAIL_WHIP
	db 1, EMBER
	db 17, STOMP
	db 20, FLAME_WHEEL
	db 25, DOUBLE_KICK
	db 33, TAKE_DOWN
	db 36, FLAMETHROWER
	db 39, FIRE_SPIN
	db 40, FURY_ATTACK
	db 45, AGILITY
	db 51, FIRE_BLAST
	db 0 ; no more level-up moves

SlowpokeEvosAttacks:
	db EVOLVE_LEVEL, 37, SLOWBRO
	db EVOLVE_ITEM, KINGS_ROCK, SLOWKING
	db 0 ; no more evolutions
	db 1, CURSE
	db 1, TACKLE
	db 6, GROWL
	db 13, WATER_GUN
	db 18, CONFUSION
	db 24, DISABLE
	db 29, PSYBEAM
	db 34, HEADBUTT
	db 41, AMNESIA
	db 45, PSYCHIC_M
	db 0 ; no more level-up moves

SlowbroEvosAttacks:
	db 0 ; no more evolutions
	db 1, CURSE
	db 1, TACKLE
	db 1, GROWL
	db 1, WATER_GUN
	db 18, CONFUSION
	db 24, DISABLE
	db 29, PSYBEAM
	db 34, HEADBUTT
	db 37, WITHDRAW
	db 41, AMNESIA
	db 45, PSYCHIC_M
	db 0 ; no more level-up moves

MagnemiteEvosAttacks:
	db EVOLVE_LEVEL, 30, MAGNETON
	db 0 ; no more evolutions
	db 1, TACKLE
	db 6, THUNDERSHOCK
	db 11, SUPERSONIC
	db 16, SONICBOOM
	db 21, THUNDER_WAVE
	db 25, SPARK
	db 33, SWIFT
	db 37, THUNDERBOLT
	db 40, LOCK_ON
	db 43, SCREECH
	db 51, ZAP_CANNON
	db 0 ; no more level-up moves

MagnetonEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, THUNDERSHOCK
	db 1, SUPERSONIC
	db 1, SONICBOOM
	db 21, THUNDER_WAVE
	db 25, SPARK
	db 33, TRI_ATTACK
	db 37, THUNDERBOLT
	db 40, LOCK_ON
	db 43, SCREECH
	db 51, ZAP_CANNON
	db 0 ; no more level-up moves

FarfetchDEvosAttacks:
	db 0 ; no more evolutions
	db 1, PECK
	db 7, SAND_ATTACK
	db 13, LEER
	db 19, FURY_ATTACK
	db 25, SWORDS_DANCE
	db 31, AGILITY
	db 35, SLASH
	db 40, FALSE_SWIPE
	db 45, BATON_PASS
	db 0 ; no more level-up moves

DoduoEvosAttacks:
	db EVOLVE_LEVEL, 31, DODRIO
	db 0 ; no more evolutions
	db 1, GROWL
	db 1, PECK
	db 9, PURSUIT
	db 13, FURY_ATTACK
	db 21, TRI_ATTACK
	db 27, RAGE
	db 38, DRILL_PECK
	db 44, AGILITY
	db 56, DOUBLE_EDGE
	db 0 ; no more level-up moves

DodrioEvosAttacks:
	db 0 ; no more evolutions
	db 1, PECK
	db 1, GROWL
	db 1, PURSUIT
	db 1, FURY_ATTACK
	db 9, PURSUIT
	db 13, FURY_ATTACK
	db 21, RAGE
	db 27, TRI_ATTACK
	db 38, DRILL_PECK
	db 44, AGILITY
	db 56, DOUBLE_EDGE
	db 0 ; no more level-up moves

SeelEvosAttacks:
	db EVOLVE_LEVEL, 34, DEWGONG
	db 0 ; no more evolutions
	db 1, HEADBUTT
	db 1, GROWL
	db 5, WATER_GUN
	db 16, AURORA_BEAM
	db 21, REST
	db 25, BUBBLEBEAM
	db 32, TAKE_DOWN
	db 40, ICE_BEAM
	db 44, SAFEGUARD
	db 54, BLIZZARD
	db 0 ; no more level-up moves

DewgongEvosAttacks:
	db 0 ; no more evolutions
	db 1, HEADBUTT
	db 1, GROWL
	db 1, WATER_GUN
	db 1, AURORA_BEAM
	db 21, REST
	db 25, BUBBLEBEAM
	db 32, TAKE_DOWN
	db 40, ICE_BEAM
	db 44, SAFEGUARD
	db 54, BLIZZARD
	db 0 ; no more level-up moves

GrimerEvosAttacks:
	db EVOLVE_LEVEL, 38, MUK
	db 0 ; no more evolutions
	db 1, POISON_GAS
	db 1, POUND
	db 5, HARDEN
	db 10, DISABLE
	db 16, SLUDGE
	db 23, MINIMIZE
	db 31, SCREECH
	db 38, SLUDGE_BOMB
	db 45, ACID_ARMOR
	db 0 ; no more level-up moves

MukEvosAttacks:
	db 0 ; no more evolutions
	; moves are not sorted by level
	db 1, POISON_GAS
	db 1, POUND
	db 1, HARDEN
	db 1, DISABLE
	db 16, SLUDGE
	db 23, MINIMIZE
	db 31, SCREECH
	db 38, SLUDGE_BOMB
	db 45, ACID_ARMOR
	db 0 ; no more level-up moves

ShellderEvosAttacks:
	db EVOLVE_ITEM, WATER_STONE, CLOYSTER
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, WITHDRAW
	db 9, SUPERSONIC
	db 17, AURORA_BEAM
	db 25, PROTECT
	db 33, LEER
	db 35, CLAMP
	db 37, ICE_BEAM
	db 50, HYDRO_PUMP
	db 0 ; no more level-up moves

CloysterEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, WITHDRAW
	db 1, SUPERSONIC
	db 1, AURORA_BEAM
	db 25, PROTECT
	db 33, SPIKES
	db 35, CLAMP
	db 37, ICE_BEAM
	db 40, SPIKE_CANNON
	db 50, HYDRO_PUMP
	db 0 ; no more level-up moves

GastlyEvosAttacks:
	db EVOLVE_LEVEL, 25, HAUNTER
	db 0 ; no more evolutions
	db 1, HYPNOSIS
	db 1, LICK
	db 6, SMOG
	db 8, SPITE
	db 13, MEAN_LOOK
	db 16, CURSE
	db 21, NIGHT_SHADE
	db 28, CONFUSE_RAY
	db 33, DREAM_EATER
	db 36, DESTINY_BOND
	db 0 ; no more level-up moves

HaunterEvosAttacks:
	db EVOLVE_LEVEL, 42, GENGAR
	db 0 ; no more evolutions
	db 1, HYPNOSIS
	db 1, LICK
	db 1, SMOG
	db 8, SPITE
	db 13, MEAN_LOOK
	db 16, CURSE
	db 21, NIGHT_SHADE
	db 31, CONFUSE_RAY
	db 39, DREAM_EATER
	db 42, SHADOW_BALL
	db 48, DESTINY_BOND
	db 0 ; no more level-up moves

GengarEvosAttacks:
	db 0 ; no more evolutions
	db 1, HYPNOSIS
	db 1, LICK
	db 1, SMOG
	db 1, SPITE
	db 13, MEAN_LOOK
	db 16, CURSE
	db 21, NIGHT_SHADE
	db 31, CONFUSE_RAY
	db 39, DREAM_EATER
	db 42, SHADOW_BALL
	db 48, DESTINY_BOND
	db 0 ; no more level-up moves

OnixEvosAttacks:
	db EVOLVE_ITEM, METAL_COAT, STEELIX
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, SCREECH
	db 10, BIND
	db 12, ROCK_THROW
	db 18, DIG
	db 23, HARDEN
	db 27, RAGE
	db 30, ROCK_SLIDE
	db 36, SANDSTORM
	db 40, EARTHQUAKE
	db 49, SLAM
	db 0 ; no more level-up moves

DrowzeeEvosAttacks:
	db EVOLVE_LEVEL, 26, HYPNO
	db 0 ; no more evolutions
	db 1, POUND
	db 1, HYPNOSIS
	db 10, DISABLE
	db 18, CONFUSION
	db 25, HEADBUTT
	db 31, POISON_GAS
	db 36, MEDITATE
	db 40, PSYCHIC_M
	db 47, PSYCH_UP
	db 54, FUTURE_SIGHT
	db 0 ; no more level-up moves

HypnoEvosAttacks:
	db 0 ; no more evolutions
	db 1, POUND
	db 1, HYPNOSIS
	db 1, DISABLE
	db 1, CONFUSION
	db 25, HEADBUTT
	db 31, POISON_GAS
	db 38, MEDITATE
	db 42, PSYCHIC_M
	db 47, PSYCH_UP
	db 54, FUTURE_SIGHT
	db 0 ; no more level-up moves

KrabbyEvosAttacks:
	db EVOLVE_LEVEL, 28, KINGLER
	db 0 ; no more evolutions
	db 1, BUBBLE
	db 5, LEER
	db 12, VICEGRIP
	db 16, HARDEN
	db 23, STOMP
	db 27, GUILLOTINE
	db 29, METAL_CLAW
	db 37, PROTECT
	db 51, CRABHAMMER
	db 0 ; no more level-up moves

KinglerEvosAttacks:
	db 0 ; no more evolutions
	db 1, BUBBLE
	db 1, LEER
	db 1, VICEGRIP
	db 16, HARDEN
	db 23, STOMP
	db 27, CRABHAMMER
	db 28, METAL_CLAW
	db 37, PROTECT
	db 44, GUILLOTINE
	db 51, CRABHAMMER
	db 0 ; no more level-up moves

VoltorbEvosAttacks:
	db EVOLVE_LEVEL, 30, ELECTRODE
	db 0 ; no more evolutions
	db 1, TACKLE
	db 9, SCREECH
	db 17, SONICBOOM
	db 19, SPARK
	db 23, SELFDESTRUCT
	db 29, ROLLOUT
	db 34, LIGHT_SCREEN
	db 40, THUNDER
	db 44, EXPLOSION
	db 48, MIRROR_COAT
	db 0 ; no more level-up moves

ElectrodeEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, SCREECH
	db 1, SONICBOOM
	db 1, SPARK
	db 23, SELFDESTRUCT
	db 29, ROLLOUT
	db 34, LIGHT_SCREEN
	db 40, THUNDER
	db 44, EXPLOSION
	db 48, MIRROR_COAT
	db 0 ; no more level-up moves

ExeggcuteEvosAttacks:
	db EVOLVE_ITEM, LEAF_STONE, EXEGGUTOR
	db 0 ; no more evolutions
	db 1, BARRAGE
	db 1, HYPNOSIS
	db 7, REFLECT
	db 13, LEECH_SEED
	db 19, CONFUSION
	db 20, MEGA_DRAIN
	db 25, STUN_SPORE
	db 25, POISONPOWDER
	db 28, PSYBEAM
	db 32, GIGA_DRAIN
	db 37, SLEEP_POWDER
	db 42, SOLARBEAM
	db 45, PSYCHIC_M
	db 0 ; no more level-up moves

ExeggutorEvosAttacks:
	db 0 ; no more evolutions
	db 1, GIGA_DRAIN
	db 1, BARRAGE
	db 1, HYPNOSIS
	db 1, REFLECT
	db 9, LEECH_SEED
	db 13, STOMP
	db 17, CONFUSION
	db 20, MEGA_DRAIN
	db 25, STUN_SPORE
	db 25, POISONPOWDER
	db 28, PSYBEAM
	db 32, EGG_BOMB
	db 37, SLEEP_POWDER
	db 42, SOLARBEAM
	db 45, PSYCHIC_M
	db 0 ; no more level-up moves

CuboneEvosAttacks:
	db EVOLVE_LEVEL, 28, MAROWAK
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 5, TAIL_WHIP
	db 8, BONE_CLUB
	db 13, HEADBUTT
	db 15, FALSE_SWIPE
	db 17, LEER
	db 21, FOCUS_ENERGY
	db 25, BONEMERANG
	db 32, RAGE
	db 37, THRASH
	db 41, BONE_RUSH
	db 0 ; no more level-up moves

MarowakEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 1, TAIL_WHIP
	db 1, BONE_CLUB
	db 13, HEADBUTT
	db 15, FALSE_SWIPE
	db 17, LEER
	db 21, FOCUS_ENERGY
	db 25, BONEMERANG
	db 32, RAGE
	db 37, THRASH
	db 41, BONE_RUSH
	db 0 ; no more level-up moves

HitmonleeEvosAttacks:
	db 0 ; no more evolutions
	db 1, DOUBLE_KICK
	db 20, MEDITATE
	db 20, ROLLING_KICK
	db 20, JUMP_KICK
	db 21, FOCUS_ENERGY
	db 25, FORESIGHT
	db 31, MIND_READER
	db 36, HI_JUMP_KICK
	db 41, ENDURE
	db 46, MEGA_KICK
	db 51, REVERSAL
	db 0 ; no more level-up moves

HitmonchanEvosAttacks:
	db 0 ; no more evolutions
	db 1, COMET_PUNCH
	db 20, AGILITY
	db 20, PURSUIT
	db 20, MACH_PUNCH
	db 26, THUNDERPUNCH
	db 26, ICE_PUNCH
	db 26, FIRE_PUNCH
	db 32, MEGA_PUNCH
	db 38, DYNAMICPUNCH
	db 44, DETECT
	db 50, COUNTER
	db 0 ; no more level-up moves

LickitungEvosAttacks:
	db 0 ; no more evolutions
	db 1, LICK
	db 1, WRAP
	db 7, SUPERSONIC
	db 13, STOMP
	db 17, ROLLOUT
	db 21, SLAM
	db 25, CURSE
	db 28, DISABLE
	db 32, BODY_SLAM
	db 40, BELLY_DRUM
	db 43, SCREECH
	db 0 ; no more level-up moves

KoffingEvosAttacks:
	db EVOLVE_LEVEL, 35, WEEZING
	db 0 ; no more evolutions
	db 1, POISON_GAS
	db 1, TACKLE
	db 9, SMOG
	db 15, SELFDESTRUCT
	db 19, SLUDGE
	db 23, SMOKESCREEN
	db 29, HAZE
	db 33, AMNESIA
	db 36, SLUDGE_BOMB
	db 41, EXPLOSION
	db 45, DESTINY_BOND
	db 0 ; no more level-up moves

WeezingEvosAttacks:
	db 0 ; no more evolutions
	db 1, POISON_GAS
	db 1, TACKLE
	db 1, SMOG
	db 1, SELFDESTRUCT
	db 19, SLUDGE
	db 23, SMOKESCREEN
	db 29, HAZE
	db 33, AMNESIA
	db 35, SLUDGE_BOMB
	db 41, EXPLOSION
	db 45, DESTINY_BOND
	db 0 ; no more level-up moves

RhyhornEvosAttacks:
	db EVOLVE_LEVEL, 42, RHYDON
	db 0 ; no more evolutions
	db 1, HORN_ATTACK
	db 1, TAIL_WHIP
	db 8, FURY_ATTACK
	db 13, STOMP
	db 19, ROCK_THROW
	db 24, MAGNITUDE
	db 31, SCARY_FACE
	db 39, EARTHQUAKE
	db 44, ROCK_SLIDE
	db 51, TAKE_DOWN
	db 58, HORN_DRILL
	db 0 ; no more level-up moves

RhydonEvosAttacks:
	db 0 ; no more evolutions
	db 1, HORN_ATTACK
	db 1, TAIL_WHIP
	db 1, FURY_ATTACK
	db 1, STOMP
	db 19, ROCK_THROW
	db 24, MAGNITUDE
	db 31, SCARY_FACE
	db 39, EARTHQUAKE
	db 44, ROCK_SLIDE
	db 51, TAKE_DOWN
	db 58, HORN_DRILL
	db 0 ; no more level-up moves

ChanseyEvosAttacks:
	db EVOLVE_HAPPINESS, TR_ANYTIME, BLISSEY
	db 0 ; no more evolutions
	db 1, POUND
	db 4, GROWL
	db 7, TAIL_WHIP
	db 10, SOFTBOILED
	db 13, DOUBLESLAP
	db 18, MINIMIZE
	db 23, SING
	db 28, EGG_BOMB
	db 33, DEFENSE_CURL
	db 40, LIGHT_SCREEN
	db 47, DOUBLE_EDGE
	db 0 ; no more level-up moves

TangelaEvosAttacks:
	db 0 ; no more evolutions
	db 1, CONSTRICT
	db 4, SLEEP_POWDER
	db 10, ABSORB
	db 13, POISONPOWDER
	db 19, VINE_WHIP
	db 22, MEGA_DRAIN
	db 25, BIND
	db 34, STUN_SPORE
	db 37, GIGA_DRAIN
	db 46, GROWTH
	db 0 ; no more level-up moves

KangaskhanEvosAttacks:
	db 0 ; no more evolutions
	db 1, COMET_PUNCH
	db 7, LEER
	db 13, BITE
	db 19, TAIL_WHIP
	db 25, MEGA_PUNCH
	db 31, RAGE
	db 37, ENDURE
	db 40, BODY_SLAM
	db 43, DIZZY_PUNCH
	db 49, REVERSAL
	db 0 ; no more level-up moves

HorseaEvosAttacks:
	db EVOLVE_LEVEL, 32, SEADRA
	db 0 ; no more evolutions
	db 1, BUBBLE
	db 8, SMOKESCREEN
	db 13, LEER
	db 18, WATER_GUN
	db 22, BUBBLEBEAM
	db 29, TWISTER
	db 40, AGILITY
	db 51, HYDRO_PUMP
	db 0 ; no more level-up moves

SeadraEvosAttacks:
	db EVOLVE_ITEM, DRAGON_SCALE, KINGDRA
	db 0 ; no more evolutions
	db 1, BUBBLE
	db 1, SMOKESCREEN
	db 1, LEER
	db 1, WATER_GUN
	db 22, BUBBLEBEAM
	db 29, TWISTER
	db 40, AGILITY
	db 51, HYDRO_PUMP
	db 0 ; no more level-up moves

GoldeenEvosAttacks:
	db EVOLVE_LEVEL, 28, SEAKING
	db 0 ; no more evolutions
	db 1, TAIL_WHIP
	db 1, PECK
	db 5, WATER_GUN
	db 10, SUPERSONIC
	db 12, HORN_ATTACK
	db 15, WATERFALL
	db 20, FLAIL
	db 24, FURY_ATTACK
	db 30, DRILL_PECK
	db 35, MEGAHORN
	db 43, HORN_DRILL
	db 48, AGILITY
	db 53, HYDRO_PUMP
	db 0 ; no more level-up moves

SeakingEvosAttacks:
	db 0 ; no more evolutions
	db 1, TAIL_WHIP
	db 1, PECK
	db 1, WATER_GUN
	db 1, SUPERSONIC
	db 12, HORN_ATTACK
	db 15, WATERFALL
	db 20, FLAIL
	db 24, FURY_ATTACK
	db 30, DRILL_PECK
	db 35, MEGAHORN
	db 43, HORN_DRILL
	db 48, AGILITY
	db 53, HYDRO_PUMP
	db 0 ; no more level-up moves

StaryuEvosAttacks:
	db EVOLVE_ITEM, WATER_STONE, STARMIE
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, HARDEN
	db 7, WATER_GUN
	db 13, RAPID_SPIN
	db 19, RECOVER
	db 25, SWIFT
	db 27, LIGHT_SCREEN
	db 31, BUBBLEBEAM
	db 37, MINIMIZE
	db 40, PSYCHIC_M
	db 50, HYDRO_PUMP
	db 0 ; no more level-up moves

StarmieEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, HARDEN
	db 1, WATER_GUN
	db 1, RAPID_SPIN
	db 19, RECOVER
	db 25, SWIFT
	db 27, LIGHT_SCREEN
	db 31, BUBBLEBEAM
	db 34, MINIMIZE
	db 37, CONFUSE_RAY
	db 40, PSYCHIC_M
	db 50, HYDRO_PUMP
	db 0 ; no more level-up moves

MrMimeEvosAttacks:
	db 0 ; no more evolutions
	db 1, BARRIER
	db 6, CONFUSION
	db 11, SUBSTITUTE
	db 16, MEDITATE
	db 21, DOUBLESLAP
	db 26, LIGHT_SCREEN
	db 26, REFLECT
	db 31, ENCORE
	db 36, PSYBEAM
	db 41, BATON_PASS
	db 46, SAFEGUARD
	db 0 ; no more level-up moves

ScytherEvosAttacks:
    db EVOLVE_ITEM, METAL_COAT, SCIZOR
    db 0 ; no more evolutions
    db 1, QUICK_ATTACK
    db 1, LEER
    db 6, FOCUS_ENERGY
    db 12, PURSUIT
    db 16, CUT
    db 18, FALSE_SWIPE
    db 24, AGILITY
    db 30, WING_ATTACK
    db 36, SLASH
    db 42, TWINEEDLE
    db 48, DOUBLE_TEAM
    db 54, SWORDS_DANCE
    db 0 ; no more level-up moves

JynxEvosAttacks:
	db 0 ; no more evolutions
	db 1, POUND
	db 1, LICK
	db 1, LOVELY_KISS
	db 1, POWDER_SNOW
	db 13, CONFUSION
	db 17, ICY_WIND
	db 21, DOUBLESLAP
	db 25, ICE_PUNCH
	db 34, LOVELY_KISS
	db 36, MEAN_LOOK
	db 39, PSYCHIC_M
	db 41, BODY_SLAM
	db 51, PERISH_SONG
	db 57, BLIZZARD
	db 0 ; no more level-up moves

ElectabuzzEvosAttacks:
	db 0 ; no more evolutions
	db 1, THUNDERSHOCK
	db 1, LEER
	db 1, QUICK_ATTACK
	db 17, SPARK
	db 21, LIGHT_SCREEN
	db 25, SWIFT
	db 30, THUNDERPUNCH
	db 36, SCREECH
	db 42, THUNDERBOLT
	db 52, THUNDER
	db 0 ; no more level-up moves

MagmarEvosAttacks:
	db 0 ; no more evolutions
	db 1, EMBER
	db 1, LEER
	db 1, SMOG
	db 17, FLAME_WHEEL
	db 21, SMOKESCREEN
	db 25, POISON_GAS
	db 30, FIRE_PUNCH
	db 33, SUNNY_DAY
	db 41, FLAMETHROWER
	db 49, CONFUSE_RAY
	db 57, FIRE_BLAST
	db 0 ; no more level-up moves

PinsirEvosAttacks:
    db 0 ; no more evolutions
    db 1, VICEGRIP
    db 7, FOCUS_ENERGY
    db 13, BIND
    db 19, SEISMIC_TOSS
    db 25, TWINEEDLE
    db 27, HARDEN
    db 31, GUILLOTINE
    db 37, SUBMISSION
    db 43, SWORDS_DANCE
    db 48, MEGAHORN
    db 0 ; no more level-up moves

TaurosEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 4, TAIL_WHIP
	db 8, RAGE
	db 13, HORN_ATTACK
	db 19, SCARY_FACE
	db 23, HEADBUTT
	db 26, PURSUIT
	db 34, REST
	db 43, THRASH
	db 48, TAKE_DOWN
	db 58, DOUBLE_EDGE
	db 0 ; no more level-up moves

MagikarpEvosAttacks:
	db EVOLVE_LEVEL, 20, GYARADOS
	db 0 ; no more evolutions
	db 1, SPLASH
	db 15, TACKLE
	db 30, FLAIL
	db 0 ; no more level-up moves

GyaradosEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, LEER
	db 20, BITE
	db 20, GUST
	db 22, LEER
	db 25, DRAGON_RAGE
	db 30, THRASH
	db 35, TWISTER
	db 40, HYDRO_PUMP
	db 45, RAIN_DANCE
	db 50, HYPER_BEAM
	db 0 ; no more level-up moves

LaprasEvosAttacks:
	db 0 ; no more evolutions
	db 1, WATER_GUN
	db 1, GROWL
	db 1, SING
	db 8, MIST
	db 15, BODY_SLAM
	db 20, ICY_WIND
	db 22, CONFUSE_RAY
	db 29, PERISH_SONG
	db 36, ICE_BEAM
	db 43, RAIN_DANCE
	db 50, SAFEGUARD
	db 57, HYDRO_PUMP
	db 0 ; no more level-up moves

DittoEvosAttacks:
	db 0 ; no more evolutions
	db 1, TRANSFORM
	db 0 ; no more level-up moves

EeveeEvosAttacks:
	db EVOLVE_ITEM, THUNDERSTONE, JOLTEON
	db EVOLVE_ITEM, WATER_STONE, VAPOREON
	db EVOLVE_ITEM, FIRE_STONE, FLAREON
	db EVOLVE_HAPPINESS, TR_MORNDAY, ESPEON
	db EVOLVE_HAPPINESS, TR_NITE, UMBREON
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, TAIL_WHIP
	db 8, SAND_ATTACK
	db 12, GROWL
	db 16, DOUBLE_KICK
	db 20, BITE
	db 23, QUICK_ATTACK
	db 30, BATON_PASS
	db 36, TAKE_DOWN
	db 0 ; no more level-up moves

VaporeonEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, TAIL_WHIP
	db 8, SAND_ATTACK
	db 12, GROWL
	db 16, DOUBLE_KICK
	db 20, WATER_GUN
	db 23, QUICK_ATTACK
	db 26, BUBBLEBEAM
	db 30, BITE
	db 36, AURORA_BEAM
	db 42, ACID_ARMOR
	db 47, HAZE
	db 52, HYDRO_PUMP
	db 0 ; no more level-up moves

JolteonEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, TAIL_WHIP
	db 8, SAND_ATTACK
	db 12, GROWL
	db 16, DOUBLE_KICK
	db 20, THUNDERSHOCK
	db 23, QUICK_ATTACK
	db 26, SPARK
	db 30, PIN_MISSILE
	db 36, THUNDERBOLT
	db 42, THUNDER_WAVE
	db 47, AGILITY
	db 52, THUNDER
	db 0 ; no more level-up moves

FlareonEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, TAIL_WHIP
	db 8, SAND_ATTACK
	db 12, GROWL
	db 16, DOUBLE_KICK
	db 20, EMBER
	db 23, QUICK_ATTACK
	db 26, FLAME_WHEEL
	db 30, BITE
	db 36, FLAMETHROWER
	db 42, FIRE_SPIN
	db 47, SMOG
	db 52, FIRE_BLAST
	db 0 ; no more level-up moves

PorygonEvosAttacks:
	db EVOLVE_ITEM, UP_GRADE, PORYGON2
	db 0 ; no more evolutions
	db 1, CONVERSION2
	db 1, TACKLE
	db 1, CONVERSION
	db 9, AGILITY
	db 12, PSYBEAM
	db 20, RECOVER
	db 24, SHARPEN
	db 32, LOCK_ON
	db 36, TRI_ATTACK
	db 44, ZAP_CANNON
	db 50, HYPER_BEAM
	db 0 ; no more level-up moves

OmanyteEvosAttacks:
	db EVOLVE_LEVEL, 40, OMASTAR
	db 0 ; no more evolutions
	db 1, CONSTRICT
	db 1, WITHDRAW
	db 7, WATER_GUN
	db 11, BITE
	db 14, ROCK_THROW
	db 18, BUBBLEBEAM
	db 23, LEER
	db 27, SPIKE_CANNON
	db 30, ANCIENTPOWER
	db 37, PROTECT
	db 46, HYDRO_PUMP
	db 0 ; no more level-up moves

OmastarEvosAttacks:
	db 0 ; no more evolutions
	db 1, CONSTRICT
	db 1, WITHDRAW
	db 1, WATER_GUN
	db 1, BITE
	db 14, ROCK_THROW
	db 18, BUBBLEBEAM
	db 23, LEER
	db 27, SPIKE_CANNON
	db 30, ANCIENTPOWER
	db 37, PROTECT
	db 46, HYDRO_PUMP
	db 0 ; no more level-up moves

KabutoEvosAttacks:
	db EVOLVE_LEVEL, 40, KABUTOPS
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, HARDEN
	db 1, LEER
	db 7, ROCK_THROW
	db 14, WATER_GUN
	db 19, ABSORB
	db 25, LEER
	db 28, SAND_ATTACK
	db 30, ANCIENTPOWER
	db 35, MEGA_DRAIN
	db 37, ENDURE
	db 43, SWORDS_DANCE
	db 46, ROCK_SLIDE
	db 0 ; no more level-up moves

KabutopsEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, HARDEN
	db 1, ABSORB
	db 7, ROCK_THROW
	db 14, WATER_GUN
	db 19, ABSORB
	db 25, LEER
	db 28, SAND_ATTACK
	db 30, ANCIENTPOWER
	db 35, MEGA_DRAIN
	db 37, ENDURE
	db 40, SLASH
	db 43, SWORDS_DANCE
	db 46, ROCK_SLIDE
	db 0 ; no more level-up moves

AerodactylEvosAttacks:
	db 0 ; no more evolutions
	db 1, GUST
	db 8, AGILITY
	db 15, BITE
	db 22, SUPERSONIC
	db 29, ANCIENTPOWER
	db 32, WING_ATTACK
	db 36, SCARY_FACE
	db 40, ROCK_SLIDE
	db 43, TAKE_DOWN
	db 50, HYPER_BEAM
	db 0 ; no more level-up moves

SnorlaxEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 8, AMNESIA
	db 15, DEFENSE_CURL
	db 22, BELLY_DRUM
	db 29, HEADBUTT
	db 36, SNORE
	db 36, REST
	db 43, BODY_SLAM
	db 50, ROLLOUT
	db 57, HYPER_BEAM
	db 0 ; no more level-up moves

ArticunoEvosAttacks:
	db 0 ; no more evolutions
	db 1, GUST
	db 1, POWDER_SNOW
	db 13, MIST
	db 25, AGILITY
	db 37, MIND_READER
	db 49, ICE_BEAM
	db 55, DRILL_PECK
	db 61, REFLECT
	db 73, BLIZZARD
	db 76, SKY_ATTACK
	db 0 ; no more level-up moves

ZapdosEvosAttacks:
	db 0 ; no more evolutions
	db 1, PECK
	db 1, THUNDERSHOCK
	db 13, THUNDER_WAVE
	db 25, AGILITY
	db 37, DETECT
	db 49, THUNDERBOLT
	db 55, DRILL_PECK
	db 61, LIGHT_SCREEN
	db 73, THUNDER
	db 76, SKY_ATTACK
	db 0 ; no more level-up moves

MoltresEvosAttacks:
	db 0 ; no more evolutions
	db 1, WING_ATTACK
	db 1, EMBER
	db 13, FIRE_SPIN
	db 25, AGILITY
	db 37, ENDURE
	db 49, FLAMETHROWER
	db 55, DRILL_PECK
	db 61, SAFEGUARD
	db 73, FIRE_BLAST
	db 76, SKY_ATTACK
	db 0 ; no more level-up moves

DratiniEvosAttacks:
	db EVOLVE_LEVEL, 30, DRAGONAIR
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, LEER
	db 5, WRAP
	db 8, THUNDER_WAVE
	db 15, TWISTER
	db 22, DRAGON_RAGE
	db 29, SLAM
	db 35, AGILITY
	db 41, SAFEGUARD
	db 45, OUTRAGE
	db 54, HYPER_BEAM
	db 0 ; no more level-up moves

DragonairEvosAttacks:
	db EVOLVE_LEVEL, 55, DRAGONITE
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, LEER
	db 1, WRAP
	db 8, THUNDER_WAVE
	db 15, TWISTER
	db 22, DRAGON_RAGE
	db 29, SLAM
	db 38, AGILITY
	db 47, SAFEGUARD
	db 50, OUTRAGE
	db 65, HYPER_BEAM
	db 0 ; no more level-up moves

DragoniteEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, LEER
	db 1, WRAP
	db 1, THUNDER_WAVE
	db 15, TWISTER
	db 22, DRAGON_RAGE
	db 29, SLAM
	db 38, AGILITY
	db 47, SAFEGUARD
	db 55, WING_ATTACK
	db 56, OUTRAGE
	db 70, HYPER_BEAM
	db 0 ; no more level-up moves

MewtwoEvosAttacks:
	db 0 ; no more evolutions
	db 1, CONFUSION
	db 1, DISABLE
	db 11, BARRIER
	db 22, SWIFT
	db 33, PSYCH_UP
	db 44, FUTURE_SIGHT
	db 55, MIST
	db 66, PSYCHIC_M
	db 77, AMNESIA
	db 88, RECOVER
	db 99, SAFEGUARD
	db 0 ; no more level-up moves

MewEvosAttacks:
	db 0 ; no more evolutions
	db 1, POUND
	db 10, TRANSFORM
	db 20, MEGA_PUNCH
	db 30, METRONOME
	db 40, PSYCHIC_M
	db 50, ANCIENTPOWER
	db 0 ; no more level-up moves

ChikoritaEvosAttacks:
	db EVOLVE_LEVEL, 16, BAYLEEF
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 6, RAZOR_LEAF
	db 9, LEECH_SEED
	db 12, REFLECT
	db 15, POISONPOWDER
	db 21, MEGA_DRAIN
	db 23, SYNTHESIS
	db 31, BODY_SLAM
	db 36, GIGA_DRAIN
	db 41, LIGHT_SCREEN
	db 45, SOLARBEAM
	db 46, SUNNY_DAY
	db 50, SAFEGUARD
	db 0 ; no more level-up moves

BayleefEvosAttacks:
	db EVOLVE_LEVEL, 32, MEGANIUM
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 1, RAZOR_LEAF
	db 1, REFLECT
	db 15, POISONPOWDER
	db 21, MEGA_DRAIN
	db 23, SYNTHESIS
	db 31, BODY_SLAM
	db 36, GIGA_DRAIN
	db 41, LIGHT_SCREEN
	db 45, SOLARBEAM
	db 46, SUNNY_DAY
	db 50, SAFEGUARD
	db 0 ; no more level-up moves

MeganiumEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 1, RAZOR_LEAF
	db 1, REFLECT
	db 15, POISONPOWDER
	db 21, MEGA_DRAIN
	db 23, SYNTHESIS
	db 31, BODY_SLAM
	db 36, GIGA_DRAIN
	db 41, LIGHT_SCREEN
	db 45, SOLARBEAM
	db 46, SUNNY_DAY
	db 50, SAFEGUARD
	db 0 ; no more level-up moves

CyndaquilEvosAttacks:
	db EVOLVE_LEVEL, 14, QUILAVA
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, LEER
	db 6, SMOKESCREEN
	db 7, EMBER
	db 16, DEFENSE_CURL
	db 21, QUICK_ATTACK
	db 24, FLAME_WHEEL
	db 32, SWIFT
	db 38, FLAMETHROWER
	db 50, FIRE_BLAST
	db 0 ; no more level-up moves

QuilavaEvosAttacks:
	db EVOLVE_LEVEL, 36, TYPHLOSION
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, LEER
	db 1, SMOKESCREEN
	db 1, EMBER
	db 16, DEFENSE_CURL
	db 21, QUICK_ATTACK
	db 24, FLAME_WHEEL
	db 32, SWIFT
	db 38, FLAMETHROWER
	db 50, FIRE_BLAST
	db 0 ; no more level-up moves

TyphlosionEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, LEER
	db 1, SMOKESCREEN
	db 1, EMBER
	db 16, DEFENSE_CURL
	db 21, QUICK_ATTACK
	db 24, FLAME_WHEEL
	db 32, SWIFT
	db 38, FLAMETHROWER
	db 50, FIRE_BLAST
	db 0 ; no more level-up moves

TotodileEvosAttacks:
	db EVOLVE_LEVEL, 18, CROCONAW
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, LEER
	db 7, WATER_GUN
	db 12, RAGE
	db 21, BITE
	db 28, SCARY_FACE
	db 37, SLASH
	db 45, SCREECH
	db 50, HYDRO_PUMP
	db 55, CRUNCH
	db 0 ; no more level-up moves

CroconawEvosAttacks:
	db EVOLVE_LEVEL, 30, FERALIGATR
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, LEER
	db 1, WATER_GUN
	db 1, RAGE
	db 21, BITE
	db 28, SCARY_FACE
	db 37, SLASH
	db 45, SCREECH
	db 50, HYDRO_PUMP
	db 55, CRUNCH
	db 0 ; no more level-up moves

FeraligatrEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, LEER
	db 7, WATER_GUN
	db 12, RAGE
	db 21, BITE
	db 28, SCARY_FACE
	db 37, SLASH
	db 45, SCREECH
	db 50, HYDRO_PUMP
	db 55, CRUNCH
	db 0 ; no more level-up moves

SentretEvosAttacks:
	db EVOLVE_LEVEL, 15, FURRET
	db 0 ; no more evolutions
	db 1, TACKLE
	db 4, DEFENSE_CURL
	db 6, QUICK_ATTACK
	db 9, THIEF
	db 12, FURY_SWIPES
	db 16, HEADBUTT
	db 20, DIG
	db 25, PURSUIT
	db 30, EXTREMESPEED
	db 35, REST
	db 40, AMNESIA
	db 0 ; no more level-up moves

FurretEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, DEFENSE_CURL
	db 1, QUICK_ATTACK
	db 1, THIEF
	db 12, FURY_SWIPES
	db 16, HEADBUTT
	db 20, DIG
	db 25, PURSUIT
	db 30, EXTREMESPEED
	db 35, REST
	db 40, AMNESIA
	db 45, DOUBLE_EDGE
	db 0 ; no more level-up moves

HoothootEvosAttacks:
	db EVOLVE_LEVEL, 20, NOCTOWL
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 6, PECK
	db 10, FORESIGHT
	db 14, HYPNOSIS
	db 20, PSYBEAM
	db 24, WING_ATTACK
	db 28, REFLECT
	db 28, LIGHT_SCREEN
	db 32, MIRROR_COAT
	db 36, TAKE_DOWN
	db 40, PSYCHIC_M
	db 45, DREAM_EATER
	db 50, FUTURE_SIGHT
	db 0 ; no more level-up moves

NoctowlEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 1, PECK
	db 1, FORESIGHT
	db 14, HYPNOSIS
	db 20, PSYBEAM
	db 24, WING_ATTACK
	db 28, REFLECT
	db 28, LIGHT_SCREEN
	db 32, MIRROR_COAT
	db 36, TAKE_DOWN
	db 40, PSYCHIC_M
	db 45, DREAM_EATER
	db 50, FUTURE_SIGHT
	db 0 ; no more level-up moves

LedybaEvosAttacks:
	db EVOLVE_LEVEL, 18, LEDIAN
	db 0 ; no more evolutions
	db 1, TACKLE
	db 6, LEECH_LIFE
	db 8, SUPERSONIC
	db 15, COMET_PUNCH
	db 20, LIGHT_SCREEN
	db 20, REFLECT
	db 22, SAFEGUARD
	db 26, BATON_PASS
	db 31, AGILITY
	db 36, GIGA_DRAIN
	db 42, SWIFT
	db 50, DOUBLE_EDGE
	db 0 ; no more level-up moves

LedianEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, LEECH_LIFE
	db 1, SUPERSONIC
	db 15, COMET_PUNCH
	db 18, LIGHT_SCREEN
	db 18, REFLECT
	db 24, SAFEGUARD
	db 26, BATON_PASS
	db 31, AGILITY
	db 36, GIGA_DRAIN
	db 42, SWIFT
	db 50, DOUBLE_EDGE
	db 0 ; no more level-up moves

SpinarakEvosAttacks:
	db EVOLVE_LEVEL, 21, ARIADOS
	db 0 ; no more evolutions
	db 1, POISON_STING
	db 1, STRING_SHOT
	db 6, SCARY_FACE
	db 9, LEECH_LIFE
	db 12, CONSTRICT
	db 17, NIGHT_SHADE
	db 21, TWINEEDLE
	db 25, FURY_SWIPES
	db 33, SPIDER_WEB
	db 38, GIGA_DRAIN
	db 43, PSYCHIC_M
	db 47, MEGAHORN
	db 53, AGILITY
	db 0 ; no more level-up moves

AriadosEvosAttacks:
	db 0 ; no more evolutions
	db 1, POISON_STING
	db 1, STRING_SHOT
	db 1, SCARY_FACE
	db 1, LEECH_LIFE
	db 12, CONSTRICT
	db 17, NIGHT_SHADE
	db 21, TWINEEDLE
	db 25, FURY_SWIPES
	db 33, SPIDER_WEB
	db 38, GIGA_DRAIN
	db 43, PSYCHIC_M
	db 47, MEGAHORN
	db 53, AGILITY
	db 0 ; no more level-up moves

CrobatEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCREECH
	db 1, LEECH_LIFE
	db 1, SUPERSONIC
	db 1, GUST
	db 12, BITE
	db 19, CONFUSE_RAY
	db 22, WING_ATTACK
	db 27, SLUDGE
	db 36, SLUDGE_BOMB
	db 42, MEAN_LOOK
	db 48, HAZE
	db 0 ; no more level-up moves

ChinchouEvosAttacks:
	db EVOLVE_LEVEL, 27, LANTURN
	db 0 ; no more evolutions
	db 1, BUBBLE
	db 1, SUPERSONIC
	db 5, THUNDER_WAVE
	db 11, FLAIL
	db 17, WATER_GUN
	db 20, SPARK
	db 29, CONFUSE_RAY
	db 35, THUNDERBOLT
	db 40, TAKE_DOWN
	db 45, RAIN_DANCE
	db 49, THUNDER
	db 54, HYDRO_PUMP
	db 0 ; no more level-up moves

LanturnEvosAttacks:
	db 0 ; no more evolutions
	db 1, BUBBLE
	db 1, SUPERSONIC
	db 1, THUNDER_WAVE
	db 11, FLAIL
	db 17, WATER_GUN
	db 20, SPARK
	db 29, CONFUSE_RAY
	db 35, THUNDERBOLT
	db 40, TAKE_DOWN
	db 45, RAIN_DANCE
	db 49, THUNDER
	db 54, HYDRO_PUMP
	db 0 ; no more level-up moves

PichuEvosAttacks:
	db EVOLVE_HAPPINESS, TR_ANYTIME, PIKACHU
	db 0 ; no more evolutions
	db 1, THUNDERSHOCK
	db 1, CHARM
	db 6, TAIL_WHIP
	db 8, THUNDER_WAVE
	db 11, SWEET_KISS
	db 0 ; no more level-up moves

CleffaEvosAttacks:
	db EVOLVE_HAPPINESS, TR_ANYTIME, CLEFAIRY
	db 0 ; no more evolutions
	db 1, POUND
	db 1, CHARM
	db 6, ENCORE
	db 8, SING
	db 13, SWEET_KISS
	db 0 ; no more level-up moves

IgglybuffEvosAttacks:
	db EVOLVE_HAPPINESS, TR_ANYTIME, JIGGLYPUFF
	db 0 ; no more evolutions
	db 1, SING
	db 1, CHARM
	db 6, DEFENSE_CURL
	db 9, POUND
	db 14, SWEET_KISS
	db 0 ; no more level-up moves

TogepiEvosAttacks:
	db EVOLVE_HAPPINESS, TR_ANYTIME, TOGETIC
	db 0 ; no more evolutions
	db 1, GROWL
	db 1, CHARM
	db 5, METRONOME
	db 11, RETURN
	db 18, SWEET_KISS
	db 25, ENCORE
	db 31, SAFEGUARD
	db 38, DOUBLE_EDGE
	db 43, TRI_ATTACK
	db 0 ; no more level-up moves

TogeticEvosAttacks:
	db 0 ; no more evolutions
	db 1, GROWL
	db 1, CHARM
	db 5, METRONOME
	db 18, SWEET_KISS
	db 25, ENCORE
	db 27, WING_ATTACK
	db 31, SAFEGUARD
	db 38, DOUBLE_EDGE
	db 43, TRI_ATTACK
	db 0 ; no more level-up moves

NatuEvosAttacks:
	db EVOLVE_LEVEL, 25, XATU
	db 0 ; no more evolutions
	db 1, LEER
	db 1, PECK
	db 5, CONFUSION
	db 10, NIGHT_SHADE
	db 20, TELEPORT
	db 25, PSYBEAM
	db 30, RECOVER
	db 35, PSYCHIC_M
	db 40, WING_ATTACK
	db 45, FUTURE_SIGHT
	db 50, CONFUSE_RAY
	db 0 ; no more level-up moves

XatuEvosAttacks:
	db 0 ; no more evolutions
	db 1, LEER
	db 1, PECK
	db 1, CONFUSION
	db 1, NIGHT_SHADE
	db 20, TELEPORT
	db 25, PSYBEAM
	db 30, RECOVER
	db 35, PSYCHIC_M
	db 40, WING_ATTACK
	db 45, FUTURE_SIGHT
	db 50, CONFUSE_RAY
	db 0 ; no more level-up moves

MareepEvosAttacks:
	db EVOLVE_LEVEL, 15, FLAAFFY
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 7, THUNDERSHOCK
	db 18, THUNDER_WAVE
	db 27, COTTON_SPORE
	db 39, LIGHT_SCREEN
	db 47, THUNDERBOLT
	db 55, THUNDER
	db 0 ; no more level-up moves

FlaaffyEvosAttacks:
	db EVOLVE_LEVEL, 30, AMPHAROS
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 1, THUNDERSHOCK
	db 18, THUNDER_WAVE
	db 27, COTTON_SPORE
	db 39, LIGHT_SCREEN
	db 47, THUNDERBOLT
	db 55, THUNDER
	db 0 ; no more level-up moves

AmpharosEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 1, THUNDERSHOCK
	db 1, THUNDER_WAVE
	db 27, COTTON_SPORE
	db 30, THUNDERPUNCH
	db 39, LIGHT_SCREEN
	db 47, THUNDERBOLT
	db 55, THUNDER
	db 0 ; no more level-up moves

BellossomEvosAttacks:
	db 0 ; no more evolutions
	db 1, ABSORB
	db 1, SWEET_SCENT
	db 1, POISONPOWDER
	db 1, STUN_SPORE
	db 18, SLEEP_POWDER
	db 21, MEGA_DRAIN
	db 24, CHARM
	db 32, GIGA_DRAIN
	db 35, MOONLIGHT
	db 44, PETAL_DANCE
	db 50, SOLARBEAM
	db 0 ; no more level-up moves

MarillEvosAttacks:
	db EVOLVE_LEVEL, 18, AZUMARILL
	db 0 ; no more evolutions
	db 1, TACKLE
	db 3, DEFENSE_CURL
	db 6, TAIL_WHIP
	db 10, WATER_GUN
	db 15, ROLLOUT
	db 18, BUBBLEBEAM
	db 28, RAIN_DANCE
	db 36, DOUBLE_EDGE
	db 44, HYDRO_PUMP
	db 0 ; no more level-up moves

AzumarillEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, DEFENSE_CURL
	db 1, TAIL_WHIP
	db 1, WATER_GUN
	db 15, ROLLOUT
	db 18, BUBBLEBEAM
	db 28, RAIN_DANCE
	db 36, DOUBLE_EDGE
	db 44, HYDRO_PUMP
	db 0 ; no more level-up moves

SudowoodoEvosAttacks:
	db 0 ; no more evolutions
	db 1, ROCK_THROW
	db 1, MIMIC
	db 10, FLAIL
	db 19, LOW_KICK
	db 28, ROCK_SLIDE
	db 31, COUNTER
	db 36, FAINT_ATTACK
	db 46, THRASH
	db 0 ; no more level-up moves

PolitoedEvosAttacks:
	db 0 ; no more evolutions
	db 1, BUBBLE
	db 1, MIST
	db 1, HYPNOSIS
	db 1, PERISH_SONG
	db 10, WATER_GUN
	db 14, DOUBLESLAP
	db 20, BUBBLEBEAM
	db 25, RAIN_DANCE
	db 31, BODY_SLAM
	db 34, PERISH_SONG
	db 36, ICE_BEAM
	db 40, LIGHT_SCREEN
	db 45, HYDRO_PUMP
	db 51, SWAGGER
	db 0 ; no more level-up moves

HoppipEvosAttacks:
	db EVOLVE_LEVEL, 18, SKIPLOOM
	db 0 ; no more evolutions
	db 1, SPLASH
	db 1, GUST
	db 3, TACKLE
	db 5, SYNTHESIS
	db 5, TAIL_WHIP
	db 7, ABSORB
	db 10, POISONPOWDER
	db 14, STUN_SPORE
	db 17, SLEEP_POWDER
	db 19, MEGA_DRAIN
	db 21, LEECH_SEED
	db 24, PROTECT
	db 31, COTTON_SPORE
	db 36, GIGA_DRAIN
	db 0 ; no more level-up moves

SkiploomEvosAttacks:
	db EVOLVE_LEVEL, 27, JUMPLUFF
	db 0 ; no more evolutions
	db 1, SPLASH
	db 1, GUST
	db 1, TACKLE
	db 1, SYNTHESIS
	db 5, TAIL_WHIP
	db 7, ABSORB
	db 10, POISONPOWDER
	db 14, STUN_SPORE
	db 17, SLEEP_POWDER
	db 19, MEGA_DRAIN
	db 21, LEECH_SEED
	db 24, PROTECT
	db 31, COTTON_SPORE
	db 36, GIGA_DRAIN
	db 0 ; no more level-up moves

JumpluffEvosAttacks:
	db 0 ; no more evolutions
	db 1, SPLASH
	db 1, GUST
	db 1, TACKLE
	db 1, SYNTHESIS
	db 5, TAIL_WHIP
	db 7, ABSORB
	db 10, POISONPOWDER
	db 14, STUN_SPORE
	db 17, SLEEP_POWDER
	db 19, MEGA_DRAIN
	db 21, LEECH_SEED
	db 24, PROTECT
	db 31, COTTON_SPORE
	db 36, GIGA_DRAIN
	db 0 ; no more level-up moves

AipomEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, TAIL_WHIP
	db 6, SAND_ATTACK
	db 12, BATON_PASS
	db 19, LOW_KICK
	db 27, SWIFT
	db 36, SCREECH
	db 46, AGILITY
	db 0 ; no more level-up moves

SunkernEvosAttacks:
	db EVOLVE_ITEM, SUN_STONE, SUNFLORA
	db 0 ; no more evolutions
	db 1, ABSORB
	db 4, GROWTH
	db 10, MEGA_DRAIN
	db 15, RAZOR_LEAF
	db 19, SUNNY_DAY
	db 25, SYNTHESIS
	db 31, PETAL_DANCE
	db 36, SOLARBEAM
	db 50, GIGA_DRAIN
	db 0 ; no more level-up moves

SunfloraEvosAttacks:
	db 0 ; no more evolutions
	db 1, ABSORB
	db 1, POUND
	db 1, GROWTH
	db 10, MEGA_DRAIN
	db 15, RAZOR_LEAF
	db 19, SUNNY_DAY
	db 25, SYNTHESIS
	db 31, PETAL_DANCE
	db 36, SOLARBEAM
	db 50, GIGA_DRAIN
	db 0 ; no more level-up moves

YanmaEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, FORESIGHT
	db 7, QUICK_ATTACK
	db 13, DOUBLE_TEAM
	db 19, WING_ATTACK
	db 25, TWINEEDLE
	db 30, TWISTER
	db 28, DETECT
	db 31, SUPERSONIC
	db 37, SONICBOOM
	db 43, SCREECH
	db 0 ; no more level-up moves

WooperEvosAttacks:
	db EVOLVE_LEVEL, 20, QUAGSIRE
	db 0 ; no more evolutions
	db 1, WATER_GUN
	db 1, TAIL_WHIP
	db 5, MUD_SLAP
	db 11, SLAM
	db 16, BUBBLEBEAM
	db 20, MAGNITUDE
	db 23, AMNESIA
	db 33, EARTHQUAKE
	db 41, RAIN_DANCE
	db 51, MIST
	db 51, HAZE
	db 0 ; no more level-up moves

QuagsireEvosAttacks:
	db 0 ; no more evolutions
	db 1, WATER_GUN
	db 1, TAIL_WHIP
	db 5, MUD_SLAP
	db 11, SLAM
	db 16, BUBBLEBEAM
	db 20, MAGNITUDE
	db 23, AMNESIA
	db 33, EARTHQUAKE
	db 41, RAIN_DANCE
	db 51, MIST
	db 51, HAZE
	db 0 ; no more level-up moves

EspeonEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, TAIL_WHIP
	db 8, SAND_ATTACK
	db 12, GROWL
	db 16, DOUBLE_KICK
	db 20, CONFUSION
	db 23, QUICK_ATTACK
	db 26, SWIFT
	db 30, PSYBEAM
	db 36, PSYCHIC_M
	db 42, PSYCH_UP
	db 47, MORNING_SUN
	db 52, REFLECT
	db 0 ; no more level-up moves

UmbreonEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, TAIL_WHIP
	db 8, SAND_ATTACK
	db 12, GROWL
	db 16, DOUBLE_KICK
	db 20, PURSUIT
	db 23, QUICK_ATTACK
	db 26, CONFUSE_RAY
	db 30, FAINT_ATTACK
	db 36, CURSE
	db 42, MEAN_LOOK
	db 47, MOONLIGHT
	db 52, SCREECH
	db 0 ; no more level-up moves

MurkrowEvosAttacks:
	db 0 ; no more evolutions
	db 1, PECK
	db 11, PURSUIT
	db 16, HAZE
	db 22, WING_ATTACK
	db 26, NIGHT_SHADE
	db 31, FAINT_ATTACK
	db 36, DRILL_PECK
	db 41, MEAN_LOOK
	db 0 ; no more level-up moves

SlowkingEvosAttacks:
	db 0 ; no more evolutions
	db 1, CURSE
	db 1, TACKLE
	db 1, GROWL
	db 1, WATER_GUN
	db 18, CONFUSION
	db 24, DISABLE
	db 29, PSYBEAM
	db 34, HEADBUTT
	db 41, SWAGGER
	db 45, PSYCHIC_M
	db 50, FUTURE_SIGHT
	db 0 ; no more level-up moves

MisdreavusEvosAttacks:
	db 0 ; no more evolutions
	db 1, PSYWAVE
	db 1, GROWL
	db 4, NIGHT_SHADE
	db 8, SPITE
	db 12, CONFUSE_RAY
	db 19, MEAN_LOOK
	db 24, SCREECH
	db 27, SHADOW_BALL
	db 32, PSYBEAM
	db 36, PAIN_SPLIT
	db 41, SING
	db 46, PERISH_SONG
	db 0 ; no more level-up moves

UnownEvosAttacks:
	db 0 ; no more evolutions
	db 1, HIDDEN_POWER
	db 1, ANCIENTPOWER
	db 0 ; no more level-up moves

WobbuffetEvosAttacks:
	db 0 ; no more evolutions
	db 1, COUNTER
	db 1, MIRROR_COAT
	db 1, SAFEGUARD
	db 1, DESTINY_BOND
	db 0 ; no more level-up moves

GirafarigEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 1, CONFUSION
	db 1, STOMP
	db 7, CONFUSION
	db 13, STOMP
	db 20, AGILITY
	db 21, PSYBEAM
	db 30, BATON_PASS
	db 41, PSYCHIC_M
	db 46, CRUNCH
	db 0 ; no more level-up moves

PinecoEvosAttacks:
	db EVOLVE_LEVEL, 25, FORRETRESS
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, HARDEN
	db 7, PIN_MISSILE
	db 12, PROTECT
	db 15, MEGA_DRAIN
	db 19, TAKE_DOWN
	db 22, RAPID_SPIN
	db 25, SELFDESTRUCT
	db 29, BIDE
	db 39, EXPLOSION
	db 44, SPIKES
	db 54, DOUBLE_EDGE
	db 0 ; no more level-up moves

ForretressEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, HARDEN
	db 1, PIN_MISSILE
	db 1, PROTECT
	db 15, MEGA_DRAIN
	db 19, TAKE_DOWN
	db 22, RAPID_SPIN
	db 25, SELFDESTRUCT
	db 29, BIDE
	db 33, SPIKE_CANNON
	db 39, EXPLOSION
	db 44, SPIKES
	db 54, DOUBLE_EDGE
	db 0 ; no more level-up moves

DunsparceEvosAttacks:
	db 0 ; no more evolutions
	db 1, RAGE
	db 1, TACKLE
	db 5, DEFENSE_CURL
	db 13, GLARE
	db 15, DIG
	db 18, SPITE
	db 26, PURSUIT
	db 30, SCREECH
	db 33, BODY_SLAM
	db 0 ; no more level-up moves

GligarEvosAttacks:
	db 0 ; no more evolutions
	db 1, POISON_STING
	db 6, SAND_ATTACK
	db 13, HARDEN
	db 16, MUD_SLAP
	db 20, QUICK_ATTACK
	db 24, WING_ATTACK
	db 28, FAINT_ATTACK
	db 36, SLASH
	db 38, EARTHQUAKE
	db 44, SCREECH
	db 52, GUILLOTINE
	db 0 ; no more level-up moves

SteelixEvosAttacks:
	db 0 ; no more evolutions
	db 1, ROCK_SLIDE
	db 1, TACKLE
	db 1, SCREECH
	db 1, BIND
	db 12, ROCK_THROW
	db 18, DIG
	db 23, HARDEN
	db 27, RAGE
	db 36, SANDSTORM
	db 40, IRON_TAIL
	db 45, EARTHQUAKE
	db 49, CRUNCH
	db 0 ; no more level-up moves

SnubbullEvosAttacks:
	db EVOLVE_LEVEL, 23, GRANBULL
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, SCARY_FACE
	db 4, TAIL_WHIP
	db 8, CHARM
	db 13, BITE
	db 19, LICK
	db 23, RAGE
	db 28, ROAR
	db 39, CRUNCH
	db 44, THRASH
	db 0 ; no more level-up moves

GranbullEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, SCARY_FACE
	db 4, TAIL_WHIP
	db 8, CHARM
	db 13, BITE
	db 19, LICK
	db 23, RAGE
	db 28, ROAR
	db 39, CRUNCH
	db 44, THRASH
	db 0 ; no more level-up moves

QwilfishEvosAttacks:
	db 0 ; no more evolutions
	db 1, BUBBLE
	db 1, TACKLE
	db 1, POISON_STING
	db 6, WATER_GUN
	db 10, HARDEN
	db 10, MINIMIZE
	db 14, SPIKES
	db 20, SLUDGE
	db 26, PIN_MISSILE
	db 30, BUBBLEBEAM
	db 32, PROTECT
	db 36, TOXIC
	db 45, SLUDGE_BOMB
	db 50, HYDRO_PUMP
	db 0 ; no more level-up moves

ScizorEvosAttacks:
    db 0 ; no more evolutions
    db 1, QUICK_ATTACK
    db 1, LEER
    db 6, FOCUS_ENERGY
    db 12, PURSUIT
	db 16, CUT
    db 18, FALSE_SWIPE
    db 24, DOUBLE_TEAM
    db 30, METAL_CLAW
    db 36, SLASH
    db 42, TWINEEDLE
    db 48, SWORDS_DANCE
    db 54, AGILITY
    db 0 ; no more level-up moves

ShuckleEvosAttacks:
	db 0 ; no more evolutions
	db 1, CONSTRICT
	db 1, WITHDRAW
	db 7, WRAP
	db 10, ACID
	db 13, ENCORE
	db 19, DEFENSE_CURL
	db 21, ROLLOUT
	db 23, SAFEGUARD
	db 27, SANDSTORM
	db 31, ACID_ARMOR
	db 34, BIDE
	db 37, REST
	db 40, PROTECT
	db 0 ; no more level-up moves

HeracrossEvosAttacks:
    db 0 ; no more evolutions
    db 1, TACKLE
    db 1, LEER
    db 5, PIN_MISSILE
    db 9, HORN_ATTACK
    db 12, ENDURE
    db 18, FURY_ATTACK
	db 25, COUNTER
    db 35, TAKE_DOWN
    db 44, REVERSAL
    db 45, MEGAHORN
    db 50, CROSS_CHOP
    db 0 ; no more level-up moves

SneaselEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, LEER
	db 9, QUICK_ATTACK
	db 13, FURY_SWIPES
	db 17, SCREECH
	db 20, ICY_WIND
	db 25, FAINT_ATTACK
	db 33, ICE_PUNCH
	db 38, METAL_CLAW
	db 41, AGILITY
	db 43, SLASH
	db 47, BEAT_UP
	db 51, BLIZZARD
	db 0 ; no more level-up moves

TeddiursaEvosAttacks:
	db EVOLVE_LEVEL, 30, URSARING
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, LEER
	db 8, LICK
	db 15, FURY_SWIPES
	db 22, FAINT_ATTACK
	db 29, REST
	db 34, SNORE
	db 39, SLASH
	db 45, SUBMISSION
	db 50, THRASH
	db 0 ; no more level-up moves

UrsaringEvosAttacks:
	db 0 ; no more evolutions
	db 1, SCRATCH
	db 1, LEER
	db 1, LICK
	db 1, FURY_SWIPES
	db 22, FAINT_ATTACK
	db 29, REST
	db 34, SNORE
	db 39, SLASH
	db 45, SUBMISSION
	db 50, THRASH
	db 0 ; no more level-up moves

SlugmaEvosAttacks:
	db EVOLVE_LEVEL, 27, MAGCARGO
	db 0 ; no more evolutions
	db 1, SMOG
	db 8, EMBER
	db 13, ROCK_THROW
	db 18, HARDEN
	db 25, FLAME_WHEEL
	db 29, AMNESIA
	db 36, FLAMETHROWER
	db 41, ROCK_SLIDE
	db 46, BODY_SLAM
	db 50, FIRE_BLAST
	db 0 ; no more level-up moves

MagcargoEvosAttacks:
	db 0 ; no more evolutions
	db 1, SMOG
	db 1, EMBER
	db 1, ROCK_THROW
	db 1, HARDEN
	db 25, FLAME_WHEEL
	db 29, AMNESIA
	db 36, FLAMETHROWER
	db 41, ROCK_SLIDE
	db 46, BODY_SLAM
	db 50, EARTHQUAKE
	db 56, FIRE_BLAST
	db 0 ; no more level-up moves

SwinubEvosAttacks:
	db EVOLVE_LEVEL, 33, PILOSWINE
	db 0 ; no more evolutions
	db 1, TACKLE
	db 8, POWDER_SNOW
	db 14, MUD_SLAP
	db 18, ENDURE
	db 21, ICY_WIND
	db 28, TAKE_DOWN
	db 39, EARTHQUAKE
	db 42, MIST
	db 50, BLIZZARD
	db 55, AMNESIA
	db 0 ; no more level-up moves

PiloswineEvosAttacks:
	db 0 ; no more evolutions
	db 1, HORN_ATTACK
	db 1, POWDER_SNOW
	db 1, ENDURE
	db 1, MUD_SLAP
	db 21, ICY_WIND
	db 28, TAKE_DOWN
	db 33, FURY_ATTACK
	db 39, EARTHQUAKE
	db 42, MIST
	db 50, BLIZZARD
	db 55, AMNESIA
	db 0 ; no more level-up moves

CorsolaEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, BUBBLE
	db 7, HARDEN
	db 13, WATER_GUN
	db 18, ANCIENTPOWER
	db 19, RECOVER
	db 23, SPIKES
	db 25, BUBBLEBEAM
	db 31, SPIKE_CANNON
	db 37, MIRROR_COAT
	db 45, HYDRO_PUMP
	db 0 ; no more level-up moves

RemoraidEvosAttacks:
	db EVOLVE_LEVEL, 25, OCTILLERY
	db 0 ; no more evolutions
	db 1, WATER_GUN
	db 11, LOCK_ON
	db 22, PSYBEAM
	db 22, AURORA_BEAM
	db 22, BUBBLEBEAM
	db 28, FOCUS_ENERGY
	db 33, ICE_BEAM
	db 44, HYDRO_PUMP
	db 55, HYPER_BEAM
	db 0 ; no more level-up moves

OctilleryEvosAttacks:
	db 0 ; no more evolutions
	db 1, WATER_GUN
	db 11, CONSTRICT
	db 22, PSYBEAM
	db 22, AURORA_BEAM
	db 22, BUBBLEBEAM
	db 25, OCTAZOOKA
	db 28, FOCUS_ENERGY
	db 33, ICE_BEAM
	db 44, HYDRO_PUMP
	db 55, HYPER_BEAM
	db 0 ; no more level-up moves

DelibirdEvosAttacks:
	db 0 ; no more evolutions
	db 1, PRESENT
	db 0 ; no more level-up moves

MantineEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, BUBBLE
	db 10, SUPERSONIC
	db 18, BUBBLEBEAM
	db 20, CONFUSE_RAY
	db 25, WING_ATTACK
	db 30, TAKE_DOWN
	db 40, AGILITY
	db 45, MIRROR_COAT
	db 49, HYDRO_PUMP
	db 0 ; no more level-up moves

SkarmoryEvosAttacks:
	db 0 ; no more evolutions
	db 1, LEER
	db 1, PECK
	db 13, SAND_ATTACK
	db 17, SPIKES
	db 19, SWIFT
	db 25, AGILITY
	db 28, WING_ATTACK
	db 31, STEEL_WING
	db 37, FURY_ATTACK
	db 41, DRILL_PECK
	db 0 ; no more level-up moves

	HoundourEvosAttacks:
	db EVOLVE_LEVEL, 24, HOUNDOOM
	db 0 ; no more evolutions
	db 1, LEER
	db 1, EMBER
	db 7, ROAR
	db 12, BITE
	db 17, SMOG
	db 22, FLAME_WHEEL
	db 30, FAINT_ATTACK
	db 39, FLAMETHROWER
	db 48, CRUNCH
	db 0 ; no more level-up moves
	
HoundoomEvosAttacks:
	db 0 ; no more evolutions
	db 1, LEER
	db 1, EMBER
	db 1, ROAR
	db 1, BITE
	db 17, SMOG
	db 22, FLAME_WHEEL
	db 30, FAINT_ATTACK
	db 39, FLAMETHROWER
	db 48, CRUNCH
	db 0 ; no more level-up moves

KingdraEvosAttacks:
	db 0 ; no more evolutions
	db 1, BUBBLE
	db 1, SMOKESCREEN
	db 1, LEER
	db 1, WATER_GUN
	db 22, BUBBLEBEAM
	db 29, TWISTER
	db 36, DRAGONBREATH
	db 40, AGILITY
	db 51, HYDRO_PUMP
	db 0 ; no more level-up moves

PhanpyEvosAttacks:
	db EVOLVE_LEVEL, 25, DONPHAN
	db 0 ; no more evolutions
	db 1, TACKLE
	db 1, GROWL
	db 7, MUD_SLAP
	db 9, DEFENSE_CURL
	db 14, MAGNITUDE
	db 17, FLAIL
	db 25, TAKE_DOWN
	db 33, ROLLOUT
	db 36, ENDURE
	db 40, EARTHQUAKE
	db 48, DOUBLE_EDGE
	db 0 ; no more level-up moves

DonphanEvosAttacks:
	db 0 ; no more evolutionsFras
	db 1, HORN_ATTACK
	db 1, GROWL
	db 1, MUD_SLAP
	db 1, DEFENSE_CURL
	db 14, MAGNITUDE
	db 17, FLAIL
	db 25, FURY_ATTACK
	db 33, ROLLOUT
	db 36, RAPID_SPIN
	db 40, EARTHQUAKE
	db 48, DOUBLE_EDGE
	db 0 ; no more level-up moves

Porygon2EvosAttacks:
	db 0 ; no more evolutions
	db 1, SHARPEN
	db 1, CONVERSION2
	db 1, TACKLE
	db 1, CONVERSION
	db 9, AGILITY
	db 12, PSYBEAM
	db 20, RECOVER
	db 24, DEFENSE_CURL
	db 32, LOCK_ON
	db 36, TRI_ATTACK
	db 44, ZAP_CANNON
	db 50, HYPER_BEAM
	db 0 ; no more level-up moves

StantlerEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 8, LEER
	db 13, STOMP
	db 15, HYPNOSIS
	db 18, CONFUSE_RAY
	db 23, PURSUIT
	db 28, TAKE_DOWN
	db 33, REFLECT
	db 37, LIGHT_SCREEN
	db 40, DOUBLE_EDGE
	db 45, DREAM_EATER
	db 0 ; no more level-up moves

SmeargleEvosAttacks:
	db 0 ; no more evolutions
	db 1, SKETCH
	db 11, SKETCH
	db 21, SKETCH
	db 31, SKETCH
	db 41, SKETCH
	db 51, SKETCH
	db 61, SKETCH
	db 71, SKETCH
	db 81, SKETCH
	db 91, SKETCH
	db 0 ; no more level-up moves

TyrogueEvosAttacks:
	db EVOLVE_ITEM, BRICK_PIECE, HITMONTOP
	db EVOLVE_STAT, 20, ATK_LT_DEF, HITMONCHAN
	db EVOLVE_STAT, 20, ATK_GT_DEF, HITMONLEE
	db 0 ; no more evolutions
	db 1, TACKLE
	db 0 ; no more level-up moves

HitmontopEvosAttacks:
	db 0 ; no more evolutions
	db 1, FOCUS_ENERGY
	db 20, PURSUIT
	db 20, QUICK_ATTACK
	db 20, ROLLING_KICK
	db 25, RAPID_SPIN
	db 31, COUNTER
	db 37, AGILITY
	db 43, DETECT
	db 45, TRIPLE_KICK
	db 0 ; no more level-up moves

SmoochumEvosAttacks:
	db EVOLVE_LEVEL, 30, JYNX
	db 0 ; no more evolutions
	db 1, POWDER_SNOW
	db 1, LICK
	db 1, POUND
	db 7, SWEET_KISS
	db 17, ICY_WIND
	db 21, CONFUSION
	db 25, SING
	db 30, ICE_PUNCH
	db 33, MEAN_LOOK
	db 37, PSYCHIC_M
	db 45, PERISH_SONG
	db 49, BLIZZARD
	db 0 ; no more level-up moves

ElekidEvosAttacks:
	db EVOLVE_LEVEL, 30, ELECTABUZZ
	db 0 ; no more evolutions
	db 1, THUNDERSHOCK
	db 1, LEER
	db 7, QUICK_ATTACK
	db 17, SPARK
	db 21, LIGHT_SCREEN
	db 25, SWIFT
	db 30, THUNDERPUNCH
	db 36, SCREECH
	db 42, THUNDERBOLT
	db 52, THUNDER
	db 0 ; no more level-up moves

MagbyEvosAttacks:
	db EVOLVE_LEVEL, 30, MAGMAR
	db 0 ; no more evolutions
	db 1, EMBER
	db 1, LEER
	db 7, SMOG
	db 17, FLAME_WHEEL
	db 21, SMOKESCREEN
	db 25, POISON_GAS
	db 30, FIRE_PUNCH
	db 33, SUNNY_DAY
	db 41, FLAMETHROWER
	db 49, CONFUSE_RAY
	db 57, FIRE_BLAST
	db 0 ; no more level-up moves

MiltankEvosAttacks:
	db 0 ; no more evolutions
	db 1, TACKLE
	db 4, GROWL
	db 8, DEFENSE_CURL
	db 13, STOMP
	db 19, MILK_DRINK
	db 26, BIDE
	db 34, ROLLOUT
	db 43, BODY_SLAM
	db 53, HEAL_BELL
	db 58, DOUBLE_EDGE
	db 0 ; no more level-up moves

BlisseyEvosAttacks:
	db 0 ; no more evolutions
	db 1, POUND
	db 4, GROWL
	db 7, TAIL_WHIP
	db 10, SOFTBOILED
	db 13, DOUBLESLAP
	db 18, MINIMIZE
	db 23, SING
	db 28, EGG_BOMB
	db 33, DEFENSE_CURL
	db 40, LIGHT_SCREEN
	db 47, DOUBLE_EDGE
	db 0 ; no more level-up moves

RaikouEvosAttacks:
	db 0 ; no more evolutions
	db 1, BITE
	db 1, LEER
	db 11, SPARK
	db 21, QUICK_ATTACK
	db 31, THUNDERBOLT
	db 41, CRUNCH
	db 51, REFLECT
	db 61, THUNDER
	db 0 ; no more level-up moves

EnteiEvosAttacks:
	db 0 ; no more evolutions
	db 1, BITE
	db 1, LEER
	db 11, FLAME_WHEEL
	db 21, STOMP
	db 31, FLAMETHROWER
	db 41, CRUNCH
	db 51, LIGHT_SCREEN
	db 61, FIRE_BLAST
	db 71, SWAGGER
	db 0 ; no more level-up moves

SuicuneEvosAttacks:
	db 0 ; no more evolutions
	db 1, BITE
	db 1, LEER
	db 11, BUBBLEBEAM
	db 21, RAIN_DANCE
	db 31, ICE_BEAM
	db 41, REFLECT
	db 51, LIGHT_SCREEN
	db 61, HYDRO_PUMP
	db 71, MIRROR_COAT
	db 0 ; no more level-up moves

LarvitarEvosAttacks:
	db EVOLVE_LEVEL, 30, PUPITAR
	db 0 ; no more evolutions
	db 1, LEER
	db 1, BITE
	db 8, ROCK_THROW
	db 11, SANDSTORM
	db 15, SCREECH
	db 26, THRASH
	db 34, SCARY_FACE
	db 40, ROCK_SLIDE
	db 50, CRUNCH
	db 55, EARTHQUAKE
	db 57, HYPER_BEAM
	db 0 ; no more level-up moves

PupitarEvosAttacks:
	db EVOLVE_LEVEL, 55, TYRANITAR
	db 0 ; no more evolutions
	db 1, LEER
	db 1, BITE
	db 1, ROCK_THROW
	db 1, SANDSTORM
	db 15, SCREECH
	db 26, THRASH
	db 34, SCARY_FACE
	db 40, ROCK_SLIDE
	db 50, CRUNCH
	db 55, EARTHQUAKE
	db 65, HYPER_BEAM
	db 0 ; no more level-up moves

TyranitarEvosAttacks:
	db 0 ; no more evolutions
	db 1, LEER
	db 1, BITE
	db 1, ROCK_THROW
	db 1, SANDSTORM
	db 15, SCREECH
	db 26, THRASH
	db 34, SCARY_FACE
	db 40, ROCK_SLIDE
	db 50, CRUNCH
	db 55, EARTHQUAKE
	db 65, HYPER_BEAM
	db 0 ; no more level-up moves

LugiaEvosAttacks:
	db 0 ; no more evolutions
	db 1, GUST
	db 11, SAFEGUARD
	db 22, RECOVER
	db 33, AEROBLAST
	db 44, ANCIENTPOWER
	db 55, RAIN_DANCE
	db 66, HYDRO_PUMP
	db 77, WHIRLWIND
	db 88, SWIFT
	db 99, FUTURE_SIGHT
	db 0 ; no more level-up moves

HoOhEvosAttacks:
	db 0 ; no more evolutions
	db 1,  GUST
	db 11, SAFEGUARD
	db 22, RECOVER
	db 33, SACRED_FIRE
	db 44, ANCIENTPOWER
	db 55, SUNNY_DAY
	db 66, FIRE_BLAST
	db 77, WHIRLWIND
	db 88, SWIFT
	db 99, FUTURE_SIGHT
	db 0 ; no more level-up moves

CelebiEvosAttacks:
	db 0 ; no more evolutions
	db 1, LEECH_SEED
	db 1, CONFUSION
	db 1, RECOVER
	db 10, SAFEGUARD
	db 20, MEGA_DRAIN
	db 25, ANCIENTPOWER
	db 30, PSYBEAM
	db 35, GIGA_DRAIN
	db 40, PSYCHIC_M
	db 45, HEAL_BELL
	db 50, BATON_PASS
	db 55, FUTURE_SIGHT
	db 60, PERISH_SONG
	db 0 ; no more level-up moves
