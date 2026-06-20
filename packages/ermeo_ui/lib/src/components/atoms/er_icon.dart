import 'package:flutter/material.dart';

import '../../theme/er_semantic_tokens.dart';
import '../../theme/er_theme_context.dart';

/// Semantic icon color roles for [ErIcon].
enum ErIconColor {
  primary,
  secondary,
  disabled,
}

/// Icon size roles for [ErIcon].
enum ErIconSize {
  sm,
  md,
  lg,
}

/// Token-driven icon wrapper with semantic size and color roles.
class ErIcon extends StatelessWidget {
  const ErIcon(
    this.icon, {
    super.key,
    this.size = ErIconSize.md,
    this.color = ErIconColor.primary,
    this.semanticLabel,
  });

  final IconData icon;
  final ErIconSize size;
  final ErIconColor color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.beColors;
    final spacing = context.beSpacing;

    return Semantics(
      label: semanticLabel,
      child: Icon(
        icon,
        size: _resolveSize(spacing),
        color: _resolveColor(colors),
      ),
    );
  }

  double _resolveSize(ErSpacingTokens spacing) {
    return switch (size) {
      ErIconSize.sm => spacing.inlineGap * 4,
      ErIconSize.md => spacing.inlineGap * 5,
      ErIconSize.lg => spacing.componentGap * 3,
    };
  }

  Color _resolveColor(ErColorTokens colors) {
    return switch (color) {
      ErIconColor.primary => colors.iconPrimary,
      ErIconColor.secondary => colors.iconSecondary,
      ErIconColor.disabled => colors.iconDisabled,
    };
  }
}
