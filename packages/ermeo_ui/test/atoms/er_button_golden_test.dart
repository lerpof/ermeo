import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden_config.dart';
import '../helpers/pump_er_widget.dart';

void main() {
  group('ErButton golden', () {
    testWidgets('variants enabled light theme', (tester) async {
      await pumpErWidget(
        tester,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final variant in ErButtonVariant.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ErButton(
                  label: variant.name,
                  variant: variant,
                  onPressed: () {},
                ),
              ),
          ],
        ),
        surface: const Size(400, 480),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_button/er_button_variants_light.png'),
      );
    });

    testWidgets('sizes light theme', (tester) async {
      await pumpErWidget(
        tester,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final size in ErButtonSize.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ErButton(
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
        matchesGoldenFile('../goldens/er_button/er_button_sizes_light.png'),
      );
    });

    testWidgets('content modes light theme', (tester) async {
      await pumpErWidget(
        tester,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ErButton(label: 'Text only', onPressed: _noop),
            const SizedBox(height: 8),
            ErButton(
              label: 'Leading icon',
              icon: Icons.add,
              onPressed: _noop,
            ),
            const SizedBox(height: 8),
            ErButton(
              label: 'Trailing icon',
              icon: Icons.arrow_forward,
              iconPosition: ErButtonIconPosition.trailing,
              onPressed: _noop,
            ),
            const SizedBox(height: 8),
            ErButton.icon(icon: Icons.favorite, onPressed: _noop),
          ],
        ),
        surface: kBeGoldenSurfaceSizeTall,
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_button/er_button_content_modes_light.png'),
      );
    });

    testWidgets('disabled and loading states', (tester) async {
      await pumpErWidget(
        tester,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ErButton(label: 'Disabled', onPressed: null),
            const SizedBox(height: 8),
            ErButton(label: 'Loading', isLoading: true, onPressed: _noop),
          ],
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_button/er_button_states_light.png'),
      );
    });

    testWidgets('primary variant dark theme', (tester) async {
      await pumpErWidgetDark(
        tester,
        ErButton(label: 'Continue', onPressed: _noop),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_button/er_button_primary_dark.png'),
      );
    });
  });
}

void _noop() {}
