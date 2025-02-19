Music_HoOhBattle:
	dbw $80, Music_HoOhBattle_Ch1
	dbw $01, Music_HoOhBattle_Ch2
	dbw $02, Music_HoOhBattle_Ch3

Music_HoOhBattle_Ch1:
; Pat 0 Row 0
	tempo $6a
	dutycycle $3
	notetype $c, $c2
	octave 3
	note B_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note F_, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note D_, 1
	note C#, 1
	note C_, 1
	note C#, 1
	note C_, 1
	octave 2
	note B_, 1
	note A#, 1
	note B_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note B_, 1
	octave 3
	note C_, 1
; Pat 1 Row 0
Music_HoOhBattle_Ch1_L:
	intensity $c2
	octave 2
	note B_, 2
	note B_, 4
	note B_, 4
	note B_, 4
	intensity $c7
	note B_, 6
	note A_, 6
	octave 3
	note C_, 6
	loopchannel 3, Music_HoOhBattle_Ch1_L
; Pat 2 Row 0
	intensity $c2
	octave 2
	note B_, 2
	note B_, 4
	note B_, 4
	note B_, 4
	intensity $c7
	note B_, 6
	note A_, 4
	intensity $c2
	octave 3
	note E_, 1
	note D_, 1
	octave 2
	note B_, 1
	note E_, 1
	octave 3
	note C_, 1
	octave 2
	note A_, 1
	octave 3
	note D#, 1
	octave 2
	note B_, 1
; Pat 3 Row 0
	intensity $c8
	octave 3
	soundinput $37
	note D_, 1
	intensity $c7
	soundinput $00
	note E_, 11
	note D_, 2
	note E_, 2
	intensity $c8
	soundinput $37
	note D_, 1
	intensity $c7
	soundinput $00
	note E_, 11
	note D_, 2
	note E_, 2
	intensity $c8
	soundinput $47
	note G_, 1
	intensity $c7
	soundinput $00
	note A_, 11
	intensity $c8
	soundinput $57
	note A_, 1
	intensity $c7
	soundinput $00
	note B_, 3
	note E_, 12
	note D_, 2
	note F_, 2
; Pat 4 Row 0
	intensity $c8
	soundinput $37
	note D_, 1
	intensity $c7
	soundinput $00
	note E_, 11
	note F_, 2
	note D_, 2
	intensity $c8
	soundinput $37
	note D_, 1
	intensity $c7
	soundinput $00
	note E_, 11
	note D_, 2
	note E_, 2
	intensity $c8
	soundinput $37
	note D_, 1
	intensity $c7
	soundinput $00
	note E_, 15
	intensity $c2
	octave 2
	note B_, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note B_, 1
	note E_, 1
	octave 3
	note F_, 1
	octave 2
	note E_, 1
	octave 3
	note E_, 1
	octave 2
	note E_, 1
	octave 3
	note A#, 1
	octave 4
	note C#, 1
	octave 3
	note A_, 1
	note A#, 1
	note E_, 1
	octave 2
	note B_, 1
; Pat 5 Row 0
	intensity $c8
	octave 3
	soundinput $37
	note D_, 1
	intensity $c7
	soundinput $00
	note E_, 11
	note D_, 2
	note E_, 2
	intensity $c8
	soundinput $37
	note D_, 1
	intensity $c7
	soundinput $00
	note E_, 11
	note D_, 2
	note E_, 2
	intensity $c8
	soundinput $47
	note G_, 1
	intensity $c7
	soundinput $00
	note A_, 11
	intensity $c8
	soundinput $57
	note A_, 1
	intensity $c7
	soundinput $00
	note B_, 3
	octave 4
	note D_, 10
	octave 3
	note B_, 2
	note F_, 2
	note A_, 2
; Pat 6 Row 0
	intensity $c8
	soundinput $47
	note F#, 1
	intensity $c7
	soundinput $00
	note G#, 9
	note B_, 2
	note E_, 2
	note A_, 2
	intensity $c8
	soundinput $37
	note D#, 1
	intensity $c7
	soundinput $00
	note F_, 9
	note A_, 2
	note D_, 2
	note F_, 2
	intensity $c8
	soundinput $37
	note D_, 1
	intensity $c7
	soundinput $00
	note E_, 9
	note E_, 2
	note F_, 2
	note D_, 2
	intensity $c8
	soundinput $37
	note D_, 1
	intensity $c7
	soundinput $00
	note E_, 7
	notetype $8, $b7
	vibrato $7, $26
	octave 4
	note D_, 2
	note F_, 2
	note A_, 2
	note B_, 2
	octave 5
	note D_, 2
	note D#, 2
