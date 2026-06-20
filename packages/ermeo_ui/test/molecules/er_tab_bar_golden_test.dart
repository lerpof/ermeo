import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden_config.dart';
import '../helpers/pump_er_widget.dart';

void main() {
  group('ErTabBar golden', () {
    testWidgets('two tabs selected index 0 light theme', (tester) async {
      await pumpErWidget(
        tester,
        ErTabBar(
          selectedIndex: 0,
          onTabSelected: (_) {},
          tabs: _tabs,
        ),
        surface: kBeGoldenTabBarSize,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_tab_bar/er_tab_bar_first_selected_light.png'),
      );
    });

    testWidgets('two tabs selected index 1 light theme', (tester) async {
      await pumpErWidget(
        tester,
        ErTabBar(
          selectedIndex: 1,
          onTabSelected: (_) {},
          tabs: _tabs,
        ),
        surface: kBeGoldenTabBarSize,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_tab_bar/er_tab_bar_second_selected_light.png'),
      );
    });
  });
}

const _tabs = [
  ErTab(label: 'Log in'),
  ErTab(label: 'Sign up'),
];
