import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: BeDivider, path: '[Atoms]/BeDivider')
Widget beDividerDefault(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BeText('Above'),
        BeDivider(),
        const BeText('Below'),
      ],
    ),
  );
}
