import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErKeycap golden', () {
    testWidgets('default light', (tester) async {
      await pumpErWidget(
        tester,
        const Row(
          children: [
            ErKeycap(label: '⌘ K'),
            SizedBox(width: 8),
            ErKeycap(label: 'Esc'),
          ],
        ),
      );

      await expectLater(
        find.byType(Row),
        matchesGoldenFile('../goldens/er_keycap/er_keycap_light.png'),
      );
    });
  });
}
