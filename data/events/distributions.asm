; @towersvault note
; Since the distribution gifts changed from time to time on
; the dates distributions were done, I've opted to rather
; just add all the Pokemon in a list here as opposed to
; mapping each tiny change such as when OT ID's would change.
; The primary reason for this decision is to save space.
; I've however opted for "grouping", i.e. the Distribution Man
; will for example select only "Legendary Beasts".

; \1: Pointer to distribution data table
distribution: MACRO
    dw \1
ENDM

Distributions:
    table_width 2, Distributions
    distribution .distJohtoLegendary
    distribution .distLegendaryBirds
    distribution .distChristmasWeek
    distribution .distInitialThree
    distribution .distValentineWeek
    distribution .distSwarmWeek
    distribution .distKantoIntialThree
    distribution .distBabiesWeek
    distribution .distSpringIntoSpring
    distribution .distTropicalPromo1
    distribution .distTropicalPromo2
    distribution .distSafariWeek
    distribution .distSkyWeek
    distribution .distPowerPlant
    distribution .distScaryFace
    distribution .distSilverCave
    distribution .distUnionCave
    distribution .distCelebiPresentSP
    distribution .distPsychicType
    distribution .distJohtoInitialThree
    distribution .distRockTunnel
    distribution .distIceType
    distribution .distPokemonThatAppearAtNight
    distribution .distGrassType
    distribution .distNormalPokemon
    distribution .distMtMortar
    distribution .distDarkCave
    distribution .distRarePokemon
    distribution .distBugTypePokemon
    assert_table_length NUM_DISTRIBUTIONS

.distJohtoLegendary
    db DISTGIFT_SHINY_RAIKOU
    db DISTGIFT_SHINY_ENTEI
    db DISTGIFT_SHINY_SUICUNE
    db DISTGIFT_SHINY_HOOH
    db DISTGIFT_SHINY_LUGIA
    db -1 ; end

.distLegendaryBirds
    db DISTGIFT_SHINY_ARTICUNO
    db DISTGIFT_SHINY_ZAPDOS
    db DISTGIFT_SHINY_MOLTRES
    db -1 ; end

.distChristmasWeek
    db DISTGIFT_PAYDAY_DELIBIRD
    db -1 ; end

.distInitialThree
    db DISTGIFT_ANCIENTPOWER_BULBASAUR
    db DISTGIFT_CRUNCH_CHARMANDER
    db DISTGIFT_ZAPCANNON_SQUIRTLE
    db DISTGIFT_PETALDANCE_CHIKORITA
    db DISTGIFT_DOUBLEEDGE_CYNDAQUIL
    db DISTGIFT_SUBMISSION_TOTODILE
    db -1 ; end

.distValentineWeek
    db DISTGIFT_LOVELYKISS_NIDORANF
    db DISTGIFT_SWEETKISS_NIDORANF
    db DISTGIFT_LOVELYKISS_NIDORANM
    db DISTGIFT_SWEETKISS_NIDORANM
    db DISTGIFT_LOVELYKISS_BELLSPROUT
    db DISTGIFT_SWEETKISS_BELLSPROUT
    db DISTGIFT_LOVELYKISS_POLIWAG
    db DISTGIFT_SWEETKISS_POLIWAG
    db DISTGIFT_LOVELYKISS_SNORLAX
    db DISTGIFT_SWEETKISS_SNORLAX
    db -1 ; end

.distSwarmWeek
    db DISTGIFT_HYDROPUMP_MARILL
    db DISTGIFT_STEELWING_YANMA
    db DISTGIFT_HORNDRILL_DUNSPARCE
    db DISTGIFT_LOVELYKISS_SNUBBULL
    db DISTGIFT_DOUBLEEDGE_QWILFISH
    db DISTGIFT_AMNESIA_REMORAID
    db -1 ; end

.distKantoIntialThree
    db DISTGIFT_SHINY_VENUSAUR
    db DISTGIFT_SHINY_CHARIZARD
    db DISTGIFT_SHINY_BLASTOISE
    db DISTGIFT_SHINY_MEWTWO
    db -1 ; end

