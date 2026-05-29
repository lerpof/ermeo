import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_be_widget.dart';

void main() {
  group('BeAppBar', () {
    testWidgets('back button invokes onBack', (tester) async {
      var backPressed = false;

      await pumpBeWidget(
        tester,
        Scaffold(
          appBar: BeAppBar(
            title: 'Settings',
            showBackButton: true,
            onBack: () => backPressed = true,
          ),
          body: const SizedBox.shrink(),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(backPressed, isTrue);
    });

    testWidgets('renders title text', (tester) async {
      await pumpBeWidget(
        tester,
        Scaffold(
          appBar: const BeAppBar(title: 'Profile'),
          body: const SizedBox.shrink(),
        ),
      );

      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('renders custom title widget', (tester) async {
      await pumpBeWidget(
        tester,
        Scaffold(
          appBar: BeAppBar(
            titleWidget: const BeText('Custom', variant: BeTextVariant.titleMedium),
          ),
          body: const SizedBox.shrink(),
        ),
      );

      expect(find.text('Custom'), findsOneWidget);
    });

    testWidgets('renders action widgets', (tester) async {
      await pumpBeWidget(
        tester,
        Scaffold(
          appBar: BeAppBar(
            title: 'Home',
            actions: [
              BeButton.icon(icon: Icons.search, onPressed: _noop),
            ],
          ),
          body: const SizedBox.shrink(),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
    });
  });
}

void _noop() {}
