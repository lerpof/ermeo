import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/be_localizations.dart';

/// Localization delegates required for Beneesse apps.
const List<LocalizationsDelegate<dynamic>> beLocalizationDelegates = [
  BeLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
