# Lee con Leo

> Aprende a leer jugando con Leo.

**Lee con Leo** is a free, open-source app that helps Chilean pre-schoolers
(about 4–6 years old) take their first steps into reading, on the phone or
tablet their family or school already has.

- **No reading needed to play.** Leo speaks every instruction.
- **Silabario Hispanoamericano order**, with Spanish modelled by sound (Chilean
  pronunciation).
- **Games that teach:** spatial concepts, letter shapes, syllables, words.
- **Safe:** no ads, no purchases, no accounts, and it works offline.

> Status: early development (milestone M0). See the [roadmap](docs/06-roadmap.md).

## Run it

Requires [Flutter](https://docs.flutter.dev/get-started/install) (stable channel).

```
flutter pub get
flutter run
```

## Project layout

| Folder | What it holds |
|---|---|
| `lib/app/` | App shell: routing, theme, shared widgets |
| `lib/core/` | Content models and loading, audio, event log |
| `lib/activities/` | The shared activity frame and each activity |
| `lib/map/` | Home screen and learning path |
| `lib/utils/` | Pure helpers (Spanish syllables, sound keys) |
| `content/` | Human-edited source content (YAML) |
| `tool/` | Content validation and bundle build |
| `docs/` | The project plan |

## Content workflow

Words, the learning path and Leo's phrases live in `content/*.yaml`. After
editing them:

```
dart run tool/content.dart validate
dart run tool/content.dart build
```

`build` regenerates `assets/content/bundle.json`, which the app loads. CI fails
if the bundle is out of date.

## Checks

```
flutter analyze
flutter test
```

## License

Code: [MIT](LICENSE). Original content: CC BY-SA 4.0 (see
[LICENSE-CONTENT.md](LICENSE-CONTENT.md)).

Lee con Leo began in 2014 as a university thesis project. That original version
is archived separately.
