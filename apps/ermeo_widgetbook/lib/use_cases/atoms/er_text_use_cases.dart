import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Typography', type: ErText, path: '[Atoms]/ErText')
Widget beTextTypography(BuildContext context) {
  return const SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ErText('Display Large', variant: ErTextVariant.displayLarge),
        ErText('Display Medium', variant: ErTextVariant.displayMedium),
        ErText('Display Small', variant: ErTextVariant.displaySmall),
        ErText('Headline Large', variant: ErTextVariant.headlineLarge),
        ErText('Headline Medium', variant: ErTextVariant.headlineMedium),
        ErText('Headline Small', variant: ErTextVariant.headlineSmall),
        ErText('Title Large', variant: ErTextVariant.titleLarge),
        ErText('Title Medium', variant: ErTextVariant.titleMedium),
        ErText('Title Small', variant: ErTextVariant.titleSmall),
        ErText('Body Large', variant: ErTextVariant.bodyLarge),
        ErText('Body Medium', variant: ErTextVariant.bodyMedium),
        ErText('Body Small', variant: ErTextVariant.bodySmall),
        ErText('Label Large', variant: ErTextVariant.labelLarge),
        ErText('Label Medium', variant: ErTextVariant.labelMedium),
        ErText('Label Small', variant: ErTextVariant.labelSmall),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Color roles', type: ErText, path: '[Atoms]/ErText')
Widget beTextColorRoles(BuildContext context) {
  return const SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ErText('Primary', color: ErTextColor.primary),
        ErText('Secondary', color: ErTextColor.secondary),
        ErText('Tertiary', color: ErTextColor.tertiary),
        ErText('Disabled', color: ErTextColor.disabled),
        ErText('Error', color: ErTextColor.error),
        ColoredBox(
          color: Color(0xFF1A1A1A),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ErText('Inverse', color: ErTextColor.inverse),
          ),
        ),
      ],
    ),
  );
}
