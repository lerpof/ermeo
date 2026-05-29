import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden_config.dart';
import '../helpers/pump_be_widget.dart';

void main() {
  group('BeTextField golden', () {
    testWidgets('default and error states light theme', (tester) async {
      await pumpBeWidget(
        tester,
        const Column(
          children: [
            BeTextField(
              label: 'Email',
              hint: 'you@example.com',
              helperText: 'We never share your email',
            ),
            SizedBox(height: 16),
            BeTextField(
              label: 'Password',
              errorText: 'Password is required',
              obscureText: true,
            ),
          ],
        ),
        surface: kBeGoldenSurfaceSizeTall,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_text_field/be_text_field_light.png'),
      );
    });

    testWidgets('dark theme', (tester) async {
      await pumpBeWidgetDark(
        tester,
        const BeTextField(
          label: 'Username',
          hint: 'Enter username',
        ),
        surface: kBeGoldenSurfaceSizeTall,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_text_field/be_text_field_dark.png'),
      );
    });
  });
}
