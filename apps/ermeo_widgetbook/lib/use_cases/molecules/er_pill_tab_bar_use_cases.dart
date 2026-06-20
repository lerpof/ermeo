import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default',
  type: ErPillTabBar,
  path: '[Molecules]/ErPillTabBar',
)
Widget bePillTabBarDefault(BuildContext context) {
  return const Center(child: _ErPillTabBarPreview());
}

@widgetbook.UseCase(name: 'Knobs', type: ErPillTabBar, path: '[Molecules]/ErPillTabBar')
Widget bePillTabBarKnobs(BuildContext context) {
  final tabOne = context.knobs.string(label: 'Tab 1', initialValue: 'All');
  final tabTwo = context.knobs.string(label: 'Tab 2', initialValue: 'Recent');
  final tabThree = context.knobs.string(
    label: 'Tab 3',
    initialValue: 'Popular',
  );

  return Center(
    child: _ErPillTabBarPreview(
      tabs: [tabOne, tabTwo, tabThree],
    ),
  );
}

class _ErPillTabBarPreview extends StatefulWidget {
  const _ErPillTabBarPreview({this.tabs = const ['All', 'Recent', 'Popular']});

  final List<String> tabs;

  @override
  State<_ErPillTabBarPreview> createState() => _ErPillTabBarPreviewState();
}

class _ErPillTabBarPreviewState extends State<_ErPillTabBarPreview> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ErPillTabBar(
      tabs: [
        for (final label in widget.tabs) ErPillTab(label: label),
      ],
      selectedIndex: _selectedIndex,
      onTabSelected: (index) => setState(() => _selectedIndex = index),
    );
  }
}
