import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_er_widget.dart';

void main() {
  group('ErAppBar', () {
    testWidgets('back button invokes onBack', (tester) async {
      var backPressed = false;

      await pumpErWidget(
        tester,
        Scaffold(
          appBar: ErAppBar(
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
      await pumpErWidget(
        tester,
        Scaffold(
          appBar: const ErAppBar(title: 'Profile'),
          body: const SizedBox.shrink(),
        ),
      );

      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('renders custom title widget', (tester) async {
      await pumpErWidget(
        tester,
        Scaffold(
          appBar: ErAppBar(
            titleWidget: const ErText('Custom', variant: ErTextVariant.titleMedium),
          ),
          body: const SizedBox.shrink(),
        ),
      );

      expect(find.text('Custom'), findsOneWidget);
    });

    testWidgets('renders action widgets', (tester) async {
      await pumpErWidget(
        tester,
        Scaffold(
          appBar: ErAppBar(
            title: 'Home',
            actions: [
              ErButton.icon(icon: Icons.search, onPressed: _noop),
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
