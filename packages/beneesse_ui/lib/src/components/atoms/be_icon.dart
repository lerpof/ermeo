import 'package:flutter/material.dart';

import '../../theme/be_semantic_tokens.dart';
import '../../theme/be_theme_context.dart';

/// Semantic icon color roles for [BeIcon].
enum BeIconColor {
  primary,
  secondary,
  disabled,
}

/// Icon size roles for [BeIcon].
enum BeIconSize {
  sm,
  md,
  lg,
}

/// Token-driven icon wrapper with semantic size and color roles.
class BeIcon extends StatelessWidget {
  const BeIcon(
    this.icon, {
    super.key,
    this.size = BeIconSize.md,
    this.color = BeIconColor.primary,
    this.semanticLabel,
  });

  final IconData icon;
  final BeIconSize size;
  final BeIconColor color;
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

  double _resolveSize(BeSpacingTokens spacing) {
    return switch (size) {
      BeIconSize.sm => spacing.inlineGap * 4,
      BeIconSize.md => spacing.inlineGap * 5,
      BeIconSize.lg => spacing.componentGap * 3,
    };
  }

  Color _resolveColor(BeColorTokens colors) {
    return switch (color) {
      BeIconColor.primary => colors.iconPrimary,
      BeIconColor.secondary => colors.iconSecondary,
      BeIconColor.disabled => colors.iconDisabled,
    };
  }
}
