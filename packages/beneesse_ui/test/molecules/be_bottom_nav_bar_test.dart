import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeBottomNavBar', () {
    testWidgets('calls onDestinationSelected when tab tapped', (tester) async {
      int? selected;

      await pumpBeWidget(
        tester,
        BeBottomNavBar(
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
      await pumpBeWidget(
        tester,
        BeBottomNavBar(
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
