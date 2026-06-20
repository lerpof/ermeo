import 'package:flutter/material.dart';

import '../../theme/be_semantic_tokens.dart';
import '../../theme/be_theme_context.dart';

/// Visual variant for [BeButton].
enum BeButtonVariant {
  primary,
  secondary,
  tertiary,
  outline,
  install,
  ghost,
  destructive,
}

/// Size scale for [BeButton].
enum BeButtonSize {
  sm,
  md,
  lg,
}

/// Icon position when label and icon are both present.
enum BeButtonIconPosition {
  leading,
  trailing,
}

/// Resolved visual metrics for a [BeButton] instance.
class BeButtonMetrics {
  const BeButtonMetrics({
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

/// Resolves [BeButton] layout and colors from semantic tokens.
abstract final class BeButtonStyle {
  static BeButtonMetrics resolve(
    BuildContext context, {
    required BeButtonVariant variant,
    required BeButtonSize size,
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

    return BeButtonMetrics(
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

  static double _heightForSize(BeButtonSize size, BeSpacingTokens spacing) {
    return switch (size) {
      BeButtonSize.sm => 32,
      BeButtonSize.md => 36,
      BeButtonSize.lg => 44,
    };
  }

  static double _horizontalPaddingForSize(
    BeButtonSize size,
    BeSpacingTokens spacing,
    BeButtonVariant variant,
  ) {
    if (variant == BeButtonVariant.install) {
      return switch (size) {
        BeButtonSize.sm => 10,
        BeButtonSize.md => 14,
        BeButtonSize.lg => 16,
      };
    }
    return switch (size) {
      BeButtonSize.sm => spacing.componentGap,
      BeButtonSize.md => spacing.componentGap * 2,
      BeButtonSize.lg => spacing.pagePadding,
    };
  }

  static TextStyle _labelStyleForSize(
    BeButtonSize size,
    TextTheme typography,
  ) {
    return switch (size) {
      BeButtonSize.sm => typography.labelMedium!,
      BeButtonSize.md => typography.labelLarge!,
      BeButtonSize.lg => typography.titleSmall!,
    };
  }

  static _ButtonPalette _resolvePalette(
    BeColorTokens colors,
    BeButtonVariant variant,
    bool enabled,
  ) {
    if (!enabled) {
      return _ButtonPalette(
        background: colors.surfaceElevated,
        foreground: colors.ash,
        border: variant == BeButtonVariant.outline ||
                variant == BeButtonVariant.install
            ? colors.hairlineStrong
            : null,
      );
    }

    return switch (variant) {
      BeButtonVariant.primary => _ButtonPalette(
        background: colors.primary,
        foreground: colors.onPrimary,
      ),
      BeButtonVariant.secondary || BeButtonVariant.ghost => _ButtonPalette(
        background: Colors.transparent,
        foreground: colors.onDark,
      ),
      BeButtonVariant.tertiary => _ButtonPalette(
        background: colors.surfaceElevated,
        foreground: colors.onDark,
      ),
      BeButtonVariant.outline || BeButtonVariant.install => _ButtonPalette(
        background: Colors.transparent,
        foreground: colors.onDark,
        border: colors.hairlineStrong,
      ),
      BeButtonVariant.destructive => _ButtonPalette(
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
