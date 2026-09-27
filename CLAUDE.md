# Lee con Leo — working rules

Flutter app (Android, iOS, web) that teaches Chilean pre-schoolers to read. The
plan is in `docs/`.

## Code rules

- **English everywhere:** code, identifiers, file names, activity/step/prompt ids,
  docs. Only child-facing content stays in Spanish: the words, Leo's spoken
  phrases (`content/prompts.yaml`) and on-screen stage names.
- **Minimal to no comments.** Names explain the code.
- **Utilities** go in `lib/utils/`, one responsibility per file, pure Dart when
  possible.
- **KISS and SOLID:** small focused classes, depend on abstractions (e.g.
  `PromptPlayer`, `EventLog`, `ContentRepository`), no clever shortcuts.
- Code under `lib/core/content/models/` and `lib/utils/` must not import Flutter,
  because the command-line tool in `tool/` uses it.

## Product rules

- A child must never need to read text to play. Every instruction is spoken.
- A new activity implements `ActivitySpec`, registers in
  `lib/activities/activity_providers.dart`, adds its id to `ActivityIds`, and
  adds a `<activityId>.intro` prompt.
- Never add assets without a known open license, and list third-party ones in
  `content/CREDITS.yaml`.

## Workflow

- After editing `content/`: `dart run tool/content.dart build`.
- Before finishing: `flutter analyze` and `flutter test` must pass.
- Commits follow Conventional Commits in English (`feat:`, `fix:`, `chore:`,
  `docs:`, `refactor:`, `test:`, `ci:`), with an imperative summary.
- All changes go through pull requests into `main`. The PR title uses the same
  Conventional Commits prefix with a summary in Spanish (e.g.
  `chore: regenerar el proyecto Android`). PR descriptions are in Spanish, short
  and focused, with three sections: `Contexto`, `Cambios`, `Pruebas`. No future
  work, and nothing the README already explains.
- Don't push or create branches. The maintainer runs remote git operations.
