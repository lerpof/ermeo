import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: BeKeycap, path: '[Atoms]/BeKeycap')
Widget beKeycapDefault(BuildContext context) {
  return const Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BeKeycap(label: '⌘ K'),
        SizedBox(width: 8),
        BeKeycap(label: '⏎'),
        SizedBox(width: 8),
        BeKeycap(label: 'Esc'),
      ],
    ),
  );
}
