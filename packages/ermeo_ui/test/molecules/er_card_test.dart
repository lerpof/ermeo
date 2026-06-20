import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErCard', () {
    testWidgets('renders child content', (tester) async {
      await pumpErWidget(
        tester,
        const ErCard(
          child: ErText('Card content'),
        ),
      );

      expect(find.text('Card content'), findsOneWidget);
    });

    testWidgets('invokes onTap when tapped', (tester) async {
      var tapped = false;

      await pumpErWidget(
        tester,
        ErCard(
          onTap: () => tapped = true,
          child: const ErText('Tap card'),
        ),
      );

      await tester.tap(find.text('Tap card'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('uses custom padding when provided', (tester) async {
      await pumpErWidget(
        tester,
        const ErCard(
          padding: EdgeInsets.all(32),
          child: ErText('Padded'),
        ),
      );

      final padding = tester.widget<Padding>(
        find.descendant(
          of: find.byType(ErCard),
          matching: find.byType(Padding),
        ).first,
      );
      expect(padding.padding, const EdgeInsets.all(32));
    });
  });
}
