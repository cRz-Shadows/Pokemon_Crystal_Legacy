; @towersvault note
; Since the distribution gifts changed from time to time on
; the dates distributions were done, I've opted to rather
; just add all the Pokemon in a list here as opposed to
; mapping each tiny change such as when OT ID's would change.
; The primary reason for this decision is to save space.
; I've however opted for "grouping", i.e. the Distribution Man
; will for example select only "Legendary Beasts".

; \1: Pokemon
; \2: Egg Status
; \3 & \4: DVs
; \5: Number of Moves
; \6: Move 1 (Optional)
; \7: Move 2 (Optional)
; \8: Move 3 (Optional)
; \9: Move 4 (Optional)
; \10: OT ID
; \11: OT Name
distributionGift: MACRO
    db \1, \2, \3, \4, \5, \6, \7, \8, \9
    dw \10
    db \11
ENDM

DistributionGifts:
    table_width 11, DistributionGifts
    assert_table_length NUM_DISTRIBUTION_GIFTS
