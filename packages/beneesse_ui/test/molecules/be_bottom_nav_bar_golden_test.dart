import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden_config.dart';
import '../helpers/pump_be_widget.dart';

void main() {
  group('BeBottomNavBar golden', () {
    testWidgets('three tabs selected index 0 light theme', (tester) async {
      await pumpBeWidget(
        tester,
        BeBottomNavBar(
          selectedIndex: 0,
          onDestinationSelected: (_) {},
          destinations: _destinations,
        ),
        surface: kBeGoldenNavBarSize,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_bottom_nav_bar/be_bottom_nav_bar_selected_light.png'),
      );
    });

    testWidgets('three tabs selected index 1 light theme', (tester) async {
      await pumpBeWidget(
        tester,
        BeBottomNavBar(
          selectedIndex: 1,
          onDestinationSelected: (_) {},
          destinations: _destinations,
        ),
        surface: kBeGoldenNavBarSize,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_bottom_nav_bar/be_bottom_nav_bar_unselected_light.png'),
      );
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
