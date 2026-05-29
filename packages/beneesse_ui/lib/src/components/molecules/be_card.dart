import 'package:flutter/material.dart';

import '../../theme/be_theme_context.dart';

/// Elevated surface card with optional tap handling.
class BeCard extends StatelessWidget {
  const BeCard({
    required this.child,
    super.key,
    this.padding,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.beColors;
    final spacing = context.beSpacing;
    final radius = context.beRadius;
    final shadows = context.beShadows;

    final borderRadius = BorderRadius.circular(radius.card);
    final resolvedPadding = padding ?? EdgeInsets.all(spacing.pagePadding);

    final content = Padding(
      padding: resolvedPadding,
      child: child,
    );

    if (onTap == null) {
      return Material(
        color: colors.surfaceElevated,
        elevation: 0,
        shadowColor: colors.overlay.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: shadows.card,
          ),
          child: content,
        ),
      );
    }

    return Material(
      color: colors.surfaceElevated,
      elevation: 0,
      shadowColor: colors.overlay.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: shadows.card,
          ),
          child: content,
        ),
      ),
    );
  }
}
