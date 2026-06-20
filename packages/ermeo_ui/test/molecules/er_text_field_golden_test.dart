import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden_config.dart';
import '../helpers/pump_er_widget.dart';

void main() {
  group('ErTextField golden', () {
    testWidgets('default and error states light theme', (tester) async {
      await pumpErWidget(
        tester,
        const Column(
          children: [
            ErTextField(
              label: 'Email',
              hint: 'you@example.com',
              helperText: 'We never share your email',
            ),
            SizedBox(height: 16),
            ErTextField(
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
        matchesGoldenFile('../goldens/er_text_field/er_text_field_light.png'),
      );
    });

    testWidgets('dark theme', (tester) async {
      await pumpErWidgetDark(
        tester,
        const ErTextField(
          label: 'Username',
          hint: 'Enter username',
        ),
        surface: kBeGoldenSurfaceSizeTall,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_text_field/er_text_field_dark.png'),
      );
    });
  });
}