.distBabiesWeek
    db DISTGIFT_SING_PICHU
    db DISTGIFT_SWIFT_CLEFFA
    db DISTGIFT_MIMIC_IGGLYBUFF
    db DISTGIFT_METRONOME_SMOOCHUM
    db DISTGIFT_PURSUIT_ELEKID
    db DISTGIFT_FAINTATTACK_MAGBY
    db -1 ; end

.distSpringIntoSpring
    db DISTGIFT_PETALDANCE_PSYDUCK
    db DISTGIFT_PETALDANCE_CHIKORITA
    db DISTGIFT_PETALDANCE_PICHU
    db DISTGIFT_PETALDANCE_CLEFFA
    db DISTGIFT_PETALDANCE_IGGLYBUFF
    db DISTGIFT_PETALDANCE_SMOOCHUM
    db -1 ; end

.distTropicalPromo1
    db DISTGIFT_GROWTH_POLIWAG
    db DISTGIFT_HAZE_HORSEA
    db DISTGIFT_SWORDSDANCE_GOLDEEN
    db DISTGIFT_REVERSAL_MAGIKARP
    db DISTGIFT_DIZZYPUNCH_MARILL
    db DISTGIFT_BELLYDRUM_WOOPER
    db -1 ; end

.distTropicalPromo2
    db DISTGIFT_TRIATTACK_PSYDUCK
    db DISTGIFT_CONFUSERAY_TENTACOOL
    db DISTGIFT_BITE_LAPRAS
    db DISTGIFT_LIGHTSCREEN_CHINCHOU
    db DISTGIFT_MIST_REMORAID
    db DISTGIFT_GUST_MANTINE
    db -1 ; end

.distSafariWeek
    db DISTGIFT_MOONLIGHT_NIDORANF
    db DISTGIFT_MORNINGSUN_NIDORANM
    db DISTGIFT_SWEETSCENT_CHANSEY
    db DISTGIFT_FAINTATTACK_KANGASKHAN
    db DISTGIFT_QUICKATTACK_TAUROS
    db DISTGIFT_HYDROPUMP_DRATINI
    db -1 ; end

.distSkyWeek
    db DISTGIFT_SONICBOOM_SPEAROW
    db DISTGIFT_FURYCUTTER_FARFETCHED
    db DISTGIFT_LOWKICK_DODUO
    db DISTGIFT_SAFEGUARD_NATU
    db DISTGIFT_BEATUP_MURKROW
    db DISTGIFT_FURYCUTTER_SKARMORY
    db -1 ; end

.distPowerPlant
    db DISTGIFT_DIZZYPUNCH_PICHU
    db DISTGIFT_AGILITY_MAGNEMITE
    db DISTGIFT_DIZZYPUNCH_ELEKID
    db DISTGIFT_AGILITY_VOLTORB
    db -1 ; end 

.distScaryFace
    db DISTGIFT_SCARYFACE_CLEFFA
    db DISTGIFT_SCARYFACE_IGGLYBUFF
    db DISTGIFT_SCARYFACE_MARILL
    db DISTGIFT_SCARYFACE_PICHU
    db DISTGIFT_SCARYFACE_WOOPER
    db -1 ; end

.distSilverCave
    db DISTGIFT_SYNTHESIS_TANGELA
    db DISTGIFT_LOWKICK_PONYTA
    db DISTGIFT_LOWKICK_DODUO
    db DISTGIFT_HYPNOSIS_MISDREAVUS
    db DISTGIFT_RAGE_LARVITAR
    db -1 ; end

.distUnionCave
    db DISTGIFT_TWISTER_STARYU
    db DISTGIFT_METALCLAW_KRABBY
    db DISTGIFT_SHARPEN_ONIX
    db DISTGIFT_SWORDSDANCE_GOLDEEN
    db DISTGIFT_FUTURESIGHT_LAPRAS
    db -1 ; end

.distCelebiPresentSP
    db DISTGIFT_SHINY_MEW
    db -1 ; end

