import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void _noop() {}

@widgetbook.UseCase(name: 'Variants', type: BeButton, path: '[Atoms]/BeButton')
Widget beButtonVariants(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final variant in BeButtonVariant.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: BeButton(
              label: variant.name,
              variant: variant,
              onPressed: _noop,
            ),
          ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Sizes', type: BeButton, path: '[Atoms]/BeButton')
Widget beButtonSizes(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final size in BeButtonSize.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: BeButton(
              label: size.name,
              size: size,
              onPressed: _noop,
            ),
          ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Content modes', type: BeButton, path: '[Atoms]/BeButton')
Widget beButtonContentModes(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BeButton(label: 'Text only', onPressed: _noop),
        const SizedBox(height: 8),
        BeButton(
          label: 'Leading icon',
          icon: Icons.add,
          onPressed: _noop,
        ),
        const SizedBox(height: 8),
        BeButton(
          label: 'Trailing icon',
          icon: Icons.arrow_forward,
          iconPosition: BeButtonIconPosition.trailing,
          onPressed: _noop,
        ),
        const SizedBox(height: 8),
        BeButton.icon(icon: Icons.favorite, onPressed: _noop),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: BeButton, path: '[Atoms]/BeButton')
Widget beButtonDisabled(BuildContext context) {
  return Center(
    child: BeButton(label: 'Disabled', onPressed: null),
  );
}

@widgetbook.UseCase(name: 'Loading', type: BeButton, path: '[Atoms]/BeButton')
Widget beButtonLoading(BuildContext context) {
  return Center(
    child: BeButton(label: 'Loading', isLoading: true, onPressed: _noop),
  );
}

@widgetbook.UseCase(name: 'Knobs', type: BeButton, path: '[Atoms]/BeButton')
Widget beButtonKnobs(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Continue',
  );
  final variant = context.knobs.object.segmented<BeButtonVariant>(
    label: 'Variant',
    initialOption: BeButtonVariant.primary,
    options: BeButtonVariant.values,
    labelBuilder: (value) => value.name,
  );
  final enabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  return Center(
    child: BeButton(
      label: label,
      variant: variant,
      onPressed: enabled ? _noop : null,
    ),
  );
}
