import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void _noop() {}

@widgetbook.UseCase(name: 'Variants', type: ErButton, path: '[Atoms]/ErButton')
Widget beButtonVariants(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final variant in ErButtonVariant.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ErButton(
              label: variant.name,
              variant: variant,
              onPressed: _noop,
            ),
          ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Sizes', type: ErButton, path: '[Atoms]/ErButton')
Widget beButtonSizes(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final size in ErButtonSize.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ErButton(
              label: size.name,
              size: size,
              onPressed: _noop,
            ),
          ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Content modes', type: ErButton, path: '[Atoms]/ErButton')
Widget beButtonContentModes(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ErButton(label: 'Text only', onPressed: _noop),
        const SizedBox(height: 8),
        ErButton(
          label: 'Leading icon',
          icon: Icons.add,
          onPressed: _noop,
        ),
        const SizedBox(height: 8),
        ErButton(
          label: 'Trailing icon',
          icon: Icons.arrow_forward,
          iconPosition: ErButtonIconPosition.trailing,
          onPressed: _noop,
        ),
        const SizedBox(height: 8),
        ErButton.icon(icon: Icons.favorite, onPressed: _noop),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: ErButton, path: '[Atoms]/ErButton')
Widget beButtonDisabled(BuildContext context) {
  return Center(
    child: ErButton(label: 'Disabled', onPressed: null),
  );
}

@widgetbook.UseCase(name: 'Loading', type: ErButton, path: '[Atoms]/ErButton')
Widget beButtonLoading(BuildContext context) {
  return Center(
    child: ErButton(label: 'Loading', isLoading: true, onPressed: _noop),
  );
}

@widgetbook.UseCase(name: 'Knobs', type: ErButton, path: '[Atoms]/ErButton')
Widget beButtonKnobs(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Continue',
  );
  final variant = context.knobs.object.segmented<ErButtonVariant>(
    label: 'Variant',
    initialOption: ErButtonVariant.primary,
    options: ErButtonVariant.values,
    labelBuilder: (value) => value.name,
  );
  final enabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  return Center(
    child: ErButton(
      label: label,
      variant: variant,
      onPressed: enabled ? _noop : null,
    ),
  );
}
