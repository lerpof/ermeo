import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BePillTabBar', () {
    testWidgets('invokes onTabSelected when tab is tapped', (tester) async {
      var selectedIndex = 0;

      await pumpBeWidget(
        tester,
        BePillTabBar(
          tabs: const [
            BePillTab(label: 'All'),
            BePillTab(label: 'Recent'),
          ],
          selectedIndex: selectedIndex,
          onTabSelected: (index) => selectedIndex = index,
        ),
      );

      await tester.tap(find.text('Recent'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 1);
    });
  });
}
