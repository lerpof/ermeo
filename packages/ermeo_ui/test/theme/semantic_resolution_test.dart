import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErSemanticTokens', () {
    test('light theme resolves expected semantic colors', () {
      final colors = ErSemanticTokens.light.colors;

      expect(colors.canvas, const Color(0xFFFAFAFA));
      expect(colors.backgroundPrimary, colors.canvas);
      expect(colors.textPrimary, const Color(0xFF0A0A0C));
      expect(colors.brandPrimary, const Color(0xFF000000));
      expect(colors.primary, colors.brandPrimary);
      expect(colors.errorPrimary, const Color(0xFFFF6161));
      expect(colors.hairline, const Color(0xFFE0E0E2));
    });

    test('dark theme resolves expected semantic colors', () {
      final colors = ErSemanticTokens.dark.colors;

      expect(colors.canvas, const Color(0xFF07080A));
      expect(colors.textPrimary, const Color(0xFFF4F4F6));
      expect(colors.brandPrimary, const Color(0xFFFFFFFF));
      expect(colors.surfaceElevated, const Color(0xFF101111));
    });

    test('Raycast-native and legacy aliases resolve consistently', () {
      final colors = ErSemanticTokens.dark.colors;

      expect(colors.backgroundPrimary, colors.canvas);
      expect(colors.textPrimary, colors.ink);
      expect(colors.borderDefault, colors.hairline);
      expect(colors.brandPrimary, colors.primary);
    });

    test('semantic spacing resolves to primitive values', () {
      final spacing = ErSemanticTokens.light.spacing;

      expect(spacing.pagePadding, 24);
      expect(spacing.sectionGap, 96);
      expect(spacing.componentGap, 8);
    });

    test('semantic radius resolves to primitive values', () {
      final radius = ErSemanticTokens.light.radius;

      expect(radius.button, 8);
      expect(radius.card, 10);
      expect(radius.chip, 9999);
    });

    test('semantic shadows resolve to zero elevation', () {
      final shadows = ErSemanticTokens.light.shadows;

      expect(shadows.card, isNotEmpty);
      expect(shadows.card.first.blurRadius, 0);
      expect(shadows.card.first.color.a, 0);
    });

    test('typography tokens expose text theme from primitives', () {
      final typography = ErSemanticTokens.light.typography;

      expect(typography.textTheme.bodyLarge?.fontSize, 18);
      expect(typography.textTheme.displayLarge?.fontWeight, FontWeight.w600);
      expect(
        typography.textTheme.bodyMedium?.fontFeatures,
        contains(const FontFeature('ss03')),
      );
    });
  });

  group('ThemeExtension behavior', () {
    test('ErColorTokens lerp interpolates between themes', () {
      final result = ErSemanticTokens.light.colors.lerp(
        ErSemanticTokens.dark.colors,
        0.5,
      );

      expect(
        result.backgroundPrimary,
        isNot(equals(ErSemanticTokens.light.colors.backgroundPrimary)),
      );
      expect(
        result.backgroundPrimary,
        isNot(equals(ErSemanticTokens.dark.colors.backgroundPrimary)),
      );
    });

    test('ErColorTokens lerp returns self when other is null', () {
      final colors = ErSemanticTokens.light.colors;
      expect(colors.lerp(null, 0.5), same(colors));
    });

    test('ErColorTokens copyWith overrides selected values', () {
      final updated = ErSemanticTokens.light.colors.copyWith(
        brandPrimary: Colors.purple,
      );

      expect(updated.brandPrimary, Colors.purple);
      expect(updated.backgroundPrimary, ErSemanticTokens.light.colors.backgroundPrimary);
    });

    test('ErSpacingTokens lerp interpolates values', () {
      final result = ErSemanticTokens.light.spacing.lerp(
        ErSemanticTokens.dark.spacing,
        0.5,
      );

      expect(result.pagePadding, 24);
    });

    test('ErSpacingTokens lerp returns self when other is null', () {
      final spacing = ErSemanticTokens.light.spacing;
      expect(spacing.lerp(null, 0.5), same(spacing));
    });

    test('ErSpacingTokens copyWith overrides selected values', () {
      final updated = ErSemanticTokens.light.spacing.copyWith(pagePadding: 32);
      expect(updated.pagePadding, 32);
    });

    test('ErRadiusTokens lerp interpolates values', () {
      final result = ErSemanticTokens.light.radius.lerp(
        ErSemanticTokens.dark.radius,
        0.5,
      );

      expect(result.card, 10);
    });

    test('ErRadiusTokens lerp returns self when other is null', () {
      final radius = ErSemanticTokens.light.radius;
      expect(radius.lerp(null, 0.5), same(radius));
    });

    test('ErRadiusTokens copyWith overrides selected values', () {
      final updated = ErSemanticTokens.light.radius.copyWith(card: 20);
      expect(updated.card, 20);
    });

    test('ErShadowTokens lerp snaps to nearest theme', () {
      final light = ErSemanticTokens.light.shadows;
      final dark = ErSemanticTokens.dark.shadows;

      expect(light.lerp(dark, 0.4), same(light));
      expect(light.lerp(dark, 0.6), same(dark));
    });

    test('ErShadowTokens lerp returns self when other is null', () {
      final shadows = ErSemanticTokens.light.shadows;
      expect(shadows.lerp(null, 0.5), same(shadows));
    });

    test('ErShadowTokens copyWith overrides selected values', () {
      final custom = [BoxShadow(color: Colors.black, blurRadius: 10)];
      final updated = ErSemanticTokens.light.shadows.copyWith(card: custom);
      expect(updated.card, custom);
    });

    test('ErTypographyTokens lerp snaps to nearest theme', () {
      final light = ErSemanticTokens.light.typography;
      final dark = ErSemanticTokens.dark.typography;

      expect(light.lerp(dark, 0.2), same(light));
      expect(light.lerp(dark, 0.8), same(dark));
    });

    test('ErTypographyTokens lerp returns self when other is null', () {
      final typography = ErSemanticTokens.light.typography;
      expect(typography.lerp(null, 0.5), same(typography));
    });

    test('ErTypographyTokens copyWith overrides text theme', () {
      final custom = const TextTheme(bodyLarge: TextStyle(fontSize: 20));
      final updated = ErSemanticTokens.light.typography.copyWith(
        textTheme: custom,
      );
      expect(updated.textTheme.bodyLarge?.fontSize, 20);
    });

    test('ErColorTokens fromMap throws when key is missing', () {
      expect(
        () => ErColorTokens.fromMap(const {}),
        throwsA(isA<StateError>()),
      );
    });

    test('ErColorTokens copyWith without args returns equivalent tokens', () {
      final colors = ErSemanticTokens.light.colors;
      final copy = colors.copyWith();
      expect(copy.backgroundPrimary, colors.backgroundPrimary);
      expect(copy.brandPrimary, colors.brandPrimary);
    });

    test('ErSpacingTokens fromMap throws when key is missing', () {
      expect(
        () => ErSpacingTokens.fromMap(const {}),
        throwsA(isA<StateError>()),
      );
    });

    test('ErSpacingTokens copyWith without args returns equivalent tokens', () {
      final spacing = ErSemanticTokens.light.spacing;
      final copy = spacing.copyWith();
      expect(copy.pagePadding, spacing.pagePadding);
      expect(copy.sectionGap, spacing.sectionGap);
    });

    test('ErRadiusTokens fromMap throws when key is missing', () {
      expect(
        () => ErRadiusTokens.fromMap(const {}),
        throwsA(isA<StateError>()),
      );
    });

    test('ErRadiusTokens copyWith without args returns equivalent tokens', () {
      final radius = ErSemanticTokens.light.radius;
      final copy = radius.copyWith();
      expect(copy.card, radius.card);
      expect(copy.button, radius.button);
    });

    test('ErShadowTokens fromMap throws when key is missing', () {
      expect(
        () => ErShadowTokens.fromMap(const {}),
        throwsA(isA<StateError>()),
      );
    });

    test('ErShadowTokens copyWith without args returns equivalent tokens', () {
      final shadows = ErSemanticTokens.light.shadows;
      final copy = shadows.copyWith();
      expect(copy.card, shadows.card);
      expect(copy.modal, shadows.modal);
    });
  });
}