; Pat 7 Row 0
	notetype $c, $b7
	note E_, 1
	note F_, 1
	note E_, 12
	note F_, 2
	note D_, 2
	note E_, 2
	octave 4
	note B_, 2
	octave 5
	note D_, 2
	octave 4
	note A_, 2
	note B_, 2
	note D_, 2
	note E_, 2
	note F#, 2
	note A_, 2
	intensity $c8
	vibrato $0, $0
	octave 5
	note D_, 8
	intensity $b7
	vibrato $7, $26
	note D_, 12
	octave 4
	note B_, 1
	note A_, 1
	note F_, 1
	note D_, 1
	octave 3
	note B_, 1
	note A_, 1
	note F_, 1
	note D_, 1
; Pat 8 Row 0
	octave 5
	note E_, 1
	note F_, 1
	note E_, 8
	note F_, 2
	note D_, 2
	note E_, 2
	octave 4
	note B_, 8
	octave 5
	note D_, 2
	note E_, 2
	octave 4
	note B_, 2
	octave 5
	note D_, 2
	octave 4
	note A_, 2
	note B_, 2
	octave 5
	note D_, 4
	intensity $c8
	vibrato $0, $0
	note E_, 8
	intensity $b7
	vibrato $7, $26
	note E_, 16
; Pat 9 Row 0
	intensity $c7
	vibrato $0, $0
	octave 4
	note E_, 1
	note F_, 1
	note E_, 12
	note F_, 2
	note D_, 2
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	note D_, 2
	note E_, 2
	note F#, 2
	note A_, 2
	intensity $c8
	octave 4
	note D_, 8
	intensity $c7
	note D_, 12
	octave 3
	note B_, 1
	note A_, 1
	note F_, 1
	note D_, 1
	octave 2
	note B_, 1
	note A_, 1
	note F_, 1
	note D_, 1
; Pat 10 Row 0
	octave 4
	note E_, 1
	note F_, 1
	note E_, 8
	note F_, 2
	note D_, 2
	note E_, 2
	octave 3
	note B_, 12
	note A_, 2
	note B_, 2
	note A_, 2
	note B_, 2
	octave 4
	note D_, 4
	intensity $c8
	note E_, 8
	intensity $c7
	note E_, 16
; Pat 11 Row 0
	octave 2
	note E_, 4
	intensity $c8
	note A_, 2
	intensity $c7
	soundinput $6f
	note A_, 2
	soundinput $00
	note G_, 2
	note A_, 2
	intensity $c8
	octave 3
	note C_, 2
	intensity $c7
	soundinput $6f
	note C_, 2
	octave 2
	soundinput $00
	note A_, 2
	octave 3
	note C_, 2
	intensity $c8
	note D_, 2
	intensity $c7
	soundinput $6f
	note D_, 2
	soundinput $00
	note C_, 2
	note D_, 2
	intensity $c8
	note G_, 2
	intensity $c7
	soundinput $6f
	note G_, 2
	soundinput $00
	note E_, 2
	note __, 16
	note __, 14
; Pat 12 Row 0
	octave 2
	note E_, 4
	intensity $c8
	note A_, 2
	intensity $c7
	soundinput $6f
	note A_, 2
	soundinput $00
	note G_, 2
	note A_, 2
	octave 3
	intensity $c8
	note C_, 2
	intensity $c7
	soundinput $6f
	note C_, 2
	octave 2
	soundinput $00
	note A_, 2
	octave 3
	note C_, 2
	note D_, 1
	note C_, 1
	octave 2
	note A_, 2
	octave 3
	note C_, 2
	note D_, 2
	intensity $c8
	note G_, 2
	intensity $c7
	soundinput $6f
	note G_, 2
	soundinput $00
	note E_, 2
	note __, 16
	note __, 14
; Pat 13 Row 0
	dutycycle $0
	intensity $c4
	vibrato $1, $25
	octave 2
	note E_, 2
	note E_, 6
	intensity $93
	note E_, 1
	note E_, 1
	note E_, 2
	note E_, 1
	note E_, 1
	note E_, 2
	intensity $c4
	note E_, 1
	intensity $93
	note E_, 1
	intensity $c4
	note E_, 2
	note E_, 1
	intensity $93
	note E_, 1
	intensity $c4
	note E_, 2
	note E_, 1
	note E_, 1
	note E_, 2
	note E_, 1
	note E_, 1
	note E_, 2
	dutycycle $3
	intensity $c8
	vibrato $0, $0
	octave 3
	soundinput $47
	note D_, 1
	intensity $c7
	soundinput $00
	note E_, 3
	note D_, 2
	note E_, 2
	note __, 2
	note G_, 2
	note A_, 2
	octave 2
	note B_, 2
	intensity $c8
	octave 3
	soundinput $47
	note D_, 1
	intensity $c7
	soundinput $00
	note E_, 3
	note D_, 2
	note E_, 2
	note __, 2
	note G_, 2
	note A_, 4
