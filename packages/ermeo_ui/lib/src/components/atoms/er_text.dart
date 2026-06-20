import 'package:flutter/material.dart';

import '../../theme/er_semantic_tokens.dart';
import '../../theme/er_theme_context.dart';

/// Semantic text color roles for [ErText].
enum ErTextColor {
  primary,
  secondary,
  tertiary,
  disabled,
  inverse,
  onDark,
  onDarkMute,
  error,
}

/// Typography scale roles for [ErText].
enum ErTextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

/// Token-driven text widget mapping semantic roles to [TextTheme] styles.
class ErText extends StatelessWidget {
  const ErText(
    this.text, {
    super.key,
    this.variant = ErTextVariant.bodyMedium,
    this.color = ErTextColor.primary,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
  });

  final String text;
  final ErTextVariant variant;
  final ErTextColor color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.beColors;
    final typography = context.beTypography.textTheme;

    final style = _resolveVariant(typography).copyWith(
      color: _resolveColor(colors),
    );

    return Semantics(
      label: semanticsLabel,
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }

  TextStyle _resolveVariant(TextTheme theme) {
    return switch (variant) {
      ErTextVariant.displayLarge => theme.displayLarge!,
      ErTextVariant.displayMedium => theme.displayMedium!,
      ErTextVariant.displaySmall => theme.displaySmall!,
      ErTextVariant.headlineLarge => theme.headlineLarge!,
      ErTextVariant.headlineMedium => theme.headlineMedium!,
      ErTextVariant.headlineSmall => theme.headlineSmall!,
      ErTextVariant.titleLarge => theme.titleLarge!,
      ErTextVariant.titleMedium => theme.titleMedium!,
      ErTextVariant.titleSmall => theme.titleSmall!,
      ErTextVariant.bodyLarge => theme.bodyLarge!,
      ErTextVariant.bodyMedium => theme.bodyMedium!,
      ErTextVariant.bodySmall => theme.bodySmall!,
      ErTextVariant.labelLarge => theme.labelLarge!,
      ErTextVariant.labelMedium => theme.labelMedium!,
      ErTextVariant.labelSmall => theme.labelSmall!,
    };
  }

  Color _resolveColor(ErColorTokens colors) {
    return switch (color) {
      ErTextColor.primary => colors.textPrimary,
      ErTextColor.secondary => colors.textSecondary,
      ErTextColor.tertiary => colors.textTertiary,
      ErTextColor.disabled => colors.textDisabled,
      ErTextColor.inverse => colors.textInverse,
      ErTextColor.onDark => colors.onDark,
      ErTextColor.onDarkMute => colors.onDarkMute,
      ErTextColor.error => colors.errorPrimary,
    };
  }
}
