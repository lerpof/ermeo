import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden_config.dart';
import '../helpers/pump_be_widget.dart';

void main() {
  group('BeButton golden', () {
    testWidgets('variants enabled light theme', (tester) async {
      await pumpBeWidget(
        tester,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final variant in BeButtonVariant.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: BeButton(
                  label: variant.name,
                  variant: variant,
                  onPressed: () {},
                ),
              ),
          ],
        ),
        surface: kBeGoldenSurfaceSizeTall,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_button/be_button_variants_light.png'),
      );
    });

    testWidgets('sizes light theme', (tester) async {
      await pumpBeWidget(
        tester,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final size in BeButtonSize.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: BeButton(
                  label: size.name,
                  size: size,
                  onPressed: () {},
                ),
              ),
          ],
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_button/be_button_sizes_light.png'),
      );
    });

    testWidgets('content modes light theme', (tester) async {
      await pumpBeWidget(
        tester,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BeButton(label: 'Text only', onPressed: _noop),
            const SizedBox(height: 8),
            BeButton(
              label: 'Leading icon',
              icon: Icons.add,
              onPressed: _noop,
            ),
            const SizedBox(height: 8),
            BeButton(
              label: 'Trailing icon',
              icon: Icons.arrow_forward,
              iconPosition: BeButtonIconPosition.trailing,
              onPressed: _noop,
            ),
            const SizedBox(height: 8),
            BeButton.icon(icon: Icons.favorite, onPressed: _noop),
          ],
        ),
        surface: kBeGoldenSurfaceSizeTall,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_button/be_button_content_modes_light.png'),
      );
    });

    testWidgets('disabled and loading states', (tester) async {
      await pumpBeWidget(
        tester,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BeButton(label: 'Disabled', onPressed: null),
            const SizedBox(height: 8),
            BeButton(label: 'Loading', isLoading: true, onPressed: _noop),
          ],
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_button/be_button_states_light.png'),
      );
    });

    testWidgets('primary variant dark theme', (tester) async {
      await pumpBeWidgetDark(
        tester,
        BeButton(label: 'Continue', onPressed: _noop),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_button/be_button_primary_dark.png'),
      );
    });
  });
}

void _noop() {}
