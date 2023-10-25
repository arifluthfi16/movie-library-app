import 'package:flutter/material.dart';

class ThemeWrapper extends StatelessWidget {
  final Widget child;

  const ThemeWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF6A4DFF),
          secondary: const Color(0xFF8C76FF)
      ),
      ),
      home: child,
    );
  }
}
