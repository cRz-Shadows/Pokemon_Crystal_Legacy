# Crystal Legacy Timeless

**Timeless** is a fork of [Pokémon Crystal Legacy](https://github.com/cRz-Shadows/Pokemon_Crystal_Legacy)
that removes every dependence on the cartridge **Real-Time Clock (RTC)** and ships the ROM as
an **MBC5** cart. It is built for hardware that does not faithfully reproduce the MBC3 RTC —
flash carts, FPGA cores, and emulators where the clock is missing, frozen, or wrong — without
corrupting your save.

Everything else about Crystal Legacy is unchanged. This document covers only what Timeless
changes and why. For the base hack's feature list and credits, see [README.md](README.md).

---

## Why this fork exists

Original Pokémon Crystal uses an **MBC3** mapper with a battery-backed **Real-Time Clock**.
The game tells time by talking to that clock chip. The problem: on hardware **without a real
RTC**, those clock conversations don't just return garbage — they silently overwrite your
**saved game**.

### The corruption mechanism (the important part)

On an MBC3 cartridge, the register at `$4000` does double duty:

- Write `$00`–`$03` → select an **SRAM bank** (where your boxes/save live).
- Write `$08`–`$0C` → select an **RTC register** (seconds, minutes, hours, day-low, day-high),
  which you then read/write through `$A000`.

The game reads the clock by writing one of those `$08`–`$0C` selectors and then touching
`$A000`. **On hardware with no RTC, the mapper has no `$08`–`$0C` mode** — those values are
just treated as ordinary (out-of-range) SRAM bank numbers. So a "read the clock" sequence
becomes a "read/write some SRAM bank" sequence pointed at `$A000`.

The day-low selector is `RTC_DL = $0B`. With no RTC that selects **SRAM bank 3**, and on this
ROM's save layout (`sram.link`) bank 3 begins exactly at **Box 8**. So:

- **Writing the clock** (`SetClock`, and the day-carry poke inside `SaveRTC`) scribbles time
  bytes directly over **Box 8** and neighbouring save data → corrupted Pokémon storage.
- **Reading the clock** (`GetClock`) reads box bytes back *as if they were the current time* →
  the in-game time jumps around at random whenever anything reads the clock: collecting
  berries, entering battles, changing maps, opening the Pokégear.
- Worse: the garbage day count routinely looks like ">140 days passed", which makes the time
  fix-up code (`FixDays`) call `SetClock` to "correct" it → **more writes, more corruption**.

This is the bug behind "Box 8 keeps getting wiped" and "the clock keeps changing on its own".

### Why MBC5

If the game never touches the RTC, it never needs the MBC3-specific clock hardware at all. MBC5
is a strict superset of MBC3's *banking* behaviour (same `$00`–`$03` SRAM bank selects, same
`$2000` ROM banking for this ROM's size) but **has no RTC** and no `$08`–`$0C` selector mode.
Shipping as MBC5 means:

- The hardware target is simpler and far more commonly/faithfully implemented (the FPGA MBC5
  core this was built for is verified solid; its MBC3+RTC core is not).
- Even if some stray RTC-style write slipped through, MBC5 has nowhere for it to land as a
  clock — it can't re-enable the corruption path.

**The save format does not change.** Box layout, SRAM size (32 KB), and the battery are all
identical. Existing `.sav` files work as-is; no byte patching needed.

---

## What replaces the clock: a frozen software clock

With the RTC gone, time is now a **purely software value that the player sets** and that
**never advances on its own**.

The game already stores the time the player picks during New Game / clock reset as a set of
"start" offsets (`wStartDay`, `wStartHour`, `wStartMinute`, …). Normally the *current* time is
computed as `RTC_now − start_offset`. Timeless makes the RTC read return **all zeros**, so:

```
current time = 0 − start_offset  →  resolves to exactly the offsets you set
```

The time-of-day, the day-of-week, and the day counter are now **whatever you last set in the
clock UI, frozen there until you change it again**.

- Set it to night and grind for an hour → it stays night. Day/night palettes are stable.
- The day counter (`wCurDay`) only moves when **you** move it in the clock-setting screen.

### Setting / changing the clock

The two existing in-game clock screens are now the single source of truth for time:

- **New Game** — the normal "set the time" prompt at the start of the game.
- **Clock reset** — hold **Down + B** on the title/continue flow to re-open the clock screen
  (the vanilla Crystal "reset the clock" feature). Use this any time you want to change the
  time of day, the weekday, or bump the day forward.

---

## How this affects time-based events

Almost every daily/weekly event in Crystal is keyed off the **day counter** (`wCurDay`) and the
**weekday** derived from it — not off the raw clock chip. Because the day counter is now under
your manual control, those events still work; they simply advance **when you advance the day**
instead of in real time.

### Daily events — advance the day yourself

When you bump `wCurDay` forward in the clock screen, the daily-reset logic
(`CheckDailyResetTimer`) wipes all the "already did this today" flags at once, exactly as a real
midnight rollover would. After advancing a day you'll see, refreshed:

- Daily gift / once-per-day NPCs reset
- Swarms (the roaming/“outbreak” rolls) re-rolled
- Phone rematch availability refreshed
- All other `wDailyFlags`-gated events cleared

So: **to "wait a day", open the clock screen and move the day forward.**

### Weekday events — set the weekday yourself

Events tied to a specific day of the week read the weekday computed from `wCurDay`:

- Department-store sale
- Weekly siblings (Monday Tuscany, etc.)
- Trainer-House / weekly-rotation opponents

Set the weekday you want in the clock screen and the matching event becomes active.

### Always-available (no day-advance needed)

To make the hack pleasant on a frozen clock, a few normally once-per-day things were made
**always available** so you don't have to fiddle with the clock to use them:

| Feature | Original gate | In Timeless |
|---|---|---|
| **Fruit / berry trees** | Refill once per day | **Always refilled** — every tree always has fruit |
| **Move Tutor** (Goldenrod) | Once per day | **Always available** on each visit |
| **Trainer House battle** | Once per day | **Repeatable** without advancing the day |

These work by **not recording** the "did it today" flag, so the gate never closes. (Berries
additionally drop the daily refill check entirely and refill on every interaction.)

### Deliberately left alone

- **Daisy's grooming** stays **3 PM-only** — it's a time-of-day check, and you can set the time
  to 3 PM in the clock screen when you want it.
- Haircut brothers, Lapras (Friday), Clefairy dance, weekly siblings, swarms, the Indigo rival
  encounter, and other **weekday/encounter** events stay **manual** — set the appropriate day or
  time and they trigger normally.
- **Within-session countdowns that measured real elapsed minutes** (e.g. the Bug Catching
  Contest's 20-minute timer) no longer tick down on their own, because the clock is frozen. This
  is an accepted trade-off.

### Phone calls still happen — driven by play time, not the clock

Incoming phone calls (rematch notices, daily-gift reminders, Buena's password reminders) are
normally scheduled by *real elapsed clock minutes*. With a frozen clock that interval would
**never elapse and no call would ever fire.**

Timeless re-points the incoming-call countdown at the **play-time counter** (`wGameTime*`) — the
odometer that ticks up from VBlank every frame the game runs (the value you see as your save
file's play time). It is independent of the RTC and always moves forward while you play, so
spontaneous calls still fire after a few minutes of play, just as before. *Who* is eligible to
call at a given time-of-day still reads the (frozen) clock — "anytime" contacts always qualify,
and you can set the period for time-specific callers.

---

## Technical change list

All changes live in one commit on top of upstream `main`.

| File | Change |
|---|---|
| `Makefile` | Cartridge header byte `-m 0x10` (MBC3+TIMER+RAM+BATTERY) → `-m 0x1b` (MBC5+RAM+BATTERY) on all build targets |
| `home/time.asm` | `GetClock` returns a frozen **zero** clock with **no** hardware access; `LatchClock` and `SetClock` reduced to no-ops (their RTC pokes were the write-corruption path) |
| `engine/rtc/rtc.asm` | `StartRTC`/`StopRTC` → no-ops; `SaveRTC` keeps only the `sRTCStatusFlags` reset and drops the day-carry poke (which wrote into SRAM after an `RTC_DH` select) |
| `engine/overworld/time.asm` | Incoming-call delay now measured against play time; new `GetPlaytimeMinutes` helper (`hours*60 + minutes` from `wGameTime*`) |
| `engine/events/fruit_trees.asm` | `TryResetFruitTrees` drops the once-per-day gate → trees always refill |
| `maps/GoldenrodCity.asm` | Move Tutor: daily flag no longer set → always available |
| `maps/TrainerHouseB1F.asm` | Trainer House: daily flag no longer set → repeatable |

What was intentionally **not** touched: `OpenSRAM`/`CloseSRAM` (normal bank 0–3 selection, valid
and required on MBC5); the clock-setting UI; the save/box layout; the play-time counter.

### Verifying the build

After building with RGBDS **0.5.2** (`make`), confirm cartridge byte `$0147` of the `.gbc`
reads `0x1B` (MBC5+RAM+BATTERY). In an emulator's cart-info view it should report **MBC5,
RAM + battery, no RTC**.

### Recommended on-hardware / emulator checks

1. New game → set the time → deposit a Pokémon in **Box 8**.
2. Pick berries, fight several battles, change maps, open the Pokégear, then **save & reload**.
3. Confirm **Box 8 is intact** and the **clock did not jump**. (This is the core fix.)
4. Set night, walk around a while → still night (frozen clock).
5. Open the clock screen, advance a day → confirm daily events refreshed; set a weekday →
   confirm a weekday event appears.
6. Play continuously a few minutes → confirm an incoming phone call still fires.
