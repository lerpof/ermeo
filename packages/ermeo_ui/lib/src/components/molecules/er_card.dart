import 'package:flutter/material.dart';

import '../../theme/er_theme_context.dart';

/// Elevated surface card with optional tap handling.
class ErCard extends StatelessWidget {
  const ErCard({
    required this.child,
    super.key,
    this.padding,
    this.onTap,
    this.elevated = false,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  /// When true, uses [ErColorTokens.surfaceElevated] instead of [surface].
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final colors = context.beColors;
    final spacing = context.beSpacing;
    final radius = context.beRadius;

    final borderRadius = BorderRadius.circular(radius.card);
    final resolvedPadding = padding ?? EdgeInsets.all(spacing.pagePadding);
    final backgroundColor = elevated ? colors.surfaceElevated : colors.surface;

    final content = Padding(
      padding: resolvedPadding,
      child: child,
    );

    final shape = RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: BorderSide(color: colors.hairline),
    );

    if (onTap == null) {
      return Material(
        color: backgroundColor,
        elevation: 0,
        shape: shape,
        child: content,
      );
    }

    return Material(
      color: backgroundColor,
      elevation: 0,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: content,
      ),
    );
  }
}
