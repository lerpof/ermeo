// GENERATED CODE - DO NOT MODIFY BY HAND
//
// Run `melos run generate:tokens` to regenerate.

import 'package:flutter/material.dart';

/// Raw color scale values from the design system.
abstract final class ErPrimitiveColors {
  ErPrimitiveColors._();
  static const accentBlue = Color(0xFF57C1FF);
  static const accentBlueSoft = Color(0x2657C1FF);
  static const accentGreen = Color(0xFF59D499);
  static const accentGreenSoft = Color(0x2659D499);
  static const accentRed = Color(0xFFFF6161);
  static const accentRedSoft = Color(0x26FF6161);
  static const accentYellow = Color(0xFFFFC533);
  static const accentYellowSoft = Color(0x26FFC533);
  static const darkAsh = Color(0xFF6A6B6C);
  static const darkBody = Color(0xFFCDCDCD);
  static const darkButtonFg = Color(0xFF18191A);
  static const darkCanvas = Color(0xFF07080A);
  static const darkCharcoal = Color(0xFFD3D3D4);
  static const darkHairline = Color(0xFF242728);
  static const darkHairlineSoft = Color(0x14FFFFFF);
  static const darkHairlineStrong = Color(0x29FFFFFF);
  static const darkInk = Color(0xFFF4F4F6);
  static const darkKeyBgEnd = Color(0xFF0D0D0D);
  static const darkKeyBgStart = Color(0xFF121212);
  static const darkMute = Color(0xFF9C9C9D);
  static const darkOnDark = Color(0xFFFFFFFF);
  static const darkOnDarkMute = Color(0xB8FFFFFF);
  static const darkOnPrimary = Color(0xFF000000);
  static const darkOverlay = Color(0xFF07080A);
  static const darkPrimary = Color(0xFFFFFFFF);
  static const darkPrimaryPressed = Color(0xFFE8E8E8);
  static const darkStone = Color(0xFF434345);
  static const darkSurface = Color(0xFF0D0D0D);
  static const darkSurfaceCard = Color(0xFF121212);
  static const darkSurfaceElevated = Color(0xFF101111);
  static const heroStripeEnd = Color(0xFFA1131A);
  static const heroStripeStart = Color(0xFFFF5757);
  static const lightAsh = Color(0xFFA0A0A2);
  static const lightBody = Color(0xFF525254);
  static const lightButtonFg = Color(0xFFE8E8EA);
  static const lightCanvas = Color(0xFFFAFAFA);
  static const lightCharcoal = Color(0xFF3D3D3F);
  static const lightHairline = Color(0xFFE0E0E2);
  static const lightHairlineSoft = Color(0x14000000);
  static const lightHairlineStrong = Color(0x29000000);
  static const lightInk = Color(0xFF0A0A0C);
  static const lightKeyBgEnd = Color(0xFFF4F4F6);
  static const lightKeyBgStart = Color(0xFFECECEE);
  static const lightMute = Color(0xFF737375);
  static const lightOnDark = Color(0xFF0A0A0C);
  static const lightOnDarkMute = Color(0xB80A0A0C);
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightOverlay = Color(0xFF0A0A0C);
  static const lightPrimary = Color(0xFF000000);
  static const lightPrimaryPressed = Color(0xFF1A1A1A);
  static const lightStone = Color(0xFFB8B8BA);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceCard = Color(0xFFECECEE);
  static const lightSurfaceElevated = Color(0xFFF4F4F6);
}

/// Raw spacing scale values.
abstract final class ErPrimitiveSpacing {
  ErPrimitiveSpacing._();
  static const lg = 16.0;
  static const md = 12.0;
  static const none = 0.0;
  static const section = 96.0;
  static const sm = 8.0;
  static const xl = 24.0;
  static const xs = 4.0;
  static const xxl = 32.0;
  static const xxs = 2.0;
}

/// Raw border-radius scale values.
abstract final class ErPrimitiveRadius {
  ErPrimitiveRadius._();
  static const full = 9999.0;
  static const lg = 10.0;
  static const md = 8.0;
  static const none = 0.0;
  static const sm = 6.0;
  static const xl = 16.0;
  static const xs = 4.0;
}

