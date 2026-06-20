# ermeo_ui

Raycast-inspired, token-driven Flutter design system for Ermeo apps.

## Overview

`ermeo_ui` provides a two-layer design token system:

1. **Primitive tokens** — Raycast color scales, spacing, radius, typography (see [`design_tokens/tokens.json`](design_tokens/tokens.json))
2. **Semantic tokens** — theme-aware UI roles with Raycast-native names (`canvas`, `ink`, `hairline`, `primary`, …) and legacy aliases (`backgroundPrimary`, `brandPrimary`, …)

Semantic tokens reference primitives via `{category.scale.step}` syntax in JSON. References are resolved at codegen time into const Dart values.

## Design philosophy

The system follows Raycast's marketing chrome: near-monochrome dark surfaces, hairline borders (no drop shadows), a single high-contrast CTA pill, and Inter typography with the **ss03** stylistic set enabled.

### Light theme adaptation

Raycast's captured system is dark-only. The light theme inverts the surface and text ladders while preserving the same structure:

| Role | Dark | Light |
|------|------|-------|
| Canvas | `#07080a` | `#fafafa` |
| Primary CTA | White pill, black text | Black pill, white text |
| Ink (headlines) | `#f4f4f6` | `#0a0a0c` |
| Hairline | `#242728` | `#e0e0e2` |
| Accents | Illustration-only (unchanged) | Same |

Keycap gradients invert for light surfaces. Hero stripe band is deferred for mobile chrome.

### Breaking changes from previous theme

- `brandPrimary` is now the CTA pill color (white/black), not brand blue
- Cards use hairline borders with zero elevation — no box shadows
- `ErTabBar` is now a pill-tab strip (transparent track, elevated active chip)
- Spacing: `pagePadding` = 24px, `sectionGap` = 96px

## Source of truth

Edit [`design_tokens/tokens.json`](design_tokens/tokens.json), then regenerate:

```bash
# From repo root
melos run generate:tokens

# Or from this package
fvm dart run tool/generate_tokens.dart
```

Generated files land in `lib/src/tokens/generated/` and should be committed alongside JSON changes.

## Using themes

Apply Ermeo themes in your app's `MaterialApp`:

```dart
import 'package:ermeo_ui/ermeo_ui.dart';

MaterialApp(
  theme: ErTheme.light,
  darkTheme: ErTheme.dark,
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

  return Container(
    padding: EdgeInsets.all(spacing.pagePadding),
    decoration: BoxDecoration(
      color: colors.surface,
      borderRadius: BorderRadius.circular(radius.card),
      border: Border.all(color: colors.hairline),
    ),
    child: ErText('Hello', variant: ErTextVariant.bodyLarge),
  );
}
```

Raycast-native roles (`colors.canvas`, `colors.ink`, `colors.primary`, …) and legacy aliases (`colors.backgroundPrimary`, `colors.brandPrimary`, …) are both available on [ErColorTokens](lib/src/theme/er_semantic_tokens.dart).

## Components

### Atoms

```dart
import 'package:ermeo_ui/ermeo_ui.dart';

ErText('Welcome back', variant: ErTextVariant.headlineMedium);
ErText('Metadata', color: ErTextColor.onDarkMute);

ErIcon(Icons.home, size: ErIconSize.md, color: ErIconColor.primary);
ErDivider();

ErButton(label: 'Download', onPressed: () => bloc.add(...));
ErButton(label: 'Sign in', variant: ErButtonVariant.secondary, onPressed: onSignIn);
ErButton(label: 'Watch demo', variant: ErButtonVariant.tertiary, onPressed: onDemo);
ErButton(label: 'Install', variant: ErButtonVariant.install, onPressed: onInstall);

ErBadge(label: 'Pro');
ErBadge(label: 'Beta', variant: ErBadgeVariant.info);
ErKeycap(label: '⌘ K');
```

### Molecules

```dart
ErTextField(
  label: 'Email',
  controller: emailController,
  errorText: state.emailError,
  onChanged: (value) => bloc.add(EmailChanged(value)),
);

ErTextField(
  hint: 'Search the store...',
  size: ErTextFieldSize.search,
  prefixIcon: Icon(Icons.search),
);

ErAppBar(title: 'Settings', showBackButton: true, onBack: () => context.pop());

ErPillTabBar(
  selectedIndex: state.filterIndex,
  onTabSelected: (index) => bloc.add(FilterSelected(index)),
  tabs: [
    ErPillTab(label: 'All Extensions'),
    ErPillTab(label: 'Recently Added'),
  ],
);

ErTabBar(
  selectedIndex: state.authModeIndex,
  onTabSelected: (index) => bloc.add(AuthModeSelected(index)),
  tabs: [ErTab(label: 'Login'), ErTab(label: 'Sign up')],
);

ErCard(child: ErText('Card content'));
ErCard(elevated: true, child: ErText('Featured tier'));
```

## Public API

Exported from `package:ermeo_ui/ermeo_ui.dart`:

| Symbol | Description |
|--------|-------------|
| `ErTheme.light` / `ErTheme.dark` | Material 3 `ThemeData` builders |
| `ErThemeContext` | `context.beColors`, `context.beSpacing`, etc. |
| `ErColorTokens` | Raycast-native + legacy semantic color roles |
| `ErButtonVariant` | `primary`, `secondary`, `tertiary`, `install`, `outline`, `ghost`, `destructive` |
| `ErBadge`, `ErKeycap`, `ErPillTabBar` | Raycast core components |

## Testing

```bash
cd packages/ermeo_ui && fvm flutter test
# Regenerate goldens after visual changes:
cd packages/ermeo_ui && fvm flutter test --update-goldens
```

## Dependency rules

- No dependency on `ermeo_api`.
- Consumed by `apps/ermeo_mobile` (and future apps as needed).
