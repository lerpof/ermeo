import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeIcon', () {
    testWidgets('renders icon with default size and color', (tester) async {
      await pumpBeWidget(
        tester,
        const BeIcon(Icons.home),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('applies semantic icon sizes', (tester) async {
      late BeSpacingTokens spacing;

      await pumpBeWidget(
        tester,
        Builder(
          builder: (context) {
            spacing = context.beSpacing;
            return const BeIcon(Icons.star, size: BeIconSize.lg);
          },
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.star));
      expect(icon.size, spacing.componentGap * 3);
    });

    testWidgets('applies semantic icon colors', (tester) async {
      late BeColorTokens colors;

      await pumpBeWidget(
        tester,
        Builder(
          builder: (context) {
            colors = context.beColors;
            return const BeIcon(Icons.star, color: BeIconColor.disabled);
          },
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.star));
      expect(icon.color, colors.iconDisabled);
    });
  });
}
