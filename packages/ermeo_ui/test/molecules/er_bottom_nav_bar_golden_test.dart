import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden_config.dart';
import '../helpers/pump_er_widget.dart';

void main() {
  group('ErBottomNavBar golden', () {
    testWidgets('three tabs selected index 0 light theme', (tester) async {
      await pumpErWidget(
        tester,
        ErBottomNavBar(
          selectedIndex: 0,
          onDestinationSelected: (_) {},
          destinations: _destinations,
        ),
        surface: kBeGoldenNavBarSize,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_bottom_nav_bar/er_bottom_nav_bar_selected_light.png'),
      );
    });

    testWidgets('three tabs selected index 1 light theme', (tester) async {
      await pumpErWidget(
        tester,
        ErBottomNavBar(
          selectedIndex: 1,
          onDestinationSelected: (_) {},
          destinations: _destinations,
        ),
        surface: kBeGoldenNavBarSize,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_bottom_nav_bar/er_bottom_nav_bar_unselected_light.png'),
      );
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
