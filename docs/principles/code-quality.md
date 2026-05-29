# Code quality principles

## General

- **Minimize scope** — solve the requested problem with the smallest correct diff. Do not refactor unrelated code.
- **Match conventions** — read surrounding files before writing. Naming, folder layout, and patterns should feel native to the package.
- **Avoid over-engineering** — no premature abstractions, extra layers, or speculative error handling for unlikely cases.
- **Self-explanatory code** — comments only for non-obvious business logic or external constraints.
- **English** — code, identifiers, commit messages, and documentation are in English.

## Dart and Flutter

- Follow [`analysis_options.yaml`](../../analysis_options.yaml) and fix analyzer issues before finishing.
- Prefer `const` constructors and widgets where valid.
- Use explicit types when they improve readability; avoid `dynamic` unless required.
- Keep widgets small; extract when a build method grows hard to follow.
- Do not disable lints (`// ignore:`) without a short justification comment.

## Package-specific notes

### `beneesse_api` (pure Dart)

- No `flutter` or `dart:ui` imports.
- Prefer immutable models (e.g. `freezed` / manual `copyWith` when introduced).
- Network errors and parsing failures should be modeled explicitly, not swallowed.

### `beneesse_ui` (Flutter)

- Widgets should be as stateless as possible; state belongs in the app BLoC layer.
- No direct API or monitoring SDK calls — UI receives data and callbacks from outside.
- Shared widgets require **widget tests and golden tests** — see [testing.md](testing.md).

### `beneesse_monitoring` (Flutter)

- Provide thin wrappers around third-party SDKs so the app does not scatter monitoring calls.
- No dependency on `beneesse_api`.

### `beneesse_mobile` (app)

- Owns composition: DI, routing, feature modules, and Clean Architecture feature folders — see [clean-architecture.md](clean-architecture.md).
- Feature code should not leak into shared packages unless it is genuinely reusable.
- **No business logic in presentation** — widgets, views, and pages only render BLoC state and dispatch events.
- **Display formatting belongs in BLoC** — not in `build()` methods.
- Presentation must not import repositories or call `beneesse_api` directly.

## Tests

See [testing.md](testing.md) for coverage targets and testing guidance.

- **100% coverage** required for workspace packages, app BLoCs, and app repositories.
- App **presentation** is excluded from coverage thresholds.
- Run `melos run test` or package-level `fvm flutter test` when tests exist or are added.

## Documentation

- Every new package or significant feature gets a **README** update if behavior or usage changes.
- Update [`docs/`](../index.md) when team-wide principles or architecture rules change.
