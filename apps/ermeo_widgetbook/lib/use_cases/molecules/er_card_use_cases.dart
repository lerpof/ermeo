import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void _noop() {}

@widgetbook.UseCase(name: 'Default', type: ErCard, path: '[Molecules]/ErCard')
Widget beCardDefault(BuildContext context) {
  return const Center(
    child: ErCard(
      child: ErText('Static card'),
    ),
  );
}

@widgetbook.UseCase(name: 'Tappable', type: ErCard, path: '[Molecules]/ErCard')
Widget beCardTappable(BuildContext context) {
  return Center(
    child: ErCard(
      onTap: _noop,
      child: const ErText('Tappable card'),
    ),
  );
}
