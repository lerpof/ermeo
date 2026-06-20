import 'package:flutter/material.dart';

import '../../theme/er_theme_context.dart';
import '../atoms/er_button.dart';
import '../atoms/er_button_style.dart';
import '../atoms/er_text.dart';

/// Token-driven app bar with optional back button and actions.
class ErAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ErAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.showBackButton = false,
    this.onBack,
    this.centerTitle,
  }) : assert(
         title != null || titleWidget != null,
         'Either title or titleWidget must be provided',
       );

  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBack;
  final bool? centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colors = context.beColors;

    Widget? resolvedLeading = leading;
    if (resolvedLeading == null && showBackButton && onBack != null) {
      resolvedLeading = ErButton.icon(
        icon: Icons.arrow_back,
        variant: ErButtonVariant.ghost,
        onPressed: onBack,
      );
    }

    final resolvedTitle = titleWidget ??
        ErText(
          title!,
          variant: ErTextVariant.labelLarge,
        );

    return Material(
      elevation: 0,
      color: colors.canvas,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.canvas,
          border: Border(
            bottom: BorderSide(color: colors.hairline),
          ),
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          foregroundColor: colors.ink,
          centerTitle: centerTitle,
          leading: resolvedLeading,
          title: resolvedTitle,
          actions: actions,
        ),
      ),
    );
  }
}
