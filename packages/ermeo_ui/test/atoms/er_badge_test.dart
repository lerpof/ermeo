import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErBadge', () {
    testWidgets('renders pro variant label', (tester) async {
      await pumpErWidget(
        tester,
        const ErBadge(label: 'Pro'),
      );

      expect(find.text('Pro'), findsOneWidget);
    });

    testWidgets('renders info variant label', (tester) async {
      await pumpErWidget(
        tester,
        const ErBadge(label: 'New', variant: ErBadgeVariant.info),
      );

      expect(find.text('New'), findsOneWidget);
    });
  });
}
