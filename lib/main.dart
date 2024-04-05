import 'package:flutter/material.dart';
import 'package:spray_tool/src/calculator_screen.dart';
import 'package:spray_tool/src/themes.dart';

void main() {
  runApp(const SprayTool());
}

/// App entry point.
class SprayTool extends StatelessWidget {
  /// Creates a new [SprayTool].
  const SprayTool({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spray Tool',
      theme: primaryTheme,
      home: const CalculatorScreen(),
    );
  }
}
