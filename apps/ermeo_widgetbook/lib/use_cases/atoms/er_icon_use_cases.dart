import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Size and color matrix', type: ErIcon, path: '[Atoms]/ErIcon')
Widget beIconMatrix(BuildContext context) {
  return Center(
    child: Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        const TableRow(
          children: [
            SizedBox(width: 72),
            ErText('sm', variant: ErTextVariant.labelSmall),
            ErText('md', variant: ErTextVariant.labelSmall),
            ErText('lg', variant: ErTextVariant.labelSmall),
          ],
        ),
        for (final color in ErIconColor.values)
          TableRow(
            children: [
              ErText(color.name, variant: ErTextVariant.labelSmall),
              for (final size in ErIconSize.values)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ErIcon(Icons.home, size: size, color: color),
                ),
            ],
          ),
      ],
    ),
  );
}
