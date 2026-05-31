import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      lightTheme: BeTheme.light,
      darkTheme: BeTheme.dark,
      addons: [
        ViewportAddon([
          Viewports.none,
          IosViewports.iPhone13,
          IosViewports.iPadPro11Inches,
        ]),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: BeTheme.light),
            WidgetbookTheme(name: 'Dark', data: BeTheme.dark),
          ],
        ),
        AlignmentAddon(),
        TextScaleAddon(
          min: 0.75,
          max: 3,
          initialScale: 1,
        ),
      ],
    );
  }
}
