import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BeSemanticTokens', () {
    test('light theme resolves expected semantic colors', () {
      final colors = BeSemanticTokens.light.colors;

      expect(colors.backgroundPrimary, const Color(0xFFFFFFFF));
      expect(colors.textPrimary, const Color(0xFF111827));
      expect(colors.brandPrimary, const Color(0xFF3B82F6));
      expect(colors.errorPrimary, const Color(0xFFEF4444));
    });

    test('dark theme resolves expected semantic colors', () {
      final colors = BeSemanticTokens.dark.colors;

      expect(colors.backgroundPrimary, const Color(0xFF030712));
      expect(colors.textPrimary, const Color(0xFFF9FAFB));
      expect(colors.brandPrimary, const Color(0xFF60A5FA));
    });

    test('semantic spacing resolves to primitive values', () {
      final spacing = BeSemanticTokens.light.spacing;

      expect(spacing.pagePadding, 16);
      expect(spacing.sectionGap, 24);
      expect(spacing.componentGap, 8);
    });

    test('semantic radius resolves to primitive values', () {
      final radius = BeSemanticTokens.light.radius;

      expect(radius.button, 8);
      expect(radius.card, 12);
      expect(radius.chip, 9999);
    });

    test('semantic shadows resolve to box shadows', () {
      final shadows = BeSemanticTokens.light.shadows;

      expect(shadows.card, isNotEmpty);
      expect(shadows.card.first.blurRadius, 2);
      expect(shadows.card.first.offset, const Offset(0, 1));
      expect(shadows.modal.first.blurRadius, greaterThan(shadows.card.first.blurRadius));
    });

    test('typography tokens expose text theme from primitives', () {
      final typography = BeSemanticTokens.light.typography;

      expect(typography.textTheme.bodyLarge?.fontSize, 16);
      expect(typography.textTheme.headlineLarge?.fontWeight, FontWeight.w600);
    });
  });

  group('ThemeExtension behavior', () {
    test('BeColorTokens lerp interpolates between themes', () {
      final result = BeSemanticTokens.light.colors.lerp(
        BeSemanticTokens.dark.colors,
        0.5,
      );

      expect(
        result.backgroundPrimary,
        isNot(equals(BeSemanticTokens.light.colors.backgroundPrimary)),
      );
      expect(
        result.backgroundPrimary,
        isNot(equals(BeSemanticTokens.dark.colors.backgroundPrimary)),
      );
    });

    test('BeColorTokens lerp returns self when other is null', () {
      final colors = BeSemanticTokens.light.colors;
      expect(colors.lerp(null, 0.5), same(colors));
    });

    test('BeColorTokens copyWith overrides selected values', () {
      final updated = BeSemanticTokens.light.colors.copyWith(
        brandPrimary: Colors.purple,
      );

      expect(updated.brandPrimary, Colors.purple);
      expect(updated.backgroundPrimary, BeSemanticTokens.light.colors.backgroundPrimary);
    });

    test('BeSpacingTokens lerp interpolates values', () {
      final result = BeSemanticTokens.light.spacing.lerp(
        BeSemanticTokens.dark.spacing,
        0.5,
      );

      expect(result.pagePadding, 16);
    });

    test('BeSpacingTokens lerp returns self when other is null', () {
      final spacing = BeSemanticTokens.light.spacing;
      expect(spacing.lerp(null, 0.5), same(spacing));
    });

    test('BeSpacingTokens copyWith overrides selected values', () {
      final updated = BeSemanticTokens.light.spacing.copyWith(pagePadding: 32);
      expect(updated.pagePadding, 32);
    });

    test('BeRadiusTokens lerp interpolates values', () {
      final result = BeSemanticTokens.light.radius.lerp(
        BeSemanticTokens.dark.radius,
        0.5,
      );

      expect(result.card, 12);
    });

    test('BeRadiusTokens lerp returns self when other is null', () {
      final radius = BeSemanticTokens.light.radius;
      expect(radius.lerp(null, 0.5), same(radius));
    });

    test('BeRadiusTokens copyWith overrides selected values', () {
      final updated = BeSemanticTokens.light.radius.copyWith(card: 20);
      expect(updated.card, 20);
    });

    test('BeShadowTokens lerp snaps to nearest theme', () {
      final light = BeSemanticTokens.light.shadows;
      final dark = BeSemanticTokens.dark.shadows;

      expect(light.lerp(dark, 0.4), same(light));
      expect(light.lerp(dark, 0.6), same(dark));
    });

    test('BeShadowTokens lerp returns self when other is null', () {
      final shadows = BeSemanticTokens.light.shadows;
      expect(shadows.lerp(null, 0.5), same(shadows));
    });

    test('BeShadowTokens copyWith overrides selected values', () {
      final custom = [BoxShadow(color: Colors.black, blurRadius: 10)];
      final updated = BeSemanticTokens.light.shadows.copyWith(card: custom);
      expect(updated.card, custom);
    });

    test('BeTypographyTokens lerp snaps to nearest theme', () {
      final light = BeSemanticTokens.light.typography;
      final dark = BeSemanticTokens.dark.typography;

      expect(light.lerp(dark, 0.2), same(light));
      expect(light.lerp(dark, 0.8), same(dark));
    });

    test('BeTypographyTokens lerp returns self when other is null', () {
      final typography = BeSemanticTokens.light.typography;
      expect(typography.lerp(null, 0.5), same(typography));
    });

    test('BeTypographyTokens copyWith overrides text theme', () {
      final custom = const TextTheme(bodyLarge: TextStyle(fontSize: 20));
      final updated = BeSemanticTokens.light.typography.copyWith(
        textTheme: custom,
      );
      expect(updated.textTheme.bodyLarge?.fontSize, 20);
    });

    test('BeColorTokens fromMap throws when key is missing', () {
      expect(
        () => BeColorTokens.fromMap(const {}),
        throwsA(isA<StateError>()),
      );
    });

    test('BeColorTokens copyWith without args returns equivalent tokens', () {
      final colors = BeSemanticTokens.light.colors;
      final copy = colors.copyWith();
      expect(copy.backgroundPrimary, colors.backgroundPrimary);
      expect(copy.brandPrimary, colors.brandPrimary);
    });

    test('BeSpacingTokens fromMap throws when key is missing', () {
      expect(
        () => BeSpacingTokens.fromMap(const {}),
        throwsA(isA<StateError>()),
      );
    });

    test('BeSpacingTokens copyWith without args returns equivalent tokens', () {
      final spacing = BeSemanticTokens.light.spacing;
      final copy = spacing.copyWith();
      expect(copy.pagePadding, spacing.pagePadding);
      expect(copy.sectionGap, spacing.sectionGap);
    });

    test('BeRadiusTokens fromMap throws when key is missing', () {
      expect(
        () => BeRadiusTokens.fromMap(const {}),
        throwsA(isA<StateError>()),
      );
    });

    test('BeRadiusTokens copyWith without args returns equivalent tokens', () {
      final radius = BeSemanticTokens.light.radius;
      final copy = radius.copyWith();
      expect(copy.card, radius.card);
      expect(copy.button, radius.button);
    });

    test('BeShadowTokens fromMap throws when key is missing', () {
      expect(
        () => BeShadowTokens.fromMap(const {}),
        throwsA(isA<StateError>()),
      );
    });

    test('BeShadowTokens copyWith without args returns equivalent tokens', () {
      final shadows = BeSemanticTokens.light.shadows;
      final copy = shadows.copyWith();
      expect(copy.card, shadows.card);
      expect(copy.modal, shadows.modal);
    });
  });
}
