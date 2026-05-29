// GENERATED CODE - DO NOT MODIFY BY HAND
//
// Run `melos run generate:tokens` to regenerate.

import 'package:flutter/material.dart';

/// Raw color scale values from the design system.
abstract final class BePrimitiveColors {
  BePrimitiveColors._();
  static const brand_100 = Color(0xFFDBEAFE);
  static const brand_200 = Color(0xFFBFDBFE);
  static const brand_300 = Color(0xFF93C5FD);
  static const brand_400 = Color(0xFF60A5FA);
  static const brand_50 = Color(0xFFEFF6FF);
  static const brand_500 = Color(0xFF3B82F6);
  static const brand_600 = Color(0xFF2563EB);
  static const brand_700 = Color(0xFF1D4ED8);
  static const brand_800 = Color(0xFF1E40AF);
  static const brand_900 = Color(0xFF1E3A8A);
  static const error_100 = Color(0xFFFEE2E2);
  static const error_200 = Color(0xFFFECACA);
  static const error_300 = Color(0xFFFCA5A5);
  static const error_400 = Color(0xFFF87171);
  static const error_50 = Color(0xFFFEF2F2);
  static const error_500 = Color(0xFFEF4444);
  static const error_600 = Color(0xFFDC2626);
  static const error_700 = Color(0xFFB91C1C);
  static const error_800 = Color(0xFF991B1B);
  static const error_900 = Color(0xFF7F1D1D);
  static const neutral_100 = Color(0xFFF3F4F6);
  static const neutral_200 = Color(0xFFE5E7EB);
  static const neutral_300 = Color(0xFFD1D5DB);
  static const neutral_400 = Color(0xFF9CA3AF);
  static const neutral_50 = Color(0xFFF9FAFB);
  static const neutral_500 = Color(0xFF6B7280);
  static const neutral_600 = Color(0xFF4B5563);
  static const neutral_700 = Color(0xFF374151);
  static const neutral_800 = Color(0xFF1F2937);
  static const neutral_900 = Color(0xFF111827);
  static const neutral_950 = Color(0xFF030712);
  static const success_100 = Color(0xFFDCFCE7);
  static const success_200 = Color(0xFFBBF7D0);
  static const success_300 = Color(0xFF86EFAC);
  static const success_400 = Color(0xFF4ADE80);
  static const success_50 = Color(0xFFF0FDF4);
  static const success_500 = Color(0xFF22C55E);
  static const success_600 = Color(0xFF16A34A);
  static const success_700 = Color(0xFF15803D);
  static const success_800 = Color(0xFF166534);
  static const success_900 = Color(0xFF14532D);
  static const warning_100 = Color(0xFFFEF3C7);
  static const warning_200 = Color(0xFFFDE68A);
  static const warning_300 = Color(0xFFFCD34D);
  static const warning_400 = Color(0xFFFBBF24);
  static const warning_50 = Color(0xFFFFFBEB);
  static const warning_500 = Color(0xFFF59E0B);
  static const warning_600 = Color(0xFFD97706);
  static const warning_700 = Color(0xFFB45309);
  static const warning_800 = Color(0xFF92400E);
  static const warning_900 = Color(0xFF78350F);
  static const white_0 = Color(0xFFFFFFFF);
  static const white_100 = Color(0xFFF5F5F5);
  static const white_50 = Color(0xFFFAFAFA);
}

/// Raw spacing scale values.
abstract final class BePrimitiveSpacing {
  BePrimitiveSpacing._();
  static const lg = 24.0;
  static const md = 16.0;
  static const none = 0.0;
  static const sm = 8.0;
  static const xl = 32.0;
  static const xs = 4.0;
  static const xxl = 48.0;
  static const xxs = 2.0;
  static const xxxl = 64.0;
}

/// Raw border-radius scale values.
abstract final class BePrimitiveRadius {
  BePrimitiveRadius._();
  static const full = 9999.0;
  static const lg = 12.0;
  static const md = 8.0;
  static const none = 0.0;
  static const sm = 4.0;
  static const xl = 16.0;
  static const xs = 2.0;
  static const xxl = 24.0;
}

