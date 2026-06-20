import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeBadge', () {
    testWidgets('renders pro variant label', (tester) async {
      await pumpBeWidget(
        tester,
        const BeBadge(label: 'Pro'),
      );

      expect(find.text('Pro'), findsOneWidget);
    });

    testWidgets('renders info variant label', (tester) async {
      await pumpBeWidget(
        tester,
        const BeBadge(label: 'New', variant: BeBadgeVariant.info),
      );

      expect(find.text('New'), findsOneWidget);
    });
  });
}
