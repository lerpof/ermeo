import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErIcon golden', () {
    testWidgets('sizes and colors light theme', (tester) async {
      await pumpErWidget(
        tester,
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ErIcon(Icons.home, size: ErIconSize.sm, color: ErIconColor.primary),
            ErIcon(Icons.home, size: ErIconSize.md, color: ErIconColor.secondary),
            ErIcon(Icons.home, size: ErIconSize.lg, color: ErIconColor.disabled),
          ],
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_icon/er_icon_sizes_colors_light.png'),
      );
    });
  });
}
