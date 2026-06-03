import 'package:beneesse_l10n/beneesse_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BeL10nContext', () {
    testWidgets('context.l10n resolves appTitle when delegates are wired',
        (tester) async {
      late String title;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: beLocalizationDelegates,
          supportedLocales: BeLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              title = context.l10n.appTitle;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(title, 'Beneesse');
    });
  });

  group('beLocalizationDelegates', () {
    test('includes BeLocalizations delegate', () {
      expect(
        beLocalizationDelegates,
        contains(BeLocalizations.delegate),
      );
    });
  });
}
