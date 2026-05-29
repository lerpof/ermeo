import 'package:flutter/material.dart';

import '../../theme/be_theme_context.dart';
import '../atoms/be_button.dart';
import '../atoms/be_button_style.dart';
import '../atoms/be_text.dart';

/// Token-driven app bar with optional back button and actions.
class BeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BeAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.showBackButton = false,
    this.onBack,
    this.centerTitle,
    this.useShadow = false,
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
  final bool useShadow;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colors = context.beColors;
    final shadows = context.beShadows;

    Widget? resolvedLeading = leading;
    if (resolvedLeading == null && showBackButton && onBack != null) {
      resolvedLeading = BeButton.icon(
        icon: Icons.arrow_back,
        variant: BeButtonVariant.ghost,
        onPressed: onBack,
      );
    }

    final resolvedTitle = titleWidget ??
        BeText(
          title!,
          variant: BeTextVariant.titleLarge,
        );

    return Material(
      elevation: useShadow ? 1 : 0,
      shadowColor: colors.overlay.withValues(alpha: 0.1),
      color: colors.surfacePrimary,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          boxShadow: useShadow ? shadows.card : shadows.none,
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          foregroundColor: colors.textPrimary,
          centerTitle: centerTitle,
          leading: resolvedLeading,
          title: resolvedTitle,
          actions: actions,
        ),
      ),
    );
  }
}
