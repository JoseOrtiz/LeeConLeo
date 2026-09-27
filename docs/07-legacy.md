# 7. Legacy repository

## Decision

- **Lee con Leo 2.0 goes in a new repository.** This folder (`docs/v2-plan/`) moves
  there as its `docs/`.
- **This repository stays as the archive of the 2014 thesis.**

## Archiving this repository

1. Tag the last thesis state: `v1.0.0-thesis` (done).
2. Rewrite `README.md`: what the project was (thesis, year, university), a few
   screenshots, a link to the new repository, and a note that the pictures and
   audio came from the internet and must not be reused.
3. Remove committed build output from the index (`.gradle/`, `.idea/`,
   `showcaseView/build/`, `build/`) and update `.gitignore`.
4. Mark the repository as archived on the hosting platform (if it's hosted).

## Optional side project: make the old app run again

For nostalgia and to have a working demo. It's realistic because the app's own
code is only about 4,500 lines. **It's for personal use only:** the internet assets
mean it can't be published.

| Step | Detail |
|---|---|
| Build system | Upgrade the Gradle wrapper and the Android Gradle Plugin to current versions. Replace `compile` with `implementation` in the dependencies. Add `namespace` |
| SDK levels | `compileSdk`/`targetSdk` → current, `minSdk` → 21 or higher. Remove the `<uses-sdk>` block from the manifest |
| Libraries | Support library → AndroidX. Replace or remove ShowcaseView (the in-repo copy of the library or its published version; the original is unmaintained) |
| Manifest | Remove `<compatible-screens>` and the `largeScreens=false` restrictions so it installs on phones. Drop `READ_PHONE_STATE` and the storage permissions |
| Runtime fixes | Replace the deprecated `startDrag` with `startDragAndDrop`. Check the `BackgroundSound` service against background-execution limits. Check the OpenGL surfaces (Platform, Stitch) on modern GPUs |
| Known bugs | No feedback on wrong answers in Starts With. The Between level never ends. Hardcoded pixel offsets. A layout listener in Wrap that is never removed |

Best done on a branch (`legacy-revival`), so the `v1.0.0-thesis` tag keeps the
original exactly as submitted.
