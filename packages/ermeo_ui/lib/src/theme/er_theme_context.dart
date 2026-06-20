import 'package:flutter/material.dart';

import 'er_semantic_tokens.dart';

/// Convenience accessors for Ermeo theme tokens on [BuildContext].
extension ErThemeContext on BuildContext {
  /// Semantic color tokens for the active theme.
  ErColorTokens get beColors => Theme.of(this).extension<ErColorTokens>()!;

  /// Semantic spacing tokens for the active theme.
  ErSpacingTokens get beSpacing => Theme.of(this).extension<ErSpacingTokens>()!;

  /// Semantic border-radius tokens for the active theme.
  ErRadiusTokens get beRadius => Theme.of(this).extension<ErRadiusTokens>()!;

  /// Semantic shadow tokens for the active theme.
  ErShadowTokens get beShadows => Theme.of(this).extension<ErShadowTokens>()!;

  /// Typography tokens for the active theme.
  ErTypographyTokens get beTypography =>
      Theme.of(this).extension<ErTypographyTokens>()!;
}
