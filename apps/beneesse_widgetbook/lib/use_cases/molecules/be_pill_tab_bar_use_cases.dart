import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default',
  type: BePillTabBar,
  path: '[Molecules]/BePillTabBar',
)
Widget bePillTabBarDefault(BuildContext context) {
  return const Center(child: _BePillTabBarPreview());
}

@widgetbook.UseCase(name: 'Knobs', type: BePillTabBar, path: '[Molecules]/BePillTabBar')
Widget bePillTabBarKnobs(BuildContext context) {
  final tabOne = context.knobs.string(label: 'Tab 1', initialValue: 'All');
  final tabTwo = context.knobs.string(label: 'Tab 2', initialValue: 'Recent');
  final tabThree = context.knobs.string(
    label: 'Tab 3',
    initialValue: 'Popular',
  );

  return Center(
    child: _BePillTabBarPreview(
      tabs: [tabOne, tabTwo, tabThree],
    ),
  );
}

class _BePillTabBarPreview extends StatefulWidget {
  const _BePillTabBarPreview({this.tabs = const ['All', 'Recent', 'Popular']});

  final List<String> tabs;

  @override
  State<_BePillTabBarPreview> createState() => _BePillTabBarPreviewState();
}

class _BePillTabBarPreviewState extends State<_BePillTabBarPreview> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BePillTabBar(
      tabs: [
        for (final label in widget.tabs) BePillTab(label: label),
      ],
      selectedIndex: _selectedIndex,
      onTabSelected: (index) => setState(() => _selectedIndex = index),
    );
  }
}
