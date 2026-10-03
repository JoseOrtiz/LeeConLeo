# 3. Activities

## What happens to each 2014 activity

| 2014 activity | Decision | Becomes |
|---|---|---|
| Vertical (up/down) | **Keep**, spoken | Spatial: *Up / down* |
| Horizontal: tap, drag | **Keep**, spoken | Spatial: *Left / right* |
| Horizontal: tilt | **Drop** | Not every device has the sensor, it's awkward in class, and it adds nothing to reading |
| Between (tables) | **Keep and extend**, and give it an end | Spatial: *Over / under / between / in / out* |
| Platform runner | **Reinvent** | *Leo runs*: catch the syllable you hear |
| Introduction | **Keep** | Letter sequence, step 1: *Meet* |
| Stitch (dots) | **Merge** | Letter sequence, step 2: *Trace* |
| Paint (free coloring) | **Merge** | Coloring becomes the reward at the end of *Trace* |
| Tap (bubbles on the shape) | **Change** | Letter sequence, step 3: *Find* (pop the right letter among lookalikes) |
| Starts with | **Keep** | *Starts with* |
| Ends with | **Keep** | *Ends with* |
| Join starts / ends with | **Merge** | A second way to play *Starts with / Ends with* (drag a line instead of tapping) |
| Wrap (circle inside words) | **Keep, later stage** | *Circle it*: find the syllable inside words. A curated child vocabulary replaces the 52,787-word adult list, and each word has a picture and audio |

## Common frame for every activity

Every activity follows the same frame, so children learn it once:

1. **Leo explains** (audio), and an animated hand shows the first move.
2. **The child plays** 5–8 items.
3. **Feedback on every item:** a sound, an animation and a short spoken phrase.
   After 2 errors on an item, a hint (the correct option glows, or the audio
   repeats more slowly).
4. **Reward:** a sticker or a star, then back to the map.
5. **Logging:** every item records `{activity, item, answer, correct, ms, hintUsed}`
   (see [04](04-architecture.md)).

Always on screen: a large **"listen again"** button (Leo's face) and a **back to
map** button.

## Activity catalogue

### Stage 0: spatial

| Activity | Mechanic | Example prompt |
|---|---|---|
| *Up / down* | Tap the right arrow, then drag Leo up or down | "¡Lleva a Leo **arriba**!" |
| *Left / right* | Same, left and right. Later: "which way does the arrow point?" to prepare for left-to-right reading | "¿Hacia dónde mira el perrito?" |
| *Over, under, between* | Drag an object into position in a scene | "Pon la pelota **entre** las mesas" |
| *In / out* | Drag objects into or out of a box | |
| *Follow the path* (new) | Trace a path with a finger from left to right, top to bottom | Builds the direction of reading and writing |

### Stage 1: listening (phonological awareness)

| Activity | Mechanic |
|---|---|
| *Clap the syllables* | Hear a word, tap the drum once per syllable (*ma-ri-po-sa* → 4) |
| *Rhymes* | Hear two words, tap the happy or sad face |
| *Same sound* | Hear a sound, pick the picture that starts with it. No letters shown |
| *Blend the sounds* | Leo says "ma… no", and the child picks the picture (*mano*). This is blending |

### Letter sequence (for each vowel and consonant)

| Step | Mechanic |
|---|---|
| *Meet* | Leo says the letter's name, an example syllable and a word ("eme… **ma**… **ma**no"). Printed and school-cursive forms, upper and lower case |
| *Trace* | Follow the strokes in the correct order with a finger: a glowing start point (children may not know numbers yet), arrows, and a path that fills in as the finger moves. Tolerance adapts to age. Finishing unlocks coloring the letter |
| *Find* | Letters float as bubbles. Pop every target letter, avoiding lookalikes (b/d, p/q, m/n) |

### Syllables and words

| Activity | Mechanic |
|---|---|
| *Starts with* | Hear a syllable, and 4 pictures appear. Tap (or drag a line to) the one that starts with it. Tapping a picture speaks its name |
| *Ends with* | Same, with the ending |
| *Build the word* (new) | A picture and its spoken word. Drag syllable tiles into place (*ma + no*). Stage 4 and after |
| *Circle it* | Circle the target syllable inside written words. Stage 5 and after |
| *Read and match* (new) | Read a word and match it to one of 3 pictures. Stage 8 |
| *Leo reads* (new) | Short sentence ("Mi mamá me mima") plus 3 pictures. Pick the one that matches. Stage 8 |

### *Leo runs* (the runner, reinvented)

A side-scrolling runner built with Flame. Leo hears a target syllable ("¡Atrapa
**pa**!"). Syllable balloons come along the path: swipe up to jump and catch the
right ones, swipe down to duck under the wrong ones. Speed and distractor
similarity adapt to accuracy. It keeps the 2014 gamification idea, and now the
child reads while playing. It unlocks as a reward after each consonant group.

## Motivation layer

- **Map:** Leo travels through places (forest, beach, city, mountains), one area
  per stage.
- **Stickers:** a collectible album, one sticker per mastered step.
- **No punishment:** no lives lost, no timers in learning activities (the runner
  is the only timed game, and it's optional).

## Later ideas (not in the first roadmap)

- **Read aloud:** the child says the syllable and on-device speech recognition
  checks it. Children's speech is hard to recognize, and this needs privacy review,
  so it stays experimental and offline only.
- **Teacher-made word lists** loaded from a file.
- Mapuzungun or other language packs, through the same content format.
