import 'package:flutter/material.dart';

import '../../theme/be_semantic_tokens.dart';
import '../../theme/be_theme_context.dart';

/// Visual variant for [BeButton].
enum BeButtonVariant {
  primary,
  secondary,
  outline,
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
    final horizontalPadding = _horizontalPaddingForSize(size, spacing);
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
      BeButtonSize.sm => spacing.componentGap * 4,
      BeButtonSize.md => spacing.componentGap * 5,
      BeButtonSize.lg => spacing.componentGap * 6,
    };
  }

  static double _horizontalPaddingForSize(
    BeButtonSize size,
    BeSpacingTokens spacing,
  ) {
    return switch (size) {
      BeButtonSize.sm => spacing.componentGap * 1.5,
      BeButtonSize.md => spacing.pagePadding,
      BeButtonSize.lg => spacing.pagePadding * 1.5,
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
        background: colors.surfaceSecondary,
        foreground: colors.textDisabled,
        border: variant == BeButtonVariant.outline ? colors.borderDefault : null,
      );
    }

    return switch (variant) {
      BeButtonVariant.primary => _ButtonPalette(
        background: colors.brandPrimary,
        foreground: colors.brandOnPrimary,
      ),
      BeButtonVariant.secondary => _ButtonPalette(
        background: colors.brandSecondary,
        foreground: colors.textPrimary,
      ),
      BeButtonVariant.outline => _ButtonPalette(
        background: Colors.transparent,
        foreground: colors.brandPrimary,
        border: colors.borderDefault,
      ),
      BeButtonVariant.ghost => _ButtonPalette(
        background: Colors.transparent,
        foreground: colors.brandPrimary,
      ),
      BeButtonVariant.destructive => _ButtonPalette(
        background: colors.errorPrimary,
        foreground: colors.errorOnPrimary,
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
