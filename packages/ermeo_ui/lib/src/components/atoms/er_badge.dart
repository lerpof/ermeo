import 'package:flutter/material.dart';

import '../../theme/er_theme_context.dart';

/// Visual variant for [ErBadge].
enum ErBadgeVariant {
  pro,
  info,
}

/// Small inline label chip (`badge-pro`, `badge-info-soft`).
class ErBadge extends StatelessWidget {
  const ErBadge({
    required this.label,
    super.key,
    this.variant = ErBadgeVariant.pro,
  });

  final String label;
  final ErBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = context.beColors;
    final spacing = context.beSpacing;
    final radius = context.beRadius;
    final typography = context.beTypography.textTheme;

    final (backgroundColor, foregroundColor) = switch (variant) {
      ErBadgeVariant.pro => (colors.surfaceElevated, colors.onDarkMute),
      ErBadgeVariant.info => (colors.accentBlueSoft, colors.accentBlue),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius.button - 4),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: variant == ErBadgeVariant.pro ? 6 : spacing.componentGap,
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
