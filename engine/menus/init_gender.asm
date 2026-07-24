InitCrystalData:
	ld a, $1
	ld [wPlayerPrefecture], a
	xor a
	ld [wPlayerAge], a
	ld [wPlayerGender], a
	ld [wPlayerPostalCode], a
	ld [wPlayerPostalCode+1], a
	ld [wPlayerPostalCode+2], a
	ld [wPlayerPostalCode+3], a
	ld [wd002], a
	ld [wd003], a
	ld a, [wCrystalFlags]
	res 0, a ; ???
	ld [wCrystalFlags], a
	ld a, [wCrystalFlags]
	res 1, a ; ???
	ld [wCrystalFlags], a
	ret

INCLUDE "mobile/mobile_12.asm"

InitGender:
	call InitGenderScreen
	call LoadGenderScreenPal
	call LoadGenderScreenLightBlueTile
	call WaitBGMap2
	call SetDefaultBGPAndOBP
	ld hl, AreYouABoyOrAreYouAGirlText
	call PrintText
	ld hl, .MenuHeader
	call LoadMenuHeader
	call WaitBGMap2
	call VerticalMenu
	call CloseWindow
	ld a, [wMenuCursorY]
	dec a
	ld [wPlayerGender], a
	ld c, 10
	call DelayFrames
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 6, 4, 12, 9
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_DISABLE_B ; flags
	db 2 ; items
	db "Boy@"
	db "Girl@"

AreYouABoyOrAreYouAGirlText:
	text_far _AreYouABoyOrAreYouAGirlText
	text_end

InitDifficulty:
	call InitGenderScreen
	call LoadGenderScreenPal
	call LoadGenderScreenLightBlueTile
	call WaitBGMap2
	call SetDefaultBGPAndOBP
	ld hl, SelectDifficultyText
	call PrintText
	ld hl, .DifficultyMenuHeader
	call LoadMenuHeader
	call WaitBGMap2
    call MenuCursorLoop ; VerticalMenu + yesnobox
	call CloseWindow
	ld a, [wMenuCursorY]
    dec a
	jr z, .normalMode
	cp 1
    jr z, .setHard
	ld de, ENGINE_HARDCORE_MODE
	ld b, SET_FLAG
	farcall EngineFlagAction
.setHard:
	ld de, ENGINE_HARD_MODE
	ld b, SET_FLAG
	farcall EngineFlagAction
.normalMode
	ld c, 10
	call DelayFrames
	ret

.DifficultyMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 4, 3, 15, 10
	dw .DifficultyMenuData
	db 1 ; default option

.DifficultyMenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_DISABLE_B ; flags
	db 3 ; items
	db "Normal@"
	db "Hard@"
	db "Hardcore@"

MenuCursorLoop:
	; VerticalMenu
	xor a
	ldh [hBGMapMode], a
	call MenuBox
	call UpdateSprites
	call PlaceVerticalMenuItems
	call ApplyTilemap
	call CopyMenuData
	ld a, [wMenuDataFlags]
	bit 7, a
	jr z, .cancel
	call InitVerticalMenuCursor
	call StaticMenuJoypad
	call MenuClickSound
	bit 1, a
	jr z, .okay
.cancel
	scf
	jr .done
.okay
	and a
	ld a, [wMenuCursorY]
	ld [wTempCursorPosition], a ; store temp cursor position because it will be overriten by the yesnobox
	call UpdateDifficultyText
	call YesNoBox
	jr c, .no
	ld a, [wTempCursorPosition]
	ld [wMenuCursorY], a
	ret
.no
	; reset cursor after yesnobox
	ld a, [w2DMenuCursorInitY]
	sub 2
	ld [w2DMenuCursorInitY], a
	ld a, [w2DMenuCursorInitX]
	sub 8
	ld [w2DMenuCursorInitX], a
	ld a, [wTempCursorPosition]
    ld [wMenuCursorY], a

	call CloseWindow ; close old window
	; open a new window and ask to reselect
	call SetDefaultBGPAndOBP
	ld hl, SelectDifficultyText
	call PrintText
	ld hl, .DifficultyMenuHeaderLoop
	call LoadMenuHeader
	call WaitBGMap2
	xor a
	ldh [hBGMapMode], a
	call MenuBox
	call UpdateSprites
	call PlaceVerticalMenuItems
	call ApplyTilemap
	call CopyMenuData
	ld a, [wMenuDataFlags]
	call MenuCursorLoop
.done
	ret

.DifficultyMenuHeaderLoop:
	db MENU_BACKUP_TILES ; flags
	menu_coords 4, 3, 15, 10
	dw .DifficultyMenuDataLoop

.DifficultyMenuDataLoop:
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_DISABLE_B ; flags
	db 3 ; items
	db "Normal@"
	db "Hard@"
	db "Hardcore@"

UpdateDifficultyText:
    ld a, [wMenuCursorY]
	dec a
    cp 0
    jr z, .showNormalText
    cp 1
    jr z, .showHardText
	cp 2
    jr z, .showHardcoreText
.showNormalText:
    hlcoord x, y
    ld hl, SelectDifficultyNormalText
    jr .printText
.showHardText:
    hlcoord x, y
    ld hl, SelectDifficultyHardText
	jr .printText
.showHardcoreText:
	hlcoord x, y
    ld hl, SelectDifficultyHardcoreText
.printText:
    call PrintText
    ret

SelectDifficultyText:
    text_far _SelectDifficultyText
	text_end

SelectDifficultyNormalText:
    text_far _SelectDifficultyNormalText
	text_end

SelectDifficultyHardText:
    text_far _SelectDifficultyHardText
	text_end

SelectDifficultyHardcoreText:
    text_far _SelectDifficultyHardcoreText
	text_end


InitGenderScreen:
	ld a, $10
	ld [wMusicFade], a
	ld a, LOW(MUSIC_NONE)
	ld [wMusicFadeID], a
	ld a, HIGH(MUSIC_NONE)
	ld [wMusicFadeID + 1], a
	ld c, 8
	call DelayFrames
	call ClearBGPalettes
	call InitCrystalData
	call LoadFontsExtra
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	ld a, $0
	call ByteFill
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_AREA
	xor a
	call ByteFill
	ret

LoadGenderScreenPal:
	ld hl, .Palette
	ld de, wBGPals1
	ld bc, 1 palettes
	ld a, BANK(wBGPals1)
	call FarCopyWRAM
	farcall ApplyPals
	ret

.Palette:
INCLUDE "gfx/new_game/gender_screen.pal"

LoadGenderScreenLightBlueTile:
	ld de, .LightBlueTile
	ld hl, vTiles2 tile $00
	lb bc, BANK(.LightBlueTile), 1
	call Get2bpp
	ret

.LightBlueTile:
INCBIN "gfx/new_game/gender_screen.2bpp"
