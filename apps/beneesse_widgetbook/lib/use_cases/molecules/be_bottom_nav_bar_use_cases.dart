import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _destinations = [
  BeNavDestination(
    icon: BeIcon(Icons.home_outlined, color: BeIconColor.secondary),
    selectedIcon: BeIcon(Icons.home, color: BeIconColor.primary),
    label: 'Home',
  ),
  BeNavDestination(
    icon: BeIcon(Icons.search_outlined, color: BeIconColor.secondary),
    selectedIcon: BeIcon(Icons.search, color: BeIconColor.primary),
    label: 'Search',
  ),
  BeNavDestination(
    icon: BeIcon(Icons.person_outline, color: BeIconColor.secondary),
    selectedIcon: BeIcon(Icons.person, color: BeIconColor.primary),
    label: 'Profile',
  ),
];

@widgetbook.UseCase(
  name: 'Interactive',
  type: BeBottomNavBar,
  path: '[Molecules]/BeBottomNavBar',
)
Widget beBottomNavBarInteractive(BuildContext context) {
  return const _BeBottomNavBarPreview();
}

class _BeBottomNavBarPreview extends StatefulWidget {
  const _BeBottomNavBarPreview();

  @override
  State<_BeBottomNavBarPreview> createState() => _BeBottomNavBarPreviewState();
}

class _BeBottomNavBarPreviewState extends State<_BeBottomNavBarPreview> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BeText('Tab ${_selectedIndex + 1}'),
      ),
      bottomNavigationBar: BeBottomNavBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: _destinations,
      ),
    );
  }
}
