# 8. Open questions

## Decided

| Topic | Decision |
|---|---|
| Stack | Flutter + Flame |
| Repository | New repository for 2.0. This one becomes the thesis archive ([07](07-legacy.md)) |
| Name | Keep **Lee con Leo** ("Leo" makes it easy to find on the stores). Check the stores for name conflicts before publishing |
| Voices | Automatically generated (offline TTS) for now. Human recordings may replace them later with no code changes |
| Font | Andika (SIL OFL). Cursive postponed |
| Pictures | Dedicated illustrations: SVG drawn by Claude, plus AI-generated images for complex subjects. ARASAAC/OpenMoji only as a temporary fallback |
| Letter sounds | Taught through letter names + syllables (Silabario tradition). No isolated phonemes |
| Testing | No test group: checklist, informal play-tests and an open beta ([06](06-roadmap.md) M3) |
| Leo's design | Redesigned: a blond boy whose hair looks like a lion's mane, keeping the 2014 red vest, shorts and boots ([`content/STYLE.md`](../content/STYLE.md)) |

## Still open

| # | Question | Who can answer | Blocks |
|---|---|---|---|
| 1 | Is the proposed consonant order change (t and n earlier, k/w/x last, c/g split by sound) acceptable? | Teachers from the beta, or keep the 2014 order until then | M2 |
| 2 | Do the SVG test drawings look good enough, or should most words be AI-generated? | José, after the first 10 drawings | M1 |
| 3 | Which TTS voice (and license) sounds most natural to Chilean ears? | José, by listening to samples | M1 |
| 4 | Code license: MIT (maximum reuse) or GPL-3.0 (forks must stay open)? | José | M0 |
| 5 | Is Stage 1 (listening games) a separate map area, or mixed into each consonant group? | Beta feedback | M2 |