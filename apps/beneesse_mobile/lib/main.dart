import 'package:flutter/material.dart';

void main() {
  runApp(const BeneesseMobileApp());
}

class BeneesseMobileApp extends StatelessWidget {
  const BeneesseMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('beneesse_mobile'),
        ),
      ),
    );
  }
}
