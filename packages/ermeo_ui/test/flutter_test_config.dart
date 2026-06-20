import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

/// Global test bootstrap for ermeo_ui.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  GoogleFonts.config.allowRuntimeFetching = false;
  await testMain();
}
