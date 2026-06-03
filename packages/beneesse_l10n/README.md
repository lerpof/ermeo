# beneesse_l10n

Flutter package for Beneesse localization: ARB sources, generated `BeLocalizations`, and `BuildContext` helpers.

## Purpose

- Own all user-visible strings in `lib/l10n/*.arb`
- Generate type-safe accessors via Flutter `gen-l10n`
- Provide `context.l10n` and `beLocalizationDelegates` for apps

## Public API

Import `package:beneesse_l10n/beneesse_l10n.dart`:

- `BeLocalizations` — generated class (`BeLocalizations.of`, `supportedLocales`, `delegate`)
- `beLocalizationDelegates` — Material/Cupertino + app delegates for `MaterialApp`
- `BeL10nContext` — `context.l10n` extension

## Adding strings

Follow [docs/guides/localization.md](../../docs/guides/localization.md) for ARB key naming and layer rules.

1. Add keys to `lib/l10n/app_en.arb` (template locale).
2. From repo root: `melos run generate:l10n`
3. Commit ARB changes and files under `lib/src/generated/` (generated Dart uses `// coverage:ignore-file`; `melos run generate:l10n` re-applies it)
4. Use `context.l10n.<key>` in app **presentation** only.

## Regeneration

```bash
melos run generate:l10n
```

Uses FVM Flutter (`melos` `sdkPath` in root `pubspec.yaml`).

## Dependency rules

- No dependency on `beneesse_api`.
- Consumed by `apps/beneesse_mobile` (and future apps as needed).
- `beneesse_ui` does not depend on this package unless a component owns built-in copy.
