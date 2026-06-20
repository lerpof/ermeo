import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/er_localizations.dart';

/// Localization delegates required for Ermeo apps.
const List<LocalizationsDelegate<dynamic>> erLocalizationDelegates = [
  ErLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
