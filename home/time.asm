; Functions relating to the timer interrupt and the real-time-clock.

Timer:: ; unreferenced
	push af
	ldh a, [hMobile]
	and a
	jr z, .not_mobile
	call MobileTimer

.not_mobile
	pop af
	reti

LatchClock::
; No real-time clock on this hardware (RTC-less MBC3 / MBC5).
; Latching would poke the MBC3 clock register; do nothing.
	ret

UpdateTime::
	call GetClock
	call FixDays
	call FixTime
	farcall GetTimeOfDay
	ret

GetClock::
; store clock data in hRTCDayHi-hRTCSeconds
;
; This hardware has no real-time clock. Reading the MBC3 clock registers here
; would actually select an SRAM bank ($08-$0c -> bank 0-4) and read box data as
; if it were the time (corrupting the time and, on write, Box 8). Instead return
; a frozen zero clock: the displayed time becomes exactly the wStart* offsets set
; by the player in the clock-setting UI (see FixTime), and never drifts on its own.
	xor a
	ldh [hRTCSeconds], a
	ldh [hRTCMinutes], a
	ldh [hRTCHours], a
	ldh [hRTCDayLo], a
	ldh [hRTCDayHi], a
	ret

FixDays::
; fix day count
; mod by 140

; check if day count > 255 (bit 8 set)
	ldh a, [hRTCDayHi] ; DH
	bit 0, a
	jr z, .daylo
; reset dh (bit 8)
	res 0, a
	ldh [hRTCDayHi], a

; mod 140
; mod twice since bit 8 (DH) was set
	ldh a, [hRTCDayLo]
.modh
	sub 140
	jr nc, .modh
.modl
	sub 140
	jr nc, .modl
	add 140

; update dl
	ldh [hRTCDayLo], a

; flag for sRTCStatusFlags
	ld a, %01000000
	jr .set

.daylo
; quit if fewer than 140 days have passed
	ldh a, [hRTCDayLo]
	cp 140
	jr c, .quit

; mod 140
.mod
	sub 140
	jr nc, .mod
	add 140

; update dl
	ldh [hRTCDayLo], a

; flag for sRTCStatusFlags
	ld a, %00100000

.set
; update clock with modded day value
	push af
	call SetClock
	pop af
	scf
	ret

.quit
	xor a
	ret

FixTime::
; add ingame time (set at newgame) to current time
; store time in wCurDay, hHours, hMinutes, hSeconds

; second
	ldh a, [hRTCSeconds]
	ld c, a
	ld a, [wStartSecond]
	add c
	sub 60
	jr nc, .updatesec
	add 60
.updatesec
	ldh [hSeconds], a

; minute
	ccf ; carry is set, so turn it off
	ldh a, [hRTCMinutes]
	ld c, a
	ld a, [wStartMinute]
	adc c
	sub 60
	jr nc, .updatemin
	add 60
.updatemin
	ldh [hMinutes], a

; hour
	ccf ; carry is set, so turn it off
	ldh a, [hRTCHours]
	ld c, a
	ld a, [wStartHour]
	adc c
	sub 24
	jr nc, .updatehr
	add 24
.updatehr
	ldh [hHours], a

; day
	ccf ; carry is set, so turn it off
	ldh a, [hRTCDayLo]
	ld c, a
	ld a, [wStartDay]
	adc c
	ld [wCurDay], a
	ret

InitTimeOfDay::
	xor a
	ld [wStringBuffer2], a
	ld a, 0 ; useless
	ld [wStringBuffer2 + 3], a
	jr InitTime

InitDayOfWeek::
	call UpdateTime
	ldh a, [hHours]
	ld [wStringBuffer2 + 1], a
	ldh a, [hMinutes]
	ld [wStringBuffer2 + 2], a
	ldh a, [hSeconds]
	ld [wStringBuffer2 + 3], a
	jr InitTime ; useless

InitTime::
	farcall _InitTime
	ret

ClearClock::
	call .ClearhRTC
	call SetClock
	ret

.ClearhRTC:
	xor a
	ldh [hRTCSeconds], a
	ldh [hRTCMinutes], a
	ldh [hRTCHours], a
	ldh [hRTCDayLo], a
	ldh [hRTCDayHi], a
	ret

SetClock::
; No real-time clock on this hardware. Writing the clock here would select an
; SRAM bank via the RTC register selectors ($08-$0c) and clobber save data
; (RTC_DL=$0b -> SRAM bank 3 -> start of Box 8). Do nothing; the software clock
; lives entirely in the wStart* offsets set through the clock UI.
	ret

ClearRTCStatus:: ; unreferenced
; clear sRTCStatusFlags
	xor a
	push af
	ld a, BANK(sRTCStatusFlags)
	call OpenSRAM
	pop af
	ld [sRTCStatusFlags], a
	call CloseSRAM
	ret

RecordRTCStatus::
; append flags to sRTCStatusFlags
	ld hl, sRTCStatusFlags
	push af
	ld a, BANK(sRTCStatusFlags)
	call OpenSRAM
	pop af
	or [hl]
	ld [hl], a
	call CloseSRAM
	ret

CheckRTCStatus::
; check sRTCStatusFlags
	ld a, BANK(sRTCStatusFlags)
	call OpenSRAM
	ld a, [sRTCStatusFlags]
	call CloseSRAM
	ret
