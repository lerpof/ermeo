import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: ErDivider, path: '[Atoms]/ErDivider')
Widget beDividerDefault(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ErText('Above'),
        ErDivider(),
        const ErText('Below'),
      ],
    ),
  );
}
