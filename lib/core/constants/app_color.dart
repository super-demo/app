import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const kColorPrimary = Color(0xFF29DAFC);
  static const kColorWhite = Color(0xFFFFFFFF);
  static const kColorBlack = Color(0xFF000000);
  static const kColorGray = Color(0xFF808080);

  // ✅ Define a MaterialColor for primarySwatch
  static const MaterialColor kPrimarySwatch = MaterialColor(
    0xFF29DAFC,
    {
      50: Color(0xFFE0F9FF),
      100: Color(0xFFB3F0FF),
      200: Color(0xFF80E7FF),
      300: Color(0xFF4DDEFF),
      400: Color(0xFF26D6FF),
      500: Color(0xFF29DAFC), // Main color
      600: Color(0xFF00C0E0),
      700: Color(0xFF0095B3),
      800: Color(0xFF006A86),
      900: Color(0xFF003F59),
    },
  );
}
