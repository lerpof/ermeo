import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErText golden', () {
    testWidgets('representative variants light theme', (tester) async {
      await pumpErWidget(
        tester,
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ErText('Display Large', variant: ErTextVariant.displayLarge),
            ErText('Headline Medium', variant: ErTextVariant.headlineMedium),
            ErText('Body Medium', variant: ErTextVariant.bodyMedium),
            ErText('Label Small', variant: ErTextVariant.labelSmall),
            ErText('Secondary color', color: ErTextColor.secondary),
            ErText('Error color', color: ErTextColor.error),
          ],
        ),
        surface: const Size(400, 480),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_text/er_text_variants_light.png'),
      );
    });
  });
}
