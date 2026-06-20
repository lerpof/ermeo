import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _destinations = [
  ErNavDestination(
    icon: ErIcon(Icons.home_outlined, color: ErIconColor.secondary),
    selectedIcon: ErIcon(Icons.home, color: ErIconColor.primary),
    label: 'Home',
  ),
  ErNavDestination(
    icon: ErIcon(Icons.search_outlined, color: ErIconColor.secondary),
    selectedIcon: ErIcon(Icons.search, color: ErIconColor.primary),
    label: 'Search',
  ),
  ErNavDestination(
    icon: ErIcon(Icons.person_outline, color: ErIconColor.secondary),
    selectedIcon: ErIcon(Icons.person, color: ErIconColor.primary),
    label: 'Profile',
  ),
];

@widgetbook.UseCase(
  name: 'Interactive',
  type: ErBottomNavBar,
  path: '[Molecules]/ErBottomNavBar',
)
Widget beBottomNavBarInteractive(BuildContext context) {
  return const _ErBottomNavBarPreview();
}

class _ErBottomNavBarPreview extends StatefulWidget {
  const _ErBottomNavBarPreview();

  @override
  State<_ErBottomNavBarPreview> createState() => _ErBottomNavBarPreviewState();
}

class _ErBottomNavBarPreviewState extends State<_ErBottomNavBarPreview> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ErText('Tab ${_selectedIndex + 1}'),
      ),
      bottomNavigationBar: ErBottomNavBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: _destinations,
      ),
    );
  }
}
