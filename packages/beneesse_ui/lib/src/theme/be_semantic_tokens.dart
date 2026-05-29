import 'package:flutter/material.dart';

import '../tokens/generated/primitive_tokens.g.dart';
import '../tokens/generated/semantic_token_maps.g.dart';

/// Immutable bundle of resolved semantic tokens for a single theme.
class BeSemanticTokens {
  const BeSemanticTokens({
    required this.colors,
    required this.shadows,
    required this.spacing,
    required this.radius,
    required this.typography,
  });

  final BeColorTokens colors;
  final BeShadowTokens shadows;
  final BeSpacingTokens spacing;
  final BeRadiusTokens radius;
  final BeTypographyTokens typography;

  /// Light theme semantic tokens.
  static final BeSemanticTokens light = BeSemanticTokens(
    colors: BeColorTokens.fromMap(BeSemanticColorMap.light),
    shadows: BeShadowTokens.fromMap(BeSemanticShadowMap.light),
    spacing: BeSpacingTokens.fromMap(BeSemanticSpacingMap.light),
    radius: BeRadiusTokens.fromMap(BeSemanticRadiusMap.light),
    typography: BeTypographyTokens.fromPrimitives(),
  );

  /// Dark theme semantic tokens.
  static final BeSemanticTokens dark = BeSemanticTokens(
    colors: BeColorTokens.fromMap(BeSemanticColorMap.dark),
    shadows: BeShadowTokens.fromMap(BeSemanticShadowMap.dark),
    spacing: BeSpacingTokens.fromMap(BeSemanticSpacingMap.dark),
    radius: BeRadiusTokens.fromMap(BeSemanticRadiusMap.dark),
    typography: BeTypographyTokens.fromPrimitives(),
  );
}

