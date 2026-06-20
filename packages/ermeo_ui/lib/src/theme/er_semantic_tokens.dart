import 'package:flutter/material.dart';

import '../tokens/generated/primitive_tokens.g.dart';
import '../tokens/generated/semantic_token_maps.g.dart';

/// Immutable bundle of resolved semantic tokens for a single theme.
class ErSemanticTokens {
  const ErSemanticTokens({
    required this.colors,
    required this.shadows,
    required this.spacing,
    required this.radius,
    required this.typography,
  });

  final ErColorTokens colors;
  final ErShadowTokens shadows;
  final ErSpacingTokens spacing;
  final ErRadiusTokens radius;
  final ErTypographyTokens typography;

  /// Light theme semantic tokens.
  static final ErSemanticTokens light = ErSemanticTokens(
    colors: ErColorTokens.fromMap(ErSemanticColorMap.light),
    shadows: ErShadowTokens.fromMap(ErSemanticShadowMap.light),
    spacing: ErSpacingTokens.fromMap(ErSemanticSpacingMap.light),
    radius: ErRadiusTokens.fromMap(ErSemanticRadiusMap.light),
    typography: ErTypographyTokens.fromPrimitives(),
  );

  /// Dark theme semantic tokens.
  static final ErSemanticTokens dark = ErSemanticTokens(
    colors: ErColorTokens.fromMap(ErSemanticColorMap.dark),
    shadows: ErShadowTokens.fromMap(ErSemanticShadowMap.dark),
    spacing: ErSpacingTokens.fromMap(ErSemanticSpacingMap.dark),
    radius: ErRadiusTokens.fromMap(ErSemanticRadiusMap.dark),
    typography: ErTypographyTokens.fromPrimitives(),
  );
}

/// Semantic color roles resolved for the active theme.
///
/// Includes Raycast-native roles (`canvas`, `ink`, `hairline`, …) and legacy
/// aliases (`backgroundPrimary`, `brandPrimary`, …) for backward compatibility.
class ErColorTokens extends ThemeExtension<ErColorTokens> {
  const ErColorTokens({
    required this.canvas,
    required this.surface,
    required this.surfaceElevated,
    required this.surfaceCard,
    required this.buttonFg,
    required this.hairline,
    required this.hairlineSoft,
    required this.hairlineStrong,
    required this.ink,
    required this.body,
    required this.charcoal,
    required this.mute,
    required this.ash,
    required this.stone,
    required this.onDark,
    required this.onDarkMute,
    required this.primary,
    required this.primaryPressed,
    required this.onPrimary,
    required this.keyBgStart,
    required this.keyBgEnd,
    required this.accentBlue,
    required this.accentBlueSoft,
    required this.accentRed,
    required this.accentRedSoft,
    required this.accentGreen,
    required this.accentGreenSoft,
    required this.accentYellow,
    required this.accentYellowSoft,
    required this.heroStripeStart,
    required this.heroStripeEnd,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.surfacePrimary,
    required this.surfaceSecondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.textInverse,
    required this.borderDefault,
    required this.borderStrong,
    required this.borderFocus,
    required this.brandPrimary,
    required this.brandSecondary,
    required this.brandOnPrimary,
    required this.errorPrimary,
    required this.errorSecondary,
    required this.errorOnPrimary,
    required this.warningPrimary,
    required this.warningSecondary,
    required this.warningOnPrimary,
    required this.successPrimary,
    required this.successSecondary,
    required this.successOnPrimary,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.iconDisabled,
    required this.divider,
    required this.overlay,
  });

