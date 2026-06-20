import 'package:flutter/material.dart';

import 'generated/er_localizations.dart';

/// Convenience accessor for [ErLocalizations] on [BuildContext].
extension ErL10nContext on BuildContext {
  /// Active [ErLocalizations] for the current locale.
  ErLocalizations get l10n => ErLocalizations.of(this);
}
