import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeCard', () {
    testWidgets('renders child content', (tester) async {
      await pumpBeWidget(
        tester,
        const BeCard(
          child: BeText('Card content'),
        ),
      );

      expect(find.text('Card content'), findsOneWidget);
    });

    testWidgets('invokes onTap when tapped', (tester) async {
      var tapped = false;

      await pumpBeWidget(
        tester,
        BeCard(
          onTap: () => tapped = true,
          child: const BeText('Tap card'),
        ),
      );

      await tester.tap(find.text('Tap card'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('uses custom padding when provided', (tester) async {
      await pumpBeWidget(
        tester,
        const BeCard(
          padding: EdgeInsets.all(32),
          child: BeText('Padded'),
        ),
      );

      final padding = tester.widget<Padding>(
        find.descendant(
          of: find.byType(BeCard),
          matching: find.byType(Padding),
        ).first,
      );
      expect(padding.padding, const EdgeInsets.all(32));
    });
  });
}