  factory ErColorTokens.fromMap(Map<String, Color> map) {
    Color require(String key) {
      final value = map[key];
      if (value == null) {
        throw StateError('Missing semantic color: $key');
      }
      return value;
    }

    return ErColorTokens(
      canvas: require('canvas'),
      surface: require('surface'),
      surfaceElevated: require('surfaceElevated'),
      surfaceCard: require('surfaceCard'),
      buttonFg: require('buttonFg'),
      hairline: require('hairline'),
      hairlineSoft: require('hairlineSoft'),
      hairlineStrong: require('hairlineStrong'),
      ink: require('ink'),
      body: require('body'),
      charcoal: require('charcoal'),
      mute: require('mute'),
      ash: require('ash'),
      stone: require('stone'),
      onDark: require('onDark'),
      onDarkMute: require('onDarkMute'),
      primary: require('primary'),
      primaryPressed: require('primaryPressed'),
      onPrimary: require('onPrimary'),
      keyBgStart: require('keyBgStart'),
      keyBgEnd: require('keyBgEnd'),
      accentBlue: require('accentBlue'),
      accentBlueSoft: require('accentBlueSoft'),
      accentRed: require('accentRed'),
      accentRedSoft: require('accentRedSoft'),
      accentGreen: require('accentGreen'),
      accentGreenSoft: require('accentGreenSoft'),
      accentYellow: require('accentYellow'),
      accentYellowSoft: require('accentYellowSoft'),
      heroStripeStart: require('heroStripeStart'),
      heroStripeEnd: require('heroStripeEnd'),
      backgroundPrimary: require('backgroundPrimary'),
      backgroundSecondary: require('backgroundSecondary'),
      backgroundTertiary: require('backgroundTertiary'),
      surfacePrimary: require('surfacePrimary'),
      surfaceSecondary: require('surfaceSecondary'),
      textPrimary: require('textPrimary'),
      textSecondary: require('textSecondary'),
      textTertiary: require('textTertiary'),
      textDisabled: require('textDisabled'),
      textInverse: require('textInverse'),
      borderDefault: require('borderDefault'),
      borderStrong: require('borderStrong'),
      borderFocus: require('borderFocus'),
      brandPrimary: require('brandPrimary'),
      brandSecondary: require('brandSecondary'),
      brandOnPrimary: require('brandOnPrimary'),
      errorPrimary: require('errorPrimary'),
      errorSecondary: require('errorSecondary'),
      errorOnPrimary: require('errorOnPrimary'),
      warningPrimary: require('warningPrimary'),
      warningSecondary: require('warningSecondary'),
      warningOnPrimary: require('warningOnPrimary'),
      successPrimary: require('successPrimary'),
      successSecondary: require('successSecondary'),
      successOnPrimary: require('successOnPrimary'),
      iconPrimary: require('iconPrimary'),
      iconSecondary: require('iconSecondary'),
      iconDisabled: require('iconDisabled'),
      divider: require('divider'),
      overlay: require('overlay'),
    );
  }

  final Color canvas;
  final Color surface;
  final Color surfaceElevated;
  final Color surfaceCard;
  final Color buttonFg;
  final Color hairline;
  final Color hairlineSoft;
  final Color hairlineStrong;
  final Color ink;
  final Color body;
  final Color charcoal;
  final Color mute;
  final Color ash;
  final Color stone;
  final Color onDark;
  final Color onDarkMute;
  final Color primary;
  final Color primaryPressed;
  final Color onPrimary;
  final Color keyBgStart;
  final Color keyBgEnd;
  final Color accentBlue;
  final Color accentBlueSoft;
  final Color accentRed;
  final Color accentRedSoft;
  final Color accentGreen;
  final Color accentGreenSoft;
  final Color accentYellow;
  final Color accentYellowSoft;
  final Color heroStripeStart;
  final Color heroStripeEnd;
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundTertiary;
  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color textInverse;
  final Color borderDefault;
  final Color borderStrong;
  final Color borderFocus;
  final Color brandPrimary;
  final Color brandSecondary;
  final Color brandOnPrimary;
  final Color errorPrimary;
  final Color errorSecondary;
  final Color errorOnPrimary;
  final Color warningPrimary;
  final Color warningSecondary;
  final Color warningOnPrimary;
  final Color successPrimary;
  final Color successSecondary;
  final Color successOnPrimary;
  final Color iconPrimary;
  final Color iconSecondary;
  final Color iconDisabled;
  final Color divider;
  final Color overlay;

