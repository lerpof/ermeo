import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BeneesseMobileApp());
}

class BeneesseMobileApp extends StatelessWidget {
  const BeneesseMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BeTheme.light,
      darkTheme: BeTheme.dark,
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(
          child: Text('beneesse_mobile'),
        ),
      ),
    );
  }
}
