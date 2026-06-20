# beneesse_ui

Raycast-inspired, token-driven Flutter design system for Beneesse apps.

## Overview

`beneesse_ui` provides a two-layer design token system:

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
- `BeTabBar` is now a pill-tab strip (transparent track, elevated active chip)
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

  return Container(
    padding: EdgeInsets.all(spacing.pagePadding),
    decoration: BoxDecoration(
      color: colors.surface,
      borderRadius: BorderRadius.circular(radius.card),
      border: Border.all(color: colors.hairline),
    ),
    child: BeText('Hello', variant: BeTextVariant.bodyLarge),
  );
}
```

Raycast-native roles (`colors.canvas`, `colors.ink`, `colors.primary`, …) and legacy aliases (`colors.backgroundPrimary`, `colors.brandPrimary`, …) are both available on [BeColorTokens](lib/src/theme/be_semantic_tokens.dart).

## Components

### Atoms

```dart
import 'package:beneesse_ui/beneesse_ui.dart';

BeText('Welcome back', variant: BeTextVariant.headlineMedium);
BeText('Metadata', color: BeTextColor.onDarkMute);

BeIcon(Icons.home, size: BeIconSize.md, color: BeIconColor.primary);
BeDivider();

BeButton(label: 'Download', onPressed: () => bloc.add(...));
BeButton(label: 'Sign in', variant: BeButtonVariant.secondary, onPressed: onSignIn);
BeButton(label: 'Watch demo', variant: BeButtonVariant.tertiary, onPressed: onDemo);
BeButton(label: 'Install', variant: BeButtonVariant.install, onPressed: onInstall);

BeBadge(label: 'Pro');
BeBadge(label: 'Beta', variant: BeBadgeVariant.info);
BeKeycap(label: '⌘ K');
```

### Molecules

```dart
BeTextField(
  label: 'Email',
  controller: emailController,
  errorText: state.emailError,
  onChanged: (value) => bloc.add(EmailChanged(value)),
);

BeTextField(
  hint: 'Search the store...',
  size: BeTextFieldSize.search,
  prefixIcon: Icon(Icons.search),
);

BeAppBar(title: 'Settings', showBackButton: true, onBack: () => context.pop());

BePillTabBar(
  selectedIndex: state.filterIndex,
  onTabSelected: (index) => bloc.add(FilterSelected(index)),
  tabs: [
    BePillTab(label: 'All Extensions'),
    BePillTab(label: 'Recently Added'),
  ],
);

BeTabBar(
  selectedIndex: state.authModeIndex,
  onTabSelected: (index) => bloc.add(AuthModeSelected(index)),
  tabs: [BeTab(label: 'Login'), BeTab(label: 'Sign up')],
);

BeCard(child: BeText('Card content'));
BeCard(elevated: true, child: BeText('Featured tier'));
```

## Public API

Exported from `package:beneesse_ui/beneesse_ui.dart`:

| Symbol | Description |
|--------|-------------|
| `BeTheme.light` / `BeTheme.dark` | Material 3 `ThemeData` builders |
| `BeThemeContext` | `context.beColors`, `context.beSpacing`, etc. |
| `BeColorTokens` | Raycast-native + legacy semantic color roles |
| `BeButtonVariant` | `primary`, `secondary`, `tertiary`, `install`, `outline`, `ghost`, `destructive` |
| `BeBadge`, `BeKeycap`, `BePillTabBar` | Raycast core components |

## Testing

```bash
cd packages/beneesse_ui && fvm flutter test
# Regenerate goldens after visual changes:
cd packages/beneesse_ui && fvm flutter test --update-goldens
```

## Dependency rules

- No dependency on `beneesse_api`.
- Consumed by `apps/beneesse_mobile` (and future apps as needed).