  @override
  ErColorTokens copyWith({
    Color? canvas,
    Color? surface,
    Color? surfaceElevated,
    Color? surfaceCard,
    Color? buttonFg,
    Color? hairline,
    Color? hairlineSoft,
    Color? hairlineStrong,
    Color? ink,
    Color? body,
    Color? charcoal,
    Color? mute,
    Color? ash,
    Color? stone,
    Color? onDark,
    Color? onDarkMute,
    Color? primary,
    Color? primaryPressed,
    Color? onPrimary,
    Color? keyBgStart,
    Color? keyBgEnd,
    Color? accentBlue,
    Color? accentBlueSoft,
    Color? accentRed,
    Color? accentRedSoft,
    Color? accentGreen,
    Color? accentGreenSoft,
    Color? accentYellow,
    Color? accentYellowSoft,
    Color? heroStripeStart,
    Color? heroStripeEnd,
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundTertiary,
    Color? surfacePrimary,
    Color? surfaceSecondary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? textInverse,
    Color? borderDefault,
    Color? borderStrong,
    Color? borderFocus,
    Color? brandPrimary,
    Color? brandSecondary,
    Color? brandOnPrimary,
    Color? errorPrimary,
    Color? errorSecondary,
    Color? errorOnPrimary,
    Color? warningPrimary,
    Color? warningSecondary,
    Color? warningOnPrimary,
    Color? successPrimary,
    Color? successSecondary,
    Color? successOnPrimary,
    Color? iconPrimary,
    Color? iconSecondary,
    Color? iconDisabled,
    Color? divider,
    Color? overlay,
  }) {
    return ErColorTokens(
      canvas: canvas ?? this.canvas,
      surface: surface ?? this.surface,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceCard: surfaceCard ?? this.surfaceCard,
      buttonFg: buttonFg ?? this.buttonFg,
      hairline: hairline ?? this.hairline,
      hairlineSoft: hairlineSoft ?? this.hairlineSoft,
      hairlineStrong: hairlineStrong ?? this.hairlineStrong,
      ink: ink ?? this.ink,
      body: body ?? this.body,
      charcoal: charcoal ?? this.charcoal,
      mute: mute ?? this.mute,
      ash: ash ?? this.ash,
      stone: stone ?? this.stone,
      onDark: onDark ?? this.onDark,
      onDarkMute: onDarkMute ?? this.onDarkMute,
      primary: primary ?? this.primary,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      onPrimary: onPrimary ?? this.onPrimary,
      keyBgStart: keyBgStart ?? this.keyBgStart,
      keyBgEnd: keyBgEnd ?? this.keyBgEnd,
      accentBlue: accentBlue ?? this.accentBlue,
      accentBlueSoft: accentBlueSoft ?? this.accentBlueSoft,
      accentRed: accentRed ?? this.accentRed,
      accentRedSoft: accentRedSoft ?? this.accentRedSoft,
      accentGreen: accentGreen ?? this.accentGreen,
      accentGreenSoft: accentGreenSoft ?? this.accentGreenSoft,
      accentYellow: accentYellow ?? this.accentYellow,
      accentYellowSoft: accentYellowSoft ?? this.accentYellowSoft,
      heroStripeStart: heroStripeStart ?? this.heroStripeStart,
      heroStripeEnd: heroStripeEnd ?? this.heroStripeEnd,
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundTertiary: backgroundTertiary ?? this.backgroundTertiary,
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      textInverse: textInverse ?? this.textInverse,
      borderDefault: borderDefault ?? this.borderDefault,
      borderStrong: borderStrong ?? this.borderStrong,
      borderFocus: borderFocus ?? this.borderFocus,
      brandPrimary: brandPrimary ?? this.brandPrimary,
      brandSecondary: brandSecondary ?? this.brandSecondary,
      brandOnPrimary: brandOnPrimary ?? this.brandOnPrimary,
      errorPrimary: errorPrimary ?? this.errorPrimary,
      errorSecondary: errorSecondary ?? this.errorSecondary,
      errorOnPrimary: errorOnPrimary ?? this.errorOnPrimary,
      warningPrimary: warningPrimary ?? this.warningPrimary,
      warningSecondary: warningSecondary ?? this.warningSecondary,
      warningOnPrimary: warningOnPrimary ?? this.warningOnPrimary,
      successPrimary: successPrimary ?? this.successPrimary,
      successSecondary: successSecondary ?? this.successSecondary,
      successOnPrimary: successOnPrimary ?? this.successOnPrimary,
      iconPrimary: iconPrimary ?? this.iconPrimary,
      iconSecondary: iconSecondary ?? this.iconSecondary,
      iconDisabled: iconDisabled ?? this.iconDisabled,
      divider: divider ?? this.divider,
      overlay: overlay ?? this.overlay,
    );
  }

