import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeTextField', () {
    testWidgets('shows error border when errorText is set', (tester) async {
      await pumpBeWidget(
        tester,
        const BeTextField(
          label: 'Email',
          errorText: 'Invalid email',
        ),
      );

      expect(find.text('Invalid email'), findsOneWidget);
    });

    testWidgets('calls onChanged when text changes', (tester) async {
      String? lastValue;

      await pumpBeWidget(
        tester,
        BeTextField(
          onChanged: (value) => lastValue = value,
        ),
      );

      await tester.enterText(find.byType(TextField), 'hello');
      expect(lastValue, 'hello');
    });

    testWidgets('does not show error when errorText is empty', (tester) async {
      await pumpBeWidget(
        tester,
        const BeTextField(
          label: 'Name',
          errorText: '',
        ),
      );

      final decoration = tester.widget<InputDecorator>(find.byType(InputDecorator));
      expect(decoration.decoration.errorText, isNull);
    });
  });
}
