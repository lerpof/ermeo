import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErDivider', () {
    test('default thickness is 1', () {
      final divider = ErDivider();
      expect(divider.thickness, 1);
    });

    testWidgets('renders divider with semantic color', (tester) async {
      late ErColorTokens colors;

      await pumpErWidget(
        tester,
        Builder(
          builder: (context) {
            colors = context.beColors;
            return ErDivider();
          },
        ),
      );

      final divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider.color, colors.divider);
    });

    testWidgets('uses inlineGap for default indents', (tester) async {
      late ErSpacingTokens spacing;

      await pumpErWidget(
        tester,
        Builder(
          builder: (context) {
            spacing = context.beSpacing;
            return ErDivider();
          },
        ),
      );

      final divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider.indent, spacing.inlineGap);
      expect(divider.endIndent, spacing.inlineGap);
    });

    testWidgets('uses custom indent and thickness', (tester) async {
      await pumpErWidget(
        tester,
        ErDivider(
          indent: 16,
          endIndent: 24,
          thickness: 2,
        ),
      );

      final divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider.indent, 16);
      expect(divider.endIndent, 24);
      expect(divider.thickness, 2);
    });
  });
}
