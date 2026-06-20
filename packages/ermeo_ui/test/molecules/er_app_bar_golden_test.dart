import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErAppBar golden', () {
    testWidgets('with back button and actions light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ErTheme.light,
          home: Scaffold(
            appBar: ErAppBar(
              title: 'Settings',
              showBackButton: true,
              onBack: () {},
              actions: [
                ErButton.icon(icon: Icons.search, onPressed: _noop),
              ],
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );
      await tester.pump();

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/er_app_bar/er_app_bar_light.png'),
      );
    });
  });
}

void _noop() {}
