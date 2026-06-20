import 'package:flutter/material.dart';

import '../../theme/be_theme_context.dart';

/// Size scale for [BeTextField].
enum BeTextFieldSize {
  standard,
  search,
}

/// Token-driven text field with semantic decoration.
class BeTextField extends StatelessWidget {
  const BeTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.size = BeTextFieldSize.standard,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final bool autofocus;
  final int maxLines;
  final BeTextFieldSize size;

  bool get _hasError => errorText != null && errorText!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final colors = context.beColors;
    final spacing = context.beSpacing;

    final verticalPadding = size == BeTextFieldSize.search
        ? spacing.componentGap + spacing.inlineGap / 2
        : spacing.componentGap;
    final horizontalPadding = size == BeTextFieldSize.search
        ? spacing.componentGap * 2
        : spacing.componentGap + spacing.inlineGap;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      enabled: enabled,
      autofocus: autofocus,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: enabled ? colors.onDark : colors.ash,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        errorText: _hasError ? errorText : null,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        isDense: size == BeTextFieldSize.standard,
      ),
    );
  }
}
