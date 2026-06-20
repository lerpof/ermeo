import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErKeycap', () {
    testWidgets('renders shortcut label', (tester) async {
      await pumpErWidget(
        tester,
        const ErKeycap(label: '⌘ K'),
      );

      expect(find.text('⌘ K'), findsOneWidget);
    });
  });
}
