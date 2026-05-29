# beneesse_ui

Token-driven Flutter design system for Beneesse apps.

## Overview

`beneesse_ui` provides a two-layer design token system:

1. **Primitive tokens** — raw scales from Figma (colors, spacing, radius, shadows, typography)
2. **Semantic tokens** — theme-aware UI roles (`backgroundPrimary`, `textSecondary`, `radius.card`, etc.)

Semantic tokens reference primitives via `{category.scale.step}` syntax in JSON. References are resolved at codegen time into const Dart values.

## Source of truth

Edit [`design_tokens/tokens.json`](design_tokens/tokens.json) with your Figma values, then regenerate:

```bash
# From repo root
melos run generate:tokens

# Or from this package
fvm dart run tool/generate_tokens.dart
```

Generated files land in `lib/src/tokens/generated/` and should be committed alongside JSON changes.

## Using themes

Apply Beneesse themes in your app's `MaterialApp`:

```dart
import 'package:beneesse_ui/beneesse_ui.dart';

MaterialApp(
  theme: BeTheme.light,
  darkTheme: BeTheme.dark,
  themeMode: ThemeMode.system,
  // ...
)
```

## Accessing tokens in widgets

Use `BuildContext` extensions — never import primitive tokens directly in feature widgets:

```dart
Widget build(BuildContext context) {
  final colors = context.beColors;
  final spacing = context.beSpacing;
  final radius = context.beRadius;
  final shadows = context.beShadows;

  return Container(
    padding: EdgeInsets.all(spacing.pagePadding),
    decoration: BoxDecoration(
      color: colors.surfacePrimary,
      borderRadius: BorderRadius.circular(radius.card),
      boxShadow: shadows.card,
    ),
    child: Text(
      'Hello',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: colors.textPrimary,
      ),
    ),
  );
}
```

## Public API

Exported from `package:beneesse_ui/beneesse_ui.dart`:

| Symbol | Description |
|--------|-------------|
| `BeTheme.light` / `BeTheme.dark` | Material 3 `ThemeData` builders |
| `BeThemeContext` | `context.beColors`, `context.beSpacing`, etc. |
| `BeColorTokens` | Semantic color roles |
| `BeSpacingTokens` | Semantic spacing roles |
| `BeRadiusTokens` | Semantic border-radius roles |
| `BeShadowTokens` | Semantic elevation shadows |
| `BeTypographyTokens` | Typography `TextTheme` bundle |
| `BeSemanticTokens` | Full resolved token bundle per theme |

Primitive token classes (`BePrimitiveColors`, etc.) are internal to the package.

## JSON schema

Top-level sections in `tokens.json`:

| Section | Purpose |
|---------|---------|
| `color` | Color scales (`white`, `neutral`, `brand`, `error`, `warning`, `success`) |
| `spacing` | Numeric spacing scale |
| `radius` | Border-radius scale |
| `shadow` | Elevation shadows (color ref, alpha, blur, offset, spread) |
| `typography` | Font family and text style scale |
| `semantic.light` / `semantic.dark` | Theme-aware role mappings |

Reference syntax: `{color.brand.500}`, `{spacing.md}`, `{radius.lg}`, `{shadow.elevation2}`.

Both themes must define identical semantic keys.

## Deferred (follow-up)

- Atoms: `BeText`, `BeButton`, `BeIcon`, `BeDivider`
- Molecules: `BeTextField`, `BeAppBar`, `BeCard`
- Component gallery and golden tests

## Dependency rules

- No dependency on `beneesse_api`.
- Consumed by `apps/beneesse_mobile` (and future apps as needed).

## Testing

```bash
cd packages/beneesse_ui && fvm flutter test
# or from repo root:
melos run test
```

Tests cover token codegen validation, semantic resolution, and theme wiring.
