import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: ErKeycap, path: '[Atoms]/ErKeycap')
Widget beKeycapDefault(BuildContext context) {
  return const Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ErKeycap(label: '⌘ K'),
        SizedBox(width: 8),
        ErKeycap(label: '⏎'),
        SizedBox(width: 8),
        ErKeycap(label: 'Esc'),
      ],
    ),
  );
}
