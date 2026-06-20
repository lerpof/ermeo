import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErCard golden', () {
    testWidgets('default and tappable light theme', (tester) async {
      await pumpErWidget(
        tester,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ErCard(
              child: ErText('Static card'),
            ),
            const SizedBox(height: 16),
            ErCard(
              onTap: _noop,
              child: const ErText('Tappable card'),
            ),
          ],
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_card/er_card_light.png'),
      );
    });

    testWidgets('dark theme', (tester) async {
      await pumpErWidgetDark(
        tester,
        const ErCard(
          child: ErText('Dark card'),
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_card/er_card_dark.png'),
      );
    });
  });
}

void _noop() {}
