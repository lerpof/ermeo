import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErBottomNavBar', () {
    testWidgets('calls onDestinationSelected when tab tapped', (tester) async {
      int? selected;

      await pumpErWidget(
        tester,
        ErBottomNavBar(
          selectedIndex: 0,
          onDestinationSelected: (index) => selected = index,
          destinations: _destinations,
        ),
      );

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(selected, 1);
    });

    testWidgets('renders all destination labels', (tester) async {
      await pumpErWidget(
        tester,
        ErBottomNavBar(
          selectedIndex: 0,
          onDestinationSelected: (_) {},
          destinations: _destinations,
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });
  });
}

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
