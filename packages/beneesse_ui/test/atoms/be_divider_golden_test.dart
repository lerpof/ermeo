import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeDivider golden', () {
    testWidgets('light theme', (tester) async {
      await pumpBeWidget(
        tester,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BeText('Above'),
            BeDivider(),
            const BeText('Below'),
          ],
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_divider/be_divider_light.png'),
      );
    });
  });
}
