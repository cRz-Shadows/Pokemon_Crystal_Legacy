; @towersvault note
; Only 2 specific distributions will be made use of, namely one
; for pre-National Dex completion, and one for post-National
; Dex completion. The pre-National Dex distributions exclude
; all Mythical and Legendary Pokemon.

DEF NUM_PRENATDEX_DISTRIBUTIONS EQU 119

DistributionPreNatDex:
    table_width 1, DistributionPreNatDex
; Christmas Week
    db DISTGIFT_PAYDAY_DELIBIRD                 ; 08
; The Initial Three
    db DISTGIFT_ANCIENTPOWER_BULBASAUR          ; 09
    db DISTGIFT_CRUNCH_CHARMANDER               ; 0a
    db DISTGIFT_ZAPCANNON_SQUIRTLE              ; 0b
    db DISTGIFT_PETALDANCE_CHIKORITA            ; 0c
    db DISTGIFT_DOUBLEEDGE_CYNDAQUIL            ; 0d
    db DISTGIFT_SUBMISSION_TOTODILE             ; 0e
; Valentine Week
    db DISTGIFT_LOVELYKISS_NIDORANF             ; 0f
    db DISTGIFT_SWEETKISS_NIDORANF              ; 10
    db DISTGIFT_LOVELYKISS_NIDORANM             ; 11
    db DISTGIFT_SWEETKISS_NIDORANM              ; 12
    db DISTGIFT_LOVELYKISS_BELLSPROUT           ; 13
    db DISTGIFT_SWEETKISS_BELLSPROUT            ; 14
    db DISTGIFT_LOVELYKISS_POLIWAG              ; 15
    db DISTGIFT_SWEETKISS_POLIWAG               ; 16
    db DISTGIFT_LOVELYKISS_SNORLAX              ; 17
    db DISTGIFT_SWEETKISS_SNORLAX               ; 18
; Swarm Week
    db DISTGIFT_HYDROPUMP_MARILL                ; 19
    db DISTGIFT_STEELWING_YANMA                 ; 1a
    db DISTGIFT_HORNDRILL_DUNSPARCE             ; 1b
    db DISTGIFT_LOVELYKISS_SNUBBULL             ; 1c
    db DISTGIFT_DOUBLEEDGE_QWILFISH             ; 1d
    db DISTGIFT_AMNESIA_REMORAID                ; 1e
; Kanto Initial Three
    db DISTGIFT_SHINY_VENUSAUR                  ; 1f
    db DISTGIFT_SHINY_CHARIZARD                 ; 20
    db DISTGIFT_SHINY_BLASTOISE                 ; 21
; Babies Week
    db DISTGIFT_SING_PICHU                      ; 23
    db DISTGIFT_SWIFT_CLEFFA                    ; 24
    db DISTGIFT_MIMIC_IGGLYBUFF                 ; 25
    db DISTGIFT_METRONOME_SMOOCHUM              ; 26
    db DISTGIFT_PURSUIT_ELEKID                  ; 27
    db DISTGIFT_FAINTATTACK_MAGBY               ; 28
; Spring Into Spring
    db DISTGIFT_PETALDANCE_PSYDUCK              ; 29
    db DISTGIFT_PETALDANCE_PICHU                ; 2a
    db DISTGIFT_PETALDANCE_CLEFFA               ; 2b
    db DISTGIFT_PETALDANCE_IGGLYBUFF            ; 2c
    db DISTGIFT_PETALDANCE_SMOOCHUM             ; 2d
; Tropical Promotion to Summer Festival 1
    db DISTGIFT_GROWTH_POLIWAG                  ; 2e
    db DISTGIFT_HAZE_HORSEA                     ; 2f
    db DISTGIFT_SWORDSDANCE_GOLDEEN             ; 30
    db DISTGIFT_REVERSAL_MAGIKARP               ; 31
    db DISTGIFT_DIZZYPUNCH_MARILL               ; 32
    db DISTGIFT_BELLYDRUM_WOOPER                ; 33
; Tropical Promotion to Summer Festival 2
    db DISTGIFT_TRIATTACK_PSYDUCK               ; 34
    db DISTGIFT_CONFUSERAY_TENTACOOL            ; 35
    db DISTGIFT_LIGHTSCREEN_CHINCHOU            ; 37
    db DISTGIFT_MIST_REMORAID                   ; 38
    db DISTGIFT_GUST_MANTINE                    ; 39
; Safari Week
    db DISTGIFT_MOONLIGHT_NIDORANF              ; 3a
    db DISTGIFT_MORNINGSUN_NIDORANM             ; 3b
    db DISTGIFT_SWEETSCENT_CHANSEY              ; 3c
    db DISTGIFT_FAINTATTACK_KANGASKHAN          ; 3d
    db DISTGIFT_QUICKATTACK_TAUROS              ; 3e
    db DISTGIFT_HYDROPUMP_DRATINI               ; 3f
; Sky Week
    db DISTGIFT_SONICBOOM_SPEAROW               ; 40
    db DISTGIFT_FURYCUTTER_FARFETCHED           ; 41
    db DISTGIFT_LOWKICK_DODUO                   ; 42
    db DISTGIFT_SAFEGUARD_NATU                  ; 43
    db DISTGIFT_BEATUP_MURKROW                  ; 44
    db DISTGIFT_FURYCUTTER_SKARMORY             ; 45
