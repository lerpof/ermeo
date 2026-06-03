import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _authTabs = [
  BeTab(label: 'Log in'),
  BeTab(label: 'Sign up'),
];

@widgetbook.UseCase(
  name: 'Interactive',
  type: BeTabBar,
  path: '[Molecules]/BeTabBar',
)
Widget beTabBarInteractive(BuildContext context) {
  return const _BeTabBarPreview();
}

@widgetbook.UseCase(name: 'Sizes', type: BeTabBar, path: '[Molecules]/BeTabBar')
Widget beTabBarSizes(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final size in BeTabBarSize.values) ...[
          BeTabBar(
            size: size,
            selectedIndex: 0,
            onTabSelected: (_) {},
            tabs: _authTabs,
          ),
          const SizedBox(height: 16),
        ],
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Knobs', type: BeTabBar, path: '[Molecules]/BeTabBar')
Widget beTabBarKnobs(BuildContext context) {
  final firstLabel = context.knobs.string(
    label: 'First tab',
    initialValue: 'Log in',
  );
  final secondLabel = context.knobs.string(
    label: 'Second tab',
    initialValue: 'Sign up',
  );
  final size = context.knobs.object.segmented<BeTabBarSize>(
    label: 'Size',
    initialOption: BeTabBarSize.md,
    options: BeTabBarSize.values,
    labelBuilder: (value) => value.name,
  );
  final selectedIndex = context.knobs.int.slider(
    label: 'Selected index',
    initialValue: 0,
    min: 0,
    max: 1,
  );

  return Center(
    child: BeTabBar(
      size: size,
      selectedIndex: selectedIndex,
      onTabSelected: (_) {},
      tabs: [
        BeTab(label: firstLabel),
        BeTab(label: secondLabel),
      ],
    ),
  );
}

class _BeTabBarPreview extends StatefulWidget {
  const _BeTabBarPreview();

  @override
  State<_BeTabBarPreview> createState() => _BeTabBarPreviewState();
}

class _BeTabBarPreviewState extends State<_BeTabBarPreview> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final spacing = context.beSpacing;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(spacing.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BeTabBar(
              selectedIndex: _selectedIndex,
              onTabSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              tabs: _authTabs,
            ),
            SizedBox(height: spacing.sectionGap),
            BeText(
              _selectedIndex == 0 ? 'Log in form' : 'Sign up form',
              variant: BeTextVariant.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
