_InitializeStartDay:
	call InitializeStartDay
	ret

ClearDailyTimers:
	xor a
	ld [wLuckyNumberDayTimer], a
	ld [wUnusedTwoDayTimer], a
	ld [wDailyResetTimer], a
	ret

InitCallReceiveDelay::
	xor a
	ld [wTimeCyclesSinceLastCall], a

NextCallReceiveDelay:
	ld a, [wTimeCyclesSinceLastCall]
	cp 3
	jr c, .okay
	ld a, 3

.okay
	ld e, a
	ld d, 0
	ld hl, .ReceiveCallDelays
	add hl, de
	ld a, [hl]
if DEF(_DEBUG)
	ld h, a
	ld a, BANK(sDebugTimeCyclesSinceLastCall)
	call OpenSRAM
	ld a, [sDebugTimeCyclesSinceLastCall]
	call CloseSRAM
	dec a
	cp 2
	jr nc, .debug_ok
	xor 1
	ld h, a
.debug_ok
	ld a, h
endc
	jp RestartReceiveCallDelay

.ReceiveCallDelays:
	db 20, 10, 5, 3

CheckReceiveCallTimer:
	call CheckReceiveCallDelay ; check timer
	ret nc
	ld hl, wTimeCyclesSinceLastCall
	ld a, [hl]
	cp 3
	jr nc, .ok
	inc [hl]

.ok
	call NextCallReceiveDelay ; restart timer
	scf
	ret

InitOneDayCountdown:
	ld a, 1

InitNDaysCountdown:
	ld [hl], a
	push hl
	call UpdateTime
	pop hl
	inc hl
	call CopyDayToHL
	ret

CheckDayDependentEventHL:
	inc hl
	push hl
	call CalcDaysSince
	call GetDaysSince
	pop hl
	dec hl
	call UpdateTimeRemaining
	ret

RestartReceiveCallDelay:
; The in-game clock is frozen (no RTC), so the receive-call countdown is driven
; by the play-time counter (wGameTime*), which keeps ticking while playing.
; Snapshot the current play-time (in minutes) as the baseline.
	ld hl, wReceiveCallDelay_MinsRemaining
	ld [hl], a
	call GetPlaytimeMinutes ; hl = play time in minutes
	ld a, l
	ld [wReceiveCallDelay_StartTime], a
	ld a, h
	ld [wReceiveCallDelay_StartTime + 1], a
	ret

CheckReceiveCallDelay:
; Subtract the play-time minutes elapsed since the last check from the countdown.
; Carry set (call allowed) once it reaches 0. Mirrors the original incremental
; behaviour, but measured in play time instead of the frozen clock.
	call GetPlaytimeMinutes ; hl = play time now (minutes)
	ld a, [wReceiveCallDelay_StartTime]
	ld e, a
	ld a, [wReceiveCallDelay_StartTime + 1]
	ld d, a
; advance the baseline to now
	ld a, l
	ld [wReceiveCallDelay_StartTime], a
	ld a, h
	ld [wReceiveCallDelay_StartTime + 1], a
; bc = now - baseline (minutes elapsed since last check)
	ld a, l
	sub e
	ld c, a
	ld a, h
	sbc d
	ld b, a
; cap elapsed to 0-59; 60+ (or high byte set) -> -1 so the countdown fires now
	and a ; a still holds b (elapsed high byte)
	jr nz, .elapsed_capped
	ld a, c
	cp 60
	jr c, .apply
.elapsed_capped
	ld a, -1
.apply
	ld hl, wReceiveCallDelay_MinsRemaining
	call UpdateTimeRemaining
	ret

GetPlaytimeMinutes:
; Return hl = total play time in minutes = wGameTimeHours * 60 + wGameTimeMinutes.
; wGameTimeHours is a big-endian 16-bit value capped at 999, so the result
; (<= 59999) always fits in 16 bits.
	ld a, [wGameTimeHours]
	ld h, a
	ld a, [wGameTimeHours + 1]
	ld l, a
; hl = hours * 4, save into de
	add hl, hl
	add hl, hl
	ld d, h
	ld e, l
; hl = hours * 64
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
; hl = hours * 64 - hours * 4 = hours * 60
	ld a, l
	sub e
	ld l, a
	ld a, h
	sbc d
	ld h, a
; hl += minutes
	ld a, [wGameTimeMinutes]
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ret