; Power Plant 
    db DISTGIFT_DIZZYPUNCH_PICHU                ; 46
    db DISTGIFT_AGILITY_MAGNEMITE               ; 47
    db DISTGIFT_DIZZYPUNCH_ELEKID               ; 48
    db DISTGIFT_AGILITY_VOLTORB                 ; 49
; Scary Face 
    db DISTGIFT_SCARYFACE_CLEFFA                ; 4a
    db DISTGIFT_SCARYFACE_IGGLYBUFF             ; 4b
    db DISTGIFT_SCARYFACE_MARILL                ; 4c
    db DISTGIFT_SCARYFACE_PICHU                 ; 4d
    db DISTGIFT_SCARYFACE_WOOPER                ; 4e
; Silver Cave
    db DISTGIFT_SYNTHESIS_TANGELA               ; 4f
    db DISTGIFT_LOWKICK_PONYTA                  ; 50
    db DISTGIFT_HYPNOSIS_MISDREAVUS             ; 51
    db DISTGIFT_RAGE_LARVITAR                   ; 52
; Union Cave
    db DISTGIFT_TWISTER_STARYU                  ; 53
    db DISTGIFT_METALCLAW_KRABBY                ; 54
    db DISTGIFT_SHARPEN_ONIX                    ; 55
; Psychic Type
    db DISTGIFT_FORESIGHT_ABRA                  ; 58
    db DISTGIFT_AMNESIA_DROWZEE                 ; 59
    db DISTGIFT_SWEETSCENT_EXEGGCUTE            ; 5a
    db DISTGIFT_MINDREADER_MRMIME               ; 5b
; The Johto Initial Three
    db DISTGIFT_SHINY_MEGANIUM                  ; 5c
    db DISTGIFT_SHINY_TYPHLOSION                ; 5d
    db DISTGIFT_SHINY_FERALIGATR                ; 5e
; Rock Tunnel
    db DISTGIFT_RAPIDSPIN_GEODUDE               ; 5f
    db DISTGIFT_FLAIL_ZUBAT                     ; 60
    db DISTGIFT_THRASH_MACHOP                   ; 61
    db DISTGIFT_FURYATTACK_CUBONE               ; 62
; Ice Type
    db DISTGIFT_SPIKES_DELIBIRD                 ; 63
    db DISTGIFT_FLAIL_SEEL                      ; 64
    db DISTGIFT_WHIRLWIND_SWINUB                ; 65
; Pokemon that Appear at Night only
    db DISTGIFT_NIGHTSHADE_HOOTHOOT             ; 66
    db DISTGIFT_MOONLIGHT_SNEASEL               ; 67
; Grass Type
    db DISTGIFT_SPLASH_SUNKERN                  ; 68
    db DISTGIFT_SYNTHESIS_PARAS                 ; 69
    db DISTGIFT_AGILITY_HOPPIP                  ; 6a
    db DISTGIFT_LEECHSEED_ODDISH                ; 6b
; Normal Pokemon
    db DISTGIFT_DIZZYPUNCH_SENTRET              ; 6c
    db DISTGIFT_SAFEGUARD_STANTLER              ; 6d
    db DISTGIFT_MEGAKICK_MILTANK                ; 6e
    db DISTGIFT_MIMIC_AIPOM                     ; 6f
    db DISTGIFT_DOUBLESLAP_LICKITUNG            ; 70
    db DISTGIFT_SPLASH_SNORLAX                  ; 71
; Mt. Mortar
    db DISTGIFT_FALSESWIPE_MACHOP               ; 72
    db DISTGIFT_BUBBLE_MAGIKARP                 ; 73
    db DISTGIFT_RAGE_TYROGUE                    ; 74
; Dark Cave Pokemon
    db DISTGIFT_FURYATTACK_DUNSPARCE            ; 75
    db DISTGIFT_MIMIC_WOBBUFFET                 ; 76
    db DISTGIFT_ABSORB_PHANPY                   ; 77
    db DISTGIFT_SWEETSCENT_TEDDIURSA            ; 78
; Rare Pokemon
    db DISTGIFT_BARRIER_PORYGON                 ; 7c
    db DISTGIFT_GROWTH_EEVEE                    ; 7d
    db DISTGIFT_SUBSTITUTE_SUDOWOODO            ; 7e
; Bug Type Pokemon
    db DISTGIFT_SONICBOOM_SCYTHER               ; 7f
    db DISTGIFT_SEISMICTOSS_HERACROSS           ; 80
    db DISTGIFT_ROCKTHROW_PINSIR                ; 81
    db DISTGIFT_BARRIER_LEDYBA                  ; 82
    db DISTGIFT_GROWTH_SPINARAK                 ; 83
    db DISTGIFT_SWEETKISS_YANMA                 ; 84
    db DISTGIFT_SUBSTITUTE_PINECO               ; 85
    assert_table_length NUM_PRENATDEX_DISTRIBUTIONS