; Pat 14 Row 0
	intensity $c8
	note A#, 16
	intensity $c7
	note A#, 16
	loopchannel 0, Music_HoOhBattle_Ch1_L

Music_HoOhBattle_Ch2:
; Pat 0 Row 0
	dutycycle $3
	notetype $c, $c2
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
; Pat 1 Row 0
Music_HoOhBattle_Ch2_L:
	intensity $c2
	octave 3
	note E_, 2
	note E_, 4
	note E_, 4
	note E_, 4
	intensity $c7
	note E_, 6
	note D_, 6
	note F_, 6
	loopchannel 3, Music_HoOhBattle_Ch2_L
; Pat 2 Row 0
	intensity $c2
	note E_, 2
	note E_, 4
	note E_, 4
	note E_, 4
	intensity $c7
	note E_, 6
	note D_, 6
	note F_, 4
	dutycycle $0
	intensity $c4
	vibrato $1, $25
	octave 2
	note E_, 2
; Pat 3 Row 0
	note E_, 14
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 6
	note E_, 2
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 12
	note E_, 8
	note E_, 2
	note E_, 2
	note E_, 2
; Pat 4 Row 0
	note E_, 14
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 6
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	note D_, 2
	note E_, 4
	note D_, 2
	note E_, 4
	note D_, 2
	note E_, 4
	note D_, 2
	note E_, 4
	note E_, 2
	octave 1
	note B_, 2
; Pat 5 Row 0
	octave 2
	note E_, 14
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 6
	note E_, 2
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 12
	note E_, 8
	note E_, 2
	note E_, 2
	note E_, 2
; Pat 6 Row 0
	note E_, 14
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 6
	note E_, 2
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 12
	note E_, 8
	note E_, 2
	note E_, 2
	note E_, 2
; Pat 7 Row 0
	dutycycle $2
	intensity $93
	vibrato $0, $0
	octave 4
	note E_, 2
	octave 5
	note E_, 2
	note D_, 2
	octave 4
	note A_, 2
	note B_, 2
	note A_, 2
	note E_, 2
	note F_, 2
	note E_, 2
	note F_, 2
	note D_, 2
	octave 3
	note A_, 2
	note F#, 2
	octave 4
	note D_, 2
	octave 3
	note D_, 2
	note A_, 2
	note F#, 2
	octave 4
	note E_, 2
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	note A_, 2
	note F#, 2
	note D_, 2
	octave 5
	note D_, 2
	octave 4
	note A_, 2
	note B_, 2
	note F#, 2
	note F#, 1
	note E_, 1
	note C_, 1
	octave 3
	note A_, 1
	note F#, 1
	note E_, 1
	octave 4
	note B_, 2
; Pat 8 Row 0
	note E_, 2
	octave 5
	note E_, 2
	note D_, 2
	octave 4
	note A_, 2
	note B_, 2
	note A_, 2
	note F_, 2
	note D_, 2
	octave 3
	note B_, 2
	octave 4
	note F_, 2
	note E_, 2
	note D_, 2
	octave 3
	note B_, 2
	octave 5
	note E_, 2
	note D_, 2
	octave 4
	note B_, 2
	octave 3
	note D_, 2
	octave 4
	note E_, 2
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	note A_, 2
	note F#, 2
	note D_, 6
	dutycycle $3
	intensity $b7
	vibrato $7, $26
	octave 5
	note F_, 2
	note D_, 2
	note E_, 8
; Pat 9 Row 0
	dutycycle $0
	intensity $93
	vibrato $1, $25
	octave 3
	note E_, 2
	octave 4
	note E_, 2
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	note A_, 2
	note E_, 2
	note F_, 2
	note E_, 2
	note F_, 2
	note D_, 2
	octave 2
	note A_, 2
	note F#, 2
	octave 3
	note D_, 2
	octave 2
	note D_, 2
	note A_, 2
	note F#, 2
	octave 3
	note E_, 2
	note D_, 2
	octave 2
	note A_, 2
	note B_, 2
	note A_, 2
	note F#, 2
	note D_, 2
	octave 4
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	note F#, 2
	note F#, 1
	note E_, 1
	note C_, 1
	octave 2
	note A_, 1
	note F#, 1
	note E_, 1
	octave 3
	note B_, 2
