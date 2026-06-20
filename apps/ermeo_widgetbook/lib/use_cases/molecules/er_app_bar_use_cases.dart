import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void _noop() {}

@widgetbook.UseCase(name: 'With back button', type: ErAppBar, path: '[Molecules]/ErAppBar')
Widget beAppBarWithBack(BuildContext context) {
  return Scaffold(
    appBar: ErAppBar(
      title: 'Settings',
      showBackButton: true,
      onBack: _noop,
      actions: [
        ErButton.icon(icon: Icons.search, onPressed: _noop),
      ],
    ),
    body: const SizedBox.shrink(),
  );
}

@widgetbook.UseCase(name: 'Without back button', type: ErAppBar, path: '[Molecules]/ErAppBar')
Widget beAppBarWithoutBack(BuildContext context) {
  return Scaffold(
    appBar: const ErAppBar(title: 'Home'),
    body: const SizedBox.shrink(),
  );
}
