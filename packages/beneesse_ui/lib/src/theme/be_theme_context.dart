import 'package:flutter/material.dart';

import 'be_semantic_tokens.dart';

/// Convenience accessors for Beneesse theme tokens on [BuildContext].
extension BeThemeContext on BuildContext {
  /// Semantic color tokens for the active theme.
  BeColorTokens get beColors => Theme.of(this).extension<BeColorTokens>()!;

  /// Semantic spacing tokens for the active theme.
  BeSpacingTokens get beSpacing => Theme.of(this).extension<BeSpacingTokens>()!;

  /// Semantic border-radius tokens for the active theme.
  BeRadiusTokens get beRadius => Theme.of(this).extension<BeRadiusTokens>()!;

  /// Semantic shadow tokens for the active theme.
  BeShadowTokens get beShadows => Theme.of(this).extension<BeShadowTokens>()!;

  /// Typography tokens for the active theme.
  BeTypographyTokens get beTypography =>
      Theme.of(this).extension<BeTypographyTokens>()!;
}