/// Primitive shadow definition before semantic mapping.
class BePrimitiveShadowDefinition {
  const BePrimitiveShadowDefinition({
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
abstract final class BePrimitiveShadows {
  BePrimitiveShadows._();
  static const elevation0 = BePrimitiveShadowDefinition(
    color: Color(0xFF111827),
    alpha: 0.0,
    blur: 0.0,
    offsetX: 0.0,
    offsetY: 0.0,
    spread: 0.0,
  );
  static const elevation1 = BePrimitiveShadowDefinition(
    color: Color(0xFF111827),
    alpha: 0.05,
    blur: 2.0,
    offsetX: 0.0,
    offsetY: 1.0,
    spread: 0.0,
  );
  static const elevation2 = BePrimitiveShadowDefinition(
    color: Color(0xFF111827),
    alpha: 0.08,
    blur: 4.0,
    offsetX: 0.0,
    offsetY: 2.0,
    spread: -1.0,
  );
  static const elevation3 = BePrimitiveShadowDefinition(
    color: Color(0xFF111827),
    alpha: 0.12,
    blur: 8.0,
    offsetX: 0.0,
    offsetY: 4.0,
    spread: -2.0,
  );
  static const elevation4 = BePrimitiveShadowDefinition(
    color: Color(0xFF111827),
    alpha: 0.16,
    blur: 16.0,
    offsetX: 0.0,
    offsetY: 8.0,
    spread: -4.0,
  );
}

/// Primitive typography style definition.
class BePrimitiveTextStyleDefinition {
  const BePrimitiveTextStyleDefinition({
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
abstract final class BePrimitiveTypography {
  BePrimitiveTypography._();
  static const fontFamily = 'Inter';
  static const bodyLarge = BePrimitiveTextStyleDefinition(
    size: 16.0,
    weight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.5,
  );
  static const bodyMedium = BePrimitiveTextStyleDefinition(
    size: 14.0,
    weight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
  );
  static const bodySmall = BePrimitiveTextStyleDefinition(
    size: 12.0,
    weight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4,
  );
  static const displayLarge = BePrimitiveTextStyleDefinition(
    size: 57.0,
    weight: FontWeight.w400,
    height: 1.12,
    letterSpacing: -0.25,
  );
  static const displayMedium = BePrimitiveTextStyleDefinition(
    size: 45.0,
    weight: FontWeight.w400,
    height: 1.16,
    letterSpacing: 0.0,
  );
  static const displaySmall = BePrimitiveTextStyleDefinition(
    size: 36.0,
    weight: FontWeight.w400,
    height: 1.22,
    letterSpacing: 0.0,
  );
  static const headlineLarge = BePrimitiveTextStyleDefinition(
    size: 32.0,
    weight: FontWeight.w600,
    height: 1.25,
    letterSpacing: 0.0,
  );
  static const headlineMedium = BePrimitiveTextStyleDefinition(
    size: 28.0,
    weight: FontWeight.w600,
    height: 1.29,
    letterSpacing: 0.0,
  );
  static const headlineSmall = BePrimitiveTextStyleDefinition(
    size: 24.0,
    weight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.0,
  );
  static const labelLarge = BePrimitiveTextStyleDefinition(
    size: 14.0,
    weight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1,
  );
  static const labelMedium = BePrimitiveTextStyleDefinition(
    size: 12.0,
    weight: FontWeight.w500,
    height: 1.33,
    letterSpacing: 0.5,
  );
  static const labelSmall = BePrimitiveTextStyleDefinition(
    size: 11.0,
    weight: FontWeight.w500,
    height: 1.45,
    letterSpacing: 0.5,
  );
  static const titleLarge = BePrimitiveTextStyleDefinition(
    size: 22.0,
    weight: FontWeight.w500,
    height: 1.27,
    letterSpacing: 0.0,
  );
  static const titleMedium = BePrimitiveTextStyleDefinition(
    size: 16.0,
    weight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.15,
  );
  static const titleSmall = BePrimitiveTextStyleDefinition(
    size: 14.0,
    weight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1,
  );
}
