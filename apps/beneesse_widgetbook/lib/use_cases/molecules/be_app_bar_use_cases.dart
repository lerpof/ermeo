import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void _noop() {}

@widgetbook.UseCase(name: 'With back button', type: BeAppBar, path: '[Molecules]/BeAppBar')
Widget beAppBarWithBack(BuildContext context) {
  return Scaffold(
    appBar: BeAppBar(
      title: 'Settings',
      showBackButton: true,
      onBack: _noop,
      actions: [
        BeButton.icon(icon: Icons.search, onPressed: _noop),
      ],
    ),
    body: const SizedBox.shrink(),
  );
}

@widgetbook.UseCase(name: 'Without back button', type: BeAppBar, path: '[Molecules]/BeAppBar')
Widget beAppBarWithoutBack(BuildContext context) {
  return Scaffold(
    appBar: const BeAppBar(title: 'Home'),
    body: const SizedBox.shrink(),
  );
}