/// Primitive shadow definition before semantic mapping.
class ErPrimitiveShadowDefinition {
  const ErPrimitiveShadowDefinition({
    required this.color,
    required this.alpha,
    required this.blur,
    required this.offsetX,
    required this.offsetY,
    required this.spread,
  });

  final Color color;
  final double alpha;
  final double blur;
  final double offsetX;
  final double offsetY;
  final double spread;

  List<BoxShadow> toBoxShadows() {
    return [
      BoxShadow(
        color: color.withValues(alpha: alpha),
        blurRadius: blur,
        offset: Offset(offsetX, offsetY),
        spreadRadius: spread,
      ),
    ];
  }
}

/// Raw shadow scale values.
abstract final class ErPrimitiveShadows {
  ErPrimitiveShadows._();
  static const elevation0 = ErPrimitiveShadowDefinition(
    color: Color(0xFF07080A),
    alpha: 0.0,
    blur: 0.0,
    offsetX: 0.0,
    offsetY: 0.0,
    spread: 0.0,
  );
}

/// Primitive typography style definition.
class ErPrimitiveTextStyleDefinition {
  const ErPrimitiveTextStyleDefinition({
    required this.size,
    required this.weight,
    required this.height,
    required this.letterSpacing,
  });

  final double size;
  final FontWeight weight;
  final double height;
  final double letterSpacing;
}

/// Raw typography scale values.
abstract final class ErPrimitiveTypography {
  ErPrimitiveTypography._();
  static const fontFamily = 'Inter';
  static const bodyLarge = ErPrimitiveTextStyleDefinition(
    size: 18.0,
    weight: FontWeight.w400,
    height: 1.6,
    letterSpacing: 0.0,
  );
  static const bodyMedium = ErPrimitiveTextStyleDefinition(
    size: 16.0,
    weight: FontWeight.w400,
    height: 1.6,
    letterSpacing: 0.0,
  );
  static const bodySmall = ErPrimitiveTextStyleDefinition(
    size: 14.0,
    weight: FontWeight.w400,
    height: 1.6,
    letterSpacing: 0.0,
  );
  static const displayLarge = ErPrimitiveTextStyleDefinition(
    size: 64.0,
    weight: FontWeight.w600,
    height: 1.1,
    letterSpacing: 0.0,
  );
  static const displayMedium = ErPrimitiveTextStyleDefinition(
    size: 56.0,
    weight: FontWeight.w500,
    height: 1.17,
    letterSpacing: 0.2,
  );
  static const displaySmall = ErPrimitiveTextStyleDefinition(
    size: 22.0,
    weight: FontWeight.w500,
    height: 1.15,
    letterSpacing: 0.0,
  );
  static const headlineLarge = ErPrimitiveTextStyleDefinition(
    size: 32.0,
    weight: FontWeight.w600,
    height: 1.25,
    letterSpacing: 0.0,
  );
  static const headlineMedium = ErPrimitiveTextStyleDefinition(
    size: 28.0,
    weight: FontWeight.w600,
    height: 1.29,
    letterSpacing: 0.0,
  );
  static const headlineSmall = ErPrimitiveTextStyleDefinition(
    size: 24.0,
    weight: FontWeight.w500,
    height: 1.6,
    letterSpacing: 0.2,
  );
  static const labelLarge = ErPrimitiveTextStyleDefinition(
    size: 14.0,
    weight: FontWeight.w500,
    height: 1.6,
    letterSpacing: 0.2,
  );
  static const labelMedium = ErPrimitiveTextStyleDefinition(
    size: 13.0,
    weight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.1,
  );
  static const labelSmall = ErPrimitiveTextStyleDefinition(
    size: 12.0,
    weight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.4,
  );
  static const titleLarge = ErPrimitiveTextStyleDefinition(
    size: 20.0,
    weight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.2,
  );
  static const titleMedium = ErPrimitiveTextStyleDefinition(
    size: 18.0,
    weight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.2,
  );
  static const titleSmall = ErPrimitiveTextStyleDefinition(
    size: 18.0,
    weight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.2,
  );
}
