import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: ErTextField, path: '[Molecules]/ErTextField')
Widget beTextFieldDefault(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: ErTextField(
      label: 'Email',
      hint: 'you@example.com',
      helperText: 'We never share your email',
    ),
  );
}

@widgetbook.UseCase(name: 'With error', type: ErTextField, path: '[Molecules]/ErTextField')
Widget beTextFieldWithError(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: ErTextField(
      label: 'Password',
      errorText: 'Password is required',
      obscureText: true,
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: ErTextField, path: '[Molecules]/ErTextField')
Widget beTextFieldDisabled(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: ErTextField(
      label: 'Username',
      hint: 'Enter username',
      enabled: false,
    ),
  );
}

@widgetbook.UseCase(name: 'Knobs', type: ErTextField, path: '[Molecules]/ErTextField')
Widget beTextFieldKnobs(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Email',
  );
  final errorText = context.knobs.stringOrNull(
    label: 'Error text',
    initialValue: null,
  );

  return Padding(
    padding: const EdgeInsets.all(16),
    child: ErTextField(
      label: label,
      hint: 'you@example.com',
      errorText: errorText,
    ),
  );
}
