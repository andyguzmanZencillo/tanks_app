import 'package:flutter/material.dart';

class BlueStoneColors {
  static const Color blueStone50 = Color(0xFFF3FAF9);
  static const Color blueStone100 = Color(0xFFD6F1ED);
  static const Color blueStone200 = Color(0xFFACE3DB);
  static const Color blueStone300 = Color(0xFF7BCD45);
  static const Color blueStone400 = Color(0xFF4FB2AB);
  static const Color blueStone500 = Color(0xFF369692);
  static const Color blueStone600 = Color(0xFF297876);
  static const Color blueStone700 = Color(0xFF24605F);
  static const Color blueStone800 = Color(0xFF214E4E);
  static const Color blueStone900 = Color(0xFF1F4241);
  static const Color blueStone950 = Color(0xFF0D2426);
}

final ThemeData blueStoneTheme = ThemeData(
  primaryColor: BlueStoneColors.blueStone500,
  primaryColorLight: BlueStoneColors.blueStone100,
  primaryColorDark: BlueStoneColors.blueStone900,
  scaffoldBackgroundColor: BlueStoneColors.blueStone50,
  colorScheme: const ColorScheme(
    primary: BlueStoneColors.blueStone500,
    primaryContainer: BlueStoneColors.blueStone200,
    secondary: BlueStoneColors.blueStone400,
    secondaryContainer: BlueStoneColors.blueStone700,
    surface: BlueStoneColors.blueStone50,
    background: BlueStoneColors.blueStone50,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: BlueStoneColors.blueStone900,
    onBackground: BlueStoneColors.blueStone900,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
);
