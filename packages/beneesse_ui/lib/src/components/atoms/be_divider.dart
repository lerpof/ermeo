import 'package:flutter/material.dart';

import '../../theme/be_theme_context.dart';

/// Horizontal divider styled with semantic divider color and spacing.
class BeDivider extends StatelessWidget {
  BeDivider({super.key, this.indent, this.endIndent, this.thickness = 1});

  final double? indent;
  final double? endIndent;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    final colors = context.beColors;
    final spacing = context.beSpacing;

    return Divider(
      color: colors.divider,
      thickness: thickness,
      indent: indent ?? spacing.inlineGap,
      endIndent: endIndent ?? spacing.inlineGap,
    );
  }
}
