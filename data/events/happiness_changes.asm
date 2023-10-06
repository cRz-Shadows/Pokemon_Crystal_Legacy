HappinessChanges:
; entries correspond to HAPPINESS_* constants
	table_width 3, HappinessChanges
	; change if happiness < 100, change if happiness < 200, change otherwise
	db  +10, +6,  +4 ; Gained a level
	db  +5,  +3,  +2 ; Vitamin
	db  +1,  +1,  +1 ; X Item
	db  +9,  +9,  +9 ; Battled a Gym Leader
	db  +1,  +1,  +1 ; Learned a move
	db  -1,  -1,  -1 ; Lost to an enemy
	db  -5,  -5, -10 ; Fainted due to poison
	db  -5,  -5, -10 ; Lost to a much stronger enemy
	db  +5,  +5,  +5 ; Haircut (older brother) 1
	db  +5,  +5,  +5 ; Haircut (older brother) 2
	db  +5,  +5,  +5 ; Haircut (older brother) 3
	db  +5,  +5,  +5 ; Haircut (younger brother) 1
	db  +7,  +7,  +7 ; Haircut (younger brother) 2
	db +10, +10,  +9 ; Haircut (younger brother) 3
	db  -5,  -5, -10 ; Used Heal Powder or Energypowder (bitter)
	db -10, -10, -15 ; Used Energy Root (bitter)
	db -15, -15, -20 ; Used Revival Herb (bitter)
	db  +3,  +3,  +1 ; Grooming
	db +10,  +6,  +4 ; Gained a level in the place where it was caught
	assert_table_length NUM_HAPPINESS_CHANGES
