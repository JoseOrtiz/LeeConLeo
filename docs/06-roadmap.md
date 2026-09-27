# 6. Roadmap

Each milestone ends with something playable or testable. No dates yet: this is a
side project, and the milestones are sized to be finished one at a time.

## M0 — Groundwork

- New repository with a Flutter + Flame project, CI, and the licenses (MIT + CC BY-SA).
- Content pipeline: YAML → validate → JSON bundle.
- Script that extracts the 2014 vocabulary into a draft `words.yaml`.
- Activity frame (intro → items → feedback → reward) with placeholder audio.

**Done when:** `flutter test` and content validation pass in CI, and a dummy
activity runs through the full frame on an Android phone and an Android tablet.

## M1 — Playable prototype

- Stage 0: *Up/down*, *Left/right*, *Over/under/between*.
- Stage 2: vowels with *Meet*, *Trace*, *Find*.
- Leo's prompts generated with the chosen TTS voice, and the animated
  demonstration hand.
- Leo's character sheet and the first 10 SVG word illustrations (see
  [05](05-content-and-assets.md)).
- Basic map (linear), one child profile.

**Done when:** a 5-year-old who has never seen the app completes one spatial
activity and one vowel **without adult help**, on a phone and on a tablet.

## M2 — The path

- Profiles (multiple children per device), parental gate.
- Mastery, unlocking, spaced review, stickers.
- Stage 1 listening games: *Clap the syllables*, *Same sound*.
- Stage 3 vowel combinations. Stage 4 for **m, p, l** with *Starts with*,
  *Ends with* and *Build the word*.
- Illustrations for the words these steps need.

**Done when:** a child can progress from spatial concepts to "ma me mi mo mu" in
order, and progress survives closing the app.

## M3 — Test without a test group

There's no school group available, so testing is built into the release process:

- **Self-review against a checklist** at every milestone: can each activity be
  understood with the sound on and the screen text hidden? Are all touch targets
  at least 64 dp? Is feedback given within 300 ms?
- **Informal play-tests** with any child available (family, friends), following a
  short written protocol in `docs/playtest.md`. Five minutes, no help given, note
  where they get stuck.
- **Open beta:** Google Play closed testing and TestFlight, announced where
  Chilean parents and teachers gather (teacher communities, education faculties,
  kindergarten networks). An in-app "send feedback" option behind the parental
  gate opens an email with the observation-mode CSV attached, **only if the adult
  chooses to send it**.
- Observation mode + CSV export + teacher view, so any teacher who joins later
  can run a proper session without code changes.

**Done when:** the checklist passes for every activity, at least 3 informal
play-tests are written up, and the beta is open to the public.

## M4 — Full content

- All of stages 4–7, *Circle it*, *Leo runs* (runner).
- Generated audio for every word, syllable and prompt, each syllable reviewed by ear.
- Illustrations for every word in the bank (no fallback pictograms left).
- Stage 8: *Read and match*, *Leo reads*.
- iOS build verified on devices.

**Done when:** content validation reports zero missing assets, and the whole path
can be played end to end.

## M5 — Publish

- Privacy policy and legal review. Google Play (Families policy) and App Store
  (Kids category).
- Documentation: a teacher's guide (the method, how to use observation mode) and a
  contributor's guide (adding words, recordings, activities).
- Optional: web build, F-Droid.

**Done when:** the app is installable from at least one store, and a first external
contribution (a word, a recording or a fix) has been merged.
