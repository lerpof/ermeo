import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Typography', type: BeText, path: '[Atoms]/BeText')
Widget beTextTypography(BuildContext context) {
  return const SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BeText('Display Large', variant: BeTextVariant.displayLarge),
        BeText('Display Medium', variant: BeTextVariant.displayMedium),
        BeText('Display Small', variant: BeTextVariant.displaySmall),
        BeText('Headline Large', variant: BeTextVariant.headlineLarge),
        BeText('Headline Medium', variant: BeTextVariant.headlineMedium),
        BeText('Headline Small', variant: BeTextVariant.headlineSmall),
        BeText('Title Large', variant: BeTextVariant.titleLarge),
        BeText('Title Medium', variant: BeTextVariant.titleMedium),
        BeText('Title Small', variant: BeTextVariant.titleSmall),
        BeText('Body Large', variant: BeTextVariant.bodyLarge),
        BeText('Body Medium', variant: BeTextVariant.bodyMedium),
        BeText('Body Small', variant: BeTextVariant.bodySmall),
        BeText('Label Large', variant: BeTextVariant.labelLarge),
        BeText('Label Medium', variant: BeTextVariant.labelMedium),
        BeText('Label Small', variant: BeTextVariant.labelSmall),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Color roles', type: BeText, path: '[Atoms]/BeText')
Widget beTextColorRoles(BuildContext context) {
  return const SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BeText('Primary', color: BeTextColor.primary),
        BeText('Secondary', color: BeTextColor.secondary),
        BeText('Tertiary', color: BeTextColor.tertiary),
        BeText('Disabled', color: BeTextColor.disabled),
        BeText('Error', color: BeTextColor.error),
        ColoredBox(
          color: Color(0xFF1A1A1A),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: BeText('Inverse', color: BeTextColor.inverse),
          ),
        ),
      ],
    ),
  );
}
