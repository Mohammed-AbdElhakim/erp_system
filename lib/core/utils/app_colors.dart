import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primary =
      MaterialColor(_primaryPrimaryValue, <int, Color>{
    50: Color(0xFFE4E4E5),
    100: Color(0xFFBBBBBF),
    200: Color(0xFF8D8E94),
    300: Color(0xFF5F6169),
    400: Color(0xFF3D3F49),
    500: Color(_primaryPrimaryValue),
    600: Color(0xFF181A24),
    700: Color(0xFF14151F),
    800: Color(0xFF101119),
    900: Color(0xFF080A0F),
  });
  static const int _primaryPrimaryValue = 0xFF1B1D29;

  static const MaterialColor primaryAccent =
      MaterialColor(_primaryAccentValue, <int, Color>{
    100: Color(0xFF537EFF),
    200: Color(_primaryAccentValue),
    400: Color(0xFF003BEC),
    700: Color(0xFF0035D3),
  });
  static const int _primaryAccentValue = 0xFF2058FF;

  static Color grey = const Color(0xff9E9E9E);
  static Color blue = Colors.blue;
  static Color blueGreyLight = const Color(0xFFDBDEEF);
  static Color blueGreyDark = const Color(0xFF5280AF);
  static Color black = const Color(0xff000000);
  static Color white = const Color(0xffFFFFFF);
  static Color blueDark = const Color(0xff1B1D29);
  static Color blueLight = const Color(0xff005BAA);
}
