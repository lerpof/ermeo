import 'package:flutter/material.dart';

import '../../theme/er_semantic_tokens.dart';
import '../../theme/er_theme_context.dart';

/// Visual variant for [ErButton].
enum ErButtonVariant {
  primary,
  secondary,
  tertiary,
  outline,
  install,
  ghost,
  destructive,
}

/// Size scale for [ErButton].
enum ErButtonSize {
  sm,
  md,
  lg,
}

/// Icon position when label and icon are both present.
enum ErButtonIconPosition {
  leading,
  trailing,
}

/// Resolved visual metrics for a [ErButton] instance.
class ErButtonMetrics {
  const ErButtonMetrics({
    required this.height,
    required this.horizontalPadding,
    required this.iconGap,
    required this.labelStyle,
    required this.iconSize,
    required this.borderRadius,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.borderWidth,
  });

  final double height;
  final double horizontalPadding;
  final double iconGap;
  final TextStyle labelStyle;
  final double iconSize;
  final double borderRadius;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final double borderWidth;
}

/// Resolves [ErButton] layout and colors from semantic tokens.
abstract final class ErButtonStyle {
  static ErButtonMetrics resolve(
    BuildContext context, {
    required ErButtonVariant variant,
    required ErButtonSize size,
    required bool enabled,
    required bool isIconOnly,
  }) {
    final colors = context.beColors;
    final spacing = context.beSpacing;
    final radius = context.beRadius;
    final typography = context.beTypography.textTheme;

    final height = _heightForSize(size, spacing);
    final horizontalPadding = _horizontalPaddingForSize(size, spacing, variant);
    final iconGap = spacing.componentGap;
    final labelStyle = _labelStyleForSize(size, typography);
    final iconSize = spacing.inlineGap * 5;
    final borderRadius = radius.button;

    final palette = _resolvePalette(colors, variant, enabled);

    return ErButtonMetrics(
      height: height,
      horizontalPadding: isIconOnly ? 0 : horizontalPadding,
      iconGap: iconGap,
      labelStyle: labelStyle.copyWith(color: palette.foreground),
      iconSize: iconSize,
      borderRadius: borderRadius,
      backgroundColor: palette.background,
      foregroundColor: palette.foreground,
      borderColor: palette.border,
      borderWidth: palette.border != null ? 1 : 0,
    );
  }

  static double _heightForSize(ErButtonSize size, ErSpacingTokens spacing) {
    return switch (size) {
      ErButtonSize.sm => 32,
      ErButtonSize.md => 36,
      ErButtonSize.lg => 44,
    };
  }

  static double _horizontalPaddingForSize(
    ErButtonSize size,
    ErSpacingTokens spacing,
    ErButtonVariant variant,
  ) {
    if (variant == ErButtonVariant.install) {
      return switch (size) {
        ErButtonSize.sm => 10,
        ErButtonSize.md => 14,
        ErButtonSize.lg => 16,
      };
    }
    return switch (size) {
      ErButtonSize.sm => spacing.componentGap,
      ErButtonSize.md => spacing.componentGap * 2,
      ErButtonSize.lg => spacing.pagePadding,
    };
  }

  static TextStyle _labelStyleForSize(
    ErButtonSize size,
    TextTheme typography,
  ) {
    return switch (size) {
      ErButtonSize.sm => typography.labelMedium!,
      ErButtonSize.md => typography.labelLarge!,
      ErButtonSize.lg => typography.titleSmall!,
    };
  }

  static _ButtonPalette _resolvePalette(
    ErColorTokens colors,
    ErButtonVariant variant,
    bool enabled,
  ) {
    if (!enabled) {
      return _ButtonPalette(
        background: colors.surfaceElevated,
        foreground: colors.ash,
        border: variant == ErButtonVariant.outline ||
                variant == ErButtonVariant.install
            ? colors.hairlineStrong
            : null,
      );
    }

    return switch (variant) {
      ErButtonVariant.primary => _ButtonPalette(
        background: colors.primary,
        foreground: colors.onPrimary,
      ),
      ErButtonVariant.secondary || ErButtonVariant.ghost => _ButtonPalette(
        background: Colors.transparent,
        foreground: colors.onDark,
      ),
      ErButtonVariant.tertiary => _ButtonPalette(
        background: colors.surfaceElevated,
        foreground: colors.onDark,
      ),
      ErButtonVariant.outline || ErButtonVariant.install => _ButtonPalette(
        background: Colors.transparent,
        foreground: colors.onDark,
        border: colors.hairlineStrong,
      ),
      ErButtonVariant.destructive => _ButtonPalette(
        background: colors.accentRed,
        foreground: colors.onPrimary,
      ),
    };
  }
}

class _ButtonPalette {
  const _ButtonPalette({
    required this.background,
    required this.foreground,
    this.border,
  });

  final Color background;
  final Color foreground;
  final Color? border;
}
