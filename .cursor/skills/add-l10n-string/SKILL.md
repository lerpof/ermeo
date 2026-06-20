---
name: add-l10n-string
description: >-
  Adds or updates Ermeo ARB localization keys in ermeo_l10n, regenerates
  ErLocalizations, and wires context.l10n in presentation. Use when the user
  asks to add, change, or translate UI strings, ARB keys, l10n, or localization.
---

# Add localization string

Follow this workflow when adding or changing user-visible copy in Ermeo.

## Prerequisites

1. Read [`docs/guides/localization.md`](../../../docs/guides/localization.md) — key naming, `@key` metadata, placeholders, layer rules.
2. Read [`docs/principles/clean-architecture.md`](../../../docs/principles/clean-architecture.md) — presentation vs BLoC boundaries.

## Workflow

1. **Identify scope** (feature vs `common` vs `app`) and propose the key name before editing (e.g. `authLoginSubmitButton`).
2. **Edit ARB** — add the string and `@key` metadata to [`packages/ermeo_l10n/lib/l10n/app_en.arb`](../../../packages/ermeo_l10n/lib/l10n/app_en.arb). If other locale ARBs exist, add the same keys there with translated values.
3. **Regenerate** — from repo root: `melos run generate:l10n` (uses FVM via Melos `sdkPath`).
4. **Commit generated output** — include changes under `packages/ermeo_l10n/lib/src/generated/` with the ARB change (do not hand-edit generated Dart).
5. **Wire presentation** — replace hardcoded user-visible strings in **presentation** with `context.l10n.<key>`; import `package:ermeo_l10n/ermeo_l10n.dart`. Do not add l10n access in BLoC.
6. **Verify** — `melos run analyze`; `cd packages/ermeo_l10n && fvm flutter test` when the l10n package changed.

## Do not

- Edit generated files under `lib/src/generated/` by hand.
- Add strings to `ermeo_ui` unless the task explicitly requires built-in component copy.
- Use `BuildContext` or `ErLocalizations` in BLoC.
- Concatenate localized fragments in Dart — use one ARB string with placeholders.

## References

- [`packages/ermeo_l10n/README.md`](../../../packages/ermeo_l10n/README.md)
- App bootstrap: `erLocalizationDelegates` and `ErLocalizations.supportedLocales` in `apps/ermeo_mobile/lib/main.dart`
