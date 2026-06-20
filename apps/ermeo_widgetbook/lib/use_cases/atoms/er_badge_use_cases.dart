import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Variants', type: ErBadge, path: '[Atoms]/ErBadge')
Widget beBadgeVariants(BuildContext context) {
  return const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ErBadge(label: 'Pro'),
        SizedBox(height: 8),
        ErBadge(label: 'Beta', variant: ErBadgeVariant.info),
      ],
    ),
  );
}
