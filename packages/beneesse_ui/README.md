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
    child: BeText('Hello', variant: BeTextVariant.bodyLarge),
  );
}
```

## Components

### Atoms

```dart
import 'package:beneesse_ui/beneesse_ui.dart';

// Typography
BeText('Welcome back', variant: BeTextVariant.headlineMedium);
BeText('Error message', color: BeTextColor.error);

// Icons
BeIcon(Icons.home, size: BeIconSize.md, color: BeIconColor.primary);

// Divider
BeDivider();

// Buttons — text, text+icon, or icon-only
BeButton(label: 'Continue', onPressed: () => bloc.add(...));
BeButton(
  label: 'Save',
  icon: Icons.save,
  variant: BeButtonVariant.secondary,
  onPressed: onSave,
);
BeButton.icon(
  icon: Icons.close,
  variant: BeButtonVariant.ghost,
  onPressed: onClose,
);
```

### Molecules

```dart
// Text field — error text comes from BLoC state
BeTextField(
  label: 'Email',
  controller: emailController,
  errorText: state.emailError,
  onChanged: (value) => bloc.add(EmailChanged(value)),
);

// App bar with optional back button
BeAppBar(
  title: 'Settings',
  showBackButton: true,
  onBack: () => context.pop(),
  actions: [
    BeButton.icon(icon: Icons.search, onPressed: onSearch),
  ],
);

// Bottom navigation (Material 3 NavigationBar)
BeBottomNavBar(
  selectedIndex: state.tabIndex,
  onDestinationSelected: (index) => bloc.add(TabSelected(index)),
  destinations: [
    BeNavDestination(
      icon: BeIcon(Icons.home_outlined, color: BeIconColor.secondary),
      selectedIcon: BeIcon(Icons.home),
      label: 'Home',
    ),
    // ...
  ],
);

// Segmented tab bar (e.g. login / sign up)
BeTabBar(
  selectedIndex: state.authModeIndex,
  onTabSelected: (index) => bloc.add(AuthModeSelected(index)),
  tabs: [
    BeTab(label: state.loginTabLabel),
    BeTab(label: state.signupTabLabel),
  ],
);

// Card with optional tap
BeCard(
  onTap: onTap,
  child: BeText('Card content'),
);
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
| `BeText`, `BeIcon`, `BeDivider`, `BeButton` | Atoms |
| `BeTextField`, `BeAppBar`, `BeBottomNavBar`, `BeTabBar`, `BeCard` | Molecules |
| `BeButtonVariant`, `BeButtonSize`, `BeNavDestination`, `BeTab`, `BeTabBarSize` | Component enums / models |

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

## Dependency rules

- No dependency on `beneesse_api`.
- Consumed by `apps/beneesse_mobile` (and future apps as needed).

## Testing

```bash
cd packages/beneesse_ui && fvm flutter test
# or from repo root:
melos run test
```

Tests cover token codegen validation, semantic resolution, theme wiring, widget tests, and golden tests for all shared components under `test/goldens/`.
