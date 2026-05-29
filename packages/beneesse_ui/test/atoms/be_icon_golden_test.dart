import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeIcon golden', () {
    testWidgets('sizes and colors light theme', (tester) async {
      await pumpBeWidget(
        tester,
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BeIcon(Icons.home, size: BeIconSize.sm, color: BeIconColor.primary),
            BeIcon(Icons.home, size: BeIconSize.md, color: BeIconColor.secondary),
            BeIcon(Icons.home, size: BeIconSize.lg, color: BeIconColor.disabled),
          ],
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_icon/be_icon_sizes_colors_light.png'),
      );
    });
  });
}
