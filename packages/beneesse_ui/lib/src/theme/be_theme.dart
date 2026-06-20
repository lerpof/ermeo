import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'be_semantic_tokens.dart';

/// Builds Material 3 [ThemeData] instances from Beneesse semantic tokens.
abstract final class BeTheme {
  /// Light theme configured with Beneesse semantic tokens.
  static ThemeData get light => _build(BeSemanticTokens.light, Brightness.light);

  /// Dark theme configured with Beneesse semantic tokens.
  static ThemeData get dark => _build(BeSemanticTokens.dark, Brightness.dark);

  static bool get _skipGoogleFonts =>
      kIsWeb == false && Platform.environment['FLUTTER_TEST'] == 'true';

  static TextTheme _resolveTextTheme(
    BeSemanticTokens tokens,
    BeColorTokens colors,
  ) {
    final base = tokens.typography.textTheme.apply(
      bodyColor: colors.ink,
      displayColor: colors.ink,
    );
    if (_skipGoogleFonts) {
      return base;
    }
    return GoogleFonts.interTextTheme(base);
  }

  static ThemeData _build(BeSemanticTokens tokens, Brightness brightness) {
    final colors = tokens.colors;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      primaryContainer: colors.surfaceElevated,
      onPrimaryContainer: colors.ink,
      secondary: colors.primary,
      onSecondary: colors.onPrimary,
      secondaryContainer: colors.surfaceElevated,
      onSecondaryContainer: colors.ink,
      tertiary: colors.accentGreen,
      onTertiary: colors.onPrimary,
      tertiaryContainer: colors.accentGreenSoft,
      onTertiaryContainer: colors.ink,
      error: colors.accentRed,
      onError: colors.onPrimary,
      errorContainer: colors.accentRedSoft,
      onErrorContainer: colors.ink,
      surface: colors.surface,
      onSurface: colors.ink,
      onSurfaceVariant: colors.body,
      outline: colors.hairline,
      outlineVariant: colors.hairlineStrong,
      shadow: colors.overlay,
      scrim: colors.overlay,
      inverseSurface: colors.ink,
      onInverseSurface: colors.canvas,
      inversePrimary: colors.primary,
      surfaceTint: Colors.transparent,
    );

    final textTheme = _resolveTextTheme(tokens, colors);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.canvas,
      dividerColor: colors.hairline,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.canvas,
        foregroundColor: colors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.labelLarge?.copyWith(
          color: colors.ink,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: IconThemeData(color: colors.ink),
        actionsIconTheme: IconThemeData(color: colors.ink),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceElevated,
        contentPadding: EdgeInsets.symmetric(
          horizontal: tokens.spacing.componentGap + tokens.spacing.inlineGap,
          vertical: tokens.spacing.componentGap,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.input),
          borderSide: BorderSide(color: colors.hairline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.input),
          borderSide: BorderSide(color: colors.hairline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.input),
          borderSide: BorderSide(color: colors.hairlineStrong),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.input),
          borderSide: BorderSide(color: colors.accentRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.input),
          borderSide: BorderSide(color: colors.accentRed),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius.input),
          borderSide: BorderSide(color: colors.hairline),
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(color: colors.body),
        hintStyle: textTheme.bodyMedium?.copyWith(color: colors.mute),
        helperStyle: textTheme.bodySmall?.copyWith(color: colors.mute),
        errorStyle: textTheme.bodySmall?.copyWith(color: colors.accentRed),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.canvas,
        indicatorColor: colors.surfaceElevated,
        elevation: 0,
        height: 56,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return textTheme.labelMedium?.copyWith(color: colors.ash);
          }
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelMedium?.copyWith(color: colors.ink);
          }
          return textTheme.labelMedium?.copyWith(color: colors.mute);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return IconThemeData(color: colors.ash);
          }
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colors.ink);
          }
          return IconThemeData(color: colors.mute);
        }),
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.radius.card),
          side: BorderSide(color: colors.hairline),
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
