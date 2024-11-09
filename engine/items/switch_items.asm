SwitchItemsInBag:
	ld a, [wSwitchItem]
	and a
	jr z, .init
	ld b, a
	ld a, [wScrollingMenuCursorPosition]
	inc a
	cp b
	jr z, .trivial
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	ld a, [hl]
	cp -1
	ret z
	ld a, [wSwitchItem]
	dec a
	ld [wSwitchItem], a
	call .try_combining_stacks
	jp c, .combine_stacks
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld a, [wSwitchItem]
	cp c
	jr c, .above
	jr .below

.init:
	ld a, [wScrollingMenuCursorPosition]
	inc a
	ld [wSwitchItem], a
	ret

.trivial:
	xor a
	ld [wSwitchItem], a
	ret

.below:
	ld a, [wSwitchItem]
	call ItemSwitch_CopyItemToBuffer
	ld a, [wScrollingMenuCursorPosition]
	ld d, a
	ld a, [wSwitchItem]
	ld e, a
	call ItemSwitch_GetItemOffset
	push bc
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	dec hl
	push hl
	call ItemSwitch_GetItemFormatSize
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	call ItemSwitch_BackwardsCopyBytes
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_CopyBufferToItem
	xor a
	ld [wSwitchItem], a
	ret

.above:
	ld a, [wSwitchItem]
	call ItemSwitch_CopyItemToBuffer
	ld a, [wScrollingMenuCursorPosition]
	ld d, a
	ld a, [wSwitchItem]
	ld e, a
	call ItemSwitch_GetItemOffset
	push bc
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	call ItemSwitch_GetItemFormatSize
	add hl, bc
	pop bc
	call CopyBytes
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_CopyBufferToItem
	xor a
	ld [wSwitchItem], a
	ret

.try_combining_stacks:
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	ld a, [de]
	cp [hl]
	jr nz, .no_combine
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetItemQuantity
	cp MAX_ITEM_STACK
	jr z, .no_combine
	ld a, [wSwitchItem]
	call ItemSwitch_GetItemQuantity
	cp MAX_ITEM_STACK
	jr nz, .combine
.no_combine
	and a
	ret
.combine
	scf
	ret

.combine_stacks:
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	inc hl
	push hl
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	ld a, [hl]
	pop hl
	add [hl]
	cp MAX_ITEM_STACK + 1
	jr c, .merge_stacks
	sub MAX_ITEM_STACK
	push af
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	ld [hl], MAX_ITEM_STACK
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	inc hl
	pop af
	ld [hl], a
	xor a
	ld [wSwitchItem], a
	ret

.merge_stacks:
	push af
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	pop af
	ld [hl], a
	ld hl, wMenuData_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wSwitchItem]
	cp [hl]
	jr nz, .not_combining_last_item
	dec [hl]
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	ld [hl], -1 ; end
	xor a
	ld [wSwitchItem], a
	ret

.not_combining_last_item:
	dec [hl]
	call ItemSwitch_GetItemFormatSize
	push bc
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	pop bc
	push hl
	add hl, bc
	pop de
.copy_loop
	ld a, [hli]
	ld [de], a
	inc de
	cp -1 ; end?
	jr nz, .copy_loop
	xor a
	ld [wSwitchItem], a
	ret

ItemSwitch_CopyItemToBuffer:
	call ItemSwitch_GetNthItem
	ld de, wSwitchItemBuffer
	call ItemSwitch_GetItemFormatSize
	call CopyBytes
	ret

ItemSwitch_CopyBufferToItem:
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	ld hl, wSwitchItemBuffer
	call ItemSwitch_GetItemFormatSize
	call CopyBytes
	ret

ItemSwitch_GetNthItem:
	push af
	call ItemSwitch_GetItemFormatSize
	ld hl, wMenuData_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	pop af
	call AddNTimes
	ret

ItemSwitch_GetItemOffset:
	push hl
	call ItemSwitch_GetItemFormatSize
	ld a, d
	sub e
	jr nc, .dont_negate
	dec a
	cpl
.dont_negate
	ld hl, 0
	call AddNTimes
	ld b, h
	ld c, l
	pop hl
	ret

ItemSwitch_GetItemFormatSize:
	push hl
	ld a, [wMenuData_ScrollingMenuItemFormat]
	ld c, a
	ld b, 0
	ld hl, .item_format_sizes
	add hl, bc
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	pop hl
	ret

.item_format_sizes:
; entries correspond to SCROLLINGMENU_ITEMS_* constants
	dw 0 ; unused
	dw 1 ; SCROLLINGMENU_ITEMS_NORMAL
	dw 2 ; SCROLLINGMENU_ITEMS_QUANTITY

ItemSwitch_GetItemQuantity:
	push af
	call ItemSwitch_GetItemFormatSize
	ld a, c
	cp 2
	jr nz, .no_quantity
	pop af
	call ItemSwitch_GetNthItem
	inc hl
	ld a, [hl]
	ret

.no_quantity
	pop af
	ld a, 1
	ret

ItemSwitch_BackwardsCopyBytes:
.loop
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

SortItemsInBag:
; Save the current Menu Cursor Position to restore after sorting
	ld a, [wScrollingMenuCursorPosition]
	push af

; Store current checking item index in B
	ld b, 0
.outerLoop
; Checks if the current item at index B is "CANCEL" (stored as $FF in WRAM)
	ld a, b
	push bc
	call ItemSwitch_GetNthItem
	ld a, [hl]
	inc a
	pop bc
	jr z, .done
.innerLoop
; Gets the current item in the list at index B
	ld a, b
	call GetSortingItemIndex
	ld c, a
; Check if the Item ID is "CANCEL", i.e. $FF 
; If it's the case, jump to .done since there's nothing else to sort
	inc a
	jr z, .done

; Get next item in the list at index A (B+1)
	ld a, b
	inc a
	call GetSortingItemIndex

; Check again if the Item ID is "CANCEL", i.e. $FF
; If it's the case, jump to .done since there's nothing else to sort
	inc a
	jr z, .done

; Item ID isn't "CANCEL", so we continue
	dec a
; Check if A is before or after C in the ItemNameOrder table
	cp c
	jr nc, .sortingOK

; Swap items
	push bc
	ld a, b
	ld [wScrollingMenuCursorPosition], a
	call SwitchItemsInBag
	ld [wScrollingMenuCursorPosition], a
	call SwitchItemsInBag
	pop bc

; Check if list index B is 0, if not, it means the item might be able to move one slot up in the list
	ld a, b
	and a
	jr z, .innerLoop

	dec b
	jr .innerLoop
.sortingOK
	inc b
	jr .outerLoop
.done
; Sorting complete, restore Cursor Menu Position and return
	pop af
	ld [wScrollingMenuCursorPosition], a
	ret 

; @param a: Item index
; @return a: Index in name_order.asm
; @clobbers hl
GetSortingItemIndex:
	push bc
	call ItemSwitch_GetNthItem
; Check if the item is "CANCEL", if so, skip to .done
	ld a, [hl]
	ld b, a
	inc a
	jr z, .done
	ld c, [hl]
	ld b, 0
	ld hl, ItemNameOrder
.lookupLoop
	ld a, [hli]
	cp a, c
	jr z, .done
	inc b
	jr .lookupLoop
.done
	ld a, b
	pop bc
	ret 

INCLUDE "data/items/sorting_order.asm"