  @override
  ErColorTokens lerp(ErColorTokens? other, double t) {
    if (other == null) {
      return this;
    }

    Color lerpColor(Color a, Color b) => Color.lerp(a, b, t) ?? a;

    return ErColorTokens(
      canvas: lerpColor(canvas, other.canvas),
      surface: lerpColor(surface, other.surface),
      surfaceElevated: lerpColor(surfaceElevated, other.surfaceElevated),
      surfaceCard: lerpColor(surfaceCard, other.surfaceCard),
      buttonFg: lerpColor(buttonFg, other.buttonFg),
      hairline: lerpColor(hairline, other.hairline),
      hairlineSoft: lerpColor(hairlineSoft, other.hairlineSoft),
      hairlineStrong: lerpColor(hairlineStrong, other.hairlineStrong),
      ink: lerpColor(ink, other.ink),
      body: lerpColor(body, other.body),
      charcoal: lerpColor(charcoal, other.charcoal),
      mute: lerpColor(mute, other.mute),
      ash: lerpColor(ash, other.ash),
      stone: lerpColor(stone, other.stone),
      onDark: lerpColor(onDark, other.onDark),
      onDarkMute: lerpColor(onDarkMute, other.onDarkMute),
      primary: lerpColor(primary, other.primary),
      primaryPressed: lerpColor(primaryPressed, other.primaryPressed),
      onPrimary: lerpColor(onPrimary, other.onPrimary),
      keyBgStart: lerpColor(keyBgStart, other.keyBgStart),
      keyBgEnd: lerpColor(keyBgEnd, other.keyBgEnd),
      accentBlue: lerpColor(accentBlue, other.accentBlue),
      accentBlueSoft: lerpColor(accentBlueSoft, other.accentBlueSoft),
      accentRed: lerpColor(accentRed, other.accentRed),
      accentRedSoft: lerpColor(accentRedSoft, other.accentRedSoft),
      accentGreen: lerpColor(accentGreen, other.accentGreen),
      accentGreenSoft: lerpColor(accentGreenSoft, other.accentGreenSoft),
      accentYellow: lerpColor(accentYellow, other.accentYellow),
      accentYellowSoft: lerpColor(accentYellowSoft, other.accentYellowSoft),
      heroStripeStart: lerpColor(heroStripeStart, other.heroStripeStart),
      heroStripeEnd: lerpColor(heroStripeEnd, other.heroStripeEnd),
      backgroundPrimary: lerpColor(backgroundPrimary, other.backgroundPrimary),
      backgroundSecondary: lerpColor(
        backgroundSecondary,
        other.backgroundSecondary,
      ),
      backgroundTertiary: lerpColor(
        backgroundTertiary,
        other.backgroundTertiary,
      ),
      surfacePrimary: lerpColor(surfacePrimary, other.surfacePrimary),
      surfaceSecondary: lerpColor(surfaceSecondary, other.surfaceSecondary),
      textPrimary: lerpColor(textPrimary, other.textPrimary),
      textSecondary: lerpColor(textSecondary, other.textSecondary),
      textTertiary: lerpColor(textTertiary, other.textTertiary),
      textDisabled: lerpColor(textDisabled, other.textDisabled),
      textInverse: lerpColor(textInverse, other.textInverse),
      borderDefault: lerpColor(borderDefault, other.borderDefault),
      borderStrong: lerpColor(borderStrong, other.borderStrong),
      borderFocus: lerpColor(borderFocus, other.borderFocus),
      brandPrimary: lerpColor(brandPrimary, other.brandPrimary),
      brandSecondary: lerpColor(brandSecondary, other.brandSecondary),
      brandOnPrimary: lerpColor(brandOnPrimary, other.brandOnPrimary),
      errorPrimary: lerpColor(errorPrimary, other.errorPrimary),
      errorSecondary: lerpColor(errorSecondary, other.errorSecondary),
      errorOnPrimary: lerpColor(errorOnPrimary, other.errorOnPrimary),
      warningPrimary: lerpColor(warningPrimary, other.warningPrimary),
      warningSecondary: lerpColor(warningSecondary, other.warningSecondary),
      warningOnPrimary: lerpColor(warningOnPrimary, other.warningOnPrimary),
      successPrimary: lerpColor(successPrimary, other.successPrimary),
      successSecondary: lerpColor(successSecondary, other.successSecondary),
      successOnPrimary: lerpColor(successOnPrimary, other.successOnPrimary),
      iconPrimary: lerpColor(iconPrimary, other.iconPrimary),
      iconSecondary: lerpColor(iconSecondary, other.iconSecondary),
      iconDisabled: lerpColor(iconDisabled, other.iconDisabled),
      divider: lerpColor(divider, other.divider),
      overlay: lerpColor(overlay, other.overlay),
    );
  }
}

