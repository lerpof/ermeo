import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErTheme', () {
    test('light theme attaches all theme extensions', () {
      final theme = ErTheme.light;

      expect(theme.useMaterial3, isTrue);
      expect(theme.extension<ErColorTokens>(), isNotNull);
      expect(theme.extension<ErSpacingTokens>(), isNotNull);
      expect(theme.extension<ErRadiusTokens>(), isNotNull);
      expect(theme.extension<ErShadowTokens>(), isNotNull);
      expect(theme.extension<ErTypographyTokens>(), isNotNull);
    });

    test('dark theme attaches all theme extensions', () {
      final theme = ErTheme.dark;

      expect(theme.brightness, Brightness.dark);
      expect(theme.extension<ErColorTokens>(), isNotNull);
      expect(theme.extension<ErSpacingTokens>(), isNotNull);
      expect(theme.extension<ErRadiusTokens>(), isNotNull);
      expect(theme.extension<ErShadowTokens>(), isNotNull);
      expect(theme.extension<ErTypographyTokens>(), isNotNull);
    });

    test('light ColorScheme maps semantic primary and surface colors', () {
      final theme = ErTheme.light;
      final colors = theme.extension<ErColorTokens>()!;

      expect(theme.colorScheme.primary, colors.primary);
      expect(theme.colorScheme.surface, colors.surface);
      expect(theme.colorScheme.onSurface, colors.ink);
      expect(theme.colorScheme.error, colors.accentRed);
      expect(theme.scaffoldBackgroundColor, colors.canvas);
      expect(theme.dividerColor, colors.hairline);
    });

    test('dark ColorScheme maps semantic primary and surface colors', () {
      final theme = ErTheme.dark;
      final colors = theme.extension<ErColorTokens>()!;

      expect(theme.colorScheme.primary, colors.primary);
      expect(theme.colorScheme.surface, colors.surface);
      expect(theme.scaffoldBackgroundColor, colors.canvas);
    });

    test('text theme uses semantic text colors', () {
      final theme = ErTheme.light;
      final colors = theme.extension<ErColorTokens>()!;

      expect(theme.textTheme.bodyLarge?.color, colors.ink);
      expect(theme.textTheme.headlineLarge?.color, colors.ink);
    });

    test('light theme configures component themes from semantic tokens', () {
      final theme = ErTheme.light;
      final colors = theme.extension<ErColorTokens>()!;
      final radius = theme.extension<ErRadiusTokens>()!;

      expect(theme.appBarTheme.backgroundColor, colors.canvas);
      expect(theme.appBarTheme.foregroundColor, colors.ink);
      expect(theme.inputDecorationTheme.fillColor, colors.surfaceElevated);
      expect(
        theme.inputDecorationTheme.enabledBorder,
        isA<OutlineInputBorder>(),
      );
      expect(theme.navigationBarTheme.backgroundColor, colors.canvas);
      expect(theme.navigationBarTheme.indicatorColor, colors.surfaceElevated);
      expect(theme.cardTheme.color, colors.surface);
      expect(
        (theme.cardTheme.shape as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(radius.card),
      );
      expect(
        (theme.cardTheme.shape as RoundedRectangleBorder).side.color,
        colors.hairline,
      );
    });

    test('navigationBarTheme resolves label and icon styles by state', () {
      final theme = ErTheme.light;
      final colors = theme.extension<ErColorTokens>()!;
      final labelStyle = theme.navigationBarTheme.labelTextStyle!;
      final iconTheme = theme.navigationBarTheme.iconTheme!;

      expect(
        labelStyle.resolve({WidgetState.selected})?.color,
        colors.ink,
      );
      expect(
        labelStyle.resolve({WidgetState.disabled})?.color,
        colors.ash,
      );
      expect(
        iconTheme.resolve({WidgetState.selected})?.color,
        colors.ink,
      );
      expect(
        iconTheme.resolve({WidgetState.disabled})?.color,
        colors.ash,
      );
    });
  });

  group('ErThemeContext', () {
    testWidgets('context extensions expose active theme tokens', (tester) async {
      late ErColorTokens colors;
      late ErSpacingTokens spacing;
      late ErRadiusTokens radius;
      late ErShadowTokens shadows;
      late ErTypographyTokens typography;

      await tester.pumpWidget(
        MaterialApp(
          theme: ErTheme.light,
          home: Builder(
            builder: (context) {
              colors = context.beColors;
              spacing = context.beSpacing;
              radius = context.beRadius;
              shadows = context.beShadows;
              typography = context.beTypography;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(colors.canvas, ErSemanticTokens.light.colors.canvas);
      expect(spacing.pagePadding, ErSemanticTokens.light.spacing.pagePadding);
      expect(radius.card, ErSemanticTokens.light.radius.card);
      expect(shadows.card, ErSemanticTokens.light.shadows.card);
      expect(
        typography.textTheme.bodyLarge?.fontSize,
        ErSemanticTokens.light.typography.textTheme.bodyLarge?.fontSize,
      );
    });

    testWidgets('dark theme context resolves dark semantic tokens', (tester) async {
      late ErColorTokens colors;

      await tester.pumpWidget(
        MaterialApp(
          theme: ErTheme.dark,
          home: Builder(
            builder: (context) {
              colors = context.beColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(colors.canvas, ErSemanticTokens.dark.colors.canvas);
    });
  });
}
