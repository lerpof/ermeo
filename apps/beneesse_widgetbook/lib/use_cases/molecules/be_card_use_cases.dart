import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void _noop() {}

@widgetbook.UseCase(name: 'Default', type: BeCard, path: '[Molecules]/BeCard')
Widget beCardDefault(BuildContext context) {
  return const Center(
    child: BeCard(
      child: BeText('Static card'),
    ),
  );
}

@widgetbook.UseCase(name: 'Tappable', type: BeCard, path: '[Molecules]/BeCard')
Widget beCardTappable(BuildContext context) {
  return Center(
    child: BeCard(
      onTap: _noop,
      child: const BeText('Tappable card'),
    ),
  );
}