/// Semantic spacing roles resolved for the active theme.
class ErSpacingTokens extends ThemeExtension<ErSpacingTokens> {
  const ErSpacingTokens({
    required this.pagePadding,
    required this.sectionGap,
    required this.componentGap,
    required this.inlineGap,
    required this.stackGap,
  });

  factory ErSpacingTokens.fromMap(Map<String, double> map) {
    double require(String key) {
      final value = map[key];
      if (value == null) {
        throw StateError('Missing semantic spacing: $key');
      }
      return value;
    }

    return ErSpacingTokens(
      pagePadding: require('pagePadding'),
      sectionGap: require('sectionGap'),
      componentGap: require('componentGap'),
      inlineGap: require('inlineGap'),
      stackGap: require('stackGap'),
    );
  }

  final double pagePadding;
  final double sectionGap;
  final double componentGap;
  final double inlineGap;
  final double stackGap;

  @override
  ErSpacingTokens copyWith({
    double? pagePadding,
    double? sectionGap,
    double? componentGap,
    double? inlineGap,
    double? stackGap,
  }) {
    return ErSpacingTokens(
      pagePadding: pagePadding ?? this.pagePadding,
      sectionGap: sectionGap ?? this.sectionGap,
      componentGap: componentGap ?? this.componentGap,
      inlineGap: inlineGap ?? this.inlineGap,
      stackGap: stackGap ?? this.stackGap,
    );
  }

  @override
  ErSpacingTokens lerp(ErSpacingTokens? other, double t) {
    if (other == null) {
      return this;
    }

    double lerpDouble(double a, double b) => a + (b - a) * t;

    return ErSpacingTokens(
      pagePadding: lerpDouble(pagePadding, other.pagePadding),
      sectionGap: lerpDouble(sectionGap, other.sectionGap),
      componentGap: lerpDouble(componentGap, other.componentGap),
      inlineGap: lerpDouble(inlineGap, other.inlineGap),
      stackGap: lerpDouble(stackGap, other.stackGap),
    );
  }
}

/// Semantic border-radius roles resolved for the active theme.
class ErRadiusTokens extends ThemeExtension<ErRadiusTokens> {
  const ErRadiusTokens({
    required this.button,
    required this.card,
    required this.input,
    required this.chip,
    required this.modal,
  });

  factory ErRadiusTokens.fromMap(Map<String, double> map) {
    double require(String key) {
      final value = map[key];
      if (value == null) {
        throw StateError('Missing semantic radius: $key');
      }
      return value;
    }

    return ErRadiusTokens(
      button: require('button'),
      card: require('card'),
      input: require('input'),
      chip: require('chip'),
      modal: require('modal'),
    );
  }

  final double button;
  final double card;
  final double input;
  final double chip;
  final double modal;

  @override
  ErRadiusTokens copyWith({
    double? button,
    double? card,
    double? input,
    double? chip,
    double? modal,
  }) {
    return ErRadiusTokens(
      button: button ?? this.button,
      card: card ?? this.card,
      input: input ?? this.input,
      chip: chip ?? this.chip,
      modal: modal ?? this.modal,
    );
  }

  @override
  ErRadiusTokens lerp(ErRadiusTokens? other, double t) {
    if (other == null) {
      return this;
    }

    double lerpDouble(double a, double b) => a + (b - a) * t;

    return ErRadiusTokens(
      button: lerpDouble(button, other.button),
      card: lerpDouble(card, other.card),
      input: lerpDouble(input, other.input),
      chip: lerpDouble(chip, other.chip),
      modal: lerpDouble(modal, other.modal),
    );
  }
}

/// Semantic shadow roles resolved for the active theme.
class ErShadowTokens extends ThemeExtension<ErShadowTokens> {
  const ErShadowTokens({
    required this.none,
    required this.card,
    required this.dropdown,
    required this.modal,
    required this.popover,
  });

