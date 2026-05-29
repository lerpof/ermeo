import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeDivider', () {
    test('default thickness is 1', () {
      final divider = BeDivider();
      expect(divider.thickness, 1);
    });

    testWidgets('renders divider with semantic color', (tester) async {
      late BeColorTokens colors;

      await pumpBeWidget(
        tester,
        Builder(
          builder: (context) {
            colors = context.beColors;
            return BeDivider();
          },
        ),
      );

      final divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider.color, colors.divider);
    });

    testWidgets('uses inlineGap for default indents', (tester) async {
      late BeSpacingTokens spacing;

      await pumpBeWidget(
        tester,
        Builder(
          builder: (context) {
            spacing = context.beSpacing;
            return BeDivider();
          },
        ),
      );

      final divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider.indent, spacing.inlineGap);
      expect(divider.endIndent, spacing.inlineGap);
    });

    testWidgets('uses custom indent and thickness', (tester) async {
      await pumpBeWidget(
        tester,
        BeDivider(
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