; Pat 10 Row 0
	note E_, 2
	octave 4
	note E_, 2
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	note A_, 2
	note F_, 2
	note D_, 2
	octave 2
	note B_, 2
	octave 3
	note F_, 2
	note E_, 2
	note D_, 2
	octave 2
	note B_, 2
	octave 4
	note E_, 2
	note D_, 2
	octave 3
	note B_, 2
	octave 2
	note D_, 2
	octave 3
	note E_, 2
	note D_, 2
	octave 2
	note A_, 2
	note B_, 2
	note A_, 2
	note F#, 2
	note D_, 2
	octave 3
	note E_, 2
	octave 4
	note E_, 2
	note D_, 2
	octave 3
	note B_, 2
	note A_, 2
	note B_, 2
	note A_, 2
	note G_, 2
; Pat 11 Row 0
	note __, 16
	note __, 16
	note __, 1
	intensity $c4
	note D_, 1
	note E_, 4
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	note E_, 2
	note C_, 2
	octave 2
	note A_, 2
	note E_, 2
	octave 3
	note D_, 2
	note E_, 1
	note D_, 1
	octave 2
	note A_, 2
	note G_, 2
	note A_, 2
	note D_, 1
	note E_, 1
	note G_, 2
; Pat 12 Row 0
	note __, 16
	note __, 16
	octave 3
	note A_, 1
	note G_, 1
	note A_, 2
	note A_, 2
	octave 2
	note A_, 2
	octave 3
	note E_, 2
	note G_, 2
	note C_, 2
	octave 2
	note A_, 2
	octave 3
	note C_, 2
	note G_, 2
	note E_, 1
	note D_, 1
	octave 2
	note A_, 2
	note G_, 2
	note A_, 2
	note D_, 1
	note E_, 1
	note G_, 2
; Pat 13 Row 0
	note B_, 2
	note B_, 6
	intensity $93
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	intensity $c4
	note B_, 1
	intensity $93
	note B_, 1
	intensity $c4
	note B_, 2
	note B_, 1
	intensity $93
	note B_, 1
	intensity $c4
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note __, 16
	note __, 16
; Pat 14 Row 0
	dutycycle $3
	intensity $c8
	vibrato $0, $0
	octave 3
	note F_, 16
	intensity $c7
	note F_, 16
	loopchannel 0, Music_HoOhBattle_Ch2_L

Music_HoOhBattle_Ch3:
; Pat 0 Row 0
	notetype $c, $16
	octave 2
	note E_, 16
	note D_, 8
	note F_, 8
; Pat 1 Row 0
Music_HoOhBattle_Ch3_L:
	octave 1
	note B_, 2
	octave 2
	note E_, 2
	loopchannel 93, Music_HoOhBattle_Ch3_L
; Pat 2 Row 0
; Pat 3 Row 0
; Pat 4 Row 0
; Pat 5 Row 0
; Pat 6 Row 0
	note F_, 2
	note D_, 2
	note E_, 2
	note F_, 2
	note E_, 2
	note D_, 2
; Pat 7 Row 0
	note F_, 14
	octave 3
	note E_, 2
	octave 2
	note F_, 2
	note __, 2
	note E_, 2
	note __, 2
	note B_, 6
	note A_, 2
	note F#, 2
	note D_, 12
	note F#, 1
	note __, 1
	note F#, 2
	note __, 2
	note D_, 8
	note __, 4
; Pat 8 Row 0
	note D_, 1
	note __, 1
	note D_, 6
	note __, 4
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	octave 3
	note D_, 4
	octave 2
	note B_, 4
	note A_, 4
	note __, 2
	note E_, 6
	note __, 4
	note E_, 1
	note __, 1
	note E_, 2
	octave 3
	note D_, 2
	octave 2
	note E_, 1
	note __, 1
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note G_, 2
	note E_, 2
; Pat 9 Row 0
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note A_, 2
	note F#, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note F#, 2
	note E_, 2
; Pat 10 Row 0
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note A_, 2
	note F#, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note F#, 2
	note D_, 2
; Pat 11 Row 0
Music_HoOhBattle_Ch3_L1:
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note G_, 2
	octave 2
	note D_, 2
	octave 1
	note G_, 2
	octave 2
	note D_, 2
	loopchannel 2, Music_HoOhBattle_Ch3_L1
; Pat 12 Row 0
; Pat 13 Row 0
	note F_, 4
	note B_, 4
	note F_, 4
	note B_, 4
	note F_, 4
	note B_, 4
	octave 3
	note E_, 4
	octave 2
	note B_, 4
	note E_, 4
	note D_, 2
	note E_, 2
	note __, 2
	note G_, 2
	note A_, 2
	octave 1
	note B_, 2
	octave 2
	note E_, 4
	note D_, 2
	note E_, 2
	note __, 2
	note G_, 2
	note A_, 4
; Pat 14 Row 0
	note A#, 16
	note A#, 10
	note G_, 2
	note A_, 2
	note E_, 2
	loopchannel 0, Music_HoOhBattle_Ch3_L
