import 'package:flutter/material.dart';

import 'generated/be_localizations.dart';

/// Convenience accessor for [BeLocalizations] on [BuildContext].
extension BeL10nContext on BuildContext {
  /// Active [BeLocalizations] for the current locale.
  BeLocalizations get l10n => BeLocalizations.of(this);
}
