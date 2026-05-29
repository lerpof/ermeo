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
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surfacePrimary,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colors.textPrimary,
        ),
        iconTheme: IconThemeData(color: colors.iconPrimary),
        actionsIconTheme: IconThemeData(color: colors.iconPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceSecondary,
        contentPadding: EdgeInsets.symmetric(
          horizontal: tokens.spacing.pagePadding,
          vertical: tokens.spacing.componentGap,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.input),
          borderSide: BorderSide(color: colors.borderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.input),
          borderSide: BorderSide(color: colors.borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.input),
          borderSide: BorderSide(color: colors.borderFocus, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.input),
          borderSide: BorderSide(color: colors.errorPrimary),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.input),
          borderSide: BorderSide(color: colors.errorPrimary, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.input),
          borderSide: BorderSide(color: colors.borderDefault),
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
        hintStyle: textTheme.bodyMedium?.copyWith(color: colors.textTertiary),
        helperStyle: textTheme.bodySmall?.copyWith(color: colors.textTertiary),
        errorStyle: textTheme.bodySmall?.copyWith(color: colors.errorPrimary),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surfacePrimary,
        indicatorColor: colors.brandSecondary,
        elevation: 0,
        height: tokens.spacing.componentGap * 7,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return textTheme.labelMedium?.copyWith(color: colors.textDisabled);
          }
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelMedium?.copyWith(color: colors.brandPrimary);
          }
          return textTheme.labelMedium?.copyWith(color: colors.textSecondary);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return IconThemeData(color: colors.iconDisabled);
          }
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colors.brandPrimary);
          }
          return IconThemeData(color: colors.iconSecondary);
        }),
      ),
      cardTheme: CardThemeData(
        color: colors.surfaceElevated,
        elevation: 0,
        shadowColor: colors.overlay.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.radius.card),
        ),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
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
