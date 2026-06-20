import 'package:flutter/material.dart';

import '../../theme/er_theme_context.dart';

/// Labelled tab item for [ErPillTabBar].
class ErPillTab {
  const ErPillTab({required this.label});

  final String label;
}

/// Horizontal scrollable filter chip strip (`pill-tab` / `pill-tab-active`).
class ErPillTabBar extends StatelessWidget {
  const ErPillTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
  }) : assert(tabs.length > 0, 'tabs must not be empty'),
       assert(selectedIndex >= 0, 'selectedIndex must be non-negative');

  final List<ErPillTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

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
    final labelStyle = typography.bodySmall!;
    final tabRadius = BorderRadius.circular(radius.chip);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var index = 0; index < tabs.length; index++) ...[
            if (index > 0) SizedBox(width: spacing.inlineGap),
            _ErPillTabCell(
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
            ),
          ],
        ],
      ),
    );
  }
}

class _ErPillTabCell extends StatelessWidget {
  const _ErPillTabCell({
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? selectedBackgroundColor : Colors.transparent,
              borderRadius: tabRadius,
            ),
            child: Text(
              label,
              style: labelStyle.copyWith(color: foregroundColor),
            ),
          ),
        ),
      ),
    );
  }
}
