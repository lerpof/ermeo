import 'package:flutter/material.dart';

import '../../theme/be_semantic_tokens.dart';
import '../../theme/be_theme_context.dart';
import '../atoms/be_button_style.dart';

/// Labelled tab item for [BeTabBar].
class BeTab {
  const BeTab({required this.label});

  final String label;
}

/// Size scale for [BeTabBar], aligned with [BeButtonSize].
enum BeTabBarSize { sm, md, lg }

/// Horizontal segmented tab bar for switching between a small number of views.
///
/// Selected tab uses brand primary fill; unselected tabs are transparent with
/// brand primary label color, matching [BeButton] primary / ghost pairing.
class BeTabBar extends StatelessWidget {
  const BeTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
    this.size = BeTabBarSize.md,
  }) : assert(tabs.length > 0, 'tabs must not be empty'),
       assert(selectedIndex >= 0, 'selectedIndex must be non-negative');

  final List<BeTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final BeTabBarSize size;

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
    final tabHeight = _tabHeightForSize(buttonSize, spacing);
    final labelStyle = _labelStyleForSize(buttonSize, typography);
    final trackPadding = spacing.inlineGap / 2;
    final tabRadius = BorderRadius.circular(radius.button - trackPadding);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(radius.button),
      ),
      child: Padding(
        padding: EdgeInsets.all(trackPadding),
        child: SizedBox(
          height: tabHeight,
          child: Row(
            children: [
              for (var index = 0; index < tabs.length; index++)
                Expanded(
                  child: _BeTabCell(
                    label: tabs[index].label,
                    isSelected: index == selectedIndex,
                    onTap: () {
                      if (index != selectedIndex) {
                        onTabSelected(index);
                      }
                    },
                    labelStyle: labelStyle,
                    tabRadius: tabRadius,
                    selectedBackgroundColor: colors.brandPrimary,
                    selectedForegroundColor: colors.brandOnPrimary,
                    unselectedForegroundColor: colors.brandPrimary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  static BeButtonSize _buttonSizeForTabBarSize(BeTabBarSize size) {
    return switch (size) {
      BeTabBarSize.sm => BeButtonSize.sm,
      BeTabBarSize.md => BeButtonSize.md,
      BeTabBarSize.lg => BeButtonSize.lg,
    };
  }

  static double _tabHeightForSize(
    BeButtonSize buttonSize,
    BeSpacingTokens spacing,
  ) {
    return switch (buttonSize) {
      BeButtonSize.sm => spacing.componentGap * 4,
      BeButtonSize.md => spacing.componentGap * 5,
      BeButtonSize.lg => spacing.componentGap * 6,
    };
  }

  static TextStyle _labelStyleForSize(
    BeButtonSize buttonSize,
    TextTheme typography,
  ) {
    return switch (buttonSize) {
      BeButtonSize.sm => typography.labelMedium!,
      BeButtonSize.md => typography.labelLarge!,
      BeButtonSize.lg => typography.titleSmall!,
    };
  }
}

class _BeTabCell extends StatelessWidget {
  const _BeTabCell({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.labelStyle,
    required this.tabRadius,
    required this.selectedBackgroundColor,
    required this.selectedForegroundColor,
    required this.unselectedForegroundColor,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final TextStyle labelStyle;
  final BorderRadius tabRadius;
  final Color selectedBackgroundColor;
  final Color selectedForegroundColor;
  final Color unselectedForegroundColor;

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