RestartDailyResetTimer:
	ld hl, wDailyResetTimer
	jp InitOneDayCountdown

CheckDailyResetTimer::
	ld hl, wDailyResetTimer
	call CheckDayDependentEventHL
	ret nc
	xor a
	ld hl, wDailyFlags1
	ld [hli], a ; wDailyFlags1
	ld [hli], a ; wDailyFlags2
	ld [hli], a ; wSwarmFlags
	ld [hl], a  ; wSwarmFlags + 1
	ld hl, wDailyRematchFlags
rept 4
	ld [hli], a
endr
	ld hl, wDailyPhoneItemFlags
rept 4
	ld [hli], a
endr
	ld hl, wDailyPhoneTimeOfDayFlags
rept 4
	ld [hli], a
endr
	ld hl, wKenjiBreakTimer
	ld a, [hl]
	and a
	jr z, .RestartKenjiBreakCountdown
	dec [hl]
	jr nz, .DontRestartKenjiBreakCountdown
.RestartKenjiBreakCountdown:
	call SampleKenjiBreakCountdown
.DontRestartKenjiBreakCountdown:
	jr RestartDailyResetTimer

SampleKenjiBreakCountdown:
; Generate a random number between 3 and 6
	call Random
	and %11
	add 3
	ld [wKenjiBreakTimer], a
	ret

StartBugContestTimer:
	ld a, BUG_CONTEST_MINUTES
	ld [wBugContestMinsRemaining], a
	ld a, BUG_CONTEST_SECONDS
	ld [wBugContestSecsRemaining], a
	call UpdateTime
	ld hl, wBugContestStartTime
	call CopyDayHourMinSecToHL
	ret

CheckBugContestTimer::
	ld hl, wBugContestStartTime
	call CalcSecsMinsHoursDaysSince
	ld a, [wDaysSince]
	and a
	jr nz, .timed_out
	ld a, [wHoursSince]
	and a
	jr nz, .timed_out
	ld a, [wSecondsSince]
	ld b, a
	ld a, [wBugContestSecsRemaining]
	sub b
	jr nc, .okay
	add 60

.okay
	ld [wBugContestSecsRemaining], a
	ld a, [wMinutesSince]
	ld b, a
	ld a, [wBugContestMinsRemaining]
	sbc b
	ld [wBugContestMinsRemaining], a
	jr c, .timed_out
	and a
	ret

.timed_out
	xor a
	ld [wBugContestMinsRemaining], a
	ld [wBugContestSecsRemaining], a
	scf
	ret

InitializeStartDay:
	call UpdateTime
	ld hl, wTimerEventStartDay
	call CopyDayToHL
	ret

CheckPokerusTick::
	ld hl, wTimerEventStartDay
	call CalcDaysSince
	call GetDaysSince
	and a
	jr z, .done ; not even a day has passed since game start
	ld b, a
	farcall ApplyPokerusTick
.done
	xor a
	ret

SetUnusedTwoDayTimer: ; unreferenced
	ld a, 2
	ld hl, wUnusedTwoDayTimer
	ld [hl], a
	call UpdateTime
	ld hl, wUnusedTwoDayTimerStartDate
	call CopyDayToHL
	ret

CheckUnusedTwoDayTimer:
	ld hl, wUnusedTwoDayTimerStartDate
	call CalcDaysSince
	call GetDaysSince
	ld hl, wUnusedTwoDayTimer
	call UpdateTimeRemaining
	ret

UnusedSetSwarmFlag: ; unreferenced
	ld hl, wDailyFlags1
	set DAILYFLAGS1_FISH_SWARM_F, [hl]
	ret

UnusedCheckSwarmFlag: ; unreferenced
	and a
	ld hl, wDailyFlags1
	bit DAILYFLAGS1_FISH_SWARM_F, [hl]
	ret nz
	scf
	ret

RestartLuckyNumberCountdown:
	call .GetDaysUntilNextFriday
	ld hl, wLuckyNumberDayTimer
	jp InitNDaysCountdown

.GetDaysUntilNextFriday:
	call GetWeekday
	ld c, a
	ld a, FRIDAY
	sub c
	jr z, .friday_saturday
	jr nc, .earlier ; could have done "ret nc"

.friday_saturday
	add 7

.earlier
	ret

_CheckLuckyNumberShowFlag:
	ld hl, wLuckyNumberDayTimer
	jp CheckDayDependentEventHL

