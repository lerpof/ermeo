# Localization guide

Canonical rules for adding and using user-visible strings in the Beneesse monorepo.

## Where strings live

| Location | Role |
|----------|------|
| [`packages/beneesse_l10n/lib/l10n/app_en.arb`](../../packages/beneesse_l10n/lib/l10n/app_en.arb) | Template locale — **define every new key here first** |
| `app_<locale>.arb` | Translations only (same keys as template); add when that locale is supported |
| [`packages/beneesse_l10n/lib/src/generated/`](../../packages/beneesse_l10n/lib/src/generated/) | Generated — never hand-edit |
| App presentation | Consume via `context.l10n.<key>` — import `package:beneesse_l10n/beneesse_l10n.dart` |

## ARB key naming (required)

- **Format**: `lowerCamelCase`, valid Dart identifier (becomes `BeLocalizations.keyName` getter).
- **Structure**: `<scope><Context><Element>` — scope first, then screen/area, then widget or concept.
  - Feature UI: `authLoginTitle`, `authLoginSubmitButton`, `profileSettingsLogout`
  - Shared copy: `commonCancel`, `commonRetry`, `commonErrorNetwork`
  - App-wide: `appTitle` (no feature prefix when truly global)
- **Do not**: reuse one key for different meanings; abbreviate opaquely (`msg1`); embed feature name only in the English *value* while the key stays generic.
- **Prefer** stable keys over copy tweaks — change the English value, not the key, unless semantics change.

## ARB entry shape (required)

Every non-trivial key has a sibling metadata entry `@keyName`:

```json
{
  "authLoginTitle": "Sign in",
  "@authLoginTitle": {
    "description": "Title on the login screen app bar."
  },
  "authWelcomeMessage": "Hello, {userName}!",
  "@authWelcomeMessage": {
    "description": "Greeting after login with the user's display name.",
    "placeholders": {
      "userName": {
        "type": "String",
        "example": "Alex"
      }
    }
  }
}
```

## Message content rules

- **English** in `app_en.arb` is the source of truth for meaning and placeholders.
- **ICU placeholders** — use `{name}` in the string; declare every placeholder under `@key.placeholders` with `type` (`String`, `int`, `double`, `DateTime`, `num`).
- **Plurals / gender** — use ICU in the string (`{count, plural, =0{...} one{...} other{...}}`) or separate keys only when semantics truly differ; document in `description`.
- **No concatenation** in Dart (`'Hello ' + name`) — one ARB string with placeholders.
- **Punctuation and ellipsis** — include in the ARB value; do not add trailing punctuation in code.
- **Accessibility** — if a string is only for semantics, prefix key with `semantics` (e.g. `authLoginSemanticsSubmit`).

## Clean Architecture alignment

- **Presentation** (`pages` / `views` / `widgets`): use `context.l10n` for static labels, hints, buttons, empty states tied to the UI.
- **BLoC**: do not use `BuildContext` or `BeLocalizations` directly. Emit domain/error **codes** (e.g. `AuthFailure.invalidCredentials`); map codes to ARB keys in presentation, or format non-UI messages in BLoC only when using an injected locale-agnostic formatter (document if introduced later).
- **`beneesse_ui`**: keep passing `String` labels from the app unless a component is explicitly designed with built-in copy (then depend on `beneesse_l10n` in a follow-up).

## App wiring

`beneesse_mobile` registers localization at bootstrap:

```dart
MaterialApp.router(
  localizationsDelegates: beLocalizationDelegates,
  supportedLocales: BeLocalizations.supportedLocales,
  // ...
);
```

## Adding a locale later

1. Copy the key set from `app_en.arb` into `app_<locale>.arb` with `@@locale` set.
2. Translate values only; keep keys and placeholder names identical.
3. Run `melos run generate:l10n` and commit generated output under `lib/src/generated/`.

## Regeneration

After any ARB edit, from the repository root:

```bash
melos run generate:l10n
```

Commit changed files under `lib/src/generated/` with the ARB change. Use **FVM** (`fvm flutter`, `fvm dart`) per [tooling.md](../principles/tooling.md).

## Related docs

- [`packages/beneesse_l10n/README.md`](../../packages/beneesse_l10n/README.md) — package API and workflow
- [Architecture](../principles/architecture.md) — package boundaries
- [Testing](../principles/testing.md) — `beneesse_l10n` coverage expectations
- [AI guidelines](../principles/ai-guidelines.md) — agent workflow for copy changes
