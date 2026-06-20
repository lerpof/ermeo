import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErPillTabBar', () {
    testWidgets('invokes onTabSelected when tab is tapped', (tester) async {
      var selectedIndex = 0;

      await pumpErWidget(
        tester,
        ErPillTabBar(
          tabs: const [
            ErPillTab(label: 'All'),
            ErPillTab(label: 'Recent'),
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