.distPsychicType
    db DISTGIFT_FORESIGHT_ABRA
    db DISTGIFT_AMNESIA_DROWZEE
    db DISTGIFT_SWEETSCENT_EXEGGCUTE
    db DISTGIFT_SAFEGUARD_NATU
    db DISTGIFT_MINDREADER_MRMIME
    db -1 ; end

.distJohtoInitialThree
    db DISTGIFT_SHINY_MEGANIUM
    db DISTGIFT_SHINY_TYPHLOSION
    db DISTGIFT_SHINY_FERALIGATR
    db -1 ; end

.distRockTunnel
    db DISTGIFT_RAPIDSPIN_GEODUDE
    db DISTGIFT_FLAIL_ZUBAT
    db DISTGIFT_THRASH_MACHOP
    db DISTGIFT_SHARPEN_ONIX
    db DISTGIFT_FURYATTACK_CUBONE
    db DISTGIFT_FAINTATTACK_KANGASKHAN
    db -1 ; end

.distIceType
    db DISTGIFT_SPIKES_DELIBIRD
    db DISTGIFT_FLAIL_SEEL
    db DISTGIFT_FUTURESIGHT_LAPRAS
    db DISTGIFT_WHIRLWIND_SWINUB
    db -1 ; end

.distPokemonThatAppearAtNight
    db DISTGIFT_NIGHTSHADE_HOOTHOOT
    db DISTGIFT_BEATUP_MURKROW
    db DISTGIFT_HYPNOSIS_MISDREAVUS
    db DISTGIFT_MOONLIGHT_SNEASEL
    db DISTGIFT_TWISTER_STARYU
    db -1 ; end

.distGrassType
    db DISTGIFT_SPLASH_SUNKERN
    db DISTGIFT_SYNTHESIS_TANGELA
    db DISTGIFT_SYNTHESIS_PARAS
    db DISTGIFT_AGILITY_HOPPIP
    db DISTGIFT_LEECHSEED_ODDISH
    db -1 ; end

.distNormalPokemon
    db DISTGIFT_DIZZYPUNCH_SENTRET
    db DISTGIFT_SAFEGUARD_STANTLER
    db DISTGIFT_MEGAKICK_MILTANK
    db DISTGIFT_MIMIC_AIPOM
    db DISTGIFT_DOUBLESLAP_LICKITUNG
    db DISTGIFT_SPLASH_SNORLAX
    db -1 ; end

.distMtMortar
    db DISTGIFT_FALSESWIPE_MACHOP
    db DISTGIFT_DIZZYPUNCH_MARILL
    db DISTGIFT_SWORDSDANCE_GOLDEEN
    db DISTGIFT_BUBBLE_MAGIKARP
    db DISTGIFT_RAGE_TYROGUE
    db -1 ; end

.distDarkCave
    db DISTGIFT_RAPIDSPIN_GEODUDE
    db DISTGIFT_FURYATTACK_DUNSPARCE
    db DISTGIFT_MIMIC_WOBBUFFET
    db DISTGIFT_ABSORB_PHANPY
    db DISTGIFT_SWEETSCENT_TEDDIURSA
    db -1 ; end

.distRarePokemon
    db DISTGIFT_ROCKTHROW_KABUTO
    db DISTGIFT_ROCKTHROW_OMANYTE
    db DISTGIFT_ROCKTHROW_AERODACTYL
    db DISTGIFT_BARRIER_PORYGON
    db DISTGIFT_GROWTH_EEVEE
    db DISTGIFT_SWEETKISS_SNORLAX
    db DISTGIFT_SUBSTITUTE_SUDOWOODO
    db -1 ; end

.distBugTypePokemon
    db DISTGIFT_SONICBOOM_SCYTHER
    db DISTGIFT_SEISMICTOSS_HERACROSS
    db DISTGIFT_ROCKTHROW_PINSIR
    db DISTGIFT_BARRIER_LEDYBA
    db DISTGIFT_GROWTH_SPINARAK
    db DISTGIFT_SWEETKISS_YANMA
    db DISTGIFT_SUBSTITUTE_PINECO
    db -1 ; end
