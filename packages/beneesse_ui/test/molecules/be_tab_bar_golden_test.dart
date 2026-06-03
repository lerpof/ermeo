import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden_config.dart';
import '../helpers/pump_be_widget.dart';

void main() {
  group('BeTabBar golden', () {
    testWidgets('two tabs selected index 0 light theme', (tester) async {
      await pumpBeWidget(
        tester,
        BeTabBar(
          selectedIndex: 0,
          onTabSelected: (_) {},
          tabs: _tabs,
        ),
        surface: kBeGoldenTabBarSize,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_tab_bar/be_tab_bar_first_selected_light.png'),
      );
    });

    testWidgets('two tabs selected index 1 light theme', (tester) async {
      await pumpBeWidget(
        tester,
        BeTabBar(
          selectedIndex: 1,
          onTabSelected: (_) {},
          tabs: _tabs,
        ),
        surface: kBeGoldenTabBarSize,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_tab_bar/be_tab_bar_second_selected_light.png'),
      );
    });
  });
}

const _tabs = [
  BeTab(label: 'Log in'),
  BeTab(label: 'Sign up'),
];