/// Semantic color roles resolved for the active theme.
class BeColorTokens extends ThemeExtension<BeColorTokens> {
  const BeColorTokens({
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.surfacePrimary,
    required this.surfaceSecondary,
    required this.surfaceElevated,
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

  factory BeColorTokens.fromMap(Map<String, Color> map) {
    Color require(String key) {
      final value = map[key];
      if (value == null) {
        throw StateError('Missing semantic color: $key');
      }
      return value;
    }

    return BeColorTokens(
      backgroundPrimary: require('backgroundPrimary'),
      backgroundSecondary: require('backgroundSecondary'),
      backgroundTertiary: require('backgroundTertiary'),
      surfacePrimary: require('surfacePrimary'),
      surfaceSecondary: require('surfaceSecondary'),
      surfaceElevated: require('surfaceElevated'),
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

  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundTertiary;
  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color surfaceElevated;
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
  BeColorTokens copyWith({
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundTertiary,
    Color? surfacePrimary,
    Color? surfaceSecondary,
    Color? surfaceElevated,
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
    return BeColorTokens(
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundTertiary: backgroundTertiary ?? this.backgroundTertiary,
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
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
  BeColorTokens lerp(BeColorTokens? other, double t) {
    if (other == null) {
      return this;
    }

    Color lerpColor(Color a, Color b) => Color.lerp(a, b, t) ?? a;

    return BeColorTokens(
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
      surfaceElevated: lerpColor(surfaceElevated, other.surfaceElevated),
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
class BeSpacingTokens extends ThemeExtension<BeSpacingTokens> {
  const BeSpacingTokens({
    required this.pagePadding,
    required this.sectionGap,
    required this.componentGap,
    required this.inlineGap,
    required this.stackGap,
  });

  factory BeSpacingTokens.fromMap(Map<String, double> map) {
    double require(String key) {
      final value = map[key];
      if (value == null) {
        throw StateError('Missing semantic spacing: $key');
      }
      return value;
    }

    return BeSpacingTokens(
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
  BeSpacingTokens copyWith({
    double? pagePadding,
    double? sectionGap,
    double? componentGap,
    double? inlineGap,
    double? stackGap,
  }) {
    return BeSpacingTokens(
      pagePadding: pagePadding ?? this.pagePadding,
      sectionGap: sectionGap ?? this.sectionGap,
      componentGap: componentGap ?? this.componentGap,
      inlineGap: inlineGap ?? this.inlineGap,
      stackGap: stackGap ?? this.stackGap,
    );
  }

  @override
  BeSpacingTokens lerp(BeSpacingTokens? other, double t) {
    if (other == null) {
      return this;
    }

    double lerpDouble(double a, double b) => a + (b - a) * t;

    return BeSpacingTokens(
      pagePadding: lerpDouble(pagePadding, other.pagePadding),
      sectionGap: lerpDouble(sectionGap, other.sectionGap),
      componentGap: lerpDouble(componentGap, other.componentGap),
      inlineGap: lerpDouble(inlineGap, other.inlineGap),
      stackGap: lerpDouble(stackGap, other.stackGap),
    );
  }
}

/// Semantic border-radius roles resolved for the active theme.
class BeRadiusTokens extends ThemeExtension<BeRadiusTokens> {
  const BeRadiusTokens({
    required this.button,
    required this.card,
    required this.input,
    required this.chip,
    required this.modal,
  });

  factory BeRadiusTokens.fromMap(Map<String, double> map) {
    double require(String key) {
      final value = map[key];
      if (value == null) {
        throw StateError('Missing semantic radius: $key');
      }
      return value;
    }

    return BeRadiusTokens(
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
  BeRadiusTokens copyWith({
    double? button,
    double? card,
    double? input,
    double? chip,
    double? modal,
  }) {
    return BeRadiusTokens(
      button: button ?? this.button,
      card: card ?? this.card,
      input: input ?? this.input,
      chip: chip ?? this.chip,
      modal: modal ?? this.modal,
    );
  }

  @override
  BeRadiusTokens lerp(BeRadiusTokens? other, double t) {
    if (other == null) {
      return this;
    }

    double lerpDouble(double a, double b) => a + (b - a) * t;

    return BeRadiusTokens(
      button: lerpDouble(button, other.button),
      card: lerpDouble(card, other.card),
      input: lerpDouble(input, other.input),
      chip: lerpDouble(chip, other.chip),
      modal: lerpDouble(modal, other.modal),
    );
  }
}

/// Semantic shadow roles resolved for the active theme.
class BeShadowTokens extends ThemeExtension<BeShadowTokens> {
  const BeShadowTokens({
    required this.none,
    required this.card,
    required this.dropdown,
    required this.modal,
    required this.popover,
  });

  factory BeShadowTokens.fromMap(
    Map<String, BePrimitiveShadowDefinition> map,
  ) {
    List<BoxShadow> require(String key) {
      final value = map[key];
      if (value == null) {
        throw StateError('Missing semantic shadow: $key');
      }
      return value.toBoxShadows();
    }

    return BeShadowTokens(
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
  BeShadowTokens copyWith({
    List<BoxShadow>? none,
    List<BoxShadow>? card,
    List<BoxShadow>? dropdown,
    List<BoxShadow>? modal,
    List<BoxShadow>? popover,
  }) {
    return BeShadowTokens(
      none: none ?? this.none,
      card: card ?? this.card,
      dropdown: dropdown ?? this.dropdown,
      modal: modal ?? this.modal,
      popover: popover ?? this.popover,
    );
  }

  @override
  BeShadowTokens lerp(BeShadowTokens? other, double t) {
    if (other == null) {
      return this;
    }
    return t < 0.5 ? this : other;
  }
}

/// Typography tokens mapped from the primitive design scale.
class BeTypographyTokens extends ThemeExtension<BeTypographyTokens> {
  const BeTypographyTokens({required this.textTheme});

  factory BeTypographyTokens.fromPrimitives() {
    return BeTypographyTokens(textTheme: _buildTextTheme());
  }

  final TextTheme textTheme;

  @override
  BeTypographyTokens copyWith({TextTheme? textTheme}) {
    return BeTypographyTokens(textTheme: textTheme ?? this.textTheme);
  }

  @override
  BeTypographyTokens lerp(BeTypographyTokens? other, double t) {
    if (other == null) {
      return this;
    }
    return t < 0.5 ? this : other;
  }
}

TextTheme _buildTextTheme() {
  TextStyle fromPrimitive(BePrimitiveTextStyleDefinition definition) {
    return TextStyle(
      fontFamily: BePrimitiveTypography.fontFamily,
      fontSize: definition.size,
      fontWeight: definition.weight,
      height: definition.height,
      letterSpacing: definition.letterSpacing,
    );
  }

  return TextTheme(
    displayLarge: fromPrimitive(BePrimitiveTypography.displayLarge),
    displayMedium: fromPrimitive(BePrimitiveTypography.displayMedium),
    displaySmall: fromPrimitive(BePrimitiveTypography.displaySmall),
    headlineLarge: fromPrimitive(BePrimitiveTypography.headlineLarge),
    headlineMedium: fromPrimitive(BePrimitiveTypography.headlineMedium),
    headlineSmall: fromPrimitive(BePrimitiveTypography.headlineSmall),
    titleLarge: fromPrimitive(BePrimitiveTypography.titleLarge),
    titleMedium: fromPrimitive(BePrimitiveTypography.titleMedium),
    titleSmall: fromPrimitive(BePrimitiveTypography.titleSmall),
    bodyLarge: fromPrimitive(BePrimitiveTypography.bodyLarge),
    bodyMedium: fromPrimitive(BePrimitiveTypography.bodyMedium),
    bodySmall: fromPrimitive(BePrimitiveTypography.bodySmall),
    labelLarge: fromPrimitive(BePrimitiveTypography.labelLarge),
    labelMedium: fromPrimitive(BePrimitiveTypography.labelMedium),
    labelSmall: fromPrimitive(BePrimitiveTypography.labelSmall),
  );
}
