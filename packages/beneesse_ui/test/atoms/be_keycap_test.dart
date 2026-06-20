import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeKeycap', () {
    testWidgets('renders shortcut label', (tester) async {
      await pumpBeWidget(
        tester,
        const BeKeycap(label: '⌘ K'),
      );

      expect(find.text('⌘ K'), findsOneWidget);
    });
  });
}
