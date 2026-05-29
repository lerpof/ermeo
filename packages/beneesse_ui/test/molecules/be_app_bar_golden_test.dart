import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BeAppBar golden', () {
    testWidgets('with back button and actions light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: BeTheme.light,
          home: Scaffold(
            appBar: BeAppBar(
              title: 'Settings',
              showBackButton: true,
              onBack: () {},
              actions: [
                BeButton.icon(icon: Icons.search, onPressed: _noop),
              ],
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );
      await tester.pump();

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('../goldens/be_app_bar/be_app_bar_light.png'),
      );
    });
  });
}

void _noop() {}
