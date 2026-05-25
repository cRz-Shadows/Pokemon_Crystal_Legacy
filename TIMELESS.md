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

## Time-based events: what to expect

Almost every daily/weekly event in Crystal is keyed off the **day counter** (`wCurDay`) and the
**time of day / weekday** derived from it — not off the raw clock chip. Because the clock is now
a value **you** set, these events still work; they just advance when **you** move the clock
instead of in real time.

**The default rule:** unless it's listed in the "always available" table below, every event
behaves **exactly like vanilla** — it just keys off your manually-set clock. Nothing is removed;
the daily/weekly cycle is simply driven by you.

### Your controls — the clock screen has three levers

Open the clock screen from **New Game**, or any time after by holding **Down + B** at the
**title screen** (the one showing Suicune leaping over the water, before the "Continue / New
Game" menu) — this is the vanilla "reset the clock" feature. From there you control:

| Lever | What it affects |
|---|---|
| **Time of day** (Morn / Day / Nite, by hour) | Day/night wild encounters & palettes, and time-locked NPCs (Daisy at 3 PM, Buena at night, bargain shop in the morning) |
| **Weekday** (Mon–Sun) | All weekday-locked events (see table) |
| **Day counter** (advance the day) | Triggers the daily reset — refreshes **every** once-per-day event at once |

Plus one automatic lever you don't set: **play time** (the odometer on your save file) keeps
ticking while you play and is what drives **incoming phone calls** (see the last section).

> **"How do I wait a day?"** Open the clock screen and advance the day by one. The game runs its
> normal midnight reset (`CheckDailyResetTimer`) and every "already did this today" flag clears.

---

### 1. Always available — daily limit removed (CHANGED)

These repeatable benefits no longer track a "did it today" flag, so the limit never closes.
**Any weekday / time-of-day / selection gate they have is kept** — only the once-per-day cap is
gone. No day-advance needed to reuse them.

| Event | What it does | Gate still in effect | How to use it |
|---|---|---|---|
| **Berry / fruit trees** | Give a held Berry | none | Pick a tree — it's refilled every time, instantly |
| **Move Tutor** (Goldenrod, Game Corner) | Teaches a special move | none | Talk to him on any visit |
| **Trainer House battle** | One battle vs. the rotating opponent | which opponent depends on the weekday | Battle as often as you like; set the weekday for a specific opponent |
| **Haircut brothers** (Goldenrod Underground) | Raises a party Pokémon's happiness | **weekday picks the brother** — older: Tue/Thu/Sat, younger: Sun/Wed/Fri | Get a haircut, then talk again to repeat; set the weekday for older vs. younger |
| **Buena's Password** (Radio Tower 2F) | +1 Blue Card point (toward prizes, cap 30) | **night only** | **Set the clock to night**, tune the radio for the password, then answer Buena — repeat to grind points |
| **Goldenrod bargain shop** (Underground) | Sells discounted items | **Monday morning only** | **Set the clock to Monday + morning**, then buy as many times as you want |
| **Indigo rival rematch** (Pokémon Center) | Battle Silver for XP/money | **appears Mon/Wed only** | **Set the weekday to Mon or Wed**, walk onto the trigger tile; re-enter the map to refight |

### 2. Once-per-day events — refresh by advancing the day (UNTOUCHED)

These keep their normal once-per-day behavior. To use them again, **advance the day** in the
clock screen.

| Event | What it does | How to trigger / refresh |
|---|---|---|
| **Kurt's Apricorn balls** | Hand Kurt Apricorns; he makes balls "by the next day" | Give Apricorns → **advance the day once** → collect finished balls |
| **Daily-gift NPCs** | Various "here's something for today" givers | Receive once → **advance the day** to receive again |
| **Daily swarms** (Dunsparce, Yanma, fishing swarms) | A species floods a route/water for the day | **Advance the day** to re-roll which swarm is active |
| **Time Capsule** (once-a-day use) | Gen-1 trade link | **Advance the day** to use again |

### 3. Weekday-locked events — set the weekday (UNTOUCHED)

These appear/activate only on certain days. **Set the matching weekday** in the clock screen.

| Event | Day(s) | Notes |
|---|---|---|
| **Dept. Store rooftop sale** (Goldenrod) | its sale day | Set that weekday to shop the sale |
| **Lapras** (Union Cave B2F) | Friday | Set the weekday to Friday to encounter it |
| **Bitter-herb merchant** (Underground) | Sat / Sun | Sells bitter healing items those days |
| **Weekly sibling NPCs** (Tuscany, Frieda, etc.) | each a fixed day | Set the weekday to meet that day's sibling |
| **Clefairy dance** (Mt. Moon Square) | its scheduled night | Set the matching day/time |
| **Haircut brother / Trainer-House opponent** | rotate by weekday | (Service itself is repeatable — see table 1 — but *who* is present follows the weekday) |

### 4. Time-of-day-locked events — set the time (UNTOUCHED)

These check the hour. **Set the time of day** in the clock screen.

| Event | Window | How to trigger |
|---|---|---|
| **Daisy's grooming** (Pallet, Kanto) | ~3–4 PM | Set the clock to 3 PM, then talk to Daisy |
| **Buena's Password** | night | Set the clock to night (also see table 1) |
| **Goldenrod bargain shop** | Monday morning | Set Monday + morning (also see table 1) |
| **Day/night encounters & palettes** | Morn / Day / Nite | Set the time of day to find time-specific wild Pokémon and color palettes |

### 5. Special cases & trade-offs

- **Shuckie (Mania's loan)** — **not** a daily gift; it's a **one-time loan**, gated by permanent
  event flags. Its "today" flag only controls the *"come back tomorrow before you can return
  him"* timing, so it was **left untouched**. **Consequence:** after you receive Shuckie,
  **advance the day once** before Mania will let you return him — exactly like vanilla.
- **Kurt's Apricorn balls** — the "ready by the next day" delay was **kept on purpose** (see
  table 2). Hand over Apricorns, advance the day, collect.
- **Bug-Catching Contest timer** — the in-contest 20-minute countdown measured *real elapsed
  minutes*, so with a frozen clock it **no longer ticks down on its own**. The contest still
  runs; it just won't time you out. This is an accepted trade-off of freezing the clock.

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

## Building & testing

> The exact code changes aren't reproduced here — see the pull request / commit history if you
> want the assembly-level diff.

Build with RGBDS **0.5.2** (`make`). Confirm cartridge byte `$0147` of the `.gbc` reads `0x1B`
(MBC5+RAM+BATTERY); an emulator's cart-info view should report **MBC5, RAM + battery, no RTC**.

### Recommended on-hardware / emulator checks

1. New game → set the time → deposit a Pokémon in **Box 8**.
2. Pick berries, fight several battles, change maps, open the Pokégear, then **save & reload**.
3. Confirm **Box 8 is intact** and the **clock did not jump**. (This is the core fix.)
4. Set night, walk around a while → still night (frozen clock).
5. Open the clock screen, advance a day → confirm daily events refreshed; set a weekday →
   confirm a weekday event appears.
6. Play continuously a few minutes → confirm an incoming phone call still fires.
