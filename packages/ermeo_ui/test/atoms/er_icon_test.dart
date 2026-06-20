import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErIcon', () {
    testWidgets('renders icon with default size and color', (tester) async {
      await pumpErWidget(
        tester,
        const ErIcon(Icons.home),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('applies semantic icon sizes', (tester) async {
      late ErSpacingTokens spacing;

      await pumpErWidget(
        tester,
        Builder(
          builder: (context) {
            spacing = context.beSpacing;
            return const ErIcon(Icons.star, size: ErIconSize.lg);
          },
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.star));
      expect(icon.size, spacing.componentGap * 3);
    });

    testWidgets('applies semantic icon colors', (tester) async {
      late ErColorTokens colors;

      await pumpErWidget(
        tester,
        Builder(
          builder: (context) {
            colors = context.beColors;
            return const ErIcon(Icons.star, color: ErIconColor.disabled);
          },
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.star));
      expect(icon.color, colors.iconDisabled);
    });
  });
}
