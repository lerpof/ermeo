import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeKeycap golden', () {
    testWidgets('default light', (tester) async {
      await pumpBeWidget(
        tester,
        const Row(
          children: [
            BeKeycap(label: '⌘ K'),
            SizedBox(width: 8),
            BeKeycap(label: 'Esc'),
          ],
        ),
      );

      await expectLater(
        find.byType(Row),
        matchesGoldenFile('../goldens/be_keycap/be_keycap_light.png'),
      );
    });
  });
}
