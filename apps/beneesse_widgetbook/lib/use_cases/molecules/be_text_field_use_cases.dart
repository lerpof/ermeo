import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: BeTextField, path: '[Molecules]/BeTextField')
Widget beTextFieldDefault(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: BeTextField(
      label: 'Email',
      hint: 'you@example.com',
      helperText: 'We never share your email',
    ),
  );
}

@widgetbook.UseCase(name: 'With error', type: BeTextField, path: '[Molecules]/BeTextField')
Widget beTextFieldWithError(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: BeTextField(
      label: 'Password',
      errorText: 'Password is required',
      obscureText: true,
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: BeTextField, path: '[Molecules]/BeTextField')
Widget beTextFieldDisabled(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: BeTextField(
      label: 'Username',
      hint: 'Enter username',
      enabled: false,
    ),
  );
}

@widgetbook.UseCase(name: 'Knobs', type: BeTextField, path: '[Molecules]/BeTextField')
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
    child: BeTextField(
      label: label,
      hint: 'you@example.com',
      errorText: errorText,
    ),
  );
}
