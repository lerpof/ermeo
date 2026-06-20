import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErTextField', () {
    testWidgets('shows error border when errorText is set', (tester) async {
      await pumpErWidget(
        tester,
        const ErTextField(
          label: 'Email',
          errorText: 'Invalid email',
        ),
      );

      expect(find.text('Invalid email'), findsOneWidget);
    });

    testWidgets('calls onChanged when text changes', (tester) async {
      String? lastValue;

      await pumpErWidget(
        tester,
        ErTextField(
          onChanged: (value) => lastValue = value,
        ),
      );

      await tester.enterText(find.byType(TextField), 'hello');
      expect(lastValue, 'hello');
    });

    testWidgets('does not show error when errorText is empty', (tester) async {
      await pumpErWidget(
        tester,
        const ErTextField(
          label: 'Name',
          errorText: '',
        ),
      );

      final decoration = tester.widget<InputDecorator>(find.byType(InputDecorator));
      expect(decoration.decoration.errorText, isNull);
    });
  });
}
