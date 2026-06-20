import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErText', () {
    testWidgets('renders text with bodyMedium variant by default', (tester) async {
      await pumpErWidget(
        tester,
        const ErText('Hello Ermeo'),
      );

      expect(find.text('Hello Ermeo'), findsOneWidget);
    });

    testWidgets('applies variant style from typography tokens', (tester) async {
      late TextStyle? style;

      await pumpErWidget(
        tester,
        Builder(
          builder: (context) {
            style = context.beTypography.textTheme.headlineLarge;
            return const ErText(
              'Headline',
              variant: ErTextVariant.headlineLarge,
            );
          },
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Headline'));
      expect(textWidget.style?.fontSize, style?.fontSize);
      expect(textWidget.style?.fontWeight, style?.fontWeight);
    });

    testWidgets('applies semantic text colors', (tester) async {
      late ErColorTokens colors;

      await pumpErWidget(
        tester,
        Builder(
          builder: (context) {
            colors = context.beColors;
            return const ErText(
              'Error text',
              color: ErTextColor.error,
            );
          },
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Error text'));
      expect(textWidget.style?.color, colors.errorPrimary);
    });

    testWidgets('respects maxLines and overflow', (tester) async {
      await pumpErWidget(
        tester,
        const ErText(
          'Long text',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Long text'));
      expect(textWidget.maxLines, 1);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });
  });
}
