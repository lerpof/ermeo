import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErBadge golden', () {
    testWidgets('variants light', (tester) async {
      await pumpErWidget(
        tester,
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ErBadge(label: 'Pro'),
            SizedBox(height: 8),
            ErBadge(label: 'Beta', variant: ErBadgeVariant.info),
          ],
        ),
      );

      await expectLater(
        find.byType(Column),
        matchesGoldenFile('../goldens/er_badge/er_badge_variants_light.png'),
      );
    });
  });
}
