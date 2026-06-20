import 'package:flutter/material.dart';

import '../../theme/be_theme_context.dart';

/// Inline keyboard shortcut glyph with keycap gradient background.
class BeKeycap extends StatelessWidget {
  const BeKeycap({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.beColors;
    final radius = context.beRadius;
    final typography = context.beTypography.textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.button - 4),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.keyBgStart, colors.keyBgEnd],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
        child: Text(
          label,
          style: typography.labelMedium?.copyWith(color: colors.body),
        ),
      ),
    );
  }
}
