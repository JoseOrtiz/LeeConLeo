# 1. Vision and principles

## Why this exists

Learning to read is the base of everything that follows at school. Many children
start first grade without the pre-reading skills that make it easier: spatial
awareness, hearing the syllables and sounds inside words, and recognizing letter
shapes. Lee con Leo gives them a free, playful, guided path to build those skills
on a device their family or school already has.

## Who it is for

| Person | Needs |
|---|---|
| **Child, 4–6 years old** (main user) | Play without reading; know right away whether they got it; feel progress; not get bored or frustrated |
| **Teacher / educator** | Use it with a group on shared devices; see who is stuck on what; trust the teaching method |
| **Parent** | Put it on a phone and let the child play safely: no ads, no purchases, no data collection |
| **Contributor** | Add words, pictures, recordings or activities without being an expert in the codebase |

## What went wrong in 2014 (and the rule that fixes it)

| 2014 observation | Principle for 2.0 |
|---|---|
| Kids didn't know what to do. Instructions and feedback were text ("Sobre la mesa izquierda", "Bien" / "Mal") | **P1. Audio-first, zero reading required.** Every instruction is spoken, and the first move is demonstrated by an animated hand. Text on screen is only ever the *learning material* |
| No record of what children did, only handwritten notes | **P2. Evidence built in.** Every activity logs its events. Observation mode exports them |
| Every level open, no sense of progress | **P3. A path with visible progress.** Unlock step by step, collect stickers, review what was learned |
| Some games (runner, tilt) had nothing to do with reading | **P4. Fun that teaches.** Game mechanics are welcome only if the child practises a reading skill while playing |
| Checks based on spelling (`startsWith("ci")`) | **P5. Sound before spelling.** Content is tagged with how it sounds in Chilean Spanish |
| Tablet only, portrait only, Android only | **P6. Any device the family has.** Phones and tablets, portrait and landscape, Android and iOS |
| Pictures and audio taken from the internet | **P7. Open and legal.** Every asset has a known, compatible license and is credited |

## Additional rules

- **Mistakes are cheap.** A wrong answer gets gentle audio ("¡Casi! Escucha otra
  vez"), never a red "Mal". After 2 errors on the same item, the app gives a hint.
- **Short sessions.** An activity takes 2–4 minutes. The map is always one tap away.
- **Safe by design.** No ads, no in-app purchases, no accounts, no network needed
  to play. Child profiles use a nickname and an avatar, with no real names required.
  Adult areas (settings, observation export) sit behind a parental gate.
- **Teachers can change the path.** The learning order is data, not code (see
  [02](02-learning-path.md)).

## What success looks like

1. A 5-year-old who has never seen the app completes the first spatial level
   **without adult help**.
2. In a teacher-run session, observation logs show accuracy on a syllable
   improving across repeated sessions.
3. A contributor adds a new word with its picture and audio by editing one content
   file and running one validation command.
