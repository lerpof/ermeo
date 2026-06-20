import 'package:flutter/material.dart';

import '../../theme/er_semantic_tokens.dart';
import '../../theme/er_theme_context.dart';
import '../atoms/er_button_style.dart';

/// Labelled tab item for [ErTabBar].
class ErTab {
  const ErTab({required this.label});

  final String label;
}

/// Size scale for [ErTabBar], aligned with [ErButtonSize].
enum ErTabBarSize { sm, md, lg }

/// Horizontal pill-tab strip for switching between a small number of views.
///
/// Active tab uses [ErColorTokens.surfaceElevated] fill; unselected tabs are
/// transparent with [ErColorTokens.body] label color.
class ErTabBar extends StatelessWidget {
  const ErTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
    this.size = ErTabBarSize.md,
  }) : assert(tabs.length > 0, 'tabs must not be empty'),
       assert(selectedIndex >= 0, 'selectedIndex must be non-negative');

  final List<ErTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final ErTabBarSize size;

  @override
  Widget build(BuildContext context) {
    assert(
      selectedIndex < tabs.length,
      'selectedIndex must be less than tabs.length',
    );

    final colors = context.beColors;
    final spacing = context.beSpacing;
    final radius = context.beRadius;
    final typography = context.beTypography.textTheme;
    final buttonSize = _buttonSizeForTabBarSize(size);
    final tabHeight = _tabHeightForSize(buttonSize);
    final labelStyle = _labelStyleForSize(buttonSize, typography);
    final tabRadius = BorderRadius.circular(radius.chip);

    return SizedBox(
      height: tabHeight,
      child: Row(
        children: [
          for (var index = 0; index < tabs.length; index++) ...[
            if (index > 0) SizedBox(width: spacing.inlineGap),
            _ErTabCell(
              label: tabs[index].label,
              isSelected: index == selectedIndex,
              onTap: () {
                if (index != selectedIndex) onTabSelected(index);
              },
              labelStyle: labelStyle,
              tabRadius: tabRadius,
              selectedBackgroundColor: colors.surfaceElevated,
              selectedForegroundColor: colors.onDark,
              unselectedForegroundColor: colors.body,
              horizontalPadding: spacing.componentGap + spacing.inlineGap / 2,
            ),
          ],
        ],
      ),
    );
  }

  static ErButtonSize _buttonSizeForTabBarSize(ErTabBarSize size) {
    return switch (size) {
      ErTabBarSize.sm => ErButtonSize.sm,
      ErTabBarSize.md => ErButtonSize.md,
      ErTabBarSize.lg => ErButtonSize.lg,
    };
  }

  static double _tabHeightForSize(ErButtonSize buttonSize) {
    return switch (buttonSize) {
      ErButtonSize.sm => 28,
      ErButtonSize.md => 32,
      ErButtonSize.lg => 36,
    };
  }

  static TextStyle _labelStyleForSize(
    ErButtonSize buttonSize,
    TextTheme typography,
  ) {
    return switch (buttonSize) {
      ErButtonSize.sm => typography.bodySmall!,
      ErButtonSize.md => typography.bodySmall!,
      ErButtonSize.lg => typography.labelLarge!,
    };
  }
}

class _ErTabCell extends StatelessWidget {
  const _ErTabCell({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.labelStyle,
    required this.tabRadius,
    required this.selectedBackgroundColor,
    required this.selectedForegroundColor,
    required this.unselectedForegroundColor,
    required this.horizontalPadding,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final TextStyle labelStyle;
  final BorderRadius tabRadius;
  final Color selectedBackgroundColor;
  final Color selectedForegroundColor;
  final Color unselectedForegroundColor;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = isSelected
        ? selectedForegroundColor
        : unselectedForegroundColor;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: tabRadius,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            decoration: BoxDecoration(
              color: isSelected ? selectedBackgroundColor : Colors.transparent,
              borderRadius: tabRadius,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: labelStyle.copyWith(color: foregroundColor),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
