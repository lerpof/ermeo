import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeButton', () {
    testWidgets('invokes onPressed when tapped', (tester) async {
      var tapped = false;

      await pumpBeWidget(
        tester,
        BeButton(
          label: 'Tap me',
          onPressed: () => tapped = true,
        ),
      );

      await tester.tap(find.text('Tap me'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('does not invoke onPressed when disabled', (tester) async {
      var tapped = false;

      await pumpBeWidget(
        tester,
        BeButton(
          label: 'Disabled',
          onPressed: null,
        ),
      );

      await tester.tap(find.text('Disabled'));
      await tester.pumpAndSettle();

      expect(tapped, isFalse);
    });

    testWidgets('does not invoke onPressed when loading', (tester) async {
      var tapped = false;

      await pumpBeWidget(
        tester,
        BeButton(
          label: 'Loading',
          isLoading: true,
          onPressed: () => tapped = true,
        ),
      );

      await tester.tap(find.byType(BeButton));
      await tester.pump();

      expect(tapped, isFalse);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders icon-only button as square', (tester) async {
      await pumpBeWidget(
        tester,
        BeButton.icon(
          icon: Icons.add,
          onPressed: () {},
        ),
      );

      expect(
        find.descendant(
          of: find.byType(BeButton),
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is SizedBox &&
                widget.width == 36 &&
                widget.height == 36,
          ),
        ),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('renders label with leading icon', (tester) async {
      await pumpBeWidget(
        tester,
        BeButton(
          label: 'Save',
          icon: Icons.save,
          onPressed: () {},
        ),
      );

      expect(find.text('Save'), findsOneWidget);
      expect(find.byIcon(Icons.save), findsOneWidget);
    });

    testWidgets('renders label with trailing icon', (tester) async {
      await pumpBeWidget(
        tester,
        BeButton(
          label: 'Next',
          icon: Icons.arrow_forward,
          iconPosition: BeButtonIconPosition.trailing,
          onPressed: () {},
        ),
      );

      expect(find.text('Next'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });
  });
}
