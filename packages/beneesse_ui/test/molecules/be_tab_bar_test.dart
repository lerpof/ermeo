import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeTabBar', () {
    testWidgets('calls onTabSelected when unselected tab tapped', (tester) async {
      int? selected;

      await pumpBeWidget(
        tester,
        BeTabBar(
          selectedIndex: 0,
          onTabSelected: (index) => selected = index,
          tabs: _tabs,
        ),
      );

      await tester.tap(find.text('Sign up'));
      await tester.pumpAndSettle();

      expect(selected, 1);
    });

    testWidgets('does not call onTabSelected when selected tab tapped',
        (tester) async {
      int? selected;

      await pumpBeWidget(
        tester,
        BeTabBar(
          selectedIndex: 0,
          onTabSelected: (index) => selected = index,
          tabs: _tabs,
        ),
      );

      await tester.tap(find.text('Log in'));
      await tester.pumpAndSettle();

      expect(selected, isNull);
    });

    testWidgets('renders all tab labels', (tester) async {
      await pumpBeWidget(
        tester,
        BeTabBar(
          selectedIndex: 0,
          onTabSelected: (_) {},
          tabs: _tabs,
        ),
      );

      expect(find.text('Log in'), findsOneWidget);
      expect(find.text('Sign up'), findsOneWidget);
    });
  });
}

const _tabs = [
  BeTab(label: 'Log in'),
  BeTab(label: 'Sign up'),
];
