import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeText', () {
    testWidgets('renders text with bodyMedium variant by default', (tester) async {
      await pumpBeWidget(
        tester,
        const BeText('Hello Beneesse'),
      );

      expect(find.text('Hello Beneesse'), findsOneWidget);
    });

    testWidgets('applies variant style from typography tokens', (tester) async {
      late TextStyle? style;

      await pumpBeWidget(
        tester,
        Builder(
          builder: (context) {
            style = context.beTypography.textTheme.headlineLarge;
            return const BeText(
              'Headline',
              variant: BeTextVariant.headlineLarge,
            );
          },
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Headline'));
      expect(textWidget.style?.fontSize, style?.fontSize);
      expect(textWidget.style?.fontWeight, style?.fontWeight);
    });

    testWidgets('applies semantic text colors', (tester) async {
      late BeColorTokens colors;

      await pumpBeWidget(
        tester,
        Builder(
          builder: (context) {
            colors = context.beColors;
            return const BeText(
              'Error text',
              color: BeTextColor.error,
            );
          },
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Error text'));
      expect(textWidget.style?.color, colors.errorPrimary);
    });

    testWidgets('respects maxLines and overflow', (tester) async {
      await pumpBeWidget(
        tester,
        const BeText(
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
