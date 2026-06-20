import 'package:flutter/material.dart';

import '../../theme/be_theme_context.dart';

/// Visual variant for [BeBadge].
enum BeBadgeVariant {
  pro,
  info,
}

/// Small inline label chip (`badge-pro`, `badge-info-soft`).
class BeBadge extends StatelessWidget {
  const BeBadge({
    required this.label,
    super.key,
    this.variant = BeBadgeVariant.pro,
  });

  final String label;
  final BeBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = context.beColors;
    final spacing = context.beSpacing;
    final radius = context.beRadius;
    final typography = context.beTypography.textTheme;

    final (backgroundColor, foregroundColor) = switch (variant) {
      BeBadgeVariant.pro => (colors.surfaceElevated, colors.onDarkMute),
      BeBadgeVariant.info => (colors.accentBlueSoft, colors.accentBlue),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius.button - 4),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: variant == BeBadgeVariant.pro ? 6 : spacing.componentGap,
          vertical: 2,
        ),
        child: Text(
          label,
          style: typography.labelSmall?.copyWith(color: foregroundColor),
        ),
      ),
    );
  }
}
