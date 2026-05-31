import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Size and color matrix', type: BeIcon, path: '[Atoms]/BeIcon')
Widget beIconMatrix(BuildContext context) {
  return Center(
    child: Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        const TableRow(
          children: [
            SizedBox(width: 72),
            BeText('sm', variant: BeTextVariant.labelSmall),
            BeText('md', variant: BeTextVariant.labelSmall),
            BeText('lg', variant: BeTextVariant.labelSmall),
          ],
        ),
        for (final color in BeIconColor.values)
          TableRow(
            children: [
              BeText(color.name, variant: BeTextVariant.labelSmall),
              for (final size in BeIconSize.values)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: BeIcon(Icons.home, size: size, color: color),
                ),
            ],
          ),
      ],
    ),
  );
}
