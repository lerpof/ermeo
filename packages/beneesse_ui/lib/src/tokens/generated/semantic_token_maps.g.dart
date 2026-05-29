// GENERATED CODE - DO NOT MODIFY BY HAND
//
// Run `melos run generate:tokens` to regenerate.

import 'package:flutter/material.dart';

import 'primitive_tokens.g.dart';

/// Resolved semantic color maps per theme.
abstract final class BeSemanticColorMap {
  static const light = <String, Color>{
    'backgroundPrimary': Color(0xFFFFFFFF),
    'backgroundSecondary': Color(0xFFFAFAFA),
    'backgroundTertiary': Color(0xFFF5F5F5),
    'borderDefault': Color(0xFFE5E7EB),
    'borderFocus': Color(0xFF3B82F6),
    'borderStrong': Color(0xFFD1D5DB),
    'brandOnPrimary': Color(0xFFFFFFFF),
    'brandPrimary': Color(0xFF3B82F6),
    'brandSecondary': Color(0xFFDBEAFE),
    'divider': Color(0xFFE5E7EB),
    'errorOnPrimary': Color(0xFFFFFFFF),
    'errorPrimary': Color(0xFFEF4444),
    'errorSecondary': Color(0xFFFEF2F2),
    'iconDisabled': Color(0xFF9CA3AF),
    'iconPrimary': Color(0xFF374151),
    'iconSecondary': Color(0xFF6B7280),
    'overlay': Color(0xFF111827),
    'successOnPrimary': Color(0xFFFFFFFF),
    'successPrimary': Color(0xFF22C55E),
    'successSecondary': Color(0xFFF0FDF4),
    'surfaceElevated': Color(0xFFFFFFFF),
    'surfacePrimary': Color(0xFFFFFFFF),
    'surfaceSecondary': Color(0xFFF9FAFB),
    'textDisabled': Color(0xFF9CA3AF),
    'textInverse': Color(0xFFFFFFFF),
    'textPrimary': Color(0xFF111827),
    'textSecondary': Color(0xFF4B5563),
    'textTertiary': Color(0xFF6B7280),
    'warningOnPrimary': Color(0xFF111827),
    'warningPrimary': Color(0xFFF59E0B),
    'warningSecondary': Color(0xFFFFFBEB),
  };
  static const dark = <String, Color>{
    'backgroundPrimary': Color(0xFF030712),
    'backgroundSecondary': Color(0xFF111827),
    'backgroundTertiary': Color(0xFF1F2937),
    'borderDefault': Color(0xFF374151),
    'borderFocus': Color(0xFF60A5FA),
    'borderStrong': Color(0xFF4B5563),
    'brandOnPrimary': Color(0xFF030712),
    'brandPrimary': Color(0xFF60A5FA),
    'brandSecondary': Color(0xFF1E3A8A),
    'divider': Color(0xFF374151),
    'errorOnPrimary': Color(0xFF030712),
    'errorPrimary': Color(0xFFF87171),
    'errorSecondary': Color(0xFF7F1D1D),
    'iconDisabled': Color(0xFF4B5563),
    'iconPrimary': Color(0xFFE5E7EB),
    'iconSecondary': Color(0xFF9CA3AF),
    'overlay': Color(0xFF030712),
    'successOnPrimary': Color(0xFF030712),
    'successPrimary': Color(0xFF4ADE80),
    'successSecondary': Color(0xFF14532D),
    'surfaceElevated': Color(0xFF1F2937),
    'surfacePrimary': Color(0xFF111827),
    'surfaceSecondary': Color(0xFF1F2937),
    'textDisabled': Color(0xFF4B5563),
    'textInverse': Color(0xFF111827),
    'textPrimary': Color(0xFFF9FAFB),
    'textSecondary': Color(0xFF9CA3AF),
    'textTertiary': Color(0xFF6B7280),
    'warningOnPrimary': Color(0xFF030712),
    'warningPrimary': Color(0xFFFBBF24),
    'warningSecondary': Color(0xFF78350F),
  };
}

/// Resolved semantic shadow maps per theme.
abstract final class BeSemanticShadowMap {
  static const light = <String, BePrimitiveShadowDefinition>{
    'card': BePrimitiveShadowDefinition(
      color: Color(0xFF111827),
      alpha: 0.05,
      blur: 2.0,
      offsetX: 0.0,
      offsetY: 1.0,
      spread: 0.0,
    ),
    'dropdown': BePrimitiveShadowDefinition(
      color: Color(0xFF111827),
      alpha: 0.08,
      blur: 4.0,
      offsetX: 0.0,
      offsetY: 2.0,
      spread: -1.0,
    ),
    'modal': BePrimitiveShadowDefinition(
      color: Color(0xFF111827),
      alpha: 0.12,
      blur: 8.0,
      offsetX: 0.0,
      offsetY: 4.0,
      spread: -2.0,
    ),
    'none': BePrimitiveShadowDefinition(
      color: Color(0xFF111827),
      alpha: 0.0,
      blur: 0.0,
      offsetX: 0.0,
      offsetY: 0.0,
      spread: 0.0,
    ),
    'popover': BePrimitiveShadowDefinition(
      color: Color(0xFF111827),
      alpha: 0.16,
      blur: 16.0,
      offsetX: 0.0,
      offsetY: 8.0,
      spread: -4.0,
    ),
  };
  static const dark = <String, BePrimitiveShadowDefinition>{
    'card': BePrimitiveShadowDefinition(
      color: Color(0xFF111827),
      alpha: 0.08,
      blur: 4.0,
      offsetX: 0.0,
      offsetY: 2.0,
      spread: -1.0,
    ),
    'dropdown': BePrimitiveShadowDefinition(
      color: Color(0xFF111827),
      alpha: 0.12,
      blur: 8.0,
      offsetX: 0.0,
      offsetY: 4.0,
      spread: -2.0,
    ),
    'modal': BePrimitiveShadowDefinition(
      color: Color(0xFF111827),
      alpha: 0.16,
      blur: 16.0,
      offsetX: 0.0,
      offsetY: 8.0,
      spread: -4.0,
    ),
    'none': BePrimitiveShadowDefinition(
      color: Color(0xFF111827),
      alpha: 0.0,
      blur: 0.0,
      offsetX: 0.0,
      offsetY: 0.0,
      spread: 0.0,
    ),
    'popover': BePrimitiveShadowDefinition(
      color: Color(0xFF111827),
      alpha: 0.16,
      blur: 16.0,
      offsetX: 0.0,
      offsetY: 8.0,
      spread: -4.0,
    ),
  };
}

/// Resolved semantic spacing maps per theme.
abstract final class BeSemanticSpacingMap {
  static const light = <String, double>{
    'componentGap': 8.0,
    'inlineGap': 4.0,
    'pagePadding': 16.0,
    'sectionGap': 24.0,
    'stackGap': 16.0,
  };
  static const dark = <String, double>{
    'componentGap': 8.0,
    'inlineGap': 4.0,
    'pagePadding': 16.0,
    'sectionGap': 24.0,
    'stackGap': 16.0,
  };
}

/// Resolved semantic radius maps per theme.
abstract final class BeSemanticRadiusMap {
  static const light = <String, double>{
    'button': 8.0,
    'card': 12.0,
    'chip': 9999.0,
    'input': 8.0,
    'modal': 16.0,
  };
  static const dark = <String, double>{
    'button': 8.0,
    'card': 12.0,
    'chip': 9999.0,
    'input': 8.0,
    'modal': 16.0,
  };
}