  factory ErShadowTokens.fromMap(
    Map<String, ErPrimitiveShadowDefinition> map,
  ) {
    List<BoxShadow> require(String key) {
      final value = map[key];
      if (value == null) {
        throw StateError('Missing semantic shadow: $key');
      }
      return value.toBoxShadows();
    }

    return ErShadowTokens(
      none: require('none'),
      card: require('card'),
      dropdown: require('dropdown'),
      modal: require('modal'),
      popover: require('popover'),
    );
  }

  final List<BoxShadow> none;
  final List<BoxShadow> card;
  final List<BoxShadow> dropdown;
  final List<BoxShadow> modal;
  final List<BoxShadow> popover;

  @override
  ErShadowTokens copyWith({
    List<BoxShadow>? none,
    List<BoxShadow>? card,
    List<BoxShadow>? dropdown,
    List<BoxShadow>? modal,
    List<BoxShadow>? popover,
  }) {
    return ErShadowTokens(
      none: none ?? this.none,
      card: card ?? this.card,
      dropdown: dropdown ?? this.dropdown,
      modal: modal ?? this.modal,
      popover: popover ?? this.popover,
    );
  }

  @override
  ErShadowTokens lerp(ErShadowTokens? other, double t) {
    if (other == null) {
      return this;
    }
    return t < 0.5 ? this : other;
  }
}

/// Typography tokens mapped from the primitive design scale.
class ErTypographyTokens extends ThemeExtension<ErTypographyTokens> {
  const ErTypographyTokens({required this.textTheme});

  factory ErTypographyTokens.fromPrimitives() {
    return ErTypographyTokens(textTheme: _buildTextTheme());
  }

  final TextTheme textTheme;

  @override
  ErTypographyTokens copyWith({TextTheme? textTheme}) {
    return ErTypographyTokens(textTheme: textTheme ?? this.textTheme);
  }

  @override
  ErTypographyTokens lerp(ErTypographyTokens? other, double t) {
    if (other == null) {
      return this;
    }
    return t < 0.5 ? this : other;
  }
}

/// Inter ss03 stylistic set — Raycast signature alternate `g` glyph.
const _interBodyFeatures = <FontFeature>[
  FontFeature('calt'),
  FontFeature('kern'),
  FontFeature('liga'),
  FontFeature('ss03'),
];

/// Display-xl wordmark features (ss02 + ss08, ligatures off).
const _interDisplayFeatures = <FontFeature>[
  FontFeature('calt'),
  FontFeature('kern'),
  FontFeature('ss02'),
  FontFeature('ss08'),
];

TextTheme _buildTextTheme() {
  TextStyle fromPrimitive(
    ErPrimitiveTextStyleDefinition definition, {
    List<FontFeature>? fontFeatures,
  }) {
    return TextStyle(
      fontFamily: ErPrimitiveTypography.fontFamily,
      fontSize: definition.size,
      fontWeight: definition.weight,
      height: definition.height,
      letterSpacing: definition.letterSpacing,
      fontFeatures: fontFeatures ?? _interBodyFeatures,
    );
  }

  return TextTheme(
    displayLarge: fromPrimitive(
      ErPrimitiveTypography.displayLarge,
      fontFeatures: _interDisplayFeatures,
    ),
    displayMedium: fromPrimitive(ErPrimitiveTypography.displayMedium),
    displaySmall: fromPrimitive(ErPrimitiveTypography.displaySmall),
    headlineLarge: fromPrimitive(ErPrimitiveTypography.headlineLarge),
    headlineMedium: fromPrimitive(ErPrimitiveTypography.headlineMedium),
    headlineSmall: fromPrimitive(ErPrimitiveTypography.headlineSmall),
    titleLarge: fromPrimitive(ErPrimitiveTypography.titleLarge),
    titleMedium: fromPrimitive(ErPrimitiveTypography.titleMedium),
    titleSmall: fromPrimitive(ErPrimitiveTypography.titleSmall),
    bodyLarge: fromPrimitive(ErPrimitiveTypography.bodyLarge),
    bodyMedium: fromPrimitive(ErPrimitiveTypography.bodyMedium),
    bodySmall: fromPrimitive(ErPrimitiveTypography.bodySmall),
    labelLarge: fromPrimitive(ErPrimitiveTypography.labelLarge),
    labelMedium: fromPrimitive(ErPrimitiveTypography.labelMedium),
    labelSmall: fromPrimitive(ErPrimitiveTypography.labelSmall),
  );
}
