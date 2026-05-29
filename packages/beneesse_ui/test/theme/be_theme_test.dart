import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BeTheme', () {
    test('light theme attaches all theme extensions', () {
      final theme = BeTheme.light;

      expect(theme.useMaterial3, isTrue);
      expect(theme.extension<BeColorTokens>(), isNotNull);
      expect(theme.extension<BeSpacingTokens>(), isNotNull);
      expect(theme.extension<BeRadiusTokens>(), isNotNull);
      expect(theme.extension<BeShadowTokens>(), isNotNull);
      expect(theme.extension<BeTypographyTokens>(), isNotNull);
    });

    test('dark theme attaches all theme extensions', () {
      final theme = BeTheme.dark;

      expect(theme.brightness, Brightness.dark);
      expect(theme.extension<BeColorTokens>(), isNotNull);
      expect(theme.extension<BeSpacingTokens>(), isNotNull);
      expect(theme.extension<BeRadiusTokens>(), isNotNull);
      expect(theme.extension<BeShadowTokens>(), isNotNull);
      expect(theme.extension<BeTypographyTokens>(), isNotNull);
    });

    test('light ColorScheme maps semantic brand and surface colors', () {
      final theme = BeTheme.light;
      final colors = theme.extension<BeColorTokens>()!;

      expect(theme.colorScheme.primary, colors.brandPrimary);
      expect(theme.colorScheme.surface, colors.surfacePrimary);
      expect(theme.colorScheme.onSurface, colors.textPrimary);
      expect(theme.colorScheme.error, colors.errorPrimary);
      expect(theme.scaffoldBackgroundColor, colors.backgroundPrimary);
      expect(theme.dividerColor, colors.divider);
    });

    test('dark ColorScheme maps semantic brand and surface colors', () {
      final theme = BeTheme.dark;
      final colors = theme.extension<BeColorTokens>()!;

      expect(theme.colorScheme.primary, colors.brandPrimary);
      expect(theme.colorScheme.surface, colors.surfacePrimary);
      expect(theme.scaffoldBackgroundColor, colors.backgroundPrimary);
    });

    test('text theme uses semantic text colors', () {
      final theme = BeTheme.light;
      final colors = theme.extension<BeColorTokens>()!;

      expect(theme.textTheme.bodyLarge?.color, colors.textPrimary);
      expect(theme.textTheme.headlineLarge?.color, colors.textPrimary);
    });
  });

  group('BeThemeContext', () {
    testWidgets('context extensions expose active theme tokens', (tester) async {
      late BeColorTokens colors;
      late BeSpacingTokens spacing;
      late BeRadiusTokens radius;
      late BeShadowTokens shadows;
      late BeTypographyTokens typography;

      await tester.pumpWidget(
        MaterialApp(
          theme: BeTheme.light,
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

      expect(colors.backgroundPrimary, BeSemanticTokens.light.colors.backgroundPrimary);
      expect(spacing.pagePadding, BeSemanticTokens.light.spacing.pagePadding);
      expect(radius.card, BeSemanticTokens.light.radius.card);
      expect(shadows.card, BeSemanticTokens.light.shadows.card);
      expect(
        typography.textTheme.bodyLarge?.fontSize,
        BeSemanticTokens.light.typography.textTheme.bodyLarge?.fontSize,
      );
    });

    testWidgets('dark theme context resolves dark semantic tokens', (tester) async {
      late BeColorTokens colors;

      await tester.pumpWidget(
        MaterialApp(
          theme: BeTheme.dark,
          home: Builder(
            builder: (context) {
              colors = context.beColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(colors.backgroundPrimary, BeSemanticTokens.dark.colors.backgroundPrimary);
    });
  });
}
