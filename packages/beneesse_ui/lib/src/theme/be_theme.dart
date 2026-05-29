import 'package:flutter/material.dart';

import 'be_semantic_tokens.dart';

/// Builds Material 3 [ThemeData] instances from Beneesse semantic tokens.
abstract final class BeTheme {
  /// Light theme configured with Beneesse semantic tokens.
  static ThemeData get light => _build(BeSemanticTokens.light, Brightness.light);

  /// Dark theme configured with Beneesse semantic tokens.
  static ThemeData get dark => _build(BeSemanticTokens.dark, Brightness.dark);

  static ThemeData _build(BeSemanticTokens tokens, Brightness brightness) {
    final colors = tokens.colors;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.brandPrimary,
      onPrimary: colors.brandOnPrimary,
      primaryContainer: colors.brandSecondary,
      onPrimaryContainer: colors.textPrimary,
      secondary: colors.brandPrimary,
      onSecondary: colors.brandOnPrimary,
      secondaryContainer: colors.brandSecondary,
      onSecondaryContainer: colors.textPrimary,
      tertiary: colors.successPrimary,
      onTertiary: colors.successOnPrimary,
      tertiaryContainer: colors.successSecondary,
      onTertiaryContainer: colors.textPrimary,
      error: colors.errorPrimary,
      onError: colors.errorOnPrimary,
      errorContainer: colors.errorSecondary,
      onErrorContainer: colors.textPrimary,
      surface: colors.surfacePrimary,
      onSurface: colors.textPrimary,
      onSurfaceVariant: colors.textSecondary,
      outline: colors.borderDefault,
      outlineVariant: colors.borderStrong,
      shadow: colors.overlay,
      scrim: colors.overlay,
      inverseSurface: colors.textPrimary,
      onInverseSurface: colors.textInverse,
      inversePrimary: colors.brandPrimary,
      surfaceTint: colors.brandPrimary,
    );

    final textTheme = tokens.typography.textTheme.apply(
      bodyColor: colors.textPrimary,
      displayColor: colors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.backgroundPrimary,
      dividerColor: colors.divider,
      textTheme: textTheme,
      extensions: [
        tokens.colors,
        tokens.spacing,
        tokens.radius,
        tokens.shadows,
        tokens.typography,
      ],
    );
  }
}
