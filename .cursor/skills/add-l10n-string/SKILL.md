---
name: add-l10n-string
description: >-
  Adds or updates Beneesse ARB localization keys in beneesse_l10n, regenerates
  BeLocalizations, and wires context.l10n in presentation. Use when the user
  asks to add, change, or translate UI strings, ARB keys, l10n, or localization.
---

# Add localization string

Follow this workflow when adding or changing user-visible copy in Beneesse.

## Prerequisites

1. Read [`docs/guides/localization.md`](../../../docs/guides/localization.md) — key naming, `@key` metadata, placeholders, layer rules.
2. Read [`docs/principles/clean-architecture.md`](../../../docs/principles/clean-architecture.md) — presentation vs BLoC boundaries.

## Workflow

1. **Identify scope** (feature vs `common` vs `app`) and propose the key name before editing (e.g. `authLoginSubmitButton`).
2. **Edit ARB** — add the string and `@key` metadata to [`packages/beneesse_l10n/lib/l10n/app_en.arb`](../../../packages/beneesse_l10n/lib/l10n/app_en.arb). If other locale ARBs exist, add the same keys there with translated values.
3. **Regenerate** — from repo root: `melos run generate:l10n` (uses FVM via Melos `sdkPath`).
4. **Commit generated output** — include changes under `packages/beneesse_l10n/lib/src/generated/` with the ARB change (do not hand-edit generated Dart).
5. **Wire presentation** — replace hardcoded user-visible strings in **presentation** with `context.l10n.<key>`; import `package:beneesse_l10n/beneesse_l10n.dart`. Do not add l10n access in BLoC.
6. **Verify** — `melos run analyze`; `cd packages/beneesse_l10n && fvm flutter test` when the l10n package changed.

## Do not

- Edit generated files under `lib/src/generated/` by hand.
- Add strings to `beneesse_ui` unless the task explicitly requires built-in component copy.
- Use `BuildContext` or `BeLocalizations` in BLoC.
- Concatenate localized fragments in Dart — use one ARB string with placeholders.

## References

- [`packages/beneesse_l10n/README.md`](../../../packages/beneesse_l10n/README.md)
- App bootstrap: `beLocalizationDelegates` and `BeLocalizations.supportedLocales` in `apps/beneesse_mobile/lib/main.dart`
