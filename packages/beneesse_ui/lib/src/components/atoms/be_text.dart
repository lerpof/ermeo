import 'package:flutter/material.dart';

import '../../theme/be_semantic_tokens.dart';
import '../../theme/be_theme_context.dart';

/// Semantic text color roles for [BeText].
enum BeTextColor {
  primary,
  secondary,
  tertiary,
  disabled,
  inverse,
  error,
}

/// Typography scale roles for [BeText].
enum BeTextVariant {
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
class BeText extends StatelessWidget {
  const BeText(
    this.text, {
    super.key,
    this.variant = BeTextVariant.bodyMedium,
    this.color = BeTextColor.primary,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
  });

  final String text;
  final BeTextVariant variant;
  final BeTextColor color;
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
      BeTextVariant.displayLarge => theme.displayLarge!,
      BeTextVariant.displayMedium => theme.displayMedium!,
      BeTextVariant.displaySmall => theme.displaySmall!,
      BeTextVariant.headlineLarge => theme.headlineLarge!,
      BeTextVariant.headlineMedium => theme.headlineMedium!,
      BeTextVariant.headlineSmall => theme.headlineSmall!,
      BeTextVariant.titleLarge => theme.titleLarge!,
      BeTextVariant.titleMedium => theme.titleMedium!,
      BeTextVariant.titleSmall => theme.titleSmall!,
      BeTextVariant.bodyLarge => theme.bodyLarge!,
      BeTextVariant.bodyMedium => theme.bodyMedium!,
      BeTextVariant.bodySmall => theme.bodySmall!,
      BeTextVariant.labelLarge => theme.labelLarge!,
      BeTextVariant.labelMedium => theme.labelMedium!,
      BeTextVariant.labelSmall => theme.labelSmall!,
    };
  }

  Color _resolveColor(BeColorTokens colors) {
    return switch (color) {
      BeTextColor.primary => colors.textPrimary,
      BeTextColor.secondary => colors.textSecondary,
      BeTextColor.tertiary => colors.textTertiary,
      BeTextColor.disabled => colors.textDisabled,
      BeTextColor.inverse => colors.textInverse,
      BeTextColor.error => colors.errorPrimary,
    };
  }
}
