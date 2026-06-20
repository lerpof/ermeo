import 'package:ermeo_l10n/ermeo_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErL10nContext', () {
    testWidgets('context.l10n resolves appTitle when delegates are wired',
        (tester) async {
      late String title;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: erLocalizationDelegates,
          supportedLocales: ErLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              title = context.l10n.appTitle;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(title, 'Ermeo');
    });
  });

  group('erLocalizationDelegates', () {
    test('includes ErLocalizations delegate', () {
      expect(
        erLocalizationDelegates,
        contains(ErLocalizations.delegate),
      );
    });
  });
}
