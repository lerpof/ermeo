import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _authTabs = [
  ErTab(label: 'Log in'),
  ErTab(label: 'Sign up'),
];

@widgetbook.UseCase(
  name: 'Interactive',
  type: ErTabBar,
  path: '[Molecules]/ErTabBar',
)
Widget beTabBarInteractive(BuildContext context) {
  return const _ErTabBarPreview();
}

@widgetbook.UseCase(name: 'Sizes', type: ErTabBar, path: '[Molecules]/ErTabBar')
Widget beTabBarSizes(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final size in ErTabBarSize.values) ...[
          ErTabBar(
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

@widgetbook.UseCase(name: 'Knobs', type: ErTabBar, path: '[Molecules]/ErTabBar')
Widget beTabBarKnobs(BuildContext context) {
  final firstLabel = context.knobs.string(
    label: 'First tab',
    initialValue: 'Log in',
  );
  final secondLabel = context.knobs.string(
    label: 'Second tab',
    initialValue: 'Sign up',
  );
  final size = context.knobs.object.segmented<ErTabBarSize>(
    label: 'Size',
    initialOption: ErTabBarSize.md,
    options: ErTabBarSize.values,
    labelBuilder: (value) => value.name,
  );
  final selectedIndex = context.knobs.int.slider(
    label: 'Selected index',
    initialValue: 0,
    min: 0,
    max: 1,
  );

  return Center(
    child: ErTabBar(
      size: size,
      selectedIndex: selectedIndex,
      onTabSelected: (_) {},
      tabs: [
        ErTab(label: firstLabel),
        ErTab(label: secondLabel),
      ],
    ),
  );
}

class _ErTabBarPreview extends StatefulWidget {
  const _ErTabBarPreview();

  @override
  State<_ErTabBarPreview> createState() => _ErTabBarPreviewState();
}

class _ErTabBarPreviewState extends State<_ErTabBarPreview> {
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
            ErTabBar(
              selectedIndex: _selectedIndex,
              onTabSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              tabs: _authTabs,
            ),
            SizedBox(height: spacing.sectionGap),
            ErText(
              _selectedIndex == 0 ? 'Log in form' : 'Sign up form',
              variant: ErTextVariant.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
