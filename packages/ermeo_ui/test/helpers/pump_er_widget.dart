import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'golden_config.dart';

/// Pumps [child] inside a [MaterialApp] with [theme] and a fixed surface size.
Future<void> pumpErWidget(
  WidgetTester tester,
  Widget child, {
  ThemeData? theme,
  Size surface = kBeGoldenSurfaceSize,
}) async {
  final resolvedTheme = theme ?? ErTheme.light;
  await tester.pumpWidget(
    MaterialApp(
      theme: resolvedTheme,
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: surface.width,
            height: surface.height,
            child: child,
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

/// Pumps [child] with [ErTheme.dark].
Future<void> pumpErWidgetDark(
  WidgetTester tester,
  Widget child, {
  Size surface = kBeGoldenSurfaceSize,
}) {
  return pumpErWidget(
    tester,
    child,
    theme: ErTheme.dark,
    surface: surface,
  );
}