DoMysteryGiftIfDayHasPassed:
	ld a, BANK(sMysteryGiftTimer)
	call OpenSRAM
	ld hl, sMysteryGiftTimer
	ld a, [hli]
	ld [wTempMysteryGiftTimer], a
	ld a, [hl]
	ld [wTempMysteryGiftTimer + 1], a
	call CloseSRAM

	ld hl, wTempMysteryGiftTimer
	call CheckDayDependentEventHL
	jr nc, .not_timed_out
	ld hl, wTempMysteryGiftTimer
	call InitOneDayCountdown
	call CloseSRAM
	farcall ResetDailyMysteryGiftLimitIfUnlocked

.not_timed_out
	ld a, BANK(sMysteryGiftTimer)
	call OpenSRAM
	ld hl, wTempMysteryGiftTimer
	ld a, [hli]
	ld [sMysteryGiftTimer], a
	ld a, [hl]
	ld [sMysteryGiftTimer + 1], a
	call CloseSRAM
	ret

UpdateTimeRemaining:
; If the amount of time elapsed exceeds the capacity of its
; unit, skip this part.
	cp -1
	jr z, .set_carry
	ld c, a
	ld a, [hl] ; time remaining
	sub c
	jr nc, .ok
	xor a

.ok
	ld [hl], a
	jr z, .set_carry
	xor a
	ret

.set_carry
	xor a
	ld [hl], a
	scf
	ret

GetSecondsSinceIfLessThan60: ; unreferenced
	ld a, [wDaysSince]
	and a
	jr nz, GetTimeElapsed_ExceedsUnitLimit
	ld a, [wHoursSince]
	and a
	jr nz, GetTimeElapsed_ExceedsUnitLimit
	ld a, [wMinutesSince]
	jr nz, GetTimeElapsed_ExceedsUnitLimit
	ld a, [wSecondsSince]
	ret

GetMinutesSinceIfLessThan60:
	ld a, [wDaysSince]
	and a
	jr nz, GetTimeElapsed_ExceedsUnitLimit
	ld a, [wHoursSince]
	and a
	jr nz, GetTimeElapsed_ExceedsUnitLimit
	ld a, [wMinutesSince]
	ret

GetHoursSinceIfLessThan24: ; unreferenced
	ld a, [wDaysSince]
	and a
	jr nz, GetTimeElapsed_ExceedsUnitLimit
	ld a, [wHoursSince]
	ret

GetDaysSince:
	ld a, [wDaysSince]
	ret

GetTimeElapsed_ExceedsUnitLimit:
	ld a, -1
	ret

CalcDaysSince:
	xor a
	jr _CalcDaysSince

CalcHoursDaysSince: ; unreferenced
	inc hl
	xor a
	jr _CalcHoursDaysSince

CalcMinsHoursDaysSince:
	inc hl
	inc hl
	xor a
	jr _CalcMinsHoursDaysSince

CalcSecsMinsHoursDaysSince:
	inc hl
	inc hl
	inc hl
	ldh a, [hSeconds]
	ld c, a
	sub [hl]
	jr nc, .skip
	add 60
.skip
	ld [hl], c ; current seconds
	dec hl
	ld [wSecondsSince], a ; seconds since

_CalcMinsHoursDaysSince:
	ldh a, [hMinutes]
	ld c, a
	sbc [hl]
	jr nc, .skip
	add 60
.skip
	ld [hl], c ; current minutes
	dec hl
	ld [wMinutesSince], a ; minutes since

_CalcHoursDaysSince:
	ldh a, [hHours]
	ld c, a
	sbc [hl]
	jr nc, .skip
	add MAX_HOUR
.skip
	ld [hl], c ; current hours
	dec hl
	ld [wHoursSince], a ; hours since

_CalcDaysSince:
	ld a, [wCurDay]
	ld c, a
	sbc [hl]
	jr nc, .skip
	add 20 * 7
.skip
	ld [hl], c ; current days
	ld [wDaysSince], a ; days since
	ret

CopyDayHourMinSecToHL:
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ldh a, [hMinutes]
	ld [hli], a
	ldh a, [hSeconds]
	ld [hli], a
	ret

CopyDayToHL:
	ld a, [wCurDay]
	ld [hl], a
	ret

CopyDayHourToHL: ; unreferenced
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ret

CopyDayHourMinToHL:
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ldh a, [hMinutes]
	ld [hli], a
	ret
