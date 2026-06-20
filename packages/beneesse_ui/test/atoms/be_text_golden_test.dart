import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeText golden', () {
    testWidgets('representative variants light theme', (tester) async {
      await pumpBeWidget(
        tester,
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BeText('Display Large', variant: BeTextVariant.displayLarge),
            BeText('Headline Medium', variant: BeTextVariant.headlineMedium),
            BeText('Body Medium', variant: BeTextVariant.bodyMedium),
            BeText('Label Small', variant: BeTextVariant.labelSmall),
            BeText('Secondary color', color: BeTextColor.secondary),
            BeText('Error color', color: BeTextColor.error),
          ],
        ),
        surface: const Size(400, 480),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_text/be_text_variants_light.png'),
      );
    });
  });
}
