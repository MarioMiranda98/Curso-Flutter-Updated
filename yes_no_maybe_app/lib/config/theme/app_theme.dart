import 'package:flutter/material.dart';

class AppTheme {
  static const Color _customColor = Color(0XFF5C11D4);
  static const List<Color> _colorThemes = [
    _customColor,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
  ];

  final int selectedColor;

  AppTheme({
    required this.selectedColor,
  })  : assert(selectedColor >= 0,
            'Colors must be between 0 and ${_colorThemes.length - 1}'),
        assert(selectedColor < 7,
            'Colors must be between 0 and ${_colorThemes.length - 1}');

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _colorThemes.elementAt(1),
      ),
    );
  }
}
