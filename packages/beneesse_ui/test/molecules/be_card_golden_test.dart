import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeCard golden', () {
    testWidgets('default and tappable light theme', (tester) async {
      await pumpBeWidget(
        tester,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BeCard(
              child: BeText('Static card'),
            ),
            const SizedBox(height: 16),
            BeCard(
              onTap: _noop,
              child: const BeText('Tappable card'),
            ),
          ],
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_card/be_card_light.png'),
      );
    });

    testWidgets('dark theme', (tester) async {
      await pumpBeWidgetDark(
        tester,
        const BeCard(
          child: BeText('Dark card'),
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_card/be_card_dark.png'),
      );
    });
  });
}

void _noop() {}
