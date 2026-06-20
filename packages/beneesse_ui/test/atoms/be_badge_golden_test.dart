import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeBadge golden', () {
    testWidgets('variants light', (tester) async {
      await pumpBeWidget(
        tester,
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BeBadge(label: 'Pro'),
            SizedBox(height: 8),
            BeBadge(label: 'Beta', variant: BeBadgeVariant.info),
          ],
        ),
      );

      await expectLater(
        find.byType(Column),
        matchesGoldenFile('../goldens/be_badge/be_badge_variants_light.png'),
      );
    });
  });
}
