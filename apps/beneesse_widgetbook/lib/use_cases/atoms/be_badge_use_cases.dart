import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Variants', type: BeBadge, path: '[Atoms]/BeBadge')
Widget beBadgeVariants(BuildContext context) {
  return const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BeBadge(label: 'Pro'),
        SizedBox(height: 8),
        BeBadge(label: 'Beta', variant: BeBadgeVariant.info),
      ],
    ),
  );
}
