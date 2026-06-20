import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErDivider golden', () {
    testWidgets('light theme', (tester) async {
      await pumpErWidget(
        tester,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ErText('Above'),
            ErDivider(),
            const ErText('Below'),
          ],
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_divider/er_divider_light.png'),
      );
    });
  });
}
