import 'package:flutter_test/flutter_test.dart';

import 'package:beneesse_mobile/main.dart';

void main() {
  testWidgets('shows app title', (WidgetTester tester) async {
    await tester.pumpWidget(const BeneesseMobileApp());
    expect(find.text('beneesse_mobile'), findsOneWidget);
  });
}